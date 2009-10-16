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
						String fName = "&nbsp;";
						if(f.getName() != null) fName = f.getName();
						
						String fGeometry = "&nbsp;";
						if(f.getGeometry() != null) fGeometry = f.getGeometry();
						
						String fLength = "&nbsp;";
						if(f.getLength() != null) fLength = f.getLength().toString();
						
						String fLengthError = "&nbsp;";
						if(f.getLengthError() != null) fLengthError = "&plusmn;" + f.getLengthError().toString();
						
						String fSlipRate = "&nbsp;";
						if(f.getSlipRate() != null) fSlipRate = f.getSlipRate().toString();
						
						String fSlipRateError = "&nbsp;";
						if(f.getSlipRateError() != null) fSlipRateError = "&plusmn;" + f.getSlipRateError().toString();
						
						String fMMax = "&nbsp;";
						if(f.getmMax() != null) fMMax = f.getmMax().toString();
						
						String fCharRate = "&nbsp;";
						if(f.getCharRate() != null) fCharRate = f.getCharRate().toString();
						
						String fRecurrence = "&nbsp;";
						if(f.getRecurrence() != null) fRecurrence = f.getRecurrence().toString();
						
						String fDownDipWidth = "&nbsp;";
						if(f.getDownDipWidth() != null) fDownDipWidth = f.getDownDipWidth().toString();
						
						String fDownDipWidthError = "&nbsp;";
						if(f.getDownDipWidthError() != null) fDownDipWidthError = "&plusmn;" + f.getDownDipWidthError().toString();
						
						String fRupTop = "&nbsp;";
						if(f.getRupTop() != null) fRupTop = f.getRupTop().toString();
						
						String fRupBottom = "&nbsp;";
						if(f.getRupBottom() != null) fRupBottom = f.getRupBottom().toString();
						
						String fRake = "&nbsp;";
						if(f.getRake() != null) fRake = f.getRake().toString();
						
						String fDip = "&nbsp;";
						if(f.getDip() != null) fDip = f.getDip().toString();
						
						String fTraces = "&nbsp;";
						if(f.getTracesString() != null) fTraces = f.getTracesString().toString();
				%>
					<tr>
						<td align="center"><input type="checkbox" name="fault" value="<%= f.getId()%>" onclick="faultGroup.check(this)" /></td>
						<td align="center"><%= fName%></td>
						<td align="center"><%= fGeometry%></td>
						<td align="center"><%= fLength%> <%= fLengthError%></td>
						<td align="center"><%= fSlipRate%> <%= fSlipRateError %></td>
						<td align="center"><%= fMMax%></td>
						<td align="center"><%= fCharRate%></td>
						<td align="center"><%= fRecurrence%></td>
						<td align="center"><%= fDownDipWidth%> <%= fDownDipWidthError%></td>
						<td align="center"><%= fRupTop%>, <%= fRupBottom%></td>
						<td align="center"><%= fRake%></td>
						<td align="center"><%= fDip%></td>
						<td align="center"><%= fTraces%></td>
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