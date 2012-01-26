package edu.usc.sirlab;

import java.io.Serializable;
import java.util.Date;

import edu.usc.sirlab.kml.*;

public class Interferogram implements Serializable {
	private static final long serialVersionUID = 9177366610287252256L;
	private int id;
	private String title, description;
	private GeoPoint reference1, reference2, reference3, reference4;
	private Date startDate, endDate;
	private String dataURL, metaDataURL, imageURL, thumbnailURL;
	
	//private static final String SERVER_INSAR_URL = "http://quaketables.quakesim.org/insar.jsp?iid=";
	private static final String SERVER_INSAR_URL = "http://quakesim.usc.edu/quaketables/insar.jsp?iid=";
	private static final String INSAR_REPO_URL = "http://gf19.ucs.indiana.edu:9898/insar-data/";
	
	public Interferogram(int id, String title, String description,
			GeoPoint reference1, GeoPoint reference2, GeoPoint reference3,
			GeoPoint reference4, Date startDate, Date endDate, String dataURL,
			String metaDataURL, String imageURL, String thumbnailURL,
			double timespan, int width, int length) {
		super();
		this.id = id;
		this.title = title;
		this.description = description;
		this.reference1 = reference1;
		this.reference2 = reference2;
		this.reference3 = reference3;
		this.reference4 = reference4;
		this.startDate = startDate;
		this.endDate = endDate;
		this.dataURL = dataURL;
		this.metaDataURL = metaDataURL;
		this.imageURL = imageURL;
		this.thumbnailURL = thumbnailURL;
		this.timespan = timespan;
		this.width = width;
		this.length = length;
	}

	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public GeoPoint getReference1() {
		return reference1;
	}
	public void setReference1(GeoPoint reference1) {
		this.reference1 = reference1;
	}
	public GeoPoint getReference2() {
		return reference2;
	}
	public void setReference2(GeoPoint reference2) {
		this.reference2 = reference2;
	}
	public GeoPoint getReference3() {
		return reference3;
	}
	public void setReference3(GeoPoint reference3) {
		this.reference3 = reference3;
	}
	public GeoPoint getReference4() {
		return reference4;
	}
	public void setReference4(GeoPoint reference4) {
		this.reference4 = reference4;
	}
	public Date getStartDate() {
		return startDate;
	}
	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}
	public Date getEndDate() {
		return endDate;
	}
	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}
	public double getTimespan() {
		return timespan;
	}
	public void setTimespan(double timespan) {
		this.timespan = timespan;
	}
	public int getWidth() {
		return width;
	}
	public void setWidth(int width) {
		this.width = width;
	}
	public int getLength() {
		return length;
	}
	public void setLength(int length) {
		this.length = length;
	}
	private double timespan;
	private int width, length;

	public String getDataURL() {
		return dataURL;
	}

	public void setDataURL(String dataURL) {
		this.dataURL = dataURL;
	}

	public String getMetaDataURL() {
		return metaDataURL;
	}

	public void setMetaDataURL(String metaDataURL) {
		this.metaDataURL = metaDataURL;
	}

	public String getImageURL() {
		return imageURL;
	}

	public void setImageURL(String imageURL) {
		this.imageURL = imageURL;
	}

	public String getThumbnailURL() {
		return thumbnailURL;
	}

	public void setThumbnailURL(String thumbnailURL) {
		this.thumbnailURL = thumbnailURL;
	}
	
	private String getKMLDescription() {
		String details = description + "<br>";
		details += "<b>Location</b>: " + reference1.toString() + ", " + reference2.toString() + ", " + reference3.toString() + ", " + reference4.toString() + "<br>"; 
		details += "<b>Details</b>: " + "<a href=\"" + SERVER_INSAR_URL + id + "\">" + SERVER_INSAR_URL + id + "</a><br>";
		details += "<b>Download</b>: " + "<a href=\"" + INSAR_REPO_URL + dataURL + "\">Data</a>, " + "<a href=\"" + INSAR_REPO_URL + metaDataURL + "\">Metadata</a>, " + "<a href=\"" + INSAR_REPO_URL + imageURL + "\">Image</a>";
		
		return details;
	}
	
	public String getKMLPlacemark() {
		String details = getKMLDescription();
		
		GeoPoint a = reference1;
		GeoPoint b = reference4;
		
		double lat = (a.getLat() + b.getLat()) / 2.0;
		double lon = (a.getLon() + b.getLon()) / 2.0;
		GeoPoint p = new GeoPoint(lat, lon);
		
		String myString = "";
		myString += "<Placemark>";
		myString += "<name>" + title + "</name>";
		myString += "<styleUrl>" + PlacemarkSimple.EXTERNAL_STYLE_URL + "#s_dot" + "</styleUrl>";
		myString += "<description><![CDATA[" + details + "]]></description>";
		myString += "<Point>";
		myString += "<coordinates>" + p.getKMLCoordinateString() + "</coordinates>";
		myString += "</Point>";
		myString += "</Placemark>";
		
		return myString;
	}
	
	public String getKMLFolder() {
		return getKMLFolder(true);
	}
	
	public String getKMLFolder(boolean placeOverlay) {
		String details = getKMLDescription();
		
		String placemarkDetails = "<b>Source</b>: " + title + "<br>" + "<b>Details</b>: " + SERVER_INSAR_URL + id + "<br>" + "<b>Location</b>: ";
		
		//Placemarks
		PlacemarkSimple p1 = new PlacemarkSimple("Reference 1", placemarkDetails + reference1.toString(), PlacemarkSimple.TYPE_POINT);
		p1.addCoordinates(reference1);
		p1.setStyleUrl(PlacemarkSimple.EXTERNAL_STYLE_URL + "#sm_ylw-pushpin");
		PlacemarkSimple p2 = new PlacemarkSimple("Reference 2", placemarkDetails + reference2.toString(), PlacemarkSimple.TYPE_POINT);
		p2.addCoordinates(reference2);
		p2.setStyleUrl(PlacemarkSimple.EXTERNAL_STYLE_URL + "#sm_ylw-pushpin");
		PlacemarkSimple p3 = new PlacemarkSimple("Reference 3", placemarkDetails + reference3.toString(), PlacemarkSimple.TYPE_POINT);
		p3.addCoordinates(reference3);
		p3.setStyleUrl(PlacemarkSimple.EXTERNAL_STYLE_URL + "#sm_ylw-pushpin");
		PlacemarkSimple p4 = new PlacemarkSimple("Reference 4", placemarkDetails + reference4.toString(), PlacemarkSimple.TYPE_POINT);
		p4.addCoordinates(reference4);
		p4.setStyleUrl(PlacemarkSimple.EXTERNAL_STYLE_URL + "#sm_ylw-pushpin");
		
		//Polygon
		PlacemarkSimple polygon = new PlacemarkSimple(title, details, PlacemarkSimple.TYPE_POLYGON);
		polygon.setStyleUrl(PlacemarkSimple.EXTERNAL_STYLE_URL + "#s_polygon");
		polygon.addCoordinates(reference1);
		polygon.addCoordinates(reference2);
		polygon.addCoordinates(reference4);
		polygon.addCoordinates(reference3);
		
		String myString = "";
		myString += "<Folder>";
		myString += "<name>Reference Points</name>";
		myString += p1.getKML();
		myString += p2.getKML();
		myString += p3.getKML();
		myString += p4.getKML();
		myString += polygon.getKML();
		myString += "</Folder>";
		
		//Overlay
		if(placeOverlay) {
			String url = INSAR_REPO_URL + imageURL;
			double[] coordinates = {reference2.getLat(), reference3.getLat(), reference1.getLon(), reference4.getLon()}; // North, South, East, West Corners
			Overlay o = new Overlay(title, details, url, coordinates);
			
			myString += "<Folder>";
			myString += "<name>InSAR Image Overlay</name>";
			myString += o.getKML();
			myString += "</Folder>";
		}
		
		return myString;
	}
}
