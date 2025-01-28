<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%
    // Invalidate the session
    session.invalidate();
    
    // Redirect to the login page
    response.sendRedirect("admin_login.jsp");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Logout</title>
</head>
<body>
    <p>You have been logged out. Redirecting to login page...</p>
</body>
</html>
