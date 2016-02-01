<%@page import="java.util.ArrayList"%>
<%@page import="utils.DataBase"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="includes/admin_header.jsp" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Office Details</title>
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
    function statuscheck(txt,date)
    {
        //str="hii";
        //window.alert(str);
        
            document.getElementById("try").innerHTML="Remarks :- "+txt + " | Added On :- date";
    }
</script>
    
    </head>
    
    <%
    String[] strArray;
    ArrayList<String> trackarr = new ArrayList<String>();
             String off_name = request.getParameter( "off_name" );
             
                   trackarr = DataBase.listcurdocholders(off_name);
                   int total = trackarr.size();
                   System.err.println(total);
                   %>

    <body>
        <h1>Show Summary of docs that are currently in the <%= off_name %> Office</h1>
        <table>
            <tr>
                <td>
                    Document ID              
                </td>
                <td>
                    Current Editor ID
                </td>
            </tr>
            <% 
                     while(total>0)
                     {
                     
                     strArray = trackarr.get(total-1).split(":");
                   
            %>
                     <tr height="35">
                         <td>                   
                     <p title="" class="masterTooltip">
            <a href="status_admin.jsp?a=<%= strArray[0]   %>&b=-1 ">
<button style="width:100%;height:30px;" onmouseover="statuscheck('<%= strArray[0]   %>','<%= strArray[1]   %>')">
                                  
                         <%= strArray[0]   %>
                                  
                     </button>
            </a>
                     </p>
                     </td>
                     <td>
                         <%= strArray[1]   %>
                     </td>
                     </tr>
                         <%
                     total=total-1;
                     }
                    %>
            
            
        </table>
        
    
    
    
    
    
    </div>
    <%@include file="includes/footer.jsp" %>
<div id="try" style="display:none; background-color: none;  "><pre style=' font-family: Times New Roman; font-size: 10;'>Loading.... Please Wait!!</pre></div>    
</body>
    
    
</html>
