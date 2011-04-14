<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ page import="edu.usc.sirlab.*"%>
<%@ page import="edu.usc.sirlab.db.*"%>
<%! DatabaseQuery dbQuery; %>
<%! SimpleDateFormat shortFormat = new SimpleDateFormat("MMM dd, yyyy @ hh:mm aaa"); %>
<%
	dbQuery = new DatabaseQuery();

	String kmlURL = "uid=all" + "&ov=0";
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
          <h5>QuakeTables provides access to <%= dbQuery.getUAVSARCount()%> RPI product(s) of California. These data products are provided by the <a href="http://uavsar.jpl.nasa.gov/" title="UAVSAR Project Page" target="_blank">JPL UAVSAR Project</a>:</h5>
          <ul>
          <%
          	List<UAVSAR> uavsar = dbQuery.getUAVSAR();
          	for(UAVSAR u : uavsar) {
          		%><li><a href="uavsar.jsp?uid=<%= u.getId()%>" title="<%= u.getTitle()%>"><%= u.getDescription()%></a>: [<%= shortFormat.format(u.getDate1())%>, <%= shortFormat.format(u.getDate2())%>]</li><%
          	}
          %>
          </ul>
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
<% dbQuery.closeConnection(); %>
<jsp:include page="footer.jsp"/>