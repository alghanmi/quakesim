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
<%	FaultDataSet dataset = dbQuery.getFaultDataSet(request.getParameter("dataSetID")); 
	String breadCrumbURL = "fault.jsp?ds=" + dataset.getId();
%>

<jsp:include page="header.jsp">
	<jsp:param name="breadCrumb1" value="Fault Data Sets"/>
	<jsp:param name="breadCrumb1Url" value="fault.jsp"/>
	<jsp:param name="breadCrumb2" value="<%= dataset.getNickName()%>"/>
	<jsp:param name="breadCrumb2Url" value="<%= breadCrumbURL%>"/>
</jsp:include>

    <!-- C. MAIN SECTION -->      
    <div class="main">
	   <h1 class="pagetitle"><%= dataset.getTitle()%></h1>
      <!-- C.1 CONTENT -->
      <div class="content">
        <!-- CONTENT CELL -->                
        <div class="corner-content-1col-top"></div>                        
        <div class="content-1col-nobox">
          <h1><%= dataset.getName()%></h1>
          <%= dataset.getDescription() %>
          <p>The QuakeTables data can, also, be downloaded as a <a href="<%= dataset.getDownloadURL()%>">spread sheet</a></p>
        </div> 
        <div class="corner-content-1col-bottom"></div>
        <div class="corner-content-1col-top"></div>                        
        <div class="content-1col-nobox">
          <h1>Data Table</h1>
          <form name="AddToMap" action="map.jsp" method="post">
          	<input type="hidden" name="ds" value="<%= dataset.getId()%>" />
			<script type="text/javascript">
				var faultGroup = new CheckBoxGroup();
				faultGroup.addToGroup("fault");
				faultGroup.setControlBox("allfaults");
				faultGroup.setMasterBehavior("all");
			</script>
			<table>
				<tr><th class="top" scope="col"><input type="checkbox" name="allfaults" onclick="faultGroup.check(this)" /></th><th class="top" scope="col">Name</th><th class="top" scope="col">Geom</th><th class="top" scope="col">Length</th><th class="top" scope="col">SlipRate</th><th class="top" scope="col">mmax</th><th class="top" scope="col">Char Rate</th><th class="top" scope="col">Recurr</th><th class="top" scope="col">DownDip Width</th><th class="top" scope="col">Rup(t,b)</th><th class="top" scope="col">rake</th><th class="top" scope="col">dip</th><th class="top" scope="col">Location</th></tr>
				<%
				if(dataset.getDataType().equalsIgnoreCase("cgs_fault")) {
					List<CGSFault> faults = dbQuery.getCGSFaults(dataset.getId());
					for(CGSFault f : faults) {
				%>
					<tr>
						<td align="center"><input type="checkbox" name="fault" value="<%= f.getId()%>" onclick="faultGroup.check(this)" /></td>
						<td align="center"><%= f.getName()%></td>
						<td align="center"><%= f.getGeometry()%></td>
						<td align="center"><%= f.getLength()%> &plusmn; <%= f.getLengthError()%></td>
						<td align="center"><%= f.getSlipRate()%> &plusmn; <%= f.getSlipRateError() %></td>
						<td align="center"><%= f.getmMax()%></td>
						<td align="center"><%= f.getCharRate()%></td>
						<td align="center"><%= f.getRecurrence()%></td>
						<td align="center"><%= f.getDownDipWidth()%> &plusmn; <%= f.getDownDipWidthError()%></td>
						<td align="center"><%= f.getRupTop()%>, <%= f.getRupBottom()%></td>
						<td align="center"><%= f.getRake()%></td>
						<td align="center"><%= f.getDip()%></td>
						<td align="center"><%= f.getTracesString()%></td>
					</tr>
				<%	}
				}%>
			</table>
          </form>
        </div> 
        <div class="corner-content-1col-bottom"></div>
        <!-- CONTENT CELL -->                
      </div>
      <!-- C.2 SUBCONTENT -->
    </div>
<jsp:include page="footer.jsp"/>