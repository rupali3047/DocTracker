


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
    function tryagain(str)
    {
        //str="hii";
        window.alert(str);
            document.getElementById("try").innerHTML="str";
    }
function statuscheck(str)
{
    //window.alert(str);
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
            document.getElementById("try").innerHTML="No Documents!!";
            
        }
        else 
        {
            //hi = "# of Docs at Present :- " +hi "<br/> hii";
            document.getElementById("try").innerHTML=hi;
                //window.alert(hi);
        }
    }
  }

xmlhttp.open("POST","project_transact_user.jsp",true);
xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
xmlhttp.send("action=OfficeWiseDetails&office_name="+str);
}
</script>

    
    </head>
    <%
    

String result;
List<Integer> resultArray = new ArrayList<Integer>();
List<String> resultArraystr = new ArrayList<String>();
DbConfig configdb = new DbConfig("doctrack",false);
DataBase mydb;
mydb = new DataBase(configdb);
//resultArray = Employee.getlistofDocs(theName);
resultArraystr = DataBase.getOffices();
Integer count_off=resultArraystr.size();
Integer count=resultArray.size();
%>

    <body>
        <h1>Show offices that are currently in the system</h1>
    
    
    <table>
            <tr height="100">
                
                    <% 
int loop=1;
                     while(count_off>0)
                     {
                     %>
                     <td width="20%" style="text-align: center;" height="100" >
        <p title="" class="masterTooltip">
            <a href="office_det.jsp?off_name=<%= resultArraystr.get(count_off-1)   %> ">
<button style="width:100%;height:100px;" onmouseover="statuscheck('<%= resultArraystr.get(count_off-1)   %>')">
                                  
                         <%= resultArraystr.get(count_off-1)   %>
                                  
                     </button>
            </a>
                     </p>
                     </td>
                         <%
                     count_off=count_off-1;
                     loop=loop+1;
                     if(loop>=5)
                   {
                       loop=1;
                       %>
                           </td> </tr>
                                   <tr>
                       <%
                   }
                     }
                    %>
                     
                            </tr>
    </table>
            
    
    
    </div>
    <%@include file="includes/footer.jsp" %>
    </body>
    
    <div id="try" style="display:none; background-color: none;  "><pre style=' font-family: Times New Roman; font-size: 10;'>Loading.... Please Wait!!</pre></div>
        
</html>
