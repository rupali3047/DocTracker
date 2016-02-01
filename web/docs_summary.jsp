

<%@page import="java.util.ArrayList"%>
<%@page import="utils.DataBase"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="includes/admin_header.jsp" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Overall Summary</title>
    </head>
    
    <%
    
    
             String off_name = request.getParameter( "off_name" );
              int totaldocs = DataBase.totaldocsinsystem();
              int totaltransit = DataBase.totaldocsintransit();
                   %>
    <body>
        <h1>Show Summary of docs that are currently in the system</h1>
        <table>
            <tr>
                <td>
                     Total Documents in System : -             
                </td>
                <td>
                    <%= totaldocs %>
                </td>
            </tr>
            <tr>
                <td>
                     Total Documents in Transit : -             
                </td>
                <td>
                    <%= totaltransit %>
                </td>
            </tr>
            
        </table>
        
    
    
    
    
    
    </div>
    <%@include file="includes/footer.jsp" %>
    </body>
    
    
</html>
