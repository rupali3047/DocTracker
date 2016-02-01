<html>
<head>
<title>Receptionist's Workspace</title>
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
        if(hi == "invalid")
        {
            window.alert("Could not Add document.... Please Try Again!!");
        }
        else 
        {
            window.alert(hi);
            document.adddocs.email.value="";
            document.adddocs.access_code.value="";
            document.adddocs.doc_det.value="";
        }
    }
  }

xmlhttp.open("POST","project_transact_user.jsp",true);
xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
xmlhttp.send("action=AddDocumentRecep&email="+document.adddocs.email.value+"&access_code="+document.adddocs.access_code.value+"&doc_details="+document.adddocs.doc_det.value);
}
</script>

</head>
<%@include file="includes/recep_header.jsp" %>


<div class="content"><img
	style="float: left; vertical-align: middle; margin: 0 10px 0 0;"
	src="images/home.png">
<h1 style="margin: 15px 0 0 0;">Add Document</h1>
<div style="text-align: justify">
<form name="adddocs">
<table width="100%">
	
	<tr align="center">
		<td class="running">Registration ID</td>

	</tr>
	<tr align="center">
		<td><input name="email" id="email" type="text" required> <span id="email"
			style="color: Red; visibility: hidden;"  >*</span></td>
	</tr>
	<tr align="center">
		<td class="running">Access Code</td>

	</tr>
	<tr align="center">
		<td><input name="access_code" id="access_code" type="text" required> <span id="access_code"
			style="color: Red; visibility: hidden;"  >*</span></td>
	</tr>
	
	<tr align="center">
		<td class="running">Document Details</td>

	</tr>
	<tr align="center">
            <td><input name="doc_det" id="doc_det" type="text" size="100" required> <span id="doc_det"
			style="color: Red; visibility: hidden;"  >*</span></td>
	</tr>
        
        
	<tr>
		<td align="center"><input type="button" name="action"
			src="images/login.jpg"
			style="border-color: rgb(0, 0, 0); height: 22px; width: 20%; border-width: 0px;"
			value="Add Document" type="image" onclick="showCustomer()"></td>
	</tr>

        
</table>
</form>
</div>
</div>
</div>
<%@include file="includes/footer.jsp" %>