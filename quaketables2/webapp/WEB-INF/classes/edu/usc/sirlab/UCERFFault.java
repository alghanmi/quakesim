package edu.usc.sirlab;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import edu.usc.sirlab.kml.Style;

public class UCERFFault extends Fault implements Serializable {
	private static final long serialVersionUID = 2179217494637L;
	private static final String BASE_URL = "http://quaketables.quakesim.org/fault.jsp?ds=";
	
	Double upperDepth;
	Double lowerDepth;
	
	Double dipAngle;
	Double dipDirection;
	
	Double slipRate;
	Double slipFactor;
	
	Double rake;
	
	Double traceLength;
	
	public UCERFFault(FaultDataSet dataSet, String id, String name) {
		super(dataSet, id, name);
	}
	
	public Double getUpperDepth() {
		return upperDepth;
	}

	public void setUpperDepth(Double upperDepth) {
		this.upperDepth = upperDepth;
	}

	public Double getLowerDepth() {
		return lowerDepth;
	}

	public void setLowerDepth(Double lowerDepth) {
		this.lowerDepth = lowerDepth;
	}

	public Double getDipAngle() {
		return dipAngle;
	}

	public void setDipAngle(Double dipAngle) {
		this.dipAngle = dipAngle;
	}

	public Double getDipDirection() {
		return dipDirection;
	}

	public void setDipDirection(Double dipDirection) {
		this.dipDirection = dipDirection;
	}

	public Double getSlipRate() {
		return slipRate;
	}

	public void setSlipRate(Double slipRate) {
		this.slipRate = slipRate;
	}

	public Double getSlipFactor() {
		return slipFactor;
	}

	public void setSlipFactor(Double slipFactor) {
		this.slipFactor = slipFactor;
	}

	public Double getRake() {
		return rake;
	}

	public void setRake(Double rake) {
		this.rake = rake;
	}

	public Double getTraceLength() {
		return traceLength;
	}

	public void setTraceLength(Double traceLength) {
		this.traceLength = traceLength;
	}

	public List<String[]> getHTMLParameters() {
		List<String[]> param = new ArrayList<String[]>();
		
		if(name != null) {
			String[] p = {"Fault Name", name};
			param.add(p);
		}
		if(upperDepth != null) {
			String[] p = {"Ave Upper Seis Depth (km)", upperDepth.toString()};
			param.add(p);
		}
		if(lowerDepth != null) {
			String[] p = {"Ave Lower Seis Depth (km)", lowerDepth.toString()};
			param.add(p);
		}
		if(dipAngle != null) {
			String[] p = {"Ave Dip (degrees)", dipAngle.toString()};
			param.add(p);
		}
		if(dipDirection != null) {
			String[] p = {"Ave Dip Direction", dipDirection.toString()};
			param.add(p);
		}
		if(slipRate != null) {
			String[] p = {"Ave Long Term Slip Rate", slipRate.toString()};
			param.add(p);
		}
		if(slipFactor != null) {
			String[] p = {"Ave Aseismic Slip Factor", slipFactor.toString()};
			param.add(p);
		}
		if(rake != null) {
			String[] p = {"Ave Rake", rake.toString()};
			param.add(p);
		}
		if(traceLength != null) {
			String[] p = {"Trace Length (derivative value) (km)", traceLength.toString()};
			param.add(p);
		}
		if(traces != null && traces.size() > 0) {
			String[] p = {"Number of Trace Points", Integer.toString(traces.size())};
			param.add(p);
		}
		if(traces != null && traces.size() > 0) {
			String[] p = {"Location", getTracesString(false)};
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
		
		
		description += "<b>Details</b>: " + BASE_URL + dataSet.getId() + "&fid=" + id + "<br>";
		description += " <br> ";
		description += "This fault is part of the <a href=\"" + BASE_URL + dataSet.getId() + "\">" + dataSet.getName() + "</a>.";
		
		String traces = "";
		for(FaultTracePoint p : getTraces()) {
			traces += p.getLon() + "," + p.getLat() + " ";
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
