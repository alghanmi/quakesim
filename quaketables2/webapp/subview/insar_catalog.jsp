<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="edu.usc.sirlab.*"%>
<%@ page import="edu.usc.sirlab.db.*"%>
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

<jsp:include page="header.jsp">
	<jsp:param name="breadCrumb1" value="InSAR Interferograms"/>
	<jsp:param name="breadCrumb1Url" value="insar.jsp"/>
	<jsp:param name="breadCrumb2" value="InSAR Grid View"/>
	<jsp:param name="breadCrumb2Url" value="insar.jsp?v=g"/>
</jsp:include>

    <!-- C. MAIN SECTION -->      
    <div class="main">
	   <h1 class="pagetitle">InSAR Interferograms on QuakeTables</h1>
      <!-- C.1 CONTENT -->
      <div class="content">
        <!-- CONTENT CELL -->                
        <div class="corner-content-1col-top"></div>                        
        <div class="content-1col-nobox">
          <h1>InSAR Interferogram Overview</h1>
          <table>
          	<tr><th>Thumbnail</th><th>Location</th><th>Date</th><th>Timespan (year)</th><th>Width</th><th>Length</th></tr>
          	<%
          		List<Interferogram> insar = dbQuery.getInerferograms();
          		for(Interferogram i : insar) {	
          	%>
          	<tr>
          		<td align="center"><a href="insar.jsp?iid=<%= i.getId()%>"><img src="http://gf19.ucs.indiana.edu:9898/insar-data/<%= i.getThumbnailURL()%>" height="50" alt="InSAR Thumbnail" /></a></td>
          		<td align="center"><%= i.getReference1()%>, <%= i.getReference2()%>, <%= i.getReference3()%>, <%= i.getReference4()%></td>
          		<td align="center"><%= i.getStartDate()%> to <%= i.getEndDate()%></td>
          		<td align="center"><%= i.getTimespan()%></td>
          		<td align="center"><%= i.getWidth()%></td>
          		<td align="center"><%= i.getLength()%></td>
          	</tr>
          	<%
          		}
          	%>
          </table>
        </div> 
        <div class="corner-content-1col-bottom"></div>
        <!-- CONTENT CELL -->                
      </div>
      <!-- C.2 SUBCONTENT -->
    </div>
<jsp:include page="footer.jsp"/>