package edu.usc.sirlab;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import edu.usc.sirlab.kml.Style;

public class NCALFault extends Fault implements Serializable {
	private static final long serialVersionUID = 219608637L;
	private static final String BASE_URL = "http://quakesim.org/quaketables/fault.jsp?ds=";
	private Integer elementNumber;
	private Integer faultElement;
	private Integer segmentElement;
	private Double slipRate;
	private Double strength;
	private Double strike;
	private Double dip;
	private Double rake;
	
	public NCALFault(FaultDataSet dataSet, String id, String name) {
		super(dataSet, id, name);
	}

	public Integer getElementNumber() {
		return elementNumber;
	}

	public void setElementNumber(Integer elementNumber) {
		this.elementNumber = elementNumber;
	}

	public Integer getFaultElement() {
		return faultElement;
	}

	public void setFaultElement(Integer faultElement) {
		this.faultElement = faultElement;
	}

	public Integer getSegmentElement() {
		return segmentElement;
	}

	public void setSegmentElement(Integer segmentElement) {
		this.segmentElement = segmentElement;
	}

	public Double getSlipRate() {
		return slipRate;
	}

	public void setSlipRate(Double slipRate) {
		this.slipRate = slipRate;
	}

	public Double getStrength() {
		return strength;
	}

	public void setStrength(Double strength) {
		this.strength = strength;
	}

	public Double getStrike() {
		return strike;
	}

	public void setStrike(Double strike) {
		this.strike = strike;
	}

	public Double getDip() {
		return dip;
	}

	public void setDip(Double dip) {
		this.dip = dip;
	}

	public Double getRake() {
		return rake;
	}

	public void setRake(Double rake) {
		this.rake = rake;
	}

	public List<String[]> getHTMLParameters() {
		List<String[]> param = new ArrayList<String[]>();
		
		if(name != null) {
			String[] p = {"Fault Name", name};
			param.add(p);
		}
		if(elementNumber != null) {
			String[] p = {"Element Number", elementNumber.toString()};
			param.add(p);
		}
		if(faultElement != null) {
			String[] p = {"Fault Number of Element", faultElement.toString()};
			param.add(p);
		}
		if(segmentElement != null) {
			String[] p = {"Segment Number of Element", segmentElement.toString()};
			param.add(p);
		}
		if(slipRate != null) {
			String[] p = {"Slip Rate", slipRate.toString()};
			param.add(p);
		}
		if(strength != null) {
			String[] p = {"Strength", strength.toString()};
			param.add(p);
		}
		if(strike != null) {
			String[] p = {"Strike", strike.toString()};
			param.add(p);
		}
		if(rake != null) {
			String[] p = {"Rake", rake.toString()};
			param.add(p);
		}
		if(dip != null) {
			String[] p = {"Dip", dip.toString()};
			param.add(p);
		}
		if(getTraces() != null && getTraces().size() > 0) {
			String[] p = {"Location", getTracesString()};
			param.add(p);
		}
		
		return param;
	}
	
	public String getKMLPlacemark(Style style, boolean putPlacemark) {
		//TODO: Use getHTMLParameters() to make this short and easy
		
		List<String[]> params = getHTMLParameters();
		
		String description = "";
		Iterator<String[]> it = params.iterator();
		while(it.hasNext()) {
			String[] param = it.next();
			description += "<b>" + param[0] + "</b>: " + param[1] + "<br>";
		}
		
		if(getTraces() != null && getTraces().size() > 0)
			description += "<b>Location</b>: " + getTracesString() + "<br>";
		
		
		description += "<b>Details</b>: " + BASE_URL + dataSet.getId() + "&fid=" + id + "<br>";
		description += " <br> ";
		description += "This fault is part of the <a href=\"" + BASE_URL + dataSet.getId() + "\">" + dataSet.getName() + "</a>.";
		
		String traces = "";
		for(FaultTracePoint p : getTraces()) {
			traces += p.getLon() + "," + p.getLat() + ", " + p.getDepth() + " ";
		}
		
		String myString = "";
		myString += "<Placemark>";
		myString += "<name>" + name + "</name>";
		myString += "<description><![CDATA[" + description + "]]></description>";
		myString += "<styleUrl>" + "#" + style.getId() + "</styleUrl>";
		myString += "<LineString>";
		myString += "<altitudeMode>clampToGround</altitudeMode>"; //"<tessellate>1</tessellate>";
		myString += "<coordinates>" + traces.trim() + "</coordinates>"; 
		myString += "</LineString>";
		myString += "</Placemark>";
		
		return myString;
	}
}
