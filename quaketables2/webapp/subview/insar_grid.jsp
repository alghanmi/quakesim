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

	if(request.getParameter("s") != null && !request.getParameter("s").equalsIgnoreCase("")) {
		try {
			limitStart = Integer.parseInt(request.getParameter("s"));
		}catch (NumberFormatException e){};
	}
	if(request.getParameter("t") != null && !request.getParameter("t").equalsIgnoreCase("")) {
		try {
			limitStep = Integer.parseInt(request.getParameter("t"));
		}catch (NumberFormatException e){};
	}
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
          <%
          	List<Interferogram> insar = dbQuery.getInerferograms(limitStart, limitStep);
          	int insarCount = dbQuery.getInterferogramCount();
          %>
          <table>
          	<tr><th class="top" scope="col">Thumbnail</th><th class="top" scope="col">Location</th><th class="top" scope="col">Date</th><th class="top" scope="col">Timespan (year)</th><th class="top" scope="col">Width</th><th class="top" scope="col">Length</th><th class="top" scope="col">Location</th></tr>
          	<%
          		for(Interferogram i : insar) {
          			//TODO: Put the GMap key in a better place
          			
          			/*
          			String markers = "";
          			String markerColor = "red"; 
          			markers += i.getReference1().getLat() + "," + i.getReference1().getLon() + "," + markerColor + "|"; 
          			markers += i.getReference2().getLat() + "," + i.getReference2().getLon() + "," + markerColor + "|";
          			markers += i.getReference3().getLat() + "," + i.getReference3().getLon() + "," + markerColor + "|";
          			markers += i.getReference4().getLat() + "," + i.getReference4().getLon() + "," + markerColor + "|";
          			//*/
          			String path = "";
          			/* This feature is not working, so commented for now
          			//TODO: Investigate why path styles is not working
          			int pathWeight = 3;
          			String pathColor = "blue";
          			path = "weight:" + pathWeight + "|color:" + pathColor + "|";
          			*/
          			path += i.getReference1().getLat() + "," + i.getReference1().getLon() + "|";
          			path += i.getReference2().getLat() + "," + i.getReference2().getLon() + "|";
          			path += i.getReference4().getLat() + "," + i.getReference4().getLon() + "|";
          			path += i.getReference3().getLat() + "," + i.getReference3().getLon() + "|";
          			path += i.getReference1().getLat() + "," + i.getReference1().getLon();
          	%>
          	<tr>
          		<td align="center"><a href="insar.jsp?iid=<%= i.getId()%>"><img src="http://gf19.ucs.indiana.edu:9898/insar-data/<%= i.getThumbnailURL()%>" height="70" alt="InSAR Thumbnail" /></a></td>
          		<td align="center"><%= i.getReference1()%>, <%= i.getReference2()%>, <%= i.getReference3()%>, <%= i.getReference4()%></td>
          		<td align="center"><%= i.getStartDate()%> to <%= i.getEndDate()%></td>
          		<td align="center"><%= i.getTimespan()%></td>
          		<td align="center"><%= i.getWidth()%></td>
          		<td align="center"><%= i.getLength()%></td>
          		<%--<td align="center"><img src="http://maps.google.com/staticmap?size=100x100&markers=<%= markers%>&key=ABQIAAAAUkTff_jwi_yqiWcjRg9NxhTsULoSST2lX021Mx9b7Pv4zwdIFRQ6Slf2n4KaDbwaTDpq_CPz1cqkZw" /></td>--%>
          		<td align="center"><img src="http://maps.google.com/staticmap?size=100x100&zoom=5&sensor=false&path=<%= path%>&key=ABQIAAAAUkTff_jwi_yqiWcjRg9NxhTsULoSST2lX021Mx9b7Pv4zwdIFRQ6Slf2n4KaDbwaTDpq_CPz1cqkZw" /></td>
          	</tr>
          	<%
          		}
          	%>
          </table>
          <div align="center"><h5><%
          	int pages = 1;
          	for(int i = 0; i < insarCount; i = i + limitStep) {
          		if(limitStart == i)
          			{%>[<%= pages++%>]&nbsp;&nbsp;&nbsp;<%}
          		else
          			{%><a href="insar.jsp?v=g&s=<%= i%>&t=<%= limitStep%>">[<%= pages++%>]</a>&nbsp;&nbsp;&nbsp;<%}
          	}
          %></h5></div>
          <br></br>
        </div> 
        <div class="corner-content-1col-bottom"></div>
        <!-- CONTENT CELL -->                
      </div>
      <!-- C.2 SUBCONTENT -->
    </div>
<% dbQuery.closeConnection(); %>
<jsp:include page="footer.jsp"/>
