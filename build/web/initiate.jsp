<%-- 
    Document   : initiate
    Created on : 3 Apr, 2014, 10:11:15 AM
    Author     : ab-admin
--%>

<%@page import="utils.DataBase"%>
<%@page import="utils.DbConfig"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Hello World!</h1>
        <%
            DbConfig configdb = new DbConfig("doctrack",true);
            if(configdb != null)
                System.err.print("done");
            DataBase mydb;
            mydb = new DataBase(configdb);
            %>
    </body>
</html>
