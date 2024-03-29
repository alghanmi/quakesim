package edu.usc.sirlab.tools;

import java.io.Serializable;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import edu.usc.sirlab.*;
import edu.usc.sirlab.db.*;

public class KMLJavaScriptHelper implements Serializable{
	private static final long serialVersionUID = 1L;
	private DatabaseQuery dbQuery;
	
	public KMLJavaScriptHelper(DatabaseQuery dbQuery) {
		this.dbQuery = dbQuery;
	}
	
	public List<GeoPoint> getPoints(String input) throws SQLException, IllegalAccessException, InstantiationException, ClassNotFoundException {
		List<GeoPoint> points = new ArrayList<GeoPoint>();
		String[] parameters = input.split("&");
		String fid = null, ds = null, iid = null, uid = null;
		
		for(int i = 0; i < parameters.length; i++) {
			String[] value = parameters[i].split("=");
			if(value[0].equalsIgnoreCase("fid"))
				fid = value[1];
			else if(value[0].equalsIgnoreCase("ds"))
				ds = value[1];
			else if(value[0].equalsIgnoreCase("iid"))
				iid = value[1];
			else if(value[0].equalsIgnoreCase("uid"))
				uid = value[1];
		}
		
		//Look for DataSet requests
		if(ds != null && fid == null) {
			FaultDataSet dataset = dbQuery.getFaultDataSet(ds);
			if(dataset != null && dataset.getDataType().equalsIgnoreCase("cgs_fault")) {
				List<CGSFault> faults = dbQuery.getCGSFaults(dataset.getId());
				for(CGSFault f : faults) {
					for(FaultTracePoint p : f.getTraces())
						points.add(p.getGeoPoint());
				}
			}
			
			if(dataset != null && dataset.getDataType().equalsIgnoreCase("ucerf2_fault")) {
				List<UCERFFault> faults = dbQuery.getUCERFFaults(dataset.getId());
				for(UCERFFault f : faults) {
					for(FaultTracePoint p : f.getTraces())
						points.add(p.getGeoPoint());
				}
			}
			
			else if(dataset != null && dataset.getDataType().equalsIgnoreCase("ncal_fault")) {
				List<NCALFault> faults = dbQuery.getNCALFaults();
				for(NCALFault f : faults) {
					for(FaultTracePoint p : f.getTraces())
						points.add(p.getGeoPoint());
				}
			}
		}
		
		//Look for Faults
		else if(ds != null && fid != null) {
			FaultDataSet dataset = dbQuery.getFaultDataSet(ds);
			if(dataset != null && dataset.getDataType().equalsIgnoreCase("cgs_fault")) {
				CGSFault fault = dbQuery.getCGSFault(dataset.getId(), fid);
				if(fault != null) {
					for(FaultTracePoint p : fault.getTraces())
						points.add(p.getGeoPoint());
				}
			}
			
			if(dataset != null && dataset.getDataType().equalsIgnoreCase("ucerf2_fault")) {
				UCERFFault fault = dbQuery.getUCERFFault(dataset.getId(), fid);
				if(fault != null) {
					for(FaultTracePoint p : fault.getTraces())
						points.add(p.getGeoPoint());
				}
			}
			
			else if(dataset != null && dataset.getDataType().equalsIgnoreCase("ncal_fault")) {
				NCALFault fault = dbQuery.getNCALFault(fid);
				if(fault != null) {
					for(FaultTracePoint p : fault.getTraces())
						points.add(p.getGeoPoint());
				}
			}
		}
		
		//Look for InSAR interferograms
		else if(iid != null) {
			List<Interferogram> insar;
			if(iid.equalsIgnoreCase("all")) {
				insar = dbQuery.getInerferograms();
			}
			else {
				 insar = new ArrayList<Interferogram>();
				 insar.add(dbQuery.getInerferogram(iid));
			}
			for(Interferogram i : insar) {
				points.add(new GeoPoint(i.getReference1().getLat(), i.getReference1().getLon())); 
				points.add(new GeoPoint(i.getReference2().getLat(), i.getReference2().getLon()));
				points.add(new GeoPoint(i.getReference3().getLat(), i.getReference3().getLon()));
				points.add(new GeoPoint(i.getReference4().getLat(), i.getReference4().getLon()));
			}
		}
		
		//UAVSAR Products
		else if(uid != null) {
			List<UAVSAR> uavsar;
			if(uid.equalsIgnoreCase("all")) {
				uavsar = dbQuery.getUAVSAR();
			}
			else {
				uavsar = new ArrayList<UAVSAR>();
				uavsar.add(dbQuery.getUAVSAR(uid));
			}
			for(UAVSAR u : uavsar) {
				points.add(new GeoPoint(u.getReference1().getLat(), u.getReference1().getLon()));
				points.add(new GeoPoint(u.getReference2().getLat(), u.getReference2().getLon()));
				points.add(new GeoPoint(u.getReference3().getLat(), u.getReference3().getLon()));
				points.add(new GeoPoint(u.getReference4().getLat(), u.getReference4().getLon()));
			}
		}
		
		return points;
	}
}
