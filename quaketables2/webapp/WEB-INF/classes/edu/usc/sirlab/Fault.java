package edu.usc.sirlab;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import edu.usc.sirlab.kml.Style;

public class Fault implements Serializable {
	private static final long serialVersionUID = 5586063937860634421L;
	private static final String BASE_URL = "http://quakesim.org/quaketables/fault.jsp?ds=";
	
	protected FaultDataSet dataSet;
	protected String id;
	protected String name;
	protected List<FaultTracePoint> traces;
	
	public Fault(FaultDataSet dataSet, String id, String name,
			List<FaultTracePoint> traces) {

		this.dataSet = dataSet;
		this.id = id;
		this.name = name;
		this.traces = traces;
	}
	
	public Fault(FaultDataSet dataSet, String id, String name) {

		this.dataSet = dataSet;
		this.id = id;
		this.name = name;
		this.traces = new ArrayList<FaultTracePoint>();
	}

	public FaultDataSet getDataSet() {
		return dataSet;
	}

	public void setDataSet(FaultDataSet dataSet) {
		this.dataSet = dataSet;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	public List<FaultTracePoint> getTraces() {
		return traces;
	}

	public void setTraces(List<FaultTracePoint> traces) {
		this.traces = traces;
	}
	
	public void addTracePoint(FaultTracePoint point) {
		this.traces.add(point);
	}
	
	public String getTracesString() {
		String myString = "";
		for(int i = 0; i < traces.size(); i++) {
			myString += "[" + traces.get(i).getLat() + ", " + traces.get(i).getLon() + "]";
			if((i + 1) < traces.size())
				myString += ", ";
		}
		return myString;
	}
	
	public String getKMLPlaceMark(Style style) {
		//TODO: requires implementation see CGSFault.getKMLPlaceMark()
		String myString = "";
		return myString;
	}
	
	public String getKMLFolder(Style style) {
		String myString = "";
		myString += "<Folder>";
		myString += "<name>" + name + "</name>";
		myString += "<description><![CDATA[" + "<a href=\"" + BASE_URL + dataSet.getId() + "&fid=" + id + "\">[" + dataSet.getName() + "] " + name + "</a>" + "]]></description>";
		myString += getKMLPlaceMark(style);
		myString += "</Folder>";
		
		return myString;
	}
}
