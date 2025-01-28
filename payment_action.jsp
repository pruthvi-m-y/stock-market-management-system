<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*,java.util.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Transaction Success</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f9;
            color: #333;
            margin: 0;
            padding: 0;
        }
        .container {
            width: 80%;
            max-width: 800px;
            margin: 50px auto;
            padding: 20px;
            background-color: #ffffff;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        .header {
            text-align: center;
            padding-bottom: 20px;
        }
        .header h1 {
            font-size: 2.5em;
            color: #4CAF50;
        }
        .header p {
            font-size: 1.2em;
            color: #555;
        }
        .payment-info {
            font-size: 1.1em;
            margin-bottom: 30px;
        }
        .payment-info p {
            margin: 10px 0;
        }
        .success-message {
            background-color: #4CAF50;
            color: white;
            padding: 15px;
            text-align: center;
            font-size: 1.3em;
            border-radius: 5px;
            margin-bottom: 20px;
        }
        .button {
            display: block;
            width: 200px;
            margin: 0 auto;
            padding: 10px 20px;
            background-color: #4CAF50;
            color: white;
            text-align: center;
            font-size: 1.1em;
            border-radius: 5px;
            text-decoration: none;
        }
        .button:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>

<%
    // Retrieve user ID from session
    String userId = (String) session.getAttribute("userid");

    // Check if user is logged in
    if (userId == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    // Retrieve payment form data from the request
    String stockId = request.getParameter("stockId");
    String stockName = request.getParameter("stockName");
    int quantity = Integer.parseInt(request.getParameter("quantity"));
    double amount = Double.parseDouble(request.getParameter("amount"));
    String paymentMethod = request.getParameter("payment_method");
    String paymentDetails = "";

    // Construct payment details based on selected method
    if (paymentMethod.equals("Credit Card")) {
        paymentDetails = "Credit Card ending with " + request.getParameter("cardnumber").substring(12);
    } else if (paymentMethod.equals("Debit Card")) {
        paymentDetails = "Debit Card ending with " + request.getParameter("debitCardNumber").substring(12);
    } else if (paymentMethod.equals("UPI")) {
        paymentDetails = "UPI ID: " + request.getParameter("upiId");
    }

    // Connect to the database
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/userdb", "root", "Panda@2003");
        
        // Check if the stock ID exists in the stocks table
        String stockCheckQuery = "SELECT * FROM stocks WHERE id = ?";
        PreparedStatement stockCheckStmt = con.prepareStatement(stockCheckQuery);
        stockCheckStmt.setString(1, stockId);
        ResultSet rsStock = stockCheckStmt.executeQuery();
        
        if (!rsStock.next()) {
            out.println("<p>Error: Stock ID not found in the database.</p>");
            return;
        }

        // Check if the user ID exists in the users table
        String userCheckQuery = "SELECT * FROM users WHERE userid = ?";
        PreparedStatement userCheckStmt = con.prepareStatement(userCheckQuery);
        userCheckStmt.setString(1, userId);
        ResultSet rsUser = userCheckStmt.executeQuery();

        if (!rsUser.next()) {
            out.println("<p>Error: User ID not found in the database.</p>");
            return;
        }

        // Insert transaction details into the transactions table
        String insertQuery = "INSERT INTO transactions (user_id, stock_id, quantity, amount, payment_method, payment_details, transaction_status) VALUES (?, ?, ?, ?, ?, ?, 'Completed')";
        PreparedStatement pstmt = con.prepareStatement(insertQuery);
        pstmt.setString(1, userId);
        pstmt.setString(2, stockId);
        pstmt.setInt(3, quantity);
        pstmt.setDouble(4, amount);
        pstmt.setString(5, paymentMethod);
        pstmt.setString(6, paymentDetails);
        
        // Execute the insert query
        int rowsAffected = pstmt.executeUpdate();

        // Display success or failure message
        if (rowsAffected > 0) {
%>
            <div class="container">
                <div class="header">
                    <h1>Transaction Successful!</h1>
                    <p>Your payment has been successfully processed.</p>
                </div>

                <div class="success-message">
                    Transaction ID: <strong>12345</strong><br>
                    Total Amount: <strong>$1771.5</strong><br>
                    Payment Method: <strong>UPI</strong><br>
                    Payment Details: <strong>UPI ID: my@yaxis</strong>
                </div>

                <a href="update.html" class="button">Go to Home</a>
            </div>
<%
        } else {
            out.println("<p>Error: Transaction failed to insert into the database.</p>");
        }

        // Close the database connection
        con.close();
        
    } catch (Exception e) {
        // Print stack trace for debugging
        out.println("<h3>Error occurred during payment processing</h3>");
        out.println("<pre>");
        e.printStackTrace(new java.io.PrintWriter(out)); // Fix here
        out.println("</pre>");
    }
%>

</body>
</html>
