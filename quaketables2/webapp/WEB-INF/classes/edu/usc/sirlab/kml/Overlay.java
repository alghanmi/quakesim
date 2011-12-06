package edu.usc.sirlab.kml;

import java.text.SimpleDateFormat;
import java.util.Date;

public class Overlay {
	private String name;
	private String description;
	private String color;
	private String imageUrl;
	private double scale;
	private double[] coordinates;//north, south, east, west
	private Date start, end;
	private boolean isVisible;
	
	//Color is expressed in aabbggrr (hex), aa = 0x00 -> fully transparent, aa = 0xff -> fully opaque
	private static final String DEFAULT_COLOR = "66ffffff";
	private static final double DEFAULT_SCALE = 0.75;
	private static final SimpleDateFormat timespanFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'");
	
	public Overlay() {
		super();
		color = DEFAULT_COLOR;
		scale = DEFAULT_SCALE;
		start = null;
		end = null;
	}
	
	public Overlay(String name, String description, String imageUrl, double[] coordinatesNSEW) {
		this.name = name;
		this.description = description;
		this.imageUrl = imageUrl;
		this.coordinates = coordinatesNSEW;
		color = DEFAULT_COLOR;
		scale = DEFAULT_SCALE;
		start = null;
		end = null;
	}
	
	public Overlay(String name, String description, String imageUrl, double[] coordinatesNSEW, Date startDate, Date endDate) {
		this.name = name;
		this.description = description;
		this.imageUrl = imageUrl;
		this.coordinates = coordinatesNSEW;
		color = DEFAULT_COLOR;
		scale = DEFAULT_SCALE;
		start = startDate;
		end = endDate;
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

	public String getColor() {
		return color;
	}

	public void setColor(String color) {
		this.color = color;
	}

	public String getImageUrl() {
		return imageUrl;
	}

	public void setImageUrl(String imageUrl) {
		this.imageUrl = imageUrl;
	}

	public double getScale() {
		return scale;
	}

	public void setScale(double scale) {
		this.scale = scale;
	}

	public double[] getCoordinates() {
		return coordinates;
	}

	public void setCoordinates(double[] coordinates) {
		this.coordinates = coordinates;
	}

	public Date getStart() {
		return start;
	}

	public void setStart(Date start) {
		this.start = start;
	}

	public Date getEnd() {
		return end;
	}

	public void setEnd(Date end) {
		this.end = end;
	}
	
	public boolean isVisible() {
		return isVisible;
	}
	
	public void setVisible(boolean v) {
		isVisible = v;
	}

	public String getKML() {
		String myString = "";
		myString += "<GroundOverlay>";
		myString += "<name>" + name + "</name>";
		myString += "<description><![CDATA[" + description + "]]></description>";
		if(!isVisible)
			myString += "<visibility>0</visibility>";
		if(start != null && end != null) {
			myString += "<TimeSpan>";
			myString += "<begin>" + timespanFormat.format(start) + "</begin>";
			myString += "<end>" + timespanFormat.format(end) + "</end>";
			myString += "</TimeSpan>";
		}
		myString += "<color>" + color + "</color>";
		myString += "<Icon>";
		myString += "<href>" + imageUrl + "</href>";
		myString += "</Icon>";
		myString += "<LatLonBox>";
		myString += "<north>" + coordinates[0] + "</north>";
		myString += "<south>" + coordinates[1] + "</south>";
		myString += "<east>" + coordinates[2] + "</east>";
		myString += "<west>" + coordinates[3] + "</west>";
		myString += "</LatLonBox>";
		myString += "</GroundOverlay>";
		return myString;
	}
}
