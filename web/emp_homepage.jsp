<html>
<head>
<title>Homepage</title>
</head>
<%@include file="includes/emp_header.jsp" %>

<div class="content">
    Welcome 
    <% out.print(session.getAttribute("theName"));      %>
    {Employee Name/ID}
    
</div>
</div>
<%@include file="includes/footer.jsp" %>