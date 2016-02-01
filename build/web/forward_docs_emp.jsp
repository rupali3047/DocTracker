<%@page import="DOCTRACK.TransitDoc"%>
<%@page import="DOCTRACK.Office"%>
<%@page import="DOCTRACK.Employee"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="utils.DataBase"%>
<%@page import="utils.DbConfig"%>
<html>
<head>
<title>Receptionist's Workspace</title>
<script>
    function insert(str)
{
    document.forward_docs.doc_id.value=document.forward_docs.doc_id.value+str+";";
}
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
            window.alert("Could not Forward document.... Please Try Again!!");
        }
        else
        {
            window.alert(hi);
             document.forward_docs.remarks.value='';
                    document.forward_docs.doc_id.value='';
                    document.forward_docs.choice.value='';
                    location.reload(true);
        }
    }
  }

xmlhttp.open("POST","project_transact_user.jsp",true);
xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
xmlhttp.send("action=ForwardDocument&doc_id="+document.forward_docs.doc_id.value+"&off_name="+document.forward_docs.office_name.value+"&remarks="+document.forward_docs.remarks.value);
}
</script>
</head>
<%@include file="includes/emp_header.jsp" %>
<%
    
String theName=(String)session.getAttribute("theName");     
String offName=(String)session.getAttribute("offName");     
String result;
List<Integer> resultArray = new ArrayList<Integer>();
List<String> resultArraystr = new ArrayList<String>();
DbConfig configdb = new DbConfig("doctrack",false);
DataBase mydb;
mydb = new DataBase(configdb);
resultArray = Employee.getlistofDocs(theName,offName);
resultArraystr = DataBase.getOffices();
Integer count_off=resultArraystr.size();
Integer count=resultArray.size();
%>

<div class="content"><img
	style="float: left; vertical-align: middle; margin: 0 10px 0 0;"
	src="images/home.png">
<h1 style="margin: 15px 0 0 0;">Forward Document</h1>
<div style="text-align: justify">
<form name="forward_docs">

    <table width="100%">
        <tr><td width="70%">
                <table width="100%">
        <tr align="center">
		<td class="running">Document IDs </td>

	</tr>
	<tr align="center">
		<td><input name="doc_id" id="doc_id" type="text" required> <span id="doc_id"
			style="color: Red; visibility: hidden;"  >*</span></td>
	</tr>
	<tr align="center">
		<td class="running">Forward To</td>

	</tr>
	<tr align="center">
            <td><select name="office_name" id="office_name" required> <span id="office_name"
			style="color: Red; visibility: hidden;"  >
                            <%
while(count_off>0)
{
%>
<option value="<%=resultArraystr.get(count_off-1) %>"><%=resultArraystr.get(count_off-1) %></option>
<%
count_off=count_off-1;
}
%>
</select>
                
                
               </td>
	</tr>
        <tr align="center">
		<td class="running">Remarks</td>

	</tr>
	<tr align="center">
		<td><input name="remarks" id="remarks" type="text"> <span id="remarks"
			style="color: Red; visibility: hidden;"  >*</span></td>
	</tr>
	
        
	<tr>
		<td align="center"><input type="button" name="action"
			src="images/login.jpg"
			style="border-color: rgb(0, 0, 0); height: 22px; width: 30%; border-width: 0px;"
                        value="Forward Document" type="image" onclick="showCustomer()"></td>
	</tr>
                </table>
            </td>
            <td width="30%">
              <%  while(count>0)
{

%>
<input type="checkbox" name="choice" value="<%=resultArray.get(count-1) %>" onclick="insert(this.value)"><%=resultArray.get(count-1) %> 

<%
count=count-1;

}
%>

            </td>
        </tr>
</table>
</form>
</div>
</div>
</div>
<%@include file="includes/footer.jsp" %>