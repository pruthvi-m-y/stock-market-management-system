<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Process Purchase</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f9f9f9;
            text-align: center;
            margin-top: 50px;
        }
        .message {
            padding: 20px;
            border-radius: 5px;
            margin: 20px auto;
            width: 50%;
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
        a {
            text-decoration: none;
            color: #4CAF50;
            font-weight: bold;
        }
    </style>
</head>
<body>
    <%
        Connection conn = null;
        PreparedStatement pstmt = null;

        // Get form data
        String userId = "11"; // Hardcoded for now; replace with session or user input
        int stockId = Integer.parseInt(request.getParameter("stockId"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        float stockPrice = Float.parseFloat(request.getParameter("stockPrice"));
        float totalCost = quantity * stockPrice;

        try {
            // Database connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/userdb", "root", "password");

            // Insert purchase into purchases table
            String query = "INSERT INTO purchases (userid, id, quantity, total_cost) VALUES (?, ?, ?, ?)";
            pstmt = conn.prepareStatement(query);
            pstmt.setString(1, userId); // Replace with dynamic user ID when available
            pstmt.setInt(2, stockId);
            pstmt.setInt(3, quantity);
            pstmt.setFloat(4, totalCost);

            int rows = pstmt.executeUpdate();
            if (rows > 0) {
    %>
                <div class="message success">
                    <p>Stock purchase successful!</p>
                    <p>Total cost: <strong>$<%= totalCost %></strong></p>
                    <a href="buyStocks.jsp">Buy More Stocks</a>
                </div>
    <%
            } else {
    %>
                <div class="message error">
                    <p>Stock purchase failed. Please try again.</p>
                    <a href="buyStocks.jsp">Back to Buy Stocks</a>
                </div>
    <%
            }
        } catch (Exception e) {
            e.printStackTrace();
    %>
            <div class="message error">
                <p>Error occurred: <%= e.getMessage() %></p>
                <a href="buyStocks.jsp">Back to Buy Stocks</a>
            </div>
    <%
        } finally {
            try {
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    %>
</body>
</html>
