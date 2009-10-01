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
	// Show Dataset
	if(request.getParameter("ds") != null && request.getParameter("fid") == null) {
		if(!request.getParameter("ds").equalsIgnoreCase("")) {
			FaultDataSet dataset = dbQuery.getFaultDataSet(request.getParameter("ds"));
			if(dataset != null) {
			%>
				<jsp:include page="subview/fault_dataset.jsp">
					<jsp:param name="dataSetID" value="<%= dataset.getId()%>"/>
				</jsp:include>
			<%
			}
			else {
			%>
				<jsp:include page="subview/fault_all_datasets.jsp"/>
			<%
			}
		}
	}

	//Show Individual Fault
	else if(request.getParameter("ds") != null && request.getParameter("fid") != null) {
		
	}

	//Show All Datasets
	else {
	%>
		<jsp:include page="subview/fault_all_datasets.jsp"/>
	<%
	}
%>