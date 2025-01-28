<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Stock Action</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f7f7f7; /* Light gray background */
            padding-top: 50px;
        }
        .notification {
            margin: 20px auto;
            padding: 20px;
            border-radius: 8px;
            width: 50%;
            font-size: 18px;
        }
        .notification-success {
            background-color: #28a745;  /* Green background for success */
            color: white;
            text-align: center;
        }
        .notification-error {
            background-color: #dc3545;  /* Red background for error */
            color: white;
            text-align: center;
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
        String symbol = request.getParameter("symbol");
        String name = request.getParameter("name");
        double price = Double.parseDouble(request.getParameter("price"));
        float priceChange = Float.parseFloat(request.getParameter("price_change"));
        String marketCap = request.getParameter("market_cap");
        String volume = request.getParameter("volume");
        String lastTraded = request.getParameter("last_traded");
        String sector = request.getParameter("sector");

        // Database connection details
        String url = "jdbc:mysql://localhost:3306/userdb";
        String dbUser = "root";
        String dbPassword = "Panda@2003";

        Connection con = null;
        PreparedStatement ps = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection(url, dbUser, dbPassword);

            // Query to update the stock details
            String query = "UPDATE stocks SET symbol = ?, name = ?, price = ?, price_change = ?, market_cap = ?, volume = ?, last_traded = ?, sector = ? WHERE id = ?";
            ps = con.prepareStatement(query);
            ps.setString(1, symbol);
            ps.setString(2, name);
            ps.setDouble(3, price);
            ps.setFloat(4, priceChange);
            ps.setString(5, marketCap);
            ps.setString(6, volume);
            ps.setString(7, lastTraded);
            ps.setString(8, sector);
            ps.setInt(9, id);

            int result = ps.executeUpdate();

            if (result > 0) {
                out.println("<div class='notification notification-success'>");
                out.println("<h3>Success! Stock Updated Successfully.</h3>");
                out.println("<a href='manage_stocks.jsp' class='btn btn-primary'>Back to Manage Stocks</a>");
                out.println("</div>");
            } else {
                out.println("<div class='notification notification-error'>");
                out.println("<h3>Error: Unable to update stock.</h3>");
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
