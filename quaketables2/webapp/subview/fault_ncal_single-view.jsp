<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="edu.usc.sirlab.*"%>
<%@ page import="edu.usc.sirlab.db.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.net.*"%>
<%@ page import="java.util.*"%>
<%! DatabaseQuery dbQuery;
	final String GMAP_URL = "http://quakesim.org/quaketables/kml?";
%>
<%
	if(session.getAttribute("dbQuery") == null) {
		dbQuery = new DatabaseQuery();
		session.setAttribute("dbQuery", dbQuery);
	}
	else
		dbQuery = (DatabaseQuery) session.getAttribute("dbQuery");
%>
<%	NCALFault fault = dbQuery.getNCALFault(request.getParameter("faultID"));
	String breadCrumbURL2 = "fault.jsp?ds=" + fault.getDataSet().getId();
	String breadCrumbURL = "fault.jsp?ds=" + fault.getDataSet().getId() + "&amp;fid=" + fault.getId();
	//TODO: find a better way to fix this URL
	String kmlURL = "ds=" + fault.getDataSet().getId() + "&fid=" + fault.getId() + "&color=ff00007f&mark=true";
%>

<jsp:include page="header.jsp">
	<jsp:param name="gmap" value="<%= kmlURL%>"/>
	<jsp:param name="breadCrumb1" value="Fault Data Sets"/>
	<jsp:param name="breadCrumb1Url" value="fault.jsp"/>
	<jsp:param name="breadCrumb2" value="<%= fault.getDataSet().getNickName()%>"/>
	<jsp:param name="breadCrumb2Url" value="<%= breadCrumbURL2%>"/>
	<jsp:param name="breadCrumb3" value="<%= fault.getName()%>"/>
	<jsp:param name="breadCrumb3Url" value="<%= breadCrumbURL%>"/>
</jsp:include>

    <!-- C. MAIN SECTION -->      
    <div class="main">
	   <h1 class="pagetitle"><%= fault.getDataSet().getTitle()%></h1>
      <!-- C.1 CONTENT -->
      <div class="content">
        <!-- CONTENT CELL -->                
        <div class="corner-content-1col-top"></div>                        
        <div class="content-1col-nobox">
          <h1><%= fault.getName()%></h1>
          <ul>
          <%
          	for(String[] param : fault.getHTMLParameters()) {
          		%><li><b><%= param[0]%></b>: <%= param[1]%></li><%
          	}
          %>
          </ul>
          <br/>
          <p><b>Source</b>: <a title="<%= fault.getDataSet().getNickName()%>" href="<%= breadCrumbURL2%>"><%= fault.getDataSet().getName()%></a></p>
        </div> 
        <div class="corner-content-1col-bottom"></div>
        <div class="corner-content-1col-top"></div>
        <div class="content-1col-nobox">
          <h1>Maps</h1>
          <p></p>
          <ul>
          	<li><a href="<%= GMAP_URL%><%= kmlURL%>" title="KML File" target="_blank">Download KML file for this fault [Google Earth]</a></li>
          	<li><a href="http://maps.google.com/?q=<%= GMAP_URL.replace("&", "%26")%><%= kmlURL.replace("&", "%26")%>" title="Google Maps" target="_blank">View the map in Google Maps</a></li>
          </ul>
		  <div id="map_canvas" class="map" style="width: 640px; height: 480px;"></div>
        </div> 
        <div class="corner-content-1col-bottom"></div>
        <!-- CONTENT CELL -->                
      </div>
      <!-- C.2 SUBCONTENT -->
    </div>
<jsp:include page="footer.jsp"/>