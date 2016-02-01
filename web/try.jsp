


<%@page import="DOCTRACK.DocumentException"%>
<%@page import="DOCTRACK.Document"%>
<%@page import="DOCTRACK.trackinfo"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="utils.DbConfig"%>
<%@page import="utils.DataBase"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="includes/admin_header.jsp" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="style2.css">
        <title>Office Wise Details</title>
        <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.6.2/jquery.min.js"></script>    
        <script type="text/javascript">
$(document).ready(function() {
// Tooltip only Text
$('.masterTooltip').hover(function(){
        // Hover over code
        var title = document.getElementById("try").innerHTML;
        //alert(title);
        //$(this).attr('title', title);
        $(this).data('tipText', title).removeAttr('title');
        $('<p class="tooltip"></p>')
        .html(title)
        .appendTo('body')
        .fadeIn('slow');
}, function() {
        // Hover out code
        $(this).attr('title', $(this).data('tipText'));
        //$(this).attr('title', title);
        $('.tooltip').remove();
}).mousemove(function(e) {
        var mousex = e.pageX + 20; //Get X coordinates
        var mousey = e.pageY + 10; //Get Y coordinates
        $('.tooltip')
        .css({ top: mousey, left: mousex })
});
});
</script>
<script>
    function tryagain(txt,date)
    {
        //str="hii";
        //window.alert(str);
        
            document.getElementById("try").innerHTML="Remarks :- "+txt + " Added On :-"+date;
    }
function statuscheck(str)
{
    window.alert(str);
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
        
        //var hi = textContent.trim();
        if(str == "invalid")
        {
            document.getElementById("try").innerHTML="No Documents!!";
            
        }
        else 
        {
            //hi = "# of Docs at Present :- " +hi "<br/> hii";
            document.getElementById("try").innerHTML=str;
                //window.alert(hi);
        }
    }
  }

//xmlhttp.open("POST","project_transact_user.jsp",true);
//xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
//xmlhttp.send("action=OfficeWiseDetails&office_name="+str);
}
</script>

    
    </head>
<%           ArrayList<trackinfo> trackarr = new ArrayList<trackinfo>();
             String doc_id = request.getParameter( "a" );
             String access_code = request.getParameter("b");
                   try
                   {
                   int docid= Integer.parseInt(doc_id);
                   int accesscode = Integer.parseInt(access_code);
                   
                   trackarr = Document.trackthiswithremarks(docid,accesscode);
                   int count = trackarr.size();
                   %>
                   <div class="content"><img
	style="float: left; vertical-align: middle; margin: 0 10px 0 0;"
	src="images/home.png">
<h1 style="margin: 15px 0 0 0;">Track Record </h1>
<div style="text-align: justify">
                       
                   <table width="100%">
                       <tr width="100%">
                           <td>
                   <%
                   out.println("Document ID : - "+docid);
                   %>
                           </td>
                           
                       </tr>
                       <tr><td>
                   <%
                   out.println();
                   if(trackarr.get(0).getCuroffice().equals("TRANSIT"))
                   {
                       out.println("Approved & Forwarded By  : - "+trackarr.get(1).getCuroffice());
                       out.println("Currently in Transit..");
                   }
                   else
                   {
                       out.println("Current Office : - "+trackarr.get(0).getCuroffice());
                   }
                    %>
                           </td>
                           
                       </tr>
                       <tr><td>
                   <%
                   
                   out.println("Track Path : -");
                   %>
                           </td>
                           
                       </tr>
                       <tr>
                           <td>
                               <table>
                                   <tr><td>
                   <%
                   int i=1;
                   while(count>1)
                   {
                     %>
                     <p title="" class="masterTooltip">
            <button style="width:100px;height:50px;" onmouseover="tryagain('<%= trackarr.get(count-2).getAssociatedremark().getRemarkText() %>','<%= trackarr.get(count-1).getAssociatedremark().getRemarkDate() %>')">
                <%= trackarr.get(count-1).getCuroffice()  %></button></p>
                                       </td><td width="70">
                       <%
                   if(count>2)
                   {
                       %>
                       <img src="images/next.png" width="70" height="30"/>
                           </td><td>
                       <%
                   }
                   count= count-1;
                   i=i+1;
                   }
                   }
                   catch(NumberFormatException nbfe){
                       nbfe.printStackTrace();
                       //Do exception handling here...
                       
                       
                   }
                   catch(DocumentException de)
                   {
                       out.print(de);
                   }
                   //success = Office.addNewEmployee(off_name, emp_name, mydb);
		   //out.print(success);
  %>  
                           </td></tr></table></td>
                       </tr>
                   </table>
            
</div>
      </div>                    
    </div>
    <%@include file="includes/footer.jsp" %>
    </body>
    
    <div id="try" style="display:none; background-color: none;  "><pre style=' font-family: Times New Roman; font-size: 10;'>hello <br/> hahaha</pre></div>
        
</html>
