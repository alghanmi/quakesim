package edu.usc.sirlab;

public class GeoPoint {
	private double lat;
	private double lon;
	
	public GeoPoint(double lat, double lon) {
		this.lat = lat;
		this.lon = lon;
	}
	public double getLat() {
		return lat;
	}
	public void setLat(double lat) {
		this.lat = lat;
	}
	public double getLon() {
		return lon;
	}
	public void setLon(double lon) {
		this.lon = lon;
	}
	
	public String toString() {
		String myString = "[" + lat + ", " + lon + "]";
		
		return myString;
	}
	
	public String getKMLCoordinateString() {
		String myString = "";
		//Format is lon, lat, 0
		
		if(lon != 0.0)
			myString += lon + ", ";
		else
			myString += "0, ";
		if(lat != 0.0)
			myString += lat + ", ";
		else
			myString += "0, ";
		
		myString += "0";
		
		return myString;
	}
}
