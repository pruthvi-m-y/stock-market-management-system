<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Contact Us - Response</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            text-align: center;
            margin-top: 50px;
        }
        .message {
            padding: 20px;
            border-radius: 5px;
            width: 60%;
            margin: 0 auto;
            font-size: 18px;
        }
        .success {
            background-color: #4CAF50;
            color: white;
        }
        .error {
            background-color: #f44336;
            color: white;
        }
    </style>
</head>
<body>

<%
    // Get form data
    String name = request.getParameter("name");
    String email = request.getParameter("email");
    String message = request.getParameter("message");

    Connection conn = null;
    PreparedStatement pstmt = null;
    String responseMessage = "";
    String responseClass = "";

    try {
        // Database connection
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/userdb", "root", "Panda@2003");

        // Insert data into the 'contact' table
        String query = "INSERT INTO contact (name, email, message) VALUES (?, ?, ?)";
        pstmt = conn.prepareStatement(query);
        pstmt.setString(1, name);
        pstmt.setString(2, email);
        pstmt.setString(3, message);

        int rows = pstmt.executeUpdate();
        if (rows > 0) {
            responseMessage = "Your message has been successfully sent!";
            responseClass = "success";
        } else {
            responseMessage = "There was an issue sending your message. Please try again.";
            responseClass = "error";
        }
    } catch (Exception e) {
        e.printStackTrace();
        responseMessage = "Error occurred: " + e.getMessage();
        responseClass = "error";
    } finally {
        try {
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
%>

<div class="message <%= responseClass %>">
    <p><%= responseMessage %></p>
    <a href="contact.html">Go back to Contact Form</a>
</div>

</body>
</html>
