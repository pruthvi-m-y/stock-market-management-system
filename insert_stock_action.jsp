<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Insert Stock Action</title>
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
        String symbol = request.getParameter("symbol");
        String name = request.getParameter("name");
        double price = 0;
        float priceChange = 0;
        int availableQuantity = 0;

        try {
            price = Double.parseDouble(request.getParameter("price"));

            if(request.getParameter("price_change") != null && !request.getParameter("price_change").isEmpty()) {
                priceChange = Float.parseFloat(request.getParameter("price_change"));
            }

            // Handle available_quantity
            if(request.getParameter("available_quantity") != null && !request.getParameter("available_quantity").isEmpty()) {
                availableQuantity = Integer.parseInt(request.getParameter("available_quantity"));
            }

        } catch (NumberFormatException e) {
            out.println("<div class='notification notification-error'>");
            out.println("<h3>Error: Invalid numeric value entered.</h3>");
            out.println("<a href='insert_stock.jsp' class='btn btn-danger'>Try Again</a>");
            out.println("</div>");
            return; // Exit early if input is invalid
        }

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

            // Updated query to include available_quantity
            String query = "INSERT INTO stocks (symbol, name, price, price_change, market_cap, volume, last_traded, sector, available_quantity) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
            ps = con.prepareStatement(query);
            ps.setString(1, symbol);
            ps.setString(2, name);
            ps.setDouble(3, price);

            if (request.getParameter("price_change") != null && !request.getParameter("price_change").isEmpty()) {
                ps.setFloat(4, priceChange);
            } else {
                ps.setNull(4, Types.FLOAT);
            }

            ps.setString(5, marketCap);
            ps.setString(6, volume);

            if (lastTraded != null && !lastTraded.isEmpty()) {
                ps.setString(7, lastTraded);
            } else {
                ps.setNull(7, Types.VARCHAR);
            }

            ps.setString(8, sector);
            ps.setInt(9, availableQuantity); // NEW: Set available quantity

            int result = ps.executeUpdate();

            if (result > 0) {
                out.println("<div class='notification notification-success'>");
                out.println("<h3>Success! Stock Inserted Successfully.</h3>");
                out.println("<a href='manage_stocks.jsp' class='btn btn-primary'>Back to Manage Stocks</a>");
                out.println("</div>");
            } else {
                out.println("<div class='notification notification-error'>");
                out.println("<h3>Error: Unable to insert stock.</h3>");
                out.println("<a href='insert_stock.jsp' class='btn btn-danger'>Try Again</a>");
                out.println("</div>");
            }
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<div class='notification notification-error'>");
            out.println("<h3>Error: " + e.getMessage() + "</h3>");
            out.println("<a href='insert_stock.jsp' class='btn btn-danger'>Try Again</a>");
            out.println("</div>");
        } finally {
            if (ps != null) try { ps.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (con != null) try { con.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    %>

</body>

</html>
