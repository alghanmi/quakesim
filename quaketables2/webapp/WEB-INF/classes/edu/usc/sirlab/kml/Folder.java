package edu.usc.sirlab.kml;

import java.util.*;

public class Folder {
	private String name;
	private String description;
	private List<Placemark> placemarks;
	
	public Folder(String name, String description) {
		this.name = name;
		this.description = description;
		placemarks = new ArrayList<Placemark>();
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

	public List<Placemark> getPlacemarks() {
		return placemarks;
	}

	public void setPlacemarks(List<Placemark> placemarks) {
		this.placemarks = placemarks;
	}
	
	public void addPlacemark(Placemark p) {
		placemarks.add(p);
	}
	
	public String getFullKML() {
		String myString = "";
		
		myString += "\t\t" + "<Folder>" + "\n";
		if(name != null)
			myString += "\t\t\t" + "<name>" + name + "</name>" + "\n";
		
		if(description != null)
			myString += "\t\t\t" + "<description>" + description + "</description>" + "\n";
		
		if(placemarks != null && placemarks.size() > 0)
			for(Placemark p : placemarks)
				myString += p.getFullKML() + "\n";
		
		myString += "\t\t" + "</Folder>";
		return myString;
	}
	
}
