package edu.usc.sirlab;

public class FaultTracePoint {
	private double lat;
	private double lon;
	private double depth;
	
	public FaultTracePoint(double lat, double lon, double depth) {
		this.lat = lat;
		this.lon = lon;
		this.depth = depth;
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

	public double getDepth() {
		return depth;
	}

	public void setDepth(double depth) {
		this.depth = depth;
	}
}
