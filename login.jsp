<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
 pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*,java.util.*"%>
<%
    String userid = request.getParameter("usr");
    String password = request.getParameter("password");

    // Store the username in session
    session.setAttribute("userid", userid);

    try {
        // Load the MySQL driver
        Class.forName("com.mysql.cj.jdbc.Driver");
        
        // Establish the connection to the database
        java.sql.Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/userdb", "root", "Panda@2003");
        
        // Create statement and execute query
        Statement st = con.createStatement();
        ResultSet rs = st.executeQuery("SELECT * FROM users WHERE userid='" + userid + "' AND password='" + password + "'");

        // Check if user exists in the database
        if (rs.next()) {
            // Redirect to home page if login is successful
            response.sendRedirect("success.html");
        } else {
            out.print("<script>alert('Invalid credentials, please try again.');</script>");
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
