<html>
<head>
<title>Registration</title>
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
        window.alert(hi);
            if(hi != "true")
        {
            window.alert("Wrong Username or Password.... Please Try Again!!");
        }
        else 
        {
            window.alert("Registration Successfully Completed.");
        }
    }
  }
xmlhttp.open("POST","project_transact_user.jsp",true);
xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
xmlhttp.send("action=Register&email="+document.registerform.email.value+"&password="+document.registerform.password.value+"&user_name="+document.registerform.user_name.value);
}
</script>
</head>
<%@include file="includes/header.jsp" %>

<div class="content"><img
	style="float: left; vertical-align: middle; margin: 0 10px 0 0;"
	src="images/home.png">
<h1 style="margin: 15px 0 0 0;">Register Now</h1>
<div style="text-align: justify">
<form name="registerform">
<table>
	<tr align="center">
		<td class="running">Name</td>

	</tr>
	<tr align="center">
		<td><input name="user_name" id="user_name" type="text" required> <span id="email"
			style="color: Red; visibility: hidden;"  >*</span></td>
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
                        value="Register!!" type="image" onclick="showCustomer()"></td>
	</tr>

        <tr>
		<td align="center" style=" color:#000000;border-color: rgb(0, 0, 0); height: 22px; width: 15%; border-width: 0px;"></td>
	</tr> 
</table>
</form>
</div>
</div>
</div>
<%@include file="includes/footer.jsp" %>