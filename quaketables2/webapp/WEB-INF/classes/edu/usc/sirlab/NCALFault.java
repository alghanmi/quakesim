package edu.usc.sirlab;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import edu.usc.sirlab.kml.Style;

public class NCALFault extends Fault implements Serializable {
	private static final long serialVersionUID = 219608637L;
	//private static final String BASE_URL = "http://quaketables.quakesim.org/fault.jsp?ds=";
	private static final String BASE_URL = "http://quakesim.usc.edu/quaketables/fault.jsp?ds=";
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
	
	//TODO: This takes the max depth of the fault
	public double getDepth() {
		double depth = 0;
		for(FaultTracePoint p : traces) {
			if(p.getDepth() < depth)
				depth = p.getDepth();
		}
		
		return depth;
	}

	public List<String[]> getHTMLParameters() {
		List<String[]> param = new ArrayList<String[]>();
		
		if(elementNumber != null) {
			String[] p = {"Element Number", elementNumber.toString()};
			param.add(p);
		}
		
		if(name != null) {
			String[] p = {"Fault Name", name};
			param.add(p);
		}
		if(faultElement != null) {
			String[] p = {"Fault Number of Element", new String(faultElement.toString() + ": " + getElementName(faultElement))};
			param.add(p);
		}
		if(segmentElement != null) {
			String[] p = {"Segment Number of Element", new String(segmentElement.toString() + ": " + getElementName(segmentElement))};
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
	
	public static String getElementName(int id) {
		String elementName;
		switch(id) {
			case 1:
				elementName = "A0 - SAF-Mendo Offs";
				break;
			case 2:
				elementName = "A1 - SAF-N Mendocin";
				break;
			case 3:
				elementName = "A1 - SAF-N Mendocin";
				break;
			case 4:
				elementName = "A1 - SAF-N Coast Of";
				break;
			case 5:
				elementName = "A1 - SAF-N Coast On";
				break;
			case 6:
				elementName = "A2 - SAF-N Mid Peni";
				break;
			case 7:
				elementName = "A2 - SAF-S Mid Peni";
				break;
			case 8:
				elementName = "A2 - SAF-S Mid Peni";
				break;
			case 9:
				elementName = "A3 - SAF-S Cruz Mts";
				break;
			case 10:
				elementName = "A3 - SAF-S Cruz Mts";
				break;
			case 11:
				elementName = "A4 - N San Gregorio";
				break;
			case 12:
				elementName = "A5 - S San Gregorio";
				break;
			case 13:
				elementName = "H6 - N Maacama";
				break;
			case 14:
				elementName = "H5 - C Maacama";
				break;
			case 15:
				elementName = "H4 - S Maacama";
				break;
			case 16:
				elementName = "H3 - Rodgers Creek";
				break;
			case 17:
				elementName = "H2 - Hayward";
				break;
			case 18:
				elementName = "H1 - Hayward";
				break;
			case 19:
				elementName = "C5 - Berryessa";
				break;
			case 20:
				elementName = "C4 - Greenvalley";
				break;
			case 21:
				elementName = "C3 - Concord";
				break;
			case 22:
				elementName = "C2 - Calaveras";
				break;
			case 23:
				elementName = "C1 - Calaveras";
				break;
			case 24:
				elementName = "C1s - Calaveras";
				break;
			case 25:
				elementName = "L05 - West Napa";
				break;
			case 26:
				elementName = "L02 - Greenville";
				break;
			case 27:
				elementName = "CC04 - MontBay-Tul";
				break;
			case 28:
				elementName = "SF01 - Quien Sabe";
				break;
			case 29:
				elementName = "SF02 - Ortigalita";
				break;
			case 30:
				elementName = "SF03 - Mt. Diablo";
				break;
			case 31:
				elementName = "SF04 - Collayomi";
				break;
			case 32:
				elementName = "SF05 - Pt. Reyes";
				break;
			case 33:
				elementName = "SF06 - Mon Vis-Shannon";
				break;
			case 34:
				elementName = "C6 - Bartlett Spring";
				break;
			default:
				elementName = null;
				break;
		}
		
		return elementName;
	}
}
