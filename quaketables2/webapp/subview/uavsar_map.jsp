<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="edu.usc.sirlab.*"%>
<%@ page import="edu.usc.sirlab.db.*"%>
<%@ page import="java.util.*"%>
<%! DatabaseQuery dbQuery; 
	int limitStart = 0;
	int limitStep = 10;
%>
<%
	dbQuery = new DatabaseQuery();

	//String kmlURL = "uid=all" + "&ov=0";
	String kmlURL = "uid=all" + "&lowres=0";
%>

<jsp:include page="header.jsp">
	<jsp:param name="gmap" value="<%= kmlURL%>"/>
	<jsp:param name="breadCrumb1" value="InSAR Interferograms"/>
	<jsp:param name="breadCrumb1Url" value="insar.jsp"/>
	<jsp:param name="breadCrumb2" value="Interferogram Map View"/>
	<jsp:param name="breadCrumb2Url" value="insar.jsp?v=g"/>
</jsp:include>

    <!-- C. MAIN SECTION -->      
    <div class="main">
	   <h1 class="pagetitle">UAVSAR PRI Products on QuakeTables</h1>
      <!-- C.1 CONTENT -->
      <div class="content">
        <!-- CONTENT CELL -->                
        <div class="corner-content-1col-top"></div>                        
        <div class="content-1col-nobox">
          <h1>UAVSAR PRI Map</h1>
          <div id="map_canvas" class="map" style="width: 640px; height: 480px;"></div>
          <br></br>
        </div>
        <div class="corner-content-1col-bottom"></div>
        <!-- CONTENT CELL -->                
      </div>
      <!-- C.2 SUBCONTENT -->
    </div>
<% dbQuery.closeConnection(); %>
<jsp:include page="footer.jsp"/>