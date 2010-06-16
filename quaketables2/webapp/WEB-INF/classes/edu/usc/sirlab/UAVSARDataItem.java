package edu.usc.sirlab;

import java.io.Serializable;

public class UAVSARDataItem implements Serializable {
	private static final long serialVersionUID = 9041602565848620767L;
	
	String name;
	String url;
	String visualizationURL;
	String visualizationPreviewURL;
	
	public UAVSARDataItem(String name, String url, String visualizationURL, String visualizationPreviewURL) {
		this.name = name;
		this.url = url;
		this.visualizationURL = visualizationURL;
		this.visualizationPreviewURL = visualizationPreviewURL;
	}

	public String getName() {
		return name;
	}
	
	public void setName(String name) {
		this.name = name;
	}
	
	public String getUrl() {
		return url;
	}
	
	public void setUrl(String url) {
		this.url = url;
	}
	
	public String getVisualizationURL() {
		return visualizationURL;
	}
	
	public void setVisualizationURL(String visualizationURL) {
		this.visualizationURL = visualizationURL;
	}
	
	public String getVisualizationPreviewURL() {
		return visualizationPreviewURL;
	}
	
	public void setVisualizationPreviewURL(String visualizationPreviewURL) {
		this.visualizationPreviewURL = visualizationPreviewURL;
	}
}
