<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="edu.usc.sirlab.*"%>
<%@ page import="edu.usc.sirlab.db.*"%>
<%@ page import="java.util.*"%>
<%! DatabaseQuery dbQuery; 
	int limitStart = 0;
	int limitStep = 10;
%>
<%
	if(session.getAttribute("dbQuery") == null) {
		dbQuery = new DatabaseQuery();
		session.setAttribute("dbQuery", dbQuery);
	}
	else
		dbQuery = (DatabaseQuery) session.getAttribute("dbQuery");

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
          	<tr><th class="top" scope="col">Thumbnail</th><th class="top" scope="col">Location</th><th class="top" scope="col">Date</th><th class="top" scope="col">Timespan (year)</th><th class="top" scope="col">Width</th><th class="top" scope="col">Length</th></tr>
          	<%
          		for(Interferogram i : insar) {	
          	%>
          	<tr>
          		<td align="center"><a href="insar.jsp?iid=<%= i.getId()%>"><img src="http://gf19.ucs.indiana.edu:9898/insar-data/<%= i.getThumbnailURL()%>" height="70" alt="InSAR Thumbnail" /></a></td>
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
<jsp:include page="footer.jsp"/>