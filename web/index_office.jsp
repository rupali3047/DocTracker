<html>
<head>
<title>Login</title>
<script>
function showCustomer()
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
  if (xmlhttp.readyState==4 && xmlhttp.status==200)
    {
        var hi = textContent.trim();
     
        if(hi == "invalid")
        {
            window.alert("Wrong Username or Password.... Please Try Again!!");
        }
        else if(hi =="ADMINISTRATORS OFFICE")
        {
            window.location.href = "admin_homepage.jsp";
        }
        else if (hi =="RECEPTION")
        {
            window.location.href = "recep_homepage.jsp";
        }
        else
        {
            window.location.href = "emp_homepage.jsp";
        }
    }
  }
var x=document.loginform.email.value;  
xmlhttp.open("POST","project_transact_user.jsp",true);
xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
xmlhttp.send("action=LoginAdmin&email="+document.loginform.email.value+"&password="+document.loginform.password.value);
}
</script>
</head>
<%@include file="includes/header.jsp" %>

<div class="content"><img
	style="float: left; vertical-align: middle; margin: 0 10px 0 0;"
	src="images/home.png">
<h1 style="margin: 15px 0 0 0;">Login</h1>
<div style="text-align: justify">
    <form name="loginform">
<table>
	<tr bgcolor="#99CC00">
		<td class="style2" align="center" width="50%">LOGIN</td>
	</tr>
	<tr align="center">
		<td class="running">E-mail Address</td>

	</tr>
	<tr align="center">
		<td><input name="email" id="email" type="text" required> <span id="email"
			style="color: Red; visibility: hidden;"  >*</span></td>
	</tr>
	<tr align="center">

		<td class="running" align="center">Password</td>
	</tr>
	<tr align="center">
		<td align="center"><input name="password" id="password"
			type="password" required> <span id="password"
			style="color: Red; visibility: hidden;">*</span></td>

	</tr>
	<tr>
            <td align="center"><input type="button" name="action"
			src="images/login.jpg"
			style="border-color: rgb(0, 0, 0); height: 22px; width: 15%; border-width: 0px;"
			value="Login User" type="image" onclick="showCustomer()"></td>
	</tr>

        <tr>
		<td align="center" style=" color:#000000;border-color: rgb(0, 0, 0); height: 22px; width: 15%; border-width: 0px;"><a href="register.jsp" >New User? Create a new Account.</td>
	</tr> 
</table>
</form>
    <!-- <button onclick="showCustomer()">Try It </button></!-->
</div>
</div>
</div>
<%@include file="includes/footer.jsp" %>















