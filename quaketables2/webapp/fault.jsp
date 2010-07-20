<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="edu.usc.sirlab.*"%>
<%@ page import="edu.usc.sirlab.db.*"%>
<%! DatabaseQuery dbQuery; %>
<%
	dbQuery = new DatabaseQuery();
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
		FaultDataSet dataset = dbQuery.getFaultDataSet(request.getParameter("ds"));
		if(dataset != null && dataset.getDataType().equalsIgnoreCase("cgs_fault")) {
			CGSFault fault = dbQuery.getCGSFault(dataset.getId(), request.getParameter("fid"));
			if(fault != null) {
			%>
				<jsp:include page="subview/fault_cgs_single-view.jsp">
					<jsp:param name="dataSetID" value="<%= dataset.getId()%>"/>
					<jsp:param name="faultID" value="<%= fault.getId()%>"/>
				</jsp:include>
			<%
			}
		}
		else if(dataset != null && dataset.getDataType().equalsIgnoreCase("ucerf2_fault")) {
			UCERFFault fault = dbQuery.getUCERFFault(dataset.getId(), request.getParameter("fid"));
			if(fault != null) {
			%>
				<jsp:include page="subview/fault_ucerf2_single-view.jsp">
					<jsp:param name="dataSetID" value="<%= dataset.getId()%>"/>
					<jsp:param name="faultID" value="<%= fault.getId()%>"/>
				</jsp:include>
			<%
			}
		}
		else if(dataset != null && dataset.getDataType().equalsIgnoreCase("ncal_fault")) {
			NCALFault fault = dbQuery.getNCALFault(request.getParameter("fid"));
			if(fault != null) {
			%>
				<jsp:include page="subview/fault_ncal_single-view.jsp">
					<jsp:param name="faultID" value="<%= fault.getId()%>"/>
				</jsp:include>
			<%
			}
		}
		else if(dataset != null) {
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

	//Show All Datasets
	else {
	%>
		<jsp:include page="subview/fault_all_datasets.jsp"/>
	<%
	}
%>

<% dbQuery.closeConnection(); %>