<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Investment Details</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #f8f9fa;
        }
        .investment-section {
            margin: 20px;
            padding: 20px;
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        .investment-section h2 {
            color: #007bff;
        }
        table {
            width: 100%;
            border-collapse: collapse;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 10px;
            text-align: center;
        }
        th {
            background-color: #007bff;
            color: white;
        }
    </style>
</head>
<body>
    <div class="investment-section">
        <h2>Investment Details</h2>
        <table>
            <thead>
                <tr>
                    <th>User ID</th>
                    <th>Stock ID</th>
                    <th>Stock Name</th>
                    <th>Quantity</th>
                    <th>Strategy</th>
                    <th>Rate</th>
                    <th>Amount (USD)</th>
                    <th>Transaction Date</th>
                </tr>
            </thead>
            <tbody>
                <%
                    Connection conn = null;
                    PreparedStatement pstmt = null;
                    ResultSet rs = null;

                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/userdb", "root", "Panda@2003");

                        // Query to fetch investment details
                        String query = "SELECT t.user_id, t.stock_id, s.name AS stock_name, t.quantity, t.strategy, t.rate, t.amount, t.transaction_date " +
                                       "FROM transactions t " +
                                       "JOIN stocks s ON t.stock_id = s.id " +
                                       "ORDER BY t.transaction_date DESC";

                        pstmt = conn.prepareStatement(query);
                        rs = pstmt.executeQuery();

                        while (rs.next()) {
                            String userId = rs.getString("user_id");
                            String stockId = rs.getString("stock_id");
                            String stockName = rs.getString("stock_name");
                            int quantity = rs.getInt("quantity");
                            String strategy = rs.getString("strategy");
                            String rate = rs.getString("rate");
                            double amount = rs.getDouble("amount");
                            Timestamp transactionDate = rs.getTimestamp("transaction_date");
                %>
                <tr>
                    <td><%= userId %></td>
                    <td><%= stockId %></td>
                    <td><%= stockName %></td>
                    <td><%= quantity %></td>
                    <td><%= strategy %></td>
                    <td><%= rate %></td>
                    <td><%= amount %></td>
                    <td><%= transactionDate %></td>
                </tr>
                <%
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                        out.println("<tr><td colspan='8'>Error: " + e.getMessage() + "</td></tr>");
                    } finally {
                        if (rs != null) rs.close();
                        if (pstmt != null) pstmt.close();
                        if (conn != null) conn.close();
                    }
                %>
            </tbody>
        </table>
        <br>
        <a href="admin_dashboard.jsp" class="btn btn-primary">Back to Dashboard</a>
    </div>
</body>
</html>
