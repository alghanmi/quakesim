package edu.usc.sirlab;

import java.io.Serializable;

public class CGSFault extends Fault implements Serializable {
	private static final long serialVersionUID = 2179217494419608637L;
	private String faultClass;
	private String zone;
	private String geometry, geometryDirection;
	private Double length, lengthError;
	private Double slipRate, slipRateError;
	private String rank;
	private Double mMax;
	private Double charRate;
	private Double recurrence;
	private Double downDipWidth, downDipWidthError;
	private Double rupTop, rupBottom;
	private Double rake, dip, daz;
	private String comment;
	
	
	
	public CGSFault(FaultDataSet dataSet, String id, String name) {
		super(dataSet, id, name);
	}



	public String getFaultClass() {
		return faultClass;
	}



	public void setFaultClass(String faultClass) {
		this.faultClass = faultClass;
	}



	public String getZone() {
		return zone;
	}



	public void setZone(String zone) {
		this.zone = zone;
	}



	public String getGeometry() {
		return geometry;
	}



	public void setGeometry(String geometry) {
		this.geometry = geometry;
	}



	public String getGeometryDirection() {
		return geometryDirection;
	}



	public void setGeometryDirection(String geometryDirection) {
		this.geometryDirection = geometryDirection;
	}



	public Double getLength() {
		return length;
	}



	public void setLength(Double length) {
		this.length = length;
	}



	public Double getLengthError() {
		return lengthError;
	}



	public void setLengthError(Double lengthError) {
		this.lengthError = lengthError;
	}



	public Double getSlipRate() {
		return slipRate;
	}



	public void setSlipRate(Double slipRate) {
		this.slipRate = slipRate;
	}



	public Double getSlipRateError() {
		return slipRateError;
	}



	public void setSlipRateError(Double slipRateError) {
		this.slipRateError = slipRateError;
	}



	public String getRank() {
		return rank;
	}



	public void setRank(String rank) {
		this.rank = rank;
	}



	public Double getmMax() {
		return mMax;
	}



	public void setmMax(Double mMax) {
		this.mMax = mMax;
	}



	public Double getCharRate() {
		return charRate;
	}



	public void setCharRate(Double charRate) {
		this.charRate = charRate;
	}



	public Double getRecurrence() {
		return recurrence;
	}



	public void setRecurrence(Double recurrence) {
		this.recurrence = recurrence;
	}



	public Double getDownDipWidth() {
		return downDipWidth;
	}



	public void setDownDipWidth(Double downDipWidth) {
		this.downDipWidth = downDipWidth;
	}



	public Double getDownDipWidthError() {
		return downDipWidthError;
	}



	public void setDownDipWidthError(Double downDipWidthError) {
		this.downDipWidthError = downDipWidthError;
	}



	public Double getRupTop() {
		return rupTop;
	}



	public void setRupTop(Double rupTop) {
		this.rupTop = rupTop;
	}



	public Double getRupBottom() {
		return rupBottom;
	}



	public void setRupBottom(Double rupBottom) {
		this.rupBottom = rupBottom;
	}



	public Double getRake() {
		return rake;
	}



	public void setRake(Double rake) {
		this.rake = rake;
	}



	public Double getDip() {
		return dip;
	}



	public void setDip(Double dip) {
		this.dip = dip;
	}



	public Double getDaz() {
		return daz;
	}



	public void setDaz(Double daz) {
		this.daz = daz;
	}



	public String getComment() {
		return comment;
	}



	public void setComment(String comment) {
		this.comment = comment;
	}
	
}
