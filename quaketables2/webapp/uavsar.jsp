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
	if(request.getParameter("v") != null && request.getParameter("v").equalsIgnoreCase("m")) {
		%>
		<jsp:include page="subview/uavsar_map.jsp"/>
		<%
	}

	// Show InSAR Interferogram
	else if(request.getParameter("uid") != null) {
		if(!request.getParameter("uid").equalsIgnoreCase("")) {
			UAVSAR uavsar = dbQuery.getUAVSAR(request.getParameter("uid"));
			if(uavsar != null) {
			%>
				<jsp:include page="subview/uavsar_single-view.jsp">
					<jsp:param name="interferogramID" value="<%= uavsar.getId()%>"/>
				</jsp:include>
			<%
			}
			else {
			%>
				<jsp:include page="subview/uavsar_main.jsp"/>
			<%
			}
		}
	}

	//Show Main UAVSAR Page
	else {
	%>
		<jsp:include page="subview/uavsar_main.jsp"/>
	<%
	}
%>