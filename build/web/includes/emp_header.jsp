<%@page import="DOCTRACK.Employee"%>
<%@page import="java.util.ArrayList"%>
<!DOCTYPE HTML>
<html>
<head>
<title>Documents Tracking & Management System</title>
<meta http-equiv="content-type"
	content="text/html; charset=windows-1252">
	<link rel="shortcut icon" href="images/u.ico" type="image/ico" />
	
<link rel="stylesheet" type="text/css" id="theme" href="css/style.css">
<!-- modernizr enables HTML5 elements and feature detects -->
<script type="text/javascript" src="js/modernizr-1.5.min.js"></script>
</head>
<body>
<div id="main"><header>
<div id="logo">
<div id="logo_text"><!-- class="logo_colour", allows you to change the colour of the text -->
<h1><a href="index.php">Docs <span class="logo_colour">Tracker<!--<img src="images/gmlogo.jpg" width="100" height="80">-->
</span></a></h1>
<h2>Documents Tracking & Management System</h2>
</div>
</div>
<nav>
<div id="menu_container">
<ul class="sf-menu" id="nav" style="text-align:left;">
	<li><a href="emp_homepage.jsp">Home</a></li>
        <li><a href="add_docs_emp.jsp" title="Add Documents"><font style="font-size: 20px;">Add Documents</font></a>
            
        <li><a href="forward_docs_emp.jsp" title="Forward Documents"><font style="font-size: 20px;">Forward Documents</font></a>
            <!--<li><a href="#" title="Services">Check Status</a> -->
        	<!--<li><a href="sitemap.jsp" title="Sitemap">Sitemap</a>-->
        <li><a href="logout_emp.jsp" title="LogOut"><font style="font-size: 20px;">Log Out</font></a>

</ul>
</div>
</nav>
</header>

    <div id="site_content">
<div id="sidebar_container"><!--<img class="paperclip"
	src="images/paperclip.png">
<div class="sidebar">
<h3>Check Status</h3>-->
<!-- insert your sidebar items here -->
<!--<h4>Document Details Here</h4>

<div style="text-align: justify">
    <form action="project_transact_user.jsp" method="post">
<table>
	<tr align="center">
		<td class="running">Document ID</td>

	</tr>
	<tr align="center">
		<td><input name="doc_id" id="doc_id" type="text" required> <span id="doc_id"
			style="color: Red; visibility: hidden;"  >*</span></td>
	</tr>
	
        <tr align="center">
		<td class="running">Access Code</td>

	</tr>
	<tr align="center">
		<td><input name="access_code" id="access_code" type="text" required> <span id="access_code"
			style="color: Red; visibility: hidden;"  >*</span></td>
	</tr>
	<tr>
		<td align="center"><input type="submit" name="action"
			src="images/login.jpg"
			style="border-color: rgb(0, 0, 0); height: 22px; width: 55%; border-width: 0px;"
			value="Check!!" type="image"></td>
	</tr>

        <tr>
		<td align="center" style=" color:#000000;border-color: rgb(0, 0, 0); height: 22px; width: 15%; border-width: 0px;"></td>
	</tr> 
</table>
</form>
    <br>

</div>
</div> -->
<!--<img class="paperclip" src="images/paperclip.png">
<div class="sidebar">
<h3 style="margin-left: 10px;">Training</h3>
 insert your sidebar items here 
<ul>
	<li><a href="#">First Link</a></li>
	<li><a href="#">Another Link</a></li>
	<li><a href="#">And Another</a></li>
	<li><a href="#">Last One</a></li>
</ul>
</div>
<!--
--------------------------------------------------------------------------------------------------
<%           
    String offName= (String)session.getAttribute( "offName" );
    String doc_id = request.getParameter( "a" );
             String access_code = request.getParameter("b");
                   
                    ArrayList<String> trackarr = new ArrayList<String>();
                   
                   trackarr = Employee.checkErrors(offName);
                   int total = trackarr.size();
                   
                   %>

--> <img class="paperclip" src="images/paperclip.png">
<div class="sidebar">
<h3 style="margin-left: 10px;">Bulletin Board</h3>
<marquee direction="up" scrolldelay="150" onMouseOver="this.stop()"
	onMouseOut="this.start()" height="140px" width="250px">

<table>
	<tbody>
            <% 
                   while(total>0)
                   {
                       %>
		<tr>
                    
			<td>
                           <%= trackarr.get(total-1) %>  Claim!!
                            
                            
			</td>
                                
		</tr>
                <%
total=total-1;       
}
                   %>
</table>
</marquee></div>
<!--
-----------------------------------------------------------------------------
--> <img class="paperclip" src="images/paperclip.png">
<div class="sidebar">
<h3 style="margin-left: 10px;">Contacts</h3>
<table>
	<tbody>
		<tr>
			<td>
			<p><span class="news_head"><font color="#0066FF"><b>Address:</b></font></span><br>
			<span class="running"><font color="#666666">Docs Trackers <br>
			</font></span></p>
			<p><span class="news_head"><font color="#0066FF"><b>Contact No. </b></font></span>
			<br>
			<span class="running"> Sumit Paliwal
                            <font color="#666666">+91-8094359411,</font><br> Abhay Arora<font color="#666666"> +91-9001789325</font></span></p>
			<p><span class="news_head"><font color="#0066FF"><b>Email: </b></font></span>
			<br>
			<span class="running"><font color="#666666">admin@docstracker.com
			</font></span></p>
			</td>
		</tr>
	</tbody>
</table>

</div>
</div>
<!--
--------------------------------------------------------------------------------------------------
-->


