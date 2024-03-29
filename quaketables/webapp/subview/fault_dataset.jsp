<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="edu.usc.sirlab.*"%>
<%@ page import="edu.usc.sirlab.db.*"%>
<%@ page import="java.util.*"%>
<%! DatabaseQuery dbQuery; %>
<%
	dbQuery = new DatabaseQuery();
%>
<%	FaultDataSet dataset = dbQuery.getFaultDataSet(request.getParameter("dataSetID")); 
	String breadCrumbURL = "fault.jsp?ds=" + dataset.getId();
	String kmlURL = "ds=" + dataset.getId() + "&color=ff00007f";
%>

<jsp:include page="header.jsp">
	<jsp:param name="gmap" value="<%= kmlURL%>"/>
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
          <p><a href="kml?ds=<%= dataset.getId() %>" title="View using Google Earth" target="_blank"><img class="rightnb" src="img/google-earth.jpg" alt="Google Earth Icon" title="View using Google Earth" /></a><%= dataset.getDescription() %></p>
          <p>The QuakeTables data can, also, be downloaded as a <a href="<%= dataset.getDownloadURL()%>" target="_blank">spread sheet</a></p>
          <br>
          <br>
          <div id="map_canvas" class="map" style="width: 640px; height: 480px;"></div>
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
			<%
			if(dataset.getDataType().equalsIgnoreCase("cgs_fault")) {
			%>
				<table>
					<tr> <!-- <th class="top" scope="col"><input type="checkbox" name="allfaults" onclick="faultGroup.check(this)" /></th> --><th class="top" scope="col">Name</th><th class="top" scope="col">Geom</th><th class="top" scope="col">Length</th><th class="top" scope="col">SlipRate</th><th class="top" scope="col">mmax</th><th class="top" scope="col">Char Rate</th><th class="top" scope="col">Recurr</th><th class="top" scope="col">DownDip Width</th><th class="top" scope="col">Rup(t,b)</th><th class="top" scope="col">rake</th><th class="top" scope="col">dip</th></tr>
				<%
					List<CGSFault> faults = dbQuery.getCGSFaults(dataset.getId());
					for(CGSFault f : faults) {
						String fName = "&nbsp;";
						if(f.getName() != null) fName = "<a title=\"\" href=\"fault.jsp?ds=" + f.getDataSet().getId() + "&amp;fid=" + f.getId() + "\">" + f.getName() + "</a>";
						
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
				%>
					<tr>
						<!-- <td align="center"><input type="checkbox" name="fault" value="<%= f.getId()%>" onclick="faultGroup.check(this)" /></td> -->
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
					</tr>
				<%	} %>
			</table>
			<%
			}
			
			else if(dataset.getDataType().equalsIgnoreCase("ucerf2_fault")) {
				%>
					<table>
						<tr><!-- <th class="top" scope="col"><input type="checkbox" name="allfaults" onclick="faultGroup.check(this)" /></th> --><th class="top" scope="col">Name</th><th class="top" scope="col">Upper Depth</th><th class="top" scope="col">Lower Depth</th><th class="top" scope="col">Dip</th><th class="top" scope="col">Dip Dir.</th><th class="top" scope="col">Slip Rate</th><th class="top" scope="col">Slip Factor</th><th class="top" scope="col">Rake</th><th class="top" scope="col">Trace Length</th><%--<th class="top" scope="col">Location</th>--%></tr>
					<%
						List<UCERFFault> faults = dbQuery.getUCERFFaults(dataset.getId());
						for(UCERFFault f : faults) {
							String fName = "&nbsp;";
							if(f.getName() != null) fName = "<a title=\"\" href=\"fault.jsp?ds=" + f.getDataSet().getId() + "&amp;fid=" + f.getId() + "\">" + f.getName() + "</a>";
							
							String fUpperDepth = "&nbsp;";
							if(f.getUpperDepth() != null) fUpperDepth = f.getUpperDepth().toString();
							
							String fLowerDepth = "&nbsp;";
							if(f.getLowerDepth() != null) fLowerDepth = f.getLowerDepth().toString();
							
							String fDipAngle = "&nbsp;";
							if(f.getDipAngle() != null) fDipAngle = f.getDipAngle().toString();
							
							String fDipDirection = "&nbsp;";
							if(f.getDipDirection() != null) fDipDirection = f.getDipDirection().toString();
							
							String fSlipRate = "&nbsp;";
							if(f.getSlipRate() != null) fSlipRate = f.getSlipRate().toString();
							
							String fSlipFactor = "&nbsp;";
							if(f.getSlipFactor() != null) fSlipFactor = f.getSlipFactor().toString();
							
							String fRake = "&nbsp;";
							if(f.getRake() != null) fRake = f.getRake().toString();
							
							String fTraceLength = "&nbsp;";
							if(f.getTraceLength() != null) fTraceLength = f.getTraceLength().toString();
							
							/*
							String fTraces = "&nbsp;";
							if(f.getTracesString() != null) fTraces = f.getTracesString().toString();
							*/
					%>
						<tr>
							<!-- <td align="center"><input type="checkbox" name="fault" value="<%= f.getId()%>" onclick="faultGroup.check(this)" /></td> -->
							<td align="center"><%= fName%></td>
							<td align="center"><%= fUpperDepth%></td>
							<td align="center"><%= fLowerDepth%></td>
							<td align="center"><%= fDipAngle%></td>
							<td align="center"><%= fDipDirection%></td>
							<td align="center"><%= fSlipRate%></td>
							<td align="center"><%= fSlipFactor%></td>
							<td align="center"><%= fRake%></td>
							<td align="center"><%= fTraceLength%></td>
							<%--<td align="center"><%= fTraces%></td>--%>
						</tr>
					<%	} %>
				</table>
				<%
				}
			
			else if(dataset.getDataType().equalsIgnoreCase("ncal_fault")) {
			%>
				<table>
					<tr><th class="top" scope="col">Name</th><th class="top" scope="col">Fault</th><th class="top" scope="col">Segment</th><th class="top" scope="col">Slip Rate</th><th class="top" scope="col">Strength</th><th class="top" scope="col">Strike</th><th class="top" scope="col">Dip</th><th class="top" scope="col">Rake</th><th class="top" scope="col">Location</th></tr>
					<%
					List<NCALFault> faults = dbQuery.getNCALFaults();
					for(NCALFault f : faults) {
						String fName = "&nbsp;";
						if(f.getName() != null) fName = "<a title=\"\" href=\"fault.jsp?ds=" + f.getDataSet().getId() + "&amp;fid=" + f.getId() + "\">" + f.getName() + "</a>";
						
						String fFaultElement = "&nbsp;";
						if(f.getFaultElement() != null) fFaultElement = f.getFaultElement().toString();
						
						String fSegmentElement = "&nbsp;";
						if(f.getSegmentElement() != null) fSegmentElement = f.getSegmentElement().toString();
						
						String fSlipRate = "&nbsp;";
						if(f.getSlipRate() != null) fSlipRate = f.getSlipRate().toString();
						
						String fStrength = "&nbsp;";
						if(f.getStrength() != null) fStrength = f.getStrength().toString();
						
						String fStrike = "&nbsp;";
						if(f.getStrike() != null) fStrike = f.getStrike().toString();
						
						String fDip = "&nbsp;";
						if(f.getDip() != null) fDip = f.getDip().toString();
						
						String fRake = "&nbsp;";
						if(f.getRake() != null) fRake = f.getRake().toString();
						
						%>
						<tr>
							<td align="center"><%= fName%></td>
							<td align="center"><%= fFaultElement%></td>
							<td align="center"><%= fSegmentElement%></td>
							<td align="center"><%= fSlipRate%></td>
							<td align="center"><%= fStrength%></td>
							<td align="center"><%= fStrike%></td>
							<td align="center"><%= fDip%></td>
							<td align="center"><%= fRake%></td>
							<%--<td align="center"><%= fTraces%></td>  --%>
						</tr>
						<%
						
					}
					%>
				</table>
			<%} %>
          </form>
        </div> 
        <div class="corner-content-1col-bottom"></div>
        <!-- CONTENT CELL -->                
      </div>
      <!-- C.2 SUBCONTENT -->
    </div>
<% dbQuery.closeConnection(); %>
<jsp:include page="footer.jsp"/>