<html>
<head>
<title>Add New Office</title>
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
     //window.alert(textContent); 
        if (xmlhttp.readyState==4 && xmlhttp.status==200)
    {
        var hi = textContent.trim();
        
            window.alert(hi);
            document.addOffice.off_name.value="";
            document.addOffice.description.value="";
        
    }
  }

xmlhttp.open("POST","project_transact_user.jsp",true);
xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
xmlhttp.send("action=AddOffice&off_name="+document.addOffice.off_name.value+"&description="+document.addOffice.description.value);
}
</script>


</head>
<%@include file="includes/admin_header.jsp" %>

<div class="content"><img
	style="float: left; vertical-align: middle; margin: 0 10px 0 0;"
	src="images/home.png">
<h1 style="margin: 15px 0 0 0;">Add New Office</h1>
<div style="text-align: justify">
<form name="addOffice">
<table>
	<tr align="center">
		<td class="running">Office Name</td>

	</tr>
	<tr align="center">
		<td><input name="off_name" id="off_name" type="text" required> <span id="off_name"
			style="color: Red; visibility: hidden;"  >*</span></td>
	</tr>
	<tr align="center">

		<td class="running" align="center">Office Description</td>
	</tr>
	<tr align="center">
		<td align="center"><input name="description" id="description"
                                          type="text" size="100"  required> <span id="password"
			style="color: Red; visibility: hidden;">*</span></td>

	</tr>
	<tr>
		<td align="center"><input type="button" name="action"
			src="images/login.jpg"
			style="border-color: rgb(0, 0, 0); height: 22px; width: 15%; border-width: 0px;"
			value="Add Office" type="image" onclick="showCustomer()"></td>
	</tr>

        
</table>
</form>
</div>
</div>
</div>
<%@include file="includes/footer.jsp" %>