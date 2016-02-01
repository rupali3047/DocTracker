<%@page import="DOCTRACK.Office"%>
<%@page import="utils.DataBase"%>
<%@page import="utils.DbConfig"%>
<%@page import="java.util.ArrayList"%>
<%@page import="DOCTRACK.TransitDoc"%>
<html>
<head>
<title>Receptionist's Workspace</title>
<script>
function insert(str)
{
    document.adddocs.doc_id.value=document.adddocs.doc_id.value+str+";";
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
        {
            window.alert(hi);
            //windows.location.href="add_docs_emp.jsp";
            document.adddocs.choice.value='';
            document.adddocs.doc_id.value='';
                    location.reload(true);
        }
    }
  }

xmlhttp.open("POST","project_transact_user.jsp",true);
xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
xmlhttp.send("action=AddDocumentEmp&doc_id="+document.adddocs.doc_id.value);
}
</script>

</head>
<%@include file="includes/emp_header.jsp" %>
<%
    
String theName=(String)session.getAttribute("theName");     
String off_name=(String)session.getAttribute("offName");     
String result;
ArrayList<TransitDoc> allDocs = new ArrayList<TransitDoc>();
//List<Integer> resultArray = new ArrayList<Integer>();
//List<String> resultArraystr = new ArrayList<String>();
DbConfig configdb = new DbConfig("doctrack",false);
DataBase mydb;
mydb = new DataBase(configdb);
allDocs = Office.getAvailableDocs(off_name);
//resultArraystr = DataBase.getOffices();
//Integer count_off=resultArraystr.size();
Integer count=allDocs.size();
System.err.print(count);
System.err.print(off_name);
%>


<div class="content"><img
	style="float: left; vertical-align: middle; margin: 0 10px 0 0;"
	src="images/home.png">
<h1 style="margin: 15px 0 0 0;">Add Documents</h1>
<div style="text-align: justify">
<form name="adddocs">
    <table><tr><td width="100%">
<table width="100%">
	<tr align="center">
		<td class="running">Document IDs</td>

	</tr>
	<tr align="center">
		<td><input name="doc_id" id="doc_id" type="text" required> <span id="doc_id"
			style="color: Red; visibility: hidden;"  >*</span></td>
	</tr>
	
	<tr>
		<td align="center"><input type="button" name="action"
			src="images/login.jpg"
			style="border-color: rgb(0, 0, 0); height: 22px; width: 20%; border-width: 0px;"
			value="Add Document" type="image" onclick="showCustomer()"></td>
	</tr>

        
</table>
            </td>        
            <td style="min-width: 120px;">
                             <%  while(count>0)
{

%>
<input type="checkbox" name="choice" value="<%=allDocs.get(count-1).getDocid() %>" onclick="insert(this.value)"><%=allDocs.get(count-1).getDocid() %> 

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