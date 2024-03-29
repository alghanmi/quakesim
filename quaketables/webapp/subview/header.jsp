<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.util.*" %>
<%@ page import = "edu.usc.sirlab.*" %>
<%@ page import = "edu.usc.sirlab.db.*" %>
<%@ page import = "edu.usc.sirlab.tools.*" %>
<%! DatabaseQuery dbQuery;
	//final String GMAP_URL = "http://quaketables.quakesim.org/kml?";
	final String GMAP_URL = "http://quakesim.usc.edu/quaketables/kml?";
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
  	String requestMapURL = request.getParameter("gmap");
  	if(requestMapURL.startsWith("http://") || requestMapURL.startsWith("https://"))
  		mapURL = requestMapURL;
  	else
  		mapURL = GMAP_URL + request.getParameter("gmap");
  	
	//List<GeoPoint> points;
	//points = kmljs.getPoints(request.getParameter("gmap"));	  
  %>
  <script type="text/javascript" src="http://maps.google.com/maps/api/js?sensor=false"></script>
  <script type="text/javascript">
	var map;
	var geoXml;
	function initialize() {
		var config = {
			zoom: 10,
			center: new google.maps.LatLng(34.019, -118.287),
			mapTypeId: google.maps.MapTypeId.TERRAIN
		};
		map = new google.maps.Map(document.getElementById("map_canvas"), config);

		var kml = new google.maps.KmlLayer('<%= mapURL%>');
		kml.setMap(map);
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
  <div class="container">

    <!-- A. HEADER -->         
    <div class="corner-page-top"></div>        
    <div class="header">
      <div class="header-top">
        
        <!-- A.1 SITENAME -->      
        <a class="sitelogo" href="index.jsp" title="Home"></a>
        <div class="sitename">
          <h1><a href="index.jsp" title="Home">QuakeTables</a></h1> 
          <h2>The QuakeSim Database</h2>
        </div>
    
        <!-- A.2 BUTTON NAVIGATION -->
	<!--
        <div class="navbutton">
          <ul>
            <li><a href="#" title="English"><img src="./img/icon_flag_us.gif" alt="Flag" /></a></li>
            <li><a href="#" title="Deutsch"><img src="./img/icon_flag_de.gif" alt="Flag" /></a></li>
            <li><a href="#" title="Svenska"><img src="./img/icon_flag_se.gif" alt="Flag" /></a></li>
            <li><a href="#" title="RSS"><img src="./img/icon_rss.gif" alt="RSS-Button" /></a></li>
          </ul>
        </div>
	-->

        <!-- A.3 GLOBAL NAVIGATION -->
	<!--
        <div class="navglobal">
          <ul>
            <li><a href="#" title="">About</a></li>
            <li><a href="#" title="">Contact</a></li>								
            <li><a href="#" title="">Sitemap</a></li>								                        
            <li><a href="#" title="">Links</a></li>								            
          </ul>
        </div>
	-->
      </div>
    
      <!-- A.4 BREADCRUMB and SEARCHFORM -->
      <div class="header-bottom">

        <!-- Breadcrumb -->
        <ul>
          <li class="nobullet">You are here:&nbsp;</li>
          <li><a href="index.jsp">Home</a></li>
          <% if(request.getParameter("breadCrumb1") != null) {%>
              <li><a href="<%= request.getParameter("breadCrumb1Url")%>"><%= request.getParameter("breadCrumb1")%></a></li>
          <% }%>
          <% if(request.getParameter("breadCrumb2") != null) {%>
              <li><a href="<%= request.getParameter("breadCrumb2Url")%>"><%= request.getParameter("breadCrumb2")%></a></li>
          <% }%>
          <% if(request.getParameter("breadCrumb3") != null) {%>
              <li><a href="<%= request.getParameter("breadCrumb3Url")%>"><%= request.getParameter("breadCrumb3")%></a></li>
          <% }%>
        </ul>

        <!-- Search form -->                  
        <div class="searchform">
          <form action="index.jsp" method="get">
            <fieldset>
              <input name="field" class="field"  value="" />
              <input type="submit" name="button" class="button" value="Search" />
            </fieldset>
          </form>
        </div>
      </div>
    </div>      
    <div class="corner-page-bottom"></div>    
    
    <!-- B. NAVIGATION BAR -->
    <div class="corner-page-top"></div>        
    <div class="navbar">
	
      <!-- Navigation item -->
      <ul>
        <li><a href="index.jsp">Home</a></li>
      </ul>
      <!-- Navigation item -->
      <ul>
        <li><a href="http://quakesim.org/">QuakeSim</a>
          <!--[if lte IE 6]><table><tr><td><![endif]-->
            <ul>
              <li><a href="http://quakesim.org" target="_blank">QuakeSim Project Website</a></li>
              <li><a href="http://portal.quakesim.org" target="_blank">QuakeSim Portal</a></li>
            </ul>
          <!--[if lte IE 6]></td></tr></table></a><![endif]-->
	    </li>
      </ul>            
      <!-- Navigation item -->
      <ul>
        <li><a href="fault.jsp">Fault Data Sets<!--[if IE 7]><!--></a><!--<![endif]-->
          <!--[if lte IE 6]><table><tr><td><![endif]-->
            <ul>
            <%
            	List<FaultDataSet> datasets = dbQuery.getFaultDataSets();
            	for(FaultDataSet ds : datasets) {
            		if(ds.isVisible()) {
            		%>
            		<li><a href="fault.jsp?ds=<%= ds.getId()%>" title="<%= ds.getName()%>"><%= ds.getNickName()%></a></li>
            		<%
            		}
            	}
            %>
              <li><a href="fault.jsp">View All Data Sets</a></li>
            </ul>
          <!--[if lte IE 6]></td></tr></table></a><![endif]-->
        </li>
      </ul>                  
      <!-- Navigation item -->
      <ul>
        <li><a href="insar.jsp">InSAR Interferograms</a>
            <!--[if lte IE 6]><table><tr><td><![endif]-->
            <ul>
              <li><a href="insar.jsp?v=g">InSAR Grid View</a></li>
              <li><a href="insar.jsp?v=m">Interferogram Map View</a></li>
            </ul>
            <!--[if lte IE 6]></td></tr></table></a><![endif]-->
        </li>
      </ul>
      <!-- Navigation item -->
      <ul>
        <li><a href="uavsar.jsp">UAVSAR RPI</a>
            <!--[if lte IE 6]><table><tr><td><![endif]-->
            <ul>
              <li><a href="uavsar.jsp?v=m">UAVSAR Map View</a></li>
              <li><a href="uavsar.jsp?v=l">UAVSAR List</a></li>
            </ul>
            <!--[if lte IE 6]></td></tr></table></a><![endif]-->
        </li>
      </ul>
    </div>

<% dbQuery.closeConnection();%>
