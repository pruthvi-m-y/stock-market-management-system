<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Manage Stocks</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            font-family: 'Roboto', sans-serif;
            background: #f5f7fa;
            color: #333;
            line-height: 1.6;
        }
        .container {
            margin: 50px auto;
            background: #fff;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.1);
        }
        h2 {
            text-align: center;
            margin-bottom: 20px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }
        table th, table td {
            border: 1px solid #ddd;
            padding: 10px;
            text-align: left;
        }
        table th {
            background: #1f3a64;
            color: white;
        }
        .btn {
            margin: 10px 0;
        }
        .actions {
            display: flex;
            justify-content: space-between;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Manage Stocks</h2>
        <div class="actions">
            <a href="insert_stock.jsp" class="btn btn-primary">Add Stock</a>
            <a href="admin_dashboard.jsp" class="btn btn-secondary">Back to Dashboard</a>
        </div>
        <table>
            <thead>
                <tr>
                    <th>Stock Symbol</th>
                    <th>Name</th>
                    <th>Price</th>
                    <th>Price Change</th>
                    <th>Market Cap</th>
                    <th>Volume</th>
                    <th>Last Traded</th>
                    <th>Sector</th>
                    <th>Available Quantity</th> <!-- Added -->
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
<%
    // Database connection details
    String url = "jdbc:mysql://localhost:3306/userdb";
    String dbUser = "root";
    String dbPassword = "Panda@2003";

    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection(url, dbUser, dbPassword);

        // Query to get stock data in alphabetical order
        String query = "SELECT id, symbol, name, price, price_change, market_cap, volume, last_traded, sector, available_quantity FROM stocks ORDER BY name ASC";
        ps = con.prepareStatement(query);
        rs = ps.executeQuery();

        while (rs.next()) {
            int id = rs.getInt("id");
            String symbol = rs.getString("symbol");
            String name = rs.getString("name");
            double price = rs.getDouble("price");
            float priceChange = rs.getFloat("price_change");
            String marketCap = rs.getString("market_cap");
            String volume = rs.getString("volume");
            Time lastTraded = rs.getTime("last_traded");
            String sector = rs.getString("sector");
            int availableQuantity = rs.getInt("available_quantity");

            out.println("<tr>");
            out.println("<td>" + symbol + "</td>");
            out.println("<td>" + name + "</td>");
            out.println("<td>" + price + "</td>");
            out.println("<td>" + priceChange + "</td>");
            out.println("<td>" + marketCap + "</td>");
            out.println("<td>" + volume + "</td>");
            out.println("<td>" + lastTraded + "</td>");
            out.println("<td>" + sector + "</td>");
            out.println("<td>" + availableQuantity + "</td>"); // Displaying new column
            out.println("<td><a href='update_stock.jsp?id=" + id + "' class='btn btn-warning'>Update</a> ");
            out.println("<a href='delete_stock.jsp?id=" + id + "' class='btn btn-danger'>Delete</a></td>");
            out.println("</tr>");
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (ps != null) try { ps.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (con != null) try { con.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
%>
            </tbody>
        </table>
    </div>
</body>
</html>
