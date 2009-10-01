package edu.usc.sirlab.kml;

import java.util.*;

public class Style {
	protected String id;
	protected int type;
	protected String tag;
	protected List<Style> subStyles;
	protected Hashtable<String, String> properties;
	
	public static final int STYLE = 0;
	public static final int LINE_STYLE = 1;
	public static final int POLY_STYLE = 2;
	
	public Style(String id) {
		this(id, STYLE, "Style");
	}
	
	public Style(String id, int type, String tag) {
		this.id = id;
		this.type = type;
		this.tag = tag;
		subStyles = new ArrayList<Style>();
		properties = new Hashtable<String, String>();
	}
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public int getType() {
		return type;
	}
	public void setType(int type) {
		this.type = type;
	}
	
	public List<Style> getSubStyles() {
		return subStyles;
	}
	
	public void setSubStyles(List<Style> subStyles) {
		this.subStyles = subStyles;
	}
	
	public String getTag() {
		return tag;
	}

	public void setTag(String tag) {
		this.tag = tag;
	}

	public Hashtable<String, String> getProperties() {
		return properties;
	}

	public void setProperties(Hashtable<String, String> properties) {
		this.properties = properties;
	}

	public void addSubStyle(Style s) {
		subStyles.add(s);
	}
	
	public void addProperty(String property, String value) {
		properties.put(property, value);
	}
	
	public List<String[]> getPropertyList() {
		List<String[]> propertyPairs = new ArrayList<String[]>();
		Enumeration<String> e = properties.keys();
		while(e.hasMoreElements()) {
			String key = e.nextElement();
			propertyPairs.add(new String[]{key, properties.get(key)});
		}
		
		return propertyPairs;
	}
	
	public String getKML() {
		String myString = "";
		
		return myString;
	}
}
