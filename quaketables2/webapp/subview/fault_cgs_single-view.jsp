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
<%	CGSFault fault = dbQuery.getCGSFault(request.getParameter("dataSetID"), request.getParameter("faultID"));
	String breadCrumbURL2 = "fault.jsp?ds=" + fault.getDataSet().getId();
	String breadCrumbURL = "fault.jsp?ds=" + fault.getDataSet().getId() + "&fid=" + fault.getId();
%>

<jsp:include page="header.jsp">
	<jsp:param name="breadCrumb1" value="Fault Data Sets"/>
	<jsp:param name="breadCrumb1Url" value="fault.jsp"/>
	<jsp:param name="breadCrumb2" value="<%= fault.getDataSet().getNickName()%>"/>
	<jsp:param name="breadCrumb2Url" value="<%= breadCrumbURL2%>"/>
	<jsp:param name="breadCrumb3" value="<%= fault.getName()%>"/>
	<jsp:param name="breadCrumb3Url" value="<%= breadCrumbURL%>"/>
</jsp:include>

    <!-- C. MAIN SECTION -->      
    <div class="main">
	   <h1 class="pagetitle"><%= fault.getDataSet().getTitle()%></h1>
      <!-- C.1 CONTENT -->
      <div class="content">
        <!-- CONTENT CELL -->                
        <div class="corner-content-1col-top"></div>                        
        <div class="content-1col-nobox">
          <h1><%= fault.getName()%></h1>
          <ul>
          <%
          	for(String[] param : fault.getHTMLParameters()) {
          		%><li><b><%= param[0]%></b>: <%= param[1]%></li><%
          	}
          %>
          </ul>
          <br/>
          <p><b>Source</b>: <a title="<%= fault.getDataSet().getNickName()%>" href="<%= breadCrumbURL2%>"><%= fault.getDataSet().getName()%></a></p>
        </div> 
        <div class="corner-content-1col-bottom"></div>
        <div class="corner-content-1col-top"></div>                        
        <div class="content-1col-nobox">
          <h1>Maps</h1>
		  <p>Put Meta Data Here</p>
        </div> 
        <div class="corner-content-1col-bottom"></div>
        <!-- CONTENT CELL -->                
      </div>
      <!-- C.2 SUBCONTENT -->
    </div>
<jsp:include page="footer.jsp"/>