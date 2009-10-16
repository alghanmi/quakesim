package edu.usc.sirlab.kml;

import java.io.IOException;
import java.io.StringReader;
import java.io.StringWriter;
import java.util.*;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;

import org.w3c.dom.DOMConfiguration;
import org.w3c.dom.DOMImplementation;
import org.w3c.dom.Document;
import org.w3c.dom.ls.DOMImplementationLS;
import org.w3c.dom.ls.LSOutput;
import org.w3c.dom.ls.LSSerializer;
import org.xml.sax.InputSource;
import org.xml.sax.SAXException;

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
		myString += "<kml xmlns=\"http://www.opengis.net/kml/2.2\" xmlns:gx=\"http://www.google.com/kml/ext/2.2\" xmlns:atom=\"http://www.w3.org/2005/Atom\">";
		myString += "<Document>";
		myString += "<name>" + name + "</name>";
		myString += "<description><![CDATA[" + description + "]]></description>";
		myString += "<atom:author><atom:name>" + AUTHOR_NAME + "</atom:name></atom:author>";
		myString += "<atom:link rel=\"related\" type=\"text/html\" href=\"" + AUTHOR_URL + "\" />";
		
		return myString;
	}
	
	private String getKMLFooter() {
		String myString = "";
		myString += "</Document>";
		myString += "</kml>";
		
		return myString;
	}
	
	private String prettyPrint(Document document) {
		/*
		 * This code was taken from:
		 * http://www.chipkillmar.net/2009/03/25/pretty-print-xml-from-a-dom/
		 * 
		 *  Pretty-prints a DOM document to XML using DOM Load and Save's LSSerializer.
		 *  Note that the "format-pretty-print" DOM configuration parameter can only be set in JDK 1.6+.
		 */

		DOMImplementation domImplementation = document.getImplementation();
		if(domImplementation.hasFeature("LS", "3.0") && domImplementation.hasFeature("Core", "2.0")) {
			DOMImplementationLS domImplementationLS = (DOMImplementationLS) domImplementation.getFeature("LS", "3.0");
			LSSerializer lsSerializer = domImplementationLS.createLSSerializer();
			DOMConfiguration domConfiguration = lsSerializer.getDomConfig();
			if(domConfiguration.canSetParameter("format-pretty-print", Boolean.TRUE)) {
				lsSerializer.getDomConfig().setParameter("format-pretty-print", Boolean.TRUE);
				LSOutput lsOutput = domImplementationLS.createLSOutput();
				lsOutput.setEncoding("UTF-8");
				StringWriter stringWriter = new StringWriter();
				lsOutput.setCharacterStream(stringWriter);
				lsSerializer.write(document, lsOutput);
				
				return stringWriter.toString();
			}
			else
				throw new RuntimeException("DOMConfiguration 'format-pretty-print' parameter isn't settable.");
		}
		else
			throw new RuntimeException("DOM 3.0 LS and/or DOM 2.0 Core not supported.");
 }
	
	public String getKMLDocument() {
		String myString = "";
		myString += getKMLHeader();
		for(Style s : styles)
			myString += s.getKML();
		for(String f : folders)
			myString += f;
		myString += getKMLFooter();
		
		try {
			DocumentBuilderFactory docFactory = DocumentBuilderFactory.newInstance();
			DocumentBuilder docBuilder = docFactory.newDocumentBuilder();
			InputSource docSource = new InputSource(new StringReader(myString));
			Document doc = docBuilder.parse(docSource);
			myString = prettyPrint(doc);
		}
		catch(SAXException e){}
		catch(IOException e){}
		catch(ParserConfigurationException e){}
		

		
		return myString;
	}
}