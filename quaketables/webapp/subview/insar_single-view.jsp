<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="edu.usc.sirlab.*"%>
<%@ page import="edu.usc.sirlab.db.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.net.*"%>
<%@ page import="java.util.*"%>
<%! DatabaseQuery dbQuery; %>
<%
	dbQuery = new DatabaseQuery();
%>
<%	Interferogram insar = dbQuery.getInerferogram(request.getParameter("iid")); 
	String breadCrumbURL = "insar.jsp?iid=" + insar.getId();
	String kmlURL = "iid=" + insar.getId() + "&ov=0";
%>

<jsp:include page="header.jsp">
	<jsp:param name="gmap" value="<%= kmlURL%>"/>
	<jsp:param name="breadCrumb1" value="InSAR Interferograms"/>
	<jsp:param name="breadCrumb1Url" value="insar.jsp"/>
	<jsp:param name="breadCrumb2" value="Interferogram Details Page"/>
	<jsp:param name="breadCrumb2Url" value="<%= breadCrumbURL%>"/>
</jsp:include>

    <!-- C. MAIN SECTION -->      
    <div class="main">
	   <h1 class="pagetitle"><%= insar.getTitle()%></h1>
      <!-- C.1 CONTENT -->
      <div class="content">
        <!-- CONTENT CELL -->                
        <div class="corner-content-1col-top"></div>                        
        <div class="content-1col-nobox">
          <h1><%= insar.getTitle()%></h1>
          <p><%= insar.getDescription() %></p>
          
          <p><a href="kml?iid=<%= insar.getId() %>" title="View using Google Earth" target="_blank"><img class="rightnb" src="img/google-earth.jpg" alt="Google Earth Icon" title="View using Google Earth" /></a>The following data items are available for this interferogram:</p>
          <ul>
          	<li><a href="http://gf19.ucs.indiana.edu:9898/insar-data/<%= insar.getDataURL()%>" title="Data File">Data File [unwrapped, geo-coded]</a></li>
          	<li><a href="http://gf19.ucs.indiana.edu:9898/insar-data/<%= insar.getMetaDataURL()%>" title="Metadata File" target="_blank">Metadata File [text]</a></li>
          	<li><a href="http://gf19.ucs.indiana.edu:9898/insar-data/<%= insar.getImageURL()%>" title="Interferogram Image" target="_blank">Full size Image rendering of the data</a></li>
          	<li><a href="kml?iid=<%= insar.getId() %>" title="Google Earth KML File" target="_blank">KML File for Mapping [Google Earth]</a></li>
          </ul>
          
          <div id="map_canvas" class="map" style="width: 640px; height: 480px;"></div>
          <br></br>
          
          <p><a href="http://gf19.ucs.indiana.edu:9898/insar-data/<%= insar.getImageURL()%>" target="_blank"><img class="center" width="600" alt="Interferogram Thumbnail" src="http://gf19.ucs.indiana.edu:9898/insar-data/<%= insar.getThumbnailURL()%>" /></a></p>
          
        </div> 
        <div class="corner-content-1col-bottom"></div>
        <div class="corner-content-1col-top"></div>                        
        <div class="content-1col-nobox">
          <h1>Meta Data Table</h1>
          <table>
          <%
				URL url = new URL("http://gf19.ucs.indiana.edu:9898/insar-data/" + insar.getMetaDataURL());
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
			%>
			</table>
        </div> 
        <div class="corner-content-1col-bottom"></div>
        <!-- CONTENT CELL -->                
      </div>
      <!-- C.2 SUBCONTENT -->
    </div>
<% dbQuery.closeConnection(); %>
<jsp:include page="footer.jsp"/>