<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.Random" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Payment Result</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #f8f9fa;
        }
        .result-section {
            margin: 20px;
            padding: 20px;
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            text-align: center;
        }
        .success-message {
            color: green;
            font-size: 1.2em;
            text-align: center;
            margin-top: 20px;
        }
        .error-message {
            color: red;
            font-size: 1.2em;
            text-align: center;
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <div class="result-section">
        <%
            Random random = new Random();
            long transactionId = 1000000000L + (long) (random.nextDouble() * 9000000000L);

            String paymentStatus = "success";
            String userid = request.getParameter("userid");
            String stockid = request.getParameter("stockid");
            String quantity = request.getParameter("quantity");
            String strategy = request.getParameter("strategy");
            String rate = request.getParameter("rate");
            double amount = Double.parseDouble(request.getParameter("amount"));
            String paymentMethod = request.getParameter("payment_method");
            String paymentStatusMessage = paymentStatus.equals("success") ? "Payment Successful!" : "Payment Failed";

            String url = "jdbc:mysql://localhost:3306/userdb";
            String dbUser = "root";
            String dbPassword = "Panda@2003";

            Connection con = null;
            PreparedStatement ps = null;

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                con = DriverManager.getConnection(url, dbUser, dbPassword);

                String query = "INSERT INTO transactions (user_id, stock_id, quantity, strategy, rate, amount, payment_method, transaction_status, transaction_id) " +
                               "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
                ps = con.prepareStatement(query);
                ps.setString(1, userid);
                ps.setInt(2, Integer.parseInt(stockid));
                ps.setInt(3, Integer.parseInt(quantity));
                ps.setString(4, strategy);
                ps.setString(5, rate);
                ps.setDouble(6, amount);
                ps.setString(7, paymentMethod);
                ps.setString(8, paymentStatusMessage);
                ps.setLong(9, transactionId);

                int result = ps.executeUpdate();

                if (result > 0) {
        %>
                    <h3 class="success-message">Payment Successful!</h3>
                    <p>Your transaction ID: <%= transactionId %></p>
                    <p>Amount: $<%= amount %></p>
                    <a href="update.html" class="btn btn-success">Back to Dashboard</a>
        <%
                } else {
        %>
                    <h3 class="error-message">Payment Failed</h3>
                    <p>Unable to process your payment. Please try again.</p>
                    <a href="payment_invest.jsp" class="btn btn-danger">Retry Payment</a>
        <%
                }
            } catch (Exception e) {
                e.printStackTrace();
        %>
                <h3 class="error-message">Error</h3>
                <p><%= e.getMessage() %></p>
                <a href="payment_invest.jsp" class="btn btn-danger">Go Back</a>
        <%
            } finally {
                if (ps != null) ps.close();
                if (con != null) con.close();
            }
        %>
    </div>
</body>
</html>
