<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Transaction Details</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #f8f9fa;
        }
        .transaction-section {
            margin: 20px;
            padding: 20px;
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        .transaction-section h2 {
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
    <div class="transaction-section">
        <h2>Your Transaction Details</h2>
        <table>
            <thead>
                <tr>
                    <th>Transaction ID</th>
                    <th>Stock ID</th>
                    <th>Quantity</th>
                    <th>Strategy</th>
                    <th>Rate</th>
                    <th>Amount (USD)</th>
                    <th>Payment Method</th>
                    <th>Transaction Status</th>
                    <th>Transaction Date</th>
                </tr>
            </thead>
            <tbody>
                <%
                    Connection conn = null;
                    PreparedStatement pstmt = null;
                    ResultSet rs = null;
                    String userid = (String) session.getAttribute("userid");  // Get user ID from session

                    if (userid != null) {
                        try {
                            Class.forName("com.mysql.cj.jdbc.Driver");
                            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/userdb", "root", "Panda@2003");

                            // Query to fetch Buy, Invest transactions, and Purchases
                            String query = "SELECT payment_id AS transaction_id, NULL AS stock_id, NULL AS quantity, NULL AS strategy, NULL AS rate, amount, payment_method, payment_status AS transaction_status, payment_date AS transaction_date " +
                                           "FROM payments WHERE user_id = ? " +
                                           "UNION ALL " +
                                           "SELECT transaction_id, stock_id, quantity, strategy, rate, amount, payment_method, transaction_status, transaction_date " +
                                           "FROM transactions WHERE user_id = ? " +
                                           "UNION ALL " +
                                           "SELECT Pid AS transaction_id, id AS stock_id, quantity, NULL AS strategy, NULL AS rate, total_cost AS amount, NULL AS payment_method, NULL AS transaction_status, purchase_date AS transaction_date " +
                                           "FROM purchases WHERE userid = ? " +
                                           "ORDER BY transaction_date DESC";

                            pstmt = conn.prepareStatement(query);
                            pstmt.setString(1, userid);
                            pstmt.setString(2, userid);
                            pstmt.setString(3, userid);
                            rs = pstmt.executeQuery();

                            while (rs.next()) {
                                String transactionId = rs.getString("transaction_id");
                                String stockId = rs.getString("stock_id") != null ? rs.getString("stock_id") : "-";
                                String quantity = rs.getString("quantity") != null ? rs.getString("quantity") : "-";
                                String strategy = rs.getString("strategy") != null ? rs.getString("strategy") : "-";
                                String rate = rs.getString("rate") != null ? rs.getString("rate") : "-";
                                double amount = rs.getDouble("amount");
                                String paymentMethod = rs.getString("payment_method") != null ? rs.getString("payment_method") : "-";
                                String transactionStatus = rs.getString("transaction_status") != null ? rs.getString("transaction_status") : "-";
                                Timestamp transactionDate = rs.getTimestamp("transaction_date");
                %>
                <tr>
                    <td><%= transactionId %></td>
                    <td><%= stockId %></td>
                    <td><%= quantity %></td>
                    <td><%= strategy %></td>
                    <td><%= rate %></td>
                    <td><%= amount %></td>
                    <td><%= paymentMethod %></td>
                    <td><%= transactionStatus %></td>
                    <td><%= transactionDate %></td>
                </tr>
                <%
                            }
                        } catch (Exception e) {
                            e.printStackTrace();
                            out.println("<tr><td colspan='9'>Error: " + e.getMessage() + "</td></tr>");
                        } finally {
                            if (rs != null) rs.close();
                            if (pstmt != null) pstmt.close();
                            if (conn != null) conn.close();
                        }
                    } else {
                        out.println("<tr><td colspan='9'>User ID not found in session. Please log in.</td></tr>");
                    }
                %>
            </tbody>
        </table>
        <br>
        <a href="update.html" class="btn btn-primary">Back to Dashboard</a>
    </div>
</body>
</html>
