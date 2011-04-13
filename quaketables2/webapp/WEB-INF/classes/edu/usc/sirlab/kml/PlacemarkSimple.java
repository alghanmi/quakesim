package edu.usc.sirlab.kml;

import java.util.*;

import edu.usc.sirlab.*;

public class PlacemarkSimple {
	private String name;
	private String description;
	private List<GeoPoint> coordinates;
	private String styleUrl;
	private int type;
	
	public static final String EXTERNAL_STYLE_URL = "http://quaketables.quakesim.org/kml/styles.kml";
	public static final int TYPE_POINT = 0, TYPE_POLYGON = 1;
	
	public PlacemarkSimple() {
		name = null;
		description = null;
		coordinates = null;
		styleUrl = null;
		coordinates = new ArrayList<GeoPoint>();
		type = 0;
	}
	
	public PlacemarkSimple(String name, String description, int type) {
		this.name = name;
		this.description = description;
		this.coordinates = new ArrayList<GeoPoint>();
		this.styleUrl = null;
		this.type = type;
	}
	
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getStyleUrl() {
		return styleUrl;
	}

	public void setStyleUrl(String styleUrl) {
		this.styleUrl = styleUrl;
	}

	public int getType() {
		return type;
	}

	public void setType(int type) {
		this.type = type;
	}

	public void addCoordinates(GeoPoint c) {
		coordinates.add(c);
	}
	
	public String getKML() {
		String myString = "";
		myString += "<Placemark>";
		myString += "<name>" + name + "</name>";
		myString += "<description><![CDATA[" + description + "]]></description>";
		
		if(styleUrl != null)
			myString += "<styleUrl>" + styleUrl + "</styleUrl>";
		
		if(type == TYPE_POINT && coordinates.size() > 0) {
			myString += "<Point>";
			myString += "<coordinates>";
			myString += coordinates.get(0).getKMLCoordinateString();
			myString += "</coordinates>";
			myString += "</Point>";
		}
		
		else if(type == TYPE_POLYGON && coordinates.size() > 1) {
			myString += "<Polygon>";
			myString += "<tessellate>1</tessellate>";
			myString += "<outerBoundaryIs>";
			myString += "<LinearRing>";
			myString += "<coordinates>";
			for(int i = 0; i < coordinates.size(); i ++)
				myString += coordinates.get(i).getKMLCoordinateString() + " ";
			myString += "</coordinates>";
			myString += "</LinearRing>";
			myString += "</outerBoundaryIs>";
			myString += "</Polygon>";
		}
		
		myString += "</Placemark>";
		
		return myString;
	}
}
