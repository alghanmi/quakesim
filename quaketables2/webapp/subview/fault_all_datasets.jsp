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
<jsp:include page="header.jsp">
	<jsp:param name="breadCrumb1" value="Fault Data Sets"/>
	<jsp:param name="breadCrumb1Url" value="fault.jsp"/>
</jsp:include>

    <!-- C. MAIN SECTION -->      
    <div class="main">

      <!-- C.1 CONTENT -->
      <div class="content">
        <!-- CONTENT CELL -->                
        <div class="corner-content-1col-top"></div>                        
        <div class="content-1col-nobox">
          <h1>Fault Data Sets</h1>
          <h5>The following fault data sets are available to browse and download through QuakeTables</h5>
          <ul>
          <%
			List<FaultDataSet> datasets = dbQuery.getFaultDataSets();
			for(FaultDataSet ds : datasets) {
          %><li><a href="fault.jsp?ds=<%= ds.getId()%>" title="<%= ds.getName()%>"><%= ds.getTitle()%> [<%= ds.getEntryCount()%> faults]</a></li><%
			}
          %>
          </ul>
        </div> 
        <div class="corner-content-1col-bottom"></div>                       

        <!-- CONTENT CELL -->                
      </div>

      <!-- C.2 SUBCONTENT -->
    </div>
<jsp:include page="footer.jsp"/>