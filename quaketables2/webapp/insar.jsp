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
%>

<%
	//Show Grid View
	if(request.getParameter("v") != null && request.getParameter("v").equalsIgnoreCase("g")) {
		%>
		<jsp:include page="subview/insar_grid.jsp">
			<jsp:param name="s" value="<%= request.getParameter(\"s\")%>"/>
			<jsp:param name="t" value="<%= request.getParameter(\"t\")%>"/>
		</jsp:include>
		<%
	}
	
	else if(request.getParameter("v") != null && request.getParameter("v").equalsIgnoreCase("c")) {
		%>
		<jsp:include page="subview/insar_catalog.jsp"/>
		<%
	}

	// Show InSAR Interferogram
	else if(request.getParameter("iid") != null) {
		if(!request.getParameter("iid").equalsIgnoreCase("")) {
			Interferogram insar = dbQuery.getInerferogram(request.getParameter("iid"));
			if(insar != null) {
			%>
				<jsp:include page="subview/insar_single-view.jsp">
					<jsp:param name="interferogramID" value="<%= insar.getId()%>"/>
				</jsp:include>
			<%
			}
			else {
			%>
				<jsp:include page="subview/insar_main.jsp"/>
			<%
			}
		}
	}

	//Show Main InSAR Page
	else {
	%>
		<jsp:include page="subview/insar_main.jsp"/>
	<%
	}
%>