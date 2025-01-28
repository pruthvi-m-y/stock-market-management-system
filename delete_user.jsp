<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%
    // Get the userid parameter from the request
    String userid = request.getParameter("userid");

    // Database connection details
    String url = "jdbc:mysql://localhost:3306/userdb";
    String dbUser = "root";
    String dbPassword = "Panda@2003";

    Connection con = null;
    PreparedStatement ps = null;

    try {
        // Database connection
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection(url, dbUser, dbPassword);

        // SQL query to delete the user
        String query = "DELETE FROM users WHERE userid = ?";
        ps = con.prepareStatement(query);
        ps.setString(1, userid);

        // Execute the delete query
        int rowsAffected = ps.executeUpdate();

        if (rowsAffected > 0) {
            out.println("<script>alert('User deleted successfully.');</script>");
        } else {
            out.println("<script>alert('Failed to delete user. Please try again.');</script>");
        }

        // Redirect back to the manage users page
        response.sendRedirect("manage_users.jsp");

    } catch (Exception e) {
        e.printStackTrace();
        out.println("<script>alert('Error occurred: " + e.getMessage() + "');</script>");
    } finally {
        if (ps != null) ps.close();
        if (con != null) con.close();
    }
%>
