<html>
<head>
<title>Homepage</title>
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
        {
            window.alert(hi);
            windows.location.href="add_docs_user.jsp";
        }
    }
  }

xmlhttp.open("POST","project_transact_user.jsp",true);
xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
xmlhttp.send("action=AddDocumentUser&doc_id="+document.adddocs.doc_id.value+"&access_code="+document.adddocs.access_code.value);
}
</script>

</head>
<%@include file="includes/user_header.jsp" %>

<div class="content">
    Welcome 
    <% //out.print(session.getAttribute("theName"));      %>
    <% out.print(session.getAttribute("name"));      %>
    
    <br />
    <img
	style="float: left; vertical-align: middle; margin: 0 10px 0 0;"
	src="images/home.png">
<h1 style="margin: 15px 0 0 0;">Add Documents</h1>
<div style="text-align: justify">
<form name="adddocs">
 
<table width="100%">
	<tr align="center" width="100%">
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