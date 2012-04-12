package edu.usc.sirlab.kml;

public class LineStyle extends Style {
	private String color;
	private int width;
	
	public LineStyle(String id, String color, int width) {
		super(id, LINE_STYLE, "LineStyle");
		this.color = color;
		this.width = width;
	}
	
	public LineStyle(String id, int width) {
		super(id, LINE_STYLE, "LineStyle");
		this.width = width;
		
		String a = "7f";
		//String r = getRandomNumberInHex();
		//String g = getRandomNumberInHex();
		//String b = getRandomNumberInHex();
		String r = "00";
		String g = "ff";
		String b = "ff";
		this.color = a + r + g + b;
	}
	
	private int getRandomNumber() {
		int result = 0;
		result = Math.round((float)Math.random() * 255);
		
		return result;
	}
	
	private String getRandomNumberInHex() {
		int rand = getRandomNumber();
		String hex = Integer.toString(rand, 16).toUpperCase();
		if(hex.length() < 2)
			hex = "0" + hex;
		
		return hex;
	}
	
	public String getKML() {
		String myString = "";
		myString += "<Style id=\"" + id + "\">";
		myString += "<LineStyle>";
		if(color != null)
			myString += "<color>" + color + "</color>";
		if(width > 0)
			myString += "<width>" + width + "</width>";
		myString += "</LineStyle>";
		myString += "</Style>";
		
		return myString;
	}
}
