<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="edu.usc.sirlab.*"%>
<%@ page import="edu.usc.sirlab.db.*"%>
<%! DatabaseQuery dbQuery; %>
<%
	dbQuery = new DatabaseQuery();
%>
<jsp:include page="header.jsp">
	<jsp:param name="breadCrumb1" value="InSAR Interferograms"/>
	<jsp:param name="breadCrumb1Url" value="insar.jsp"/>
</jsp:include>

    <!-- C. MAIN SECTION -->      
    <div class="main">

      <!-- C.1 CONTENT -->
      <div class="content">
        <!-- CONTENT CELL -->                
        <div class="corner-content-1col-top"></div>                        
        <div class="content-1col-nobox">
          <h1>InSAR Interferograms</h1>
          <h5>QuakeTables provides access to 95 interferograms of California. These interferograms were provided by <a href="http://science.jpl.nasa.gov/people/Lundgren/" title="Paul Lundgren's Webpage" target="_blank">Paul Lundgren</a> from JPL</h5>
          <p>The interferograms can be access through:</p>
          <ul>
          	<li><a href="insar.jsp?v=g" title="InSAR Grid View">Grid View</a>: interferograms are displayed with selected information</li>
          	<li><a href="insar.jsp?v=m" title="Interferogram Map View">Map View</a>: interferograms are displayed on a Map</li>
          </ul>
        </div> 
        <div class="corner-content-1col-bottom"></div>                       

        <!-- CONTENT CELL -->                
      </div>

      <!-- C.2 SUBCONTENT -->
    </div>
<% dbQuery.closeConnection(); %>
<jsp:include page="footer.jsp"/>