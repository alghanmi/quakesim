package edu.usc.sirlab;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import edu.usc.sirlab.kml.*;

public class UAVSAR implements Serializable {
	//TODO: consoledate with InSAR
	private static final long serialVersionUID = 9177366612256L;
	private int id;
	private String title, description;
	private Date date1, date2;
	private String sourceURL, metaDataURL, imageURL, kmlURL;
	private GeoPoint reference1, reference2, reference3, reference4;
	private List<UAVSARCategory> dataCategories;
	
	public UAVSAR(int id, String title, String description, Date date1,
			Date date2, String sourceURL, String metaDataURL, String imageURL,
			String kmlURL, GeoPoint reference1, GeoPoint reference2,
			GeoPoint reference3, GeoPoint reference4) {
		this.id = id;
		this.title = title;
		this.description = description;
		this.date1 = date1;
		this.date2 = date2;
		this.sourceURL = sourceURL;
		this.metaDataURL = metaDataURL;
		this.imageURL = imageURL;
		this.kmlURL = kmlURL;
		this.reference1 = reference1;
		this.reference2 = reference2;
		this.reference3 = reference3;
		this.reference4 = reference4;
		dataCategories = new ArrayList<UAVSARCategory>();
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
	public Date getDate1() {
		return date1;
	}
	public void setDate1(Date date1) {
		this.date1 = date1;
	}
	public Date getDate2() {
		return date2;
	}
	public void setDate2(Date date2) {
		this.date2 = date2;
	}
	public String getSourceURL() {
		return sourceURL;
	}
	public void setSourceURL(String sourceURL) {
		this.sourceURL = sourceURL;
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
	public String getKmlURL() {
		return kmlURL;
	}
	public void setKmlURL(String kmlURL) {
		this.kmlURL = kmlURL;
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
	public List<UAVSARCategory> getDataCategories() {
		return dataCategories;
	}
	public void setDataCategories(List<UAVSARCategory> data) {
		this.dataCategories = data;
	}
	public void addDataCategory(UAVSARCategory data) {
		dataCategories.add(data);
	}
}
