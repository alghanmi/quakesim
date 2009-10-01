package edu.usc.sirlab;

import java.io.Serializable;

public class FaultDataSet implements Serializable {
	private static final long serialVersionUID = 4195910454082481338L;
	
	private String id;
	private String name;
	private String nickName;
	private String title;
	private String description;
	private String downloadURL;
	private int entryCount;
	private String dataType;
	
	public FaultDataSet(String id, String name, String nickName, String title,
			String description, String downloadURL, int entryCount, String dataType) {
		this.id = id;
		this.name = name;
		this.nickName = nickName;
		this.title = title;
		this.description = description;
		this.downloadURL = downloadURL;
		this.entryCount = entryCount;
		this.dataType = dataType;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getNickName() {
		return nickName;
	}
	public void setNickName(String nickName) {
		this.nickName = nickName;
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
	public String getDownloadURL() {
		return downloadURL;
	}
	public void setDownloadURL(String downloadURL) {
		this.downloadURL = downloadURL;
	}
	public int getEntryCount() {
		return entryCount;
	}
	public void setEntryCount(int entryCount) {
		this.entryCount = entryCount;
	}
	public String getDataType() {
		return dataType;
	}
	public void setDataType(String dataType) {
		this.dataType = dataType;
	}
	
	public String getKMLFolder() {
		String myString = "";
		
		myString += "<Folder>";
		myString += "<name>" + name + "</name>";
		myString += "<description>" + description + "</description>";
		myString += "</Folder>";
		return myString;
	}
}
