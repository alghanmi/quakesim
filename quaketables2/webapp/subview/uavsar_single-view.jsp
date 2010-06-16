<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="edu.usc.sirlab.*"%>
<%@ page import="edu.usc.sirlab.db.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.net.*"%>
<%@ page import="java.util.*"%>
<%! DatabaseQuery dbQuery; %>
<%
	if(session.getAttribute("dbQuery") == null) {
		dbQuery = new DatabaseQuery();
		session.setAttribute("dbQuery", dbQuery);
	}
	else
		dbQuery = (DatabaseQuery) session.getAttribute("dbQuery");
%>
<%	UAVSAR uavsar = dbQuery.getUAVSAR(request.getParameter("iid")); 
	String breadCrumbURL = "uavsar.jsp?iid=" + uavsar.getId();
	String kmlURL = uavsar.getKmlURL();
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
          <p><%= uavsar.getDescription() %></p>
          
          <p><a href="kml?iid=<%= uavsar.getId() %>" title="View using Google Earth"><img class="rightnb" src="img/google-earth.jpg" alt="Google Earth Icon" title="View using Google Earth" /></a>The following products are available for this UAVSAR RPI:</p>
          <ul>
          	<li><a href="<%= uavsar.getMetaDataURL()%>" title="">Metadata File [text]</a></li>
          	<li><a href="<%= uavsar.getKmlURL() %>">KML File for Mapping (low resolution) [Google Earth]</a></li>
          </ul>
          
          <div id="map_canvas" class="map" style="width: 640px; height: 480px;"></div>
          <br></br>
          
          <p><a href="<%= uavsar.getImageURL()%>"><img class="center" width="600" alt="Interferogram Thumbnail" src="<%= uavsar.getImageURL()%>" /></a></p>
          
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