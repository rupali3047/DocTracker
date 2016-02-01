<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="utils.DataBase"%>
<%@page import="utils.DbConfig"%>
<!DOCTYPE HTML>
<html>
<head>
<title>Training Management System</title>
<meta name="description" content="Training Management System">
<meta name="keywords" content="Training,c,cpp,java,php,asp.net,project">
<meta http-equiv="content-type"
	content="text/html; charset=windows-1252">
	<link rel="shortcut icon" href="images/u.ico" type="image/ico" />
	
<link rel="stylesheet" type="text/css" id="theme" href="css/style.css">
<!-- modernizr enables HTML5 elements and feature detects -->
<script type="text/javascript" src="js/modernizr-1.5.min.js"></script>

<script>
function statuscheck()
{
var hi;
var xmlhttp;    
//if (str=="")
 // {
  //document.getElementById("txtHint").innerHTML="empty";
  //return;
 // }
if(window.XMLHttpRequest)
  {// code for IE7+, Firefox, Chrome, Opera, Safari
  xmlhttp=new XMLHttpRequest();
  } 
else
  {// code for IE6, IE5
    xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
  }
xmlhttp.onreadystatechange=function()
  {
     textContent = xmlhttp.responseText;
     //window.alert(textContent); 
        if (xmlhttp.readyState==4 && xmlhttp.status==200)
    {
        var hi = textContent.trim();
        if(hi == "Access not authorized")
        {
            window.alert("Wrong Doc ID or Access Code.... Please Try Again!!");
        }
        else 
        {
            
               
                
                window.location.href="status_in.jsp?a="+document.status.doc_id.value+"&b=-1";
           
        }
    }
  }

xmlhttp.open("POST","project_transact_user.jsp",true);
xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
xmlhttp.send("action=CheckStatusOut&doc_id="+document.status.doc_id.value+"&access_code=-1");
}
</script>
</head>
<%
    
String theName=(String)session.getAttribute("theName");     
String result;
List<Integer> resultArray = new ArrayList<Integer>();
DbConfig configdb = new DbConfig("doctrack",false);
DataBase mydb;
mydb = new DataBase(configdb);
resultArray = DataBase.getUserDocs(theName);
Integer count=resultArray.size();
%>
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
	<li><a href="user_homepage.jsp">Home</a></li>
	<li><a href="add_docs_user.jsp" title="Add Document">Add Document</a>
    	<!--<li><a href="#" title="Services">Check Status</a> -->
       <!-- 	<li><a href="sitemap.jsp" title="Sitemap">Sitemap</a> -->
            	<li><a href="logout.jsp" title="Logout">Log Out</a>

</ul>
</div>
</nav>
</header>
<div id="site_content">
<div id="sidebar_container"><img class="paperclip"
	src="images/paperclip.png">
<div class="sidebar">
<h3>Check Status</h3>
<!-- insert your sidebar items here -->
<h4>Document Details Here</h4>

<div style="text-align: justify">
    <form name="status">
<table>
	<tr align="center">
		<td class="running">Document ID</td>

	</tr>
	<tr align="center">
		<td><select name="doc_id" id="doc_id" required> <span id="doc_id"
			style="color: Red; visibility: hidden;"  >
                            <%

while(count>0)
{
%>
<option value="<%=resultArray.get(count-1) %>"><%=resultArray.get(count-1) %></option>
<%
count=count-1;
}
%>
</select>

                            
                            </span></td>
	</tr>
	
        <tr>
		<td align="center"><input type="button" name="action"
			src="images/login.jpg"
			style="border-color: rgb(0, 0, 0); height: 22px; width: 55%; border-width: 0px;"
                        value="Check!!" type="image" onclick="statuscheck()"></td>
	</tr>

        <tr>
		<td align="center" style=" color:#000000;border-color: rgb(0, 0, 0); height: 22px; width: 15%; border-width: 0px;"></td>
	</tr> 
</table>
</form>

    
    
    
    
    
    
    
    
    <br>
</div>
</div>
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
--><!--
--------------------------------------------------------------------------------------------------
--> <img class="paperclip" src="images/paperclip.png">
<div class="sidebar">
<h3 style="margin-left: 10px;">Bulletin Board</h3>
<marquee direction="up" scrolldelay="150" onMouseOver="this.stop()"
	onMouseOut="this.start()" height="140px" width="250px">

<table>
	<tbody>
		<tr>
			<td><font color="#666666">To show any information<br> about the department
			<br>
			And Many More...... <br>
			<br>
			</font></td>
		</tr>

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


