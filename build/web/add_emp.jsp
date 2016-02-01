<%@page import="utils.DataBase"%>
<%@page import="utils.DbConfig"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<html>
<head>
<title>Add New Employee</title>
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
            document.addEmployee.emp_name.value="";
            document.addEmployee.pwd.value="";
            document.addEmployee.email.value="";
            document.addEmployee.off_name.value="";
        }
    }
  }

xmlhttp.open("POST","project_transact_user.jsp",true);
xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
xmlhttp.send("action=AddEmployee&emp_name="+document.addEmployee.emp_name.value+"&off_name="+document.addEmployee.office_name.value+"&email="+document.addEmployee.email.value+"&pwd="+document.addEmployee.pwd.value);
}
</script>

</head>
<%@include file="includes/admin_header.jsp" %>
<%
    
String theName=(String)session.getAttribute("theName");     
String off_name=(String)session.getAttribute("offName");     
String result;
List<String> resultArraystr = new ArrayList<String>();
DbConfig configdb = new DbConfig("doctrack",false);
DataBase mydb;
mydb = new DataBase(configdb);
resultArraystr = DataBase.getOffices();
Integer count_off=resultArraystr.size();
%>

<div class="content"><img
	style="float: left; vertical-align: middle; margin: 0 10px 0 0;"
	src="images/home.png">
<h1 style="margin: 15px 0 0 0;">Add New Employee</h1>
<div style="text-align: justify">
<form name="addEmployee">
<table width="100%">
	<tr align="center">
		<td class="running">Employee Name</td>

	</tr>
	<tr align="center">
		<td><input name="emp_name" id="emp_name" type="text" required> <span id="emp_name"
			style="color: Red; visibility: hidden;"  >*</span></td>
	</tr>
	<tr align="center">
		<td class="running">Office name</td>

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
		<td class="running">Employee Email ID</td>

	</tr>
	<tr align="center">
		<td><input name="email" id="email" type="text" required> <span id="email"
			style="color: Red; visibility: hidden;"  >*</span></td>
	</tr>
 
        	<tr align="center">
		<td class="running">Password</td>

	</tr>
	<tr align="center">
		<td><input name="pwd" id="pwd" type="text" required> <span id="pwd"
			style="color: Red; visibility: hidden;"  >*</span></td>
	</tr>
 
	<tr>
		<td align="center"><input type="button" name="action"
			src="images/login.jpg"
			style="border-color: rgb(0, 0, 0); height: 22px; width: 20%; border-width: 0px;"
			value="Add Employee" type="image" onclick="showCustomer()"></td>
	</tr>

        
</table>
</form>
</div>
</div>
</div>
<%@include file="includes/footer.jsp" %>