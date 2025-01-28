<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>User Investments</title>
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
    </style>
</head>
<body>
    <div class="container">
        <h2>User Investments</h2>
        <table>
            <thead>
                <tr>
                    <th>Investment ID</th>
                    <th>User ID</th>
                    <th>Stock</th>
                    <th>Quantity</th>
                    <th>Investment Amount ($)</th>
                    <th>Strategy</th>
                    <th>Status</th>
                    <th>Investment Date</th>
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

                        // Query to get complete user investments
                        String query = "SELECT i.investment_id, u.userid, s.name, i.quantity, i.investment_amount, i.investment_strategy, i.status, i.investment_date " +
                                       "FROM users u " +
                                       "JOIN investments i ON u.userid = i.userid " +
                                       "JOIN stocks s ON i.id = s.id";
                        ps = con.prepareStatement(query);
                        rs = ps.executeQuery();

                        System.out.println("Executing query: " + query);

                        while (rs.next()) {
                            int investmentId = rs.getInt("investment_id");
                            String userId = rs.getString("userid");
                            String stockName = rs.getString("name");
                            int quantity = rs.getInt("quantity");
                            double investmentAmount = rs.getDouble("investment_amount");
                            String strategy = rs.getString("investment_strategy");
                            String status = rs.getString("status");
                            Timestamp investmentDate = rs.getTimestamp("investment_date");

                            System.out.println("Investment ID: " + investmentId + ", User ID: " + userId + ", Stock: " + stockName);

                            out.println("<tr>");
                            out.println("<td>" + investmentId + "</td>");
                            out.println("<td>" + userId + "</td>");
                            out.println("<td>" + stockName + "</td>");
                            out.println("<td>" + quantity + "</td>");
                            out.println("<td>" + investmentAmount + "</td>");
                            out.println("<td>" + strategy + "</td>");
                            out.println("<td>" + status + "</td>");
                            out.println("<td>" + investmentDate + "</td>");
                            out.println("</tr>");
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    } finally {
                        if (rs != null) rs.close();
                        if (ps != null) ps.close();
                        if (con != null) con.close();
                    }
                %>
            </tbody>
        </table>
        <a href="admin_dashboard.jsp" class="btn btn-secondary">Back to Dashboard</a>
    </div>
</body>
</html>
