<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Delete Stock</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f0f4f8;  /* Light gray background color */
            padding-top: 50px;
            text-align: center;
        }
        .notification {
            margin: 20px auto;
            padding: 20px;
            border-radius: 5px;
            width: 50%;
            font-size: 18px;
        }
        .notification-success {
            background-color: #28a745;  /* Green background for success */
            color: white;
        }
        .notification-error {
            background-color: #dc3545;  /* Red background for error */
            color: white;
        }
        .btn {
            margin-top: 20px;
            font-size: 16px;
            padding: 10px 20px;
        }
    </style>
</head>
<body>

    <%
        int id = Integer.parseInt(request.getParameter("id"));

        // Database connection details
        String url = "jdbc:mysql://localhost:3306/userdb";
        String dbUser = "root";
        String dbPassword = "Panda@2003";

        Connection con = null;
        PreparedStatement ps = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection(url, dbUser, dbPassword);

            // Query to delete the stock
            String query = "DELETE FROM stocks WHERE id = ?";
            ps = con.prepareStatement(query);
            ps.setInt(1, id);

            int result = ps.executeUpdate();

            if (result > 0) {
                out.println("<div class='notification notification-success'>");
                out.println("<h3>Success! Stock Deleted Successfully.</h3>");
                out.println("<a href='manage_stocks.jsp' class='btn btn-primary'>Back to Manage Stocks</a>");
                out.println("</div>");
            } else {
                out.println("<div class='notification notification-error'>");
                out.println("<h3>Error: Unable to delete stock.</h3>");
                out.println("<a href='manage_stocks.jsp' class='btn btn-danger'>Back to Manage Stocks</a>");
                out.println("</div>");
            }
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<div class='notification notification-error'>");
            out.println("<h3>Error: " + e.getMessage() + "</h3>");
            out.println("<a href='manage_stocks.jsp' class='btn btn-danger'>Back to Manage Stocks</a>");
            out.println("</div>");
        } finally {
            if (ps != null) ps.close();
            if (con != null) con.close();
        }
    %>

</body>
</html>
