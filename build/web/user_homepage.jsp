<%@page import="utils.DataBase"%>
<%@page import="utils.DbConfig"%>
<html>
<head>
<title>Homepage</title>
</head>
<%@include file="includes/user_header.jsp"  %>

<div class="content">
    Welcome 
    <% //out.print(session.getAttribute("theName"));      %>
    <% out.print(session.getAttribute("name"));      %>
    
</div>
</div>
<%@include file="includes/footer.jsp" %>