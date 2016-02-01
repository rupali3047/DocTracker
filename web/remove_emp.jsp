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
     //window.alert(textContent); 
        if (xmlhttp.readyState==4 && xmlhttp.status==200)
    {
        var hi = textContent.trim();
        if(hi !="true")
        {
            window.alert("Could not Remove Employee.... Please Try Again with some other name!!");
        }
        else 
        {
            window.alert("Employee - "+ document.removeEmployee.emp_id.value + " removed Successfully.");
        }
    }
  }

xmlhttp.open("POST","project_transact_user.jsp",true);
xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
xmlhttp.send("action=RemoveEmployee&emp_id="+document.removeEmployee.emp_id.value);
}
</script>

</head>
<%@include file="includes/admin_header.jsp" %>

<div class="content"><img
	style="float: left; vertical-align: middle; margin: 0 10px 0 0;"
	src="images/home.png">
<h1 style="margin: 15px 0 0 0;">Remove Employee</h1>
<div style="text-align: justify" width="100%">
<form name="removeEmployee">
<table width="100%">
	
	<tr align="center">
		<td class="running">Employee ID</td>

	</tr>
	<tr align="center">
		<td><input name="emp_id" id="emp_id" type="text" required> <span id="emp_id"
			style="color: Red; visibility: hidden;"  >*</span></td>
	</tr>
        
        
	<tr>
		<td align="center"><input type="button" name="action"
			src="images/login.jpg"
			style="border-color: rgb(0, 0, 0); height: 22px; width: 25%; border-width: 0px;"
                        value="Remove Employee" type="image" onclick="showCustomer()"></td>
	</tr>

        
</table>
</form>
</div>
</div>
</div>
<%@include file="includes/footer.jsp" %>