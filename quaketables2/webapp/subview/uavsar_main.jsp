<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="edu.usc.sirlab.*"%>
<%@ page import="edu.usc.sirlab.db.*"%>
<%! DatabaseQuery dbQuery; %>
<%
	if(session.getAttribute("dbQuery") == null) {
		dbQuery = new DatabaseQuery();
		session.setAttribute("dbQuery", dbQuery);
	}
	else
		dbQuery = (DatabaseQuery) session.getAttribute("dbQuery");

	String kmlURL = "http://uavsar.jpl.nasa.gov/Release2d/SanAnd_26501_09083-010_10028-000_0174d_s01_L090_01/SanAnd_26501_09083-010_10028-000_0174d_s01_L090HH_01.int.kml";
%>
<jsp:include page="header.jsp">
	<jsp:param name="gmap" value="<%= kmlURL%>"/>
	<jsp:param name="breadCrumb1" value="UAVSAR RPI"/>
	<jsp:param name="breadCrumb1Url" value="uavsar.jsp"/>
</jsp:include>

    <!-- C. MAIN SECTION -->      
    <div class="main">

      <!-- C.1 CONTENT -->
      <div class="content">
        <!-- CONTENT CELL -->                
        <div class="corner-content-1col-top"></div>                        
        <div class="content-1col-nobox">
          <h1>UAVSAR Repeat Pass Interferometry (RPI) Products</h1>
          <h5>QuakeTables provides access to <%= dbQuery.getUAVSARCount()%> PRI product(s) of California. These data products are provided by the <a href="http://uavsar.jpl.nasa.gov/" title="UAVSAR Project Page">JPL UAVSAR Project</a></h5>
          <p></p><p></p>
        </div> 
        <div class="corner-content-1col-bottom"></div>
        
        <div class="corner-content-1col-top"></div>
        <div class="content-1col-nobox">
          <h1>Maps</h1>
          <p></p>
		  <div id="map_canvas" class="map" style="width: 640px; height: 480px;"></div>
        </div> 
        <div class="corner-content-1col-bottom"></div>

        <!-- CONTENT CELL -->                
      </div>

      <!-- C.2 SUBCONTENT -->
    </div>
<jsp:include page="footer.jsp"/>