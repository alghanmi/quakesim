<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="edu.usc.sirlab.db.*" %>
<jsp:include page="subview/header.jsp">
	<jsp:param name="sidebar" value="true"/>
</jsp:include>
    <!-- C. MAIN SECTION -->      
    <div class="main">

      <!-- C.1 CONTENT -->
      <div class="content">

        <!-- CONTENT CELL -->                
        <div class="corner-content-1col-top"></div>                        
        <div class="content-1col-nobox">
          <h1>Welcome to QuakeTables</h1>
          <h3>Quake Tables: Fault Database for Southern California</h3>
          <p>The QuakeSim project includes a web accessed, public database of geologic and modeled faults with geometric, kinematic and neotectonic parameters. The fault database is herein named QuakeTables. The contents of QuakeTables can be used to cross-validate different simulation methods, explore competing theories of plate boundary development, perform case studies with widely accepted assumptions, and provide input for visualization software to display simulation results. QuakeSim is sponsored by the NASA Earth Science Enterprise, in partnership with Goddard Space Flight Center, with the full participation of the related science and technology communities. Additional information and documentation is posted on the <a href="http://quakesim.org" title="QuakeSim Project Website" target="_blank">QuakeSim homepage</a>.</p>
        </div> 
        <div class="corner-content-1col-bottom"></div>                       

        <!-- CONTENT CELL -->                
        <div class="corner-content-1col-top"></div>                        
        <div class="content-1col-nobox">
          <h1 class="webtemplate">QuakeSim News</h1>
          <h4>CGS Datasets added</h4>
          <p>Fault data for the California <a href="http://www.consrv.ca.gov/cgs/rghm/psha//Pages/index.aspx" target="_blank">Probablistic Seismic Hazards Assessment</a> is now part of QuakeTables. Click on Fault data to get more details</p> 
          <h4>InSAR Interferograms for California</h4>
          <p>A new set of InSAR interferograms for California has been added to QuakeTables. Access is provided through the <a href="insar.jsp" title="InSAR Interferograms in QuakeTables">InSAR section</a> of the website</p>
        </div> 
        <div class="corner-content-1col-bottom"></div>
      </div>

      <!-- C.2 SUBCONTENT -->
      <div class="subcontent">

        <!-- SUBCONTENT CELL -->
        <div class="corner-subcontent-top"></div>                        
        <div class="subcontent-box">
          <h1 class="login">User Login</h1>
          <div class="loginform">
            <form method="post" action="index.jsp"> 
              <fieldset>
                <p><label for="username_1" class="top">User:</label><br />
                  <input type="text" name="username" id="username_1" tabindex="1" class="field" value="" /></p>

                <p><label for="password_1" class="top">Password:</label><br />
                  <input type="password" name="password" id="password_1" tabindex="2" class="field" value="" /></p>
                <p><input type="submit" name="cmdweblogin" class="button" value="LOGIN"  /></p>
              </fieldset>
            </form>
          </div>
        </div>  
        <div class="corner-subcontent-bottom"></div>
      </div>    
    </div>
<jsp:include page="subview/footer.jsp"/>