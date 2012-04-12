<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="edu.usc.sirlab.*"%>
<%@ page import="edu.usc.sirlab.db.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>

<%! DatabaseQuery dbQuery; 
	int limitStart = 0;
	int limitStep = 10;
	DecimalFormat df = new DecimalFormat("#.###"); 
	SimpleDateFormat shortFormat = new SimpleDateFormat("yyyy-MM-dd");
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
	<jsp:param name="breadCrumb1" value="UAVSAR Interferograms"/>
	<jsp:param name="breadCrumb1Url" value="uavsar.jsp"/>
	<jsp:param name="breadCrumb2" value="UAVSAR Grid View"/>
	<jsp:param name="breadCrumb2Url" value="uavsar.jsp?v=g"/>
</jsp:include>

    <!-- C. MAIN SECTION -->      
    <div class="main">
	   <h1 class="pagetitle">UAVSAR Interferograms on QuakeTables</h1>
      <!-- C.1 CONTENT -->
      <div class="content">
        <!-- CONTENT CELL -->                
        <div class="corner-content-1col-top"></div>                        
        <div class="content-1col-nobox">
          <h1>UAVSAR Interferogram Overview</h1>
          <%
          	List<UAVSAR> uavsar = dbQuery.getUAVSAR(limitStart, limitStep);
          	int uavsarCount = dbQuery.getUAVSARCount();
          %>
          <table>
          	<tr><th class="top" scope="col">Thumbnail</th><th class="top" scope="col">Location</th><th class="top" scope="col">Passes</th><th class="top" scope="col">Timespan (days)</th><th class="top" scope="col">Width</th><th class="top" scope="col">Length</th><th class="top" scope="col">Location</th></tr>
          	<%
          		for(UAVSAR u : uavsar) {
          			String passDiff = df.format(Math.abs((u.getDate2().getTime() - u.getDate1().getTime()) / 1000 / 60 / 60 / 24)).toString();
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
          			path += u.getSwathReference1().getLat() + "," + u.getSwathReference1().getLon() + "|";
          			path += u.getSwathReference2().getLat() + "," + u.getSwathReference2().getLon() + "|";
          			path += u.getSwathReference4().getLat() + "," + u.getSwathReference3().getLon() + "|";
          			path += u.getSwathReference3().getLat() + "," + u.getSwathReference4().getLon() + "|";
          			path += u.getSwathReference1().getLat() + "," + u.getSwathReference1().getLon();
          	%>
          	<tr>
          		<td align="center"><a href="uavsar.jsp?uid=<%= u.getId()%>"><img src="http://gf19.ucs.indiana.edu:9898/uavsar-data/<%= u.getImageURL()%>" height="70" alt="UAVSAR Thumbnail" /></a></td>
          		<td align="center"><%= u.getReference1()%>, <%= u.getReference2()%>, <%= u.getReference3()%>, <%= u.getReference4()%></td>
          		<td align="center"><%= shortFormat.format(u.getDate1())%> to <%= shortFormat.format(u.getDate2())%></td>
          		<td align="center"><%= passDiff%></td>
          		<td align="center"><%= u.getLength()%></td>
          		<%--<td align="center"><img src="http://maps.google.com/staticmap?size=100x100&markers=<%= markers%>&key=ABQIAAAAUkTff_jwi_yqiWcjRg9NxhTsULoSST2lX021Mx9b7Pv4zwdIFRQ6Slf2n4KaDbwaTDpq_CPz1cqkZw" /></td>--%>
          		<td align="center"><img src="http://maps.google.com/staticmap?size=100x100&zoom=5&sensor=false&path=<%= path%>&key=ABQIAAAAUkTff_jwi_yqiWcjRg9NxhTsULoSST2lX021Mx9b7Pv4zwdIFRQ6Slf2n4KaDbwaTDpq_CPz1cqkZw" /></td>
          	</tr>
          	<%
          		}
          	%>
          </table>
          <div align="center"><h5><%
          	int pages = 1;
          	for(int i = 0; i < uavsarCount; i = i + limitStep) {
          		if(limitStart == i)
          			{%>[<%= pages++%>]&nbsp;&nbsp;&nbsp;<%}
          		else
          			{%><a href="uavsar.jsp?v=g&s=<%= i%>&t=<%= limitStep%>">[<%= pages++%>]</a>&nbsp;&nbsp;&nbsp;<%}
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
