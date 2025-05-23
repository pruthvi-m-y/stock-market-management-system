<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*,java.util.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Investment Result</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #f8f9fa;
            margin: 0;
            padding: 0;
        }
        .result-section {
            margin: 20px;
            padding: 20px;
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            text-align: center;
        }
        .result-section h2 {
            color: #007bff;
        }
        .result-section .btn {
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <div class="result-section">
        <%
            String userid = request.getParameter("userid");
            String stockid = request.getParameter("stockid");
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            double amount = Double.parseDouble(request.getParameter("amount"));
            String strategy = request.getParameter("strategy");
            String rate = request.getParameter("rate");  // Capture the investment rate

            // Database connection details
            String url = "jdbc:mysql://localhost:3306/userdb";
            String dbUser = "root";
            String dbPassword = "Panda@2003";

            Connection con = null;
            PreparedStatement ps = null;

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                con = DriverManager.getConnection(url, dbUser, dbPassword);

                // Query to insert new investment with the rate field
                String query = "INSERT INTO investments (userid, id, quantity, investment_amount, investment_strategy, investment_rate) VALUES (?, ?, ?, ?, ?, ?)";
                ps = con.prepareStatement(query);
                ps.setString(1, userid);
                ps.setInt(2, Integer.parseInt(stockid));
                ps.setInt(3, quantity);
                ps.setDouble(4, amount);
                ps.setString(5, strategy);
                ps.setString(6, rate);  // Set the investment rate

                int result = ps.executeUpdate();

                if (result > 0) {
                    out.println("<h2>Investment Successful!</h2>");
                    out.println("<p>Your investment in stock ID " + stockid + " has been successfully processed.</p>");
                    out.println("<p>Quantity: " + quantity + "</p>");
                    out.println("<p>Investment Amount: $" + amount + "</p>");
                    out.println("<p>Investment Strategy: " + strategy + "</p>");
                    out.println("<p>Investment Rate: " + rate + "</p>");
                    out.println("<a href='invest.jsp' class='btn btn-primary'>Back</a>");
                } else {
                    out.println("<h2>Investment Failed!</h2>");
                    out.println("<p>There was an error processing your investment. Please try again.</p>");
                    out.println("<a href='invest.jsp' class='btn btn-danger'>Try Again</a>");
                }
            } catch (Exception e) {
                e.printStackTrace();
                out.println("<h2>Error</h2>");
                out.println("<p>" + e.getMessage() + "</p>");
                out.println("<a href='invest.jsp' class='btn btn-danger'>Go Back</a>");
            } finally {
                if (ps != null) ps.close();
                if (con != null) con.close();
            }
        %>
    </div>
</body>
</html>
