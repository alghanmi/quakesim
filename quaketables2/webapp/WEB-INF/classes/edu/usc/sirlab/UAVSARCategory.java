package edu.usc.sirlab;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

public class UAVSARCategory implements Serializable {
	private static final long serialVersionUID = 8655102312836299584L;
	
	private String id;
	private String name;
	
	private List<UAVSARDataItem> dataItems;
	
	public UAVSARCategory(String id, String name) {
		this(id, name, new ArrayList<UAVSARDataItem>());
	}
	
	public UAVSARCategory(String id, String name, List<UAVSARDataItem> data) {
		this.id = id;
		this.name = name;
		this.dataItems = data;
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

	public List<UAVSARDataItem> getDataItems() {
		return dataItems;
	}

	public void setDataItems(List<UAVSARDataItem> dataItems) {
		this.dataItems = dataItems;
	}
	
	public void addDataItem(UAVSARDataItem item) {
		dataItems.add(item);
	}

}
