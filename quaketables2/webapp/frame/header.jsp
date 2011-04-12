<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.util.*" %>
<%@ page import = "edu.usc.sirlab.*" %>
<%@ page import = "edu.usc.sirlab.db.*" %>
<%@ page import = "edu.usc.sirlab.tools.*" %>
<%! DatabaseQuery dbQuery;
	final String GMAP_URL = "http://quaketables.quakesim.org/kml?";
%>
<%
	dbQuery = new DatabaseQuery();
	KMLJavaScriptHelper kmljs = new KMLJavaScriptHelper(dbQuery);
%>

<%
	//<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"> 
<html xmlns="http://www.w3.org/1999/xhtml" lang="en">
<head>
  <meta http-equiv="content-type" content="text/html; charset=utf-8" />
  <link rel="stylesheet" type="text/css" media="screen,projection,print" href="./css/mf54_reset.css" />
  <%if(request.getParameter("sidebar") != null && request.getParameter("sidebar").equalsIgnoreCase("true")) {%>
    <link rel="stylesheet" type="text/css" media="screen,projection,print" href="./css/mf54_grid.css" />
    <link rel="stylesheet" type="text/css" media="screen,projection,print" href="./css/mf54_content.css" />
  <%} else{ %>
    <link rel="stylesheet" type="text/css" media="screen,projection,print" href="./css/mf54_grid_nosidebar.css" />
    <link rel="stylesheet" type="text/css" media="screen,projection,print" href="./css/mf54_content_nosidebar.css" />
  <%} %>
  <script type="text/javascript" src="scripts/checkboxgroup.js"></script>
  <script type="text/javascript" src="scripts/google-analytics.js"></script>
  <link rel="icon" type="image/x-icon" href="./img/favicon.ico" />
  <title>QuakeTables - The QuakeSim Database</title>
  
  <%if(request.getParameter("gmap") != null) {
	//TODO: Make it generic
	String mapURL;
	List<GeoPoint> points;
	mapURL = GMAP_URL + request.getParameter("gmap");
	points = kmljs.getPoints(request.getParameter("gmap"));	  
  %>
  <script src="http://maps.google.com/maps?file=api&amp;v=2&amp;sensor=false&amp;key=ABQIAAAAUkTff_jwi_yqiWcjRg9NxhTsULoSST2lX021Mx9b7Pv4zwdIFRQ6Slf2n4KaDbwaTDpq_CPz1cqkZw"
          type="text/javascript"></script>
  <script src="scripts/gmapscripts.js" type="text/javascript"></script>
  <script type="text/javascript">
      var map;
      var geoXml;
      function initialize() {
        if (GBrowserIsCompatible()) {
        	map = new GMap2(document.getElementById("map_canvas"));
        	geoXml = new GGeoXml("<%= mapURL%>");   
        	map.setCenter(new GLatLng(34.019, -118.287));

        	var points = new Array();
        	<%
        		for(GeoPoint p : points) {
        		%>
        		var point = new GLatLng(<%= p.getLat()%>, <%= p.getLon()%>);
        		points.push( point );
        		<%
        		}
        	%>
        	map.addOverlay(geoXml);
        	map.setUIToDefault();
        	fitMap(map, points);
        }
    } 
  </script>
  <%} %> 
</head>

<!-- Global IE fix to avoid layout crash when single word size wider than column width -->
<!-- Following line MUST remain as a comment to have the proper effect -->
<!--[if IE]><style type="text/css"> body {word-wrap: break-word;}</style><![endif]-->
<%if(request.getParameter("gmap") != null) {%>
<body onload="initialize()" onunload="GUnload()">
<%} else {%>
<body>
<%} %>
  <!-- CONTAINER FOR ENTIRE PAGE -->
<% dbQuery.closeConnection();%>
