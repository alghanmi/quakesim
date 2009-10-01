package edu.usc.sirlab.kml;

import java.util.*;

public class KMLDocument {
	private String name, description, authorName, authorURL;
	private List<Style> styles;
	private List<String> folders;
	
	public static final String AUTHOR_NAME = "QuakeSim Project";
	public static final String AUTHOR_URL = "http://quakesim.org/";
	
	public KMLDocument() {
		this("KML Query", "QuakeSim KML Query Result", AUTHOR_NAME, AUTHOR_URL);
		
	}

	public KMLDocument(String name, String description) {
		this(name, description, AUTHOR_NAME, AUTHOR_URL);
	}
	
	public KMLDocument(String name, String description, String authorName, String authorURL) {
		this.name = name;
		this.description = description;
		this.authorName = authorName;
		this.authorURL = authorURL;
		this.styles = new ArrayList<Style>();
		this.folders = new ArrayList<String>();
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

	public String getAuthorName() {
		return authorName;
	}

	public void setAuthorName(String authorName) {
		this.authorName = authorName;
	}

	public String getAuthorURL() {
		return authorURL;
	}

	public void setAuthorURL(String authorURL) {
		this.authorURL = authorURL;
	}
	
	public void addFolder(String kmlFolder) {
		folders.add(kmlFolder);
	}
	
	public void addStyle(Style s) {
		styles.add(s);
	}
	
	private String getKMLHeader() {
		String myString = "";
		myString += "<?xml version=\"1.0\" encoding=\"UTF-8\"?>";
		myString += "<kml xmlns=\"http://earth.google.com/kml/2.2\" xmlns:atom=\"http://www.w3.org/2005/Atom\">";
		myString += "<Document>";
		myString += "<name>" + name + "</name>";
		myString += "<description><![CDATA[" + description + "]]></description>";
		myString += "<atom:author><atom:name>" + AUTHOR_NAME + "</atom:name></atom:author>";
		myString += "<atom:link href=\"" + AUTHOR_URL + "\" />";
		
		return myString;
	}
	
	private String getKMLFooter() {
		String myString = "";
		myString += "</Document>";
		myString += "</kml>";
		
		return myString;
	}
	
	public String getKMLDocument() {
		String myString = "";
		myString += getKMLHeader();
		for(Style s : stsyles)
			myString += s.getKML();
		for(String f : folders)
			myString += f;
		myString += getKMLFooter();
		
		return myString;
	}
}