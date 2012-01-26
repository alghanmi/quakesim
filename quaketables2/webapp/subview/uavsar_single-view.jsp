<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="edu.usc.sirlab.*"%>
<%@ page import="edu.usc.sirlab.db.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.net.*"%>
<%@ page import="java.text.*"%>
<%@ page import="java.util.*"%>
<%! DatabaseQuery dbQuery; %>
<%! SimpleDateFormat longFormat = new SimpleDateFormat("MMMMM dd, yyyy @ hh:mm:ss aaa"); %>
<%! SimpleDateFormat middleFormat = new SimpleDateFormat("yyyy-MM-dd @ hh:mm aaa"); %>
<%! DecimalFormat df = new DecimalFormat("#.###"); %>
<%! //TODO: FIX URL Pattern
	//String UAVSAR_BASE = "http://gf19.ucs.indiana.edu:9898/uavsar-data/";
	String UAVSAR_BASE = "http://quakesim.usc.edu/uavsar-data/";
%>
<%
	dbQuery = new DatabaseQuery();
%>
<%	UAVSAR uavsar = dbQuery.getUAVSAR(request.getParameter("uid")); 
	String breadCrumbURL = "uavsar.jsp?uid=" + uavsar.getId();
	//String kmlURL = uavsar.getKmlURL();
	String kmlURL = "uid=" + uavsar.getId();
	String passDiff = df.format(Math.abs((uavsar.getDate2().getTime() - uavsar.getDate1().getTime()) / 1000 / 60 / 60 / 24)).toString();
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
          	<li><b>Flight Line</b>: <%= uavsar.getFlightLine()%></li>
          	<li><b>Time of Acquisition for Pass 1</b>: <%= longFormat.format(uavsar.getDate1())%> UTC</li>
          	<li><b>Time of Acquisition for Pass 2</b>: <%= longFormat.format(uavsar.getDate2())%> UTC</li>
          	<li><b>Duration Between Passes</b>: <%= passDiff%> days</li>
          	<li><b>Links</b>: <a href="<%= UAVSAR_BASE + uavsar.getMetaDataURL()%>" title="Metadata for Interferogram" target="_blank">[Meta Data]</a>, <a href="<%= UAVSAR_BASE + uavsar.getImageURL()%>" title="Interferogram URL" target="_blank">[Thumbnail]</a>, <a href="kml?uid=<%= uavsar.getId() %>" title="Low Resolution KML File" target="_blank">[KML]</a> </li>
          	<li><b>Source</b>: <a href="<%= uavsar.getSourceURL()%>" title="JPL UAVSAR Project RPI Project Page" target="_blank">JPL UAVSAR Project</a></li>
          </ul>
          <br>
          
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
        		  	<% if(i.getUrl() != null) {%><a href="<%= i.getUrl()%>" title="Download Data File">[Data]</a><%} %>
        		  	<% if(i.getVisualizationURL() != null) {%><a href="<%= i.getVisualizationURL()%>" title="GoogleEarth KMZ File">[KMZ (high res.)]</a><%} %> 
        		  	<% if(i.getVisualizationPreviewURL() != null) {%><a href="<%= i.getVisualizationPreviewURL()%>" title="Low Resolution KML File" target="_blank">[KML (low res.)]</a><%} %>
        		  </li><%
        	  }
        	  %></ul>
        	  <br><%
          }
          %>
          <br>
          <%
          List<UAVSAR> relatedProducts = uavsar.getRelatedProducts();
          if(relatedProducts != null && relatedProducts.size() > 0) {
       	  %>
       	  	<h3>Related RPI Products</h3>
       	  	<ul>
       	  	<%
       	  		for(UAVSAR rp : relatedProducts) {
       	  			%><li><a href="uavsar.jsp?uid=<%= rp.getId()%>"><%= rp.getTitle()%></a> [<%= middleFormat.format(rp.getDate1())%> &#150; <%= middleFormat.format(rp.getDate2())%>]</li><%
       	  		}
       	  	%>
       	  	</ul>
       	  <%
          }
          %>
          <br>
          <%-- 
          <p><a href="<%= uavsar.getImageURL()%>"><img class="center" width="600" alt="Interferogram Thumbnail" src="<%= UAVSAR_BASE + uavsar.getImageURL()%>" /></a></p>
          --%>
          <br>
          
          <div id="map_canvas" class="map" style="width: 640px; height: 480px;"></div>
          <br></br>
          
        </div> 
        <div class="corner-content-1col-bottom"></div>
        <%--
        <div class="corner-content-1col-top"></div>                        
        <div class="content-1col-nobox">
          <h1>Meta Data Table</h1>
          <table>
          		URL url = new URL(UAVSAR_BASE + uavsar.getMetaDataURL());
				BufferedReader min = new BufferedReader(new InputStreamReader(url.openStream()));
				String line;
				StringTokenizer tokenizer;
				
				while((line = min.readLine()) != null) {
					line = line.trim();
					if(line.equals(""))
						continue;
					//else if(line.startsWith("#"))
						//continue;
					
					tokenizer = new StringTokenizer(line, " \t\n");
					int tokens = tokenizer.countTokens();
					%><tr>
						<th class="top" scope="col"><%= tokenizer.nextToken()%></th>
						<% for(int i = 0; i < tokens - 1; i++) {%>
						<td><%= tokenizer.nextToken()%></td>
						<%} %>
					</tr><%
				}
				min.close();
			</table>
        </div> 
        <div class="corner-content-1col-bottom"></div>
        --%>
        <!-- CONTENT CELL -->                
      </div>
      <!-- C.2 SUBCONTENT -->
    </div>
<% dbQuery.closeConnection(); %>
<jsp:include page="footer.jsp"/>