<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="edu.usc.sirlab.*"%>
<%@ page import="edu.usc.sirlab.db.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.net.*"%>
<%@ page import="java.text.*"%>
<%@ page import="java.util.*"%>
<%! DatabaseQuery dbQuery; %>
<%! SimpleDateFormat longFormat = new SimpleDateFormat("MMMMM dd, yyyy @ hh:mm:ss aaa"); %>
<%! //TODO: FIX URL Pattern
	String UAVSAR_BASE = "http://gf19.ucs.indiana.edu:9898/uavsar-data/"; %>
<%
	if(session.getAttribute("dbQuery") == null) {
		dbQuery = new DatabaseQuery();
		session.setAttribute("dbQuery", dbQuery);
	}
	else
		dbQuery = (DatabaseQuery) session.getAttribute("dbQuery");
%>
<%	UAVSAR uavsar = dbQuery.getUAVSAR(request.getParameter("uid")); 
	String breadCrumbURL = "uavsar.jsp?uid=" + uavsar.getId();
	//String kmlURL = uavsar.getKmlURL();
	String kmlURL = "uid=" + uavsar.getId();
%>

<jsp:include page="header.jsp">
	<jsp:param name="gmap" value="<%= kmlURL%>"/>
	<jsp:param name="breadCrumb1" value="UAVSAR RPI"/>
	<jsp:param name="breadCrumb1Url" value="uavsar.jsp"/>
	<jsp:param name="breadCrumb2" value="Interferogram Details Page"/>
	<jsp:param name="breadCrumb2Url" value="<%= breadCrumbURL%>"/>
</jsp:include>

    <!-- C. MAIN SECTION -->      
    <div class="main">
	   <h1 class="pagetitle"><%= uavsar.getTitle()%></h1>
      <!-- C.1 CONTENT -->
      <div class="content">
        <!-- CONTENT CELL -->                
        <div class="corner-content-1col-top"></div>                        
        <div class="content-1col-nobox">
          <h1><%= uavsar.getTitle()%></h1>
          <h5>Product Information</h5>
          <p><a href="kml?uid=<%= uavsar.getId() %>" title="View using Google Earth"><img class="rightnb" src="img/google-earth.jpg" alt="Google Earth Icon" title="View using Google Earth" /></a><ul>
          	<li><b>Site Description</b>: <%= uavsar.getDescription()%></li>
          	<li><b>Time of Acquisition for Pass 1</b>: <%= longFormat.format(uavsar.getDate1())%> UTC</li>
          	<li><b>Time of Acquisition for Pass 2</b>: <%= longFormat.format(uavsar.getDate2())%> UTC</li>
          	<li><b>Links</b>: <a href="<%= UAVSAR_BASE + uavsar.getMetaDataURL()%>" title="Metadata for Interferogram">[Meta Data]</a>, <a href="<%= UAVSAR_BASE + uavsar.getImageURL()%>" title="Interferogram URL">[Thumbnail]</a>, <a href="<%= UAVSAR_BASE + uavsar.getKmlURL()%>" title="Low Resolution KML File">[KML]</a> </li>
          	<li><b>Source</b>: <a href="<%= uavsar.getSourceURL()%>" title="JPL UAVSAR Project RPI Project Page">JPL UAVSAR Project</a></li>
          </ul>
          <br>
          <%-- <p><a href="<%= uavsar.getImageURL()%>"><img class="center" width="600" alt="Interferogram Thumbnail" src="<%= UAVSAR_BASE + uavsar.getImageURL()%>" /></a></p>  --%>
          
          <%
          List<UAVSARCategory> categories = uavsar.getDataCategories();
          for(UAVSARCategory cat : categories) {
        	  %><h5><%= cat.getName()%></h5>
        	  <ul>
        	  <%
        	  List<UAVSARDataItem> items =  cat.getDataItems();
        	  for(UAVSARDataItem i : items) {
        		  %><li>
        		  	<b><%= i.getName()%></b>: 
        		  	<% if(i.getUrl() != null) {%><a href="<%= UAVSAR_BASE + i.getUrl()%>" title="Download Data File">[Data]</a><%} %>
        		  	<% if(i.getVisualizationURL() != null) {%><a href="<%= UAVSAR_BASE + i.getVisualizationURL()%>" title="GoogleEarth KMZ File">[KMZ (high res.)]</a><%} %> 
        		  	<% if(i.getVisualizationPreviewURL() != null) {%><a href="<%= UAVSAR_BASE + i.getVisualizationPreviewURL()%>" title="Low Resolution KML File">[KML (low res.)]</a><%} %>
        		  </li><%
        	  }
        	  %></ul>
        	  <br><%
          }
          %>
          
          <br>
          <br>
          
          <div id="map_canvas" class="map" style="width: 640px; height: 480px;"></div>
          <br></br>
          
        </div> 
        <div class="corner-content-1col-bottom"></div>
        <div class="corner-content-1col-top"></div>                        
        <div class="content-1col-nobox">
          <h1>Meta Data Table</h1>
          <table>
          <%--
				URL url = new URL(uavsar.getMetaDataURL());
				BufferedReader min = new BufferedReader(new InputStreamReader(url.openStream()));
				String line;
				StringTokenizer tokenizer;
				
				while((line = min.readLine()) != null) {
					line = line.trim();
					if(line.equals(""))
						continue;
					else if(line.startsWith("#"))
						continue;
					
					tokenizer = new StringTokenizer(line, " \t\n");			
					%><tr><th class="top" scope="col"><%= tokenizer.nextToken()%></th><td><%= tokenizer.nextToken()%></td></tr><%
				}
				min.close();
			--%>
			</table>
        </div> 
        <div class="corner-content-1col-bottom"></div>
        <!-- CONTENT CELL -->                
      </div>
      <!-- C.2 SUBCONTENT -->
    </div>
<jsp:include page="footer.jsp"/>