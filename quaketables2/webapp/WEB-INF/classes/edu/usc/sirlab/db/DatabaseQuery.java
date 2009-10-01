package edu.usc.sirlab.db;

import java.io.Serializable;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import edu.usc.sirlab.*;


public class DatabaseQuery implements Serializable {
	private static final long serialVersionUID = 5185656606746489628L;
	
	private DatabaseConnection dbConnection;
	
	public DatabaseQuery() throws IllegalAccessException, InstantiationException, ClassNotFoundException, SQLException {
		dbConnection = new DatabaseConnection();
		dbConnection.connect();
	}
	
	public DatabaseQuery(DatabaseConnection dbConnection) {
		this.dbConnection = dbConnection;
	}
	
	public int getInterferogramCount() throws SQLException, IllegalAccessException, InstantiationException, ClassNotFoundException {
		int count = 0;
		ResultSet rs = dbConnection.executeQuery("SELECT COUNT(*) FROM insar_interferogram");
		if(rs.next())
			count = rs.getInt(1);
		
		
		return count;
	}
	
	public List<Interferogram> getInerferograms() throws SQLException, IllegalAccessException, InstantiationException, ClassNotFoundException {
		List<Interferogram> insars = new ArrayList<Interferogram>();
		ResultSet rs = dbConnection.executeQuery("SELECT * FROM insar_interferogram ORDER BY date_start");
		
		while(rs.next()) {
			int id = rs.getInt("id");
			String title = rs.getString("title");
			String description = rs.getString("description");
			GeoPoint ref1 = new GeoPoint(rs.getDouble("point1_lat"), rs.getDouble("point1_lon"));
			GeoPoint ref2 = new GeoPoint(rs.getDouble("point2_lat"), rs.getDouble("point2_lon"));
			GeoPoint ref3 = new GeoPoint(rs.getDouble("point3_lat"), rs.getDouble("point3_lon"));
			GeoPoint ref4 = new GeoPoint(rs.getDouble("point4_lat"), rs.getDouble("point4_lon"));
			Date start = rs.getDate("date_start");
			Date end = rs.getDate("date_end");
			double timespan = rs.getDouble("timespan");
			int width = rs.getInt("width");
			int length = rs.getInt("length");
			String dataURL = rs.getString("data_file_url");
			String metaURL = rs.getString("meta_file_url");
			String imageURL = rs.getString("image_url");
			String thumbnailURL = rs.getString("thumbnail_url");
			
			Interferogram insar = new Interferogram(id, title, description, ref1, ref2, ref3, ref4, start, end, dataURL, metaURL, imageURL, thumbnailURL, timespan, width, length);
			insars.add(insar);
		}
		
		return insars;
	}
	
	public List<Interferogram> getInerferograms(int limitStart, int limitEnd) throws SQLException, IllegalAccessException, InstantiationException, ClassNotFoundException {
		List<Interferogram> insars = new ArrayList<Interferogram>();
		PreparedStatement statement = dbConnection.getPreparedStatement("SELECT * FROM insar_interferogram ORDER BY date_start LIMIT ?, ?");
		statement.setInt(1, limitStart);
		statement.setInt(2, limitEnd);
		ResultSet rs = statement.executeQuery();
		
		while(rs.next()) {
			int id = rs.getInt("id");
			String title = rs.getString("title");
			String description = rs.getString("description");
			GeoPoint ref1 = new GeoPoint(rs.getDouble("point1_lat"), rs.getDouble("point1_lon"));
			GeoPoint ref2 = new GeoPoint(rs.getDouble("point2_lat"), rs.getDouble("point2_lon"));
			GeoPoint ref3 = new GeoPoint(rs.getDouble("point3_lat"), rs.getDouble("point3_lon"));
			GeoPoint ref4 = new GeoPoint(rs.getDouble("point4_lat"), rs.getDouble("point4_lon"));
			Date start = rs.getDate("date_start");
			Date end = rs.getDate("date_end");
			double timespan = rs.getDouble("timespan");
			int width = rs.getInt("width");
			int length = rs.getInt("length");
			String dataURL = rs.getString("data_file_url");
			String metaURL = rs.getString("meta_file_url");
			String imageURL = rs.getString("image_url");
			String thumbnailURL = rs.getString("thumbnail_url");
			
			Interferogram insar = new Interferogram(id, title, description, ref1, ref2, ref3, ref4, start, end, dataURL, metaURL, imageURL, thumbnailURL, timespan, width, length);
			insars.add(insar);
		}
		
		return insars;
	}
	
	public Interferogram getInerferogram(String iid) throws SQLException, IllegalAccessException, InstantiationException, ClassNotFoundException {
		Interferogram insar = null;
		PreparedStatement statement = dbConnection.getPreparedStatement("SELECT * FROM insar_interferogram WHERE id = ?");
		statement.setString(1, iid);
		ResultSet rs = statement.executeQuery();
		
		if(rs.next()) {
			int id = rs.getInt("id");
			String title = rs.getString("title");
			String description = rs.getString("description");
			GeoPoint ref1 = new GeoPoint(rs.getDouble("point1_lat"), rs.getDouble("point1_lon"));
			GeoPoint ref2 = new GeoPoint(rs.getDouble("point2_lat"), rs.getDouble("point2_lon"));
			GeoPoint ref3 = new GeoPoint(rs.getDouble("point3_lat"), rs.getDouble("point3_lon"));
			GeoPoint ref4 = new GeoPoint(rs.getDouble("point4_lat"), rs.getDouble("point4_lon"));
			Date start = rs.getDate("date_start");
			Date end = rs.getDate("date_end");
			double timespan = rs.getDouble("timespan");
			int width = rs.getInt("width");
			int length = rs.getInt("length");
			String dataURL = rs.getString("data_file_url");
			String metaURL = rs.getString("meta_file_url");
			String imageURL = rs.getString("image_url");
			String thumbnailURL = rs.getString("thumbnail_url");
			
			insar = new Interferogram(id, title, description, ref1, ref2, ref3, ref4, start, end, dataURL, metaURL, imageURL, thumbnailURL, timespan, width, length);
		}
		
		return insar;
	}
	
	public List<CGSFault> getCGSFaults(String dataSetID) throws SQLException, IllegalAccessException, InstantiationException, ClassNotFoundException {
		List<CGSFault> faults = new ArrayList<CGSFault>();
		FaultDataSet dataset = getFaultDataSet(dataSetID);
		
		
		PreparedStatement statement = dbConnection.getPreparedStatement("SELECT * FROM data_cgs WHERE data_set_id = ? ORDER BY entry_id");
		statement.setString(1, dataset.getId());
		ResultSet rs = statement.executeQuery();
		while(rs.next()) {
			CGSFault f = new CGSFault(dataset, rs.getString("entry_id"), rs.getString("fault_name"));
			f.setFaultClass(rs.getString("fault_class"));
			f.setZone(rs.getString("fault_zone"));
			f.setGeometry(rs.getString("geometry"));
			f.setGeometryDirection(rs.getString("geometry_direction"));
			f.setLength(rs.getDouble("length"));
			f.setLengthError(rs.getDouble("length_error"));
			f.setSlipRate(rs.getDouble("slip_rate"));
			f.setSlipRateError(rs.getDouble("slip_rate_error"));
			f.setRank(rs.getString("rank"));
			f.setmMax(rs.getDouble("mmax"));
			f.setCharRate(rs.getDouble("char_rate"));
			f.setRecurrence(rs.getDouble("recurrence"));
			f.setDownDipWidth(rs.getDouble("down_dip_width"));
			f.setDownDipWidthError(rs.getDouble("down_dip_width_error"));
			f.setRupTop(rs.getDouble("rup_top"));
			f.setRupBottom(rs.getDouble("rup_bot"));
			f.setRake(rs.getDouble("rake"));
			f.setDip(rs.getDouble("dip"));
			f.setDaz(rs.getDouble("daz"));
			f.setComment(rs.getString("comment"));
			
			FaultTracePoint start = new FaultTracePoint(rs.getDouble("start_point_lat"), rs.getDouble("start_point_lon"), 0.0);
			FaultTracePoint end = new FaultTracePoint(rs.getDouble("end_point_lat"), rs.getDouble("end_point_lon"), 0.0);
			f.addTracePoint(start);
			f.addTracePoint(end);
			
			faults.add(f);
		}
		
		return faults;
	}
	
	public List<FaultDataSet> getFaultDataSets() throws SQLException, IllegalAccessException, InstantiationException, ClassNotFoundException {		
		List<FaultDataSet> datasets = new ArrayList<FaultDataSet>();
		ResultSet rs = dbConnection.executeQuery("SELECT id, name, nick_name, title, description, download_url, entry_count, data_type FROM data_set_definition ORDER BY nick_name");
		while(rs.next()) {
			FaultDataSet fds = new FaultDataSet(rs.getString("id"), rs.getString("name"), rs.getString("nick_name"), rs.getString("title"), rs.getString("description"), rs.getString("download_url"), rs.getInt("entry_count"), rs.getString("data_type"));
			datasets.add(fds);
		}
		
		return datasets;
	}
	
	public FaultDataSet getFaultDataSet(String id) throws SQLException {
		FaultDataSet dataset = null;
		PreparedStatement statement = dbConnection.getPreparedStatement("SELECT id, name, nick_name, title, description, download_url, entry_count, data_type FROM data_set_definition WHERE id = ? ORDER BY nick_name");
		statement.setString(1, id);
		ResultSet rs = statement.executeQuery();
		if(rs.next()) {
			dataset = new FaultDataSet(rs.getString("id"), rs.getString("name"), rs.getString("nick_name"), rs.getString("title"), rs.getString("description"), rs.getString("download_url"), rs.getInt("entry_count"), rs.getString("data_type"));
		}
		
		return dataset;
	}
}
