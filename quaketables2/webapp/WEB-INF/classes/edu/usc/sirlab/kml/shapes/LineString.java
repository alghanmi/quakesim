package edu.usc.sirlab.kml.shapes;

import java.util.*;

public class LineString {
	public static final String ALTITUDE_RELATIVE_TO_GROUND = "relativeToGround";
	
	private int tessellate;
	private String altitudeMode;
	private List<String[]> coordinates;
	
	public LineString() {
		this(1, ALTITUDE_RELATIVE_TO_GROUND, new ArrayList<String[]>());
	}
	
	public LineString(List<String[]> coordinates) {
		this(1, ALTITUDE_RELATIVE_TO_GROUND, coordinates);
	}
	
	public LineString(int tessellate, String altitudeMode) {
		this(tessellate, altitudeMode, new ArrayList<String[]>());
	}
	
	public LineString(int tessellate, String altitudeMode, List<String[]> coordinates) {
		this.tessellate = tessellate;
		this.altitudeMode = altitudeMode;
		this.coordinates = coordinates;
	}

	public int getTessellate() {
		return tessellate;
	}

	public void setTessellate(int tessellate) {
		this.tessellate = tessellate;
	}

	public String getAltitudeMode() {
		return altitudeMode;
	}

	public void setAltitudeMode(String altitudeMode) {
		this.altitudeMode = altitudeMode;
	}

	public List<String[]> getCoordinates() {
		return coordinates;
	}

	public void setCoordinates(List<String[]> coordinates) {
		this.coordinates = coordinates;
	}
	
	public void addCoordinate(String[] c) {
		coordinates.add(c);
	}
	
	public String getFullKML() {
		String myString = "";
		
		myString += "<LineString>";
		myString += "<altitudeMode>" + altitudeMode + "</altitudeMode>";
		myString += "<tessellate>" + tessellate + "</tessellate>";
		myString += "<coordinates>";
		
		String coordinateString = "";
		for(String[] c : coordinates) {
			for(int i = 0; i < c.length; i++) {
				coordinateString += c[i];
				if(i + 1 < c.length)
					coordinateString += ",";
			}
			coordinateString += " ";
		}
		
		myString += coordinateString.trim();
		myString += "</coordinates>";
		myString += "</LineString>";
		
		return myString;
	}
}
