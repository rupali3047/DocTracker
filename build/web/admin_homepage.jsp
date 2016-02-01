<html>
<head>
<title>Admin's Workspace</title>
</head>
<%@include file="includes/admin_header.jsp" %>
  
<div class="content">
    Welcome Admin <br/>
    You are Currently logged in by email ID :
    <%
    out.println(user_name);
    
    if(user_name.equals(""))
        
    {
        out.print("ok");
    }
    %>
</div>
</div>
<%@include file="includes/footer.jsp" %>