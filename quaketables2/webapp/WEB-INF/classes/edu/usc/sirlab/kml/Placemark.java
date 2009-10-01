package edu.usc.sirlab.kml;

import java.util.*;

import edu.usc.sirlab.kml.shapes.*;

public class Placemark {
	private String name;
	private String description;
	private Style style;
	private List<LineString> lines;
	
	public Placemark(String name, String description, Style style) {
		this.name = name;
		this.description = description;
		this.style = style;
		lines = new ArrayList<LineString>();
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

	public Style getStyle() {
		return style;
	}

	public void setStyle(Style style) {
		this.style = style;
	}

	public List<LineString> getLines() {
		return lines;
	}

	public void setLines(List<LineString> lines) {
		this.lines = lines;
	}

	public void addLineString(LineString l) {
		lines.add(l);
	}
	
	public String getFullKML() {
		String myString = "";
		myString += "\t\t\t" + "<Placemark>" + "\n";
		if(name != null)
			myString += "\t\t\t\t" + "<name>" + name + "</name>" + "\n";
		if(description != null)
			myString += "\t\t\t\t" + "<description>" + description + "</description>" + "\n";
		if(style != null)
			myString += "\t\t\t\t" + "<styleUrl>#" + style.getId() + "</styleUrl>" + "\n";
		if(lines != null && lines.size() > 0)
			for(LineString l : lines)
				myString += "\t\t\t\t" + l.getFullKML() + "\n";
		myString += "\t\t\t" + "</Placemark>";
		
		return myString;
	}
	
}
