<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Buy Stocks</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f9f9f9;
            margin: 0;
            padding: 0;
        }
        table {
            width: 80%;
            margin: 20px auto;
            border-collapse: collapse;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 10px;
            text-align: center;
        }
        th {
            background-color: #4CAF50;
            color: white;
        }
        tr:nth-child(even) {
            background-color: #f2f2f2;
        }
        tr:hover {
            background-color: #ddd;
        }
        .container {
            width: 90%;
            margin: 0 auto;
        }
        .form-container {
            margin: 20px auto;
            text-align: center;
        }
        input[type="text"], input[type="number"], select, button {
            padding: 10px;
            margin: 5px;
            border-radius: 5px;
            border: 1px solid #ccc;
        }
        button {
            background-color: #4CAF50;
            color: white;
            cursor: pointer;
        }
        button:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1 style="text-align: center;">Buy Stocks</h1>
        <table>
            <tr>
                <th>Stock ID</th>
                <th>Symbol</th>
                <th>Name</th>
                <th>Price (USD)</th>
                <th>Sector</th>
                <th>Available Quantity</th>
                <th>Action</th>
            </tr>
            <%
                Connection conn = null;
                Statement stmt = null;
                ResultSet rs = null;

                try {
                    // Database connection
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/userdb", "root", "Panda@2003");

                    // Query to fetch stocks
                    String query = "SELECT * FROM stocks";
                    stmt = conn.createStatement();
                    rs = stmt.executeQuery(query);

                    while (rs.next()) {
                        int stockId = rs.getInt("id");
                        String symbol = rs.getString("symbol");
                        String name = rs.getString("name");
                        float price = rs.getFloat("price");
                        String sector = rs.getString("sector");
                        int availableQuantity = rs.getInt("available_quantity");
            %>
            <tr>
                <td><%= stockId %></td>
                <td><%= symbol %></td>
                <td><%= name %></td>
                <td><%= price %></td>
                <td><%= sector %></td>
                <td><%= availableQuantity %></td>
                <td>
                    <form action="new_buy_action.jsp" method="post">
                        <input type="hidden" name="stockId" value="<%= stockId %>">
                        <input type="hidden" name="stockPrice" value="<%= price %>">
                        <input type="number" name="quantity" placeholder="Enter Quantity" required>
                        <button type="submit">Buy</button>
                    </form>
                </td>
            </tr>
            <%
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    if (rs != null) rs.close();
                    if (stmt != null) stmt.close();
                    if (conn != null) conn.close();
                }
            %>
        </table>
    </div>
</body>
</html>
