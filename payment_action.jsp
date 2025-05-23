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
    String quantityStr = request.getParameter("quantity");
    String amountStr = request.getParameter("amount");
    String paymentMethod = request.getParameter("payment_method");
    String paymentDetails = "";

    // Check if quantity and amount are valid numbers
    int quantity = 0;
    double amount = 0.0;

    try {
        quantity = Integer.parseInt(quantityStr);
        amount = Double.parseDouble(amountStr);
    } catch (NumberFormatException e) {
        out.println("<p>Error: Invalid quantity or amount entered.</p>");
        return;
    }

    // Construct payment details based on selected method
    if (paymentMethod.equals("Credit Card")) {
        paymentDetails = "Credit Card ending with " + request.getParameter("cardnumber").substring(12);
    } else if (paymentMethod.equals("Debit Card")) {
        paymentDetails = "Debit Card ending with " + request.getParameter("debitCardNumber").substring(12);
    } else if (paymentMethod.equals("UPI")) {
        paymentDetails = "UPI ID: " + request.getParameter("upiId");
    }

    // Database connection
    Connection con = null;
    PreparedStatement pstmt = null;
    ResultSet rsStock = null;
    ResultSet rsTransaction = null;

    try {
        // Database connection
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/userdb", "root", "Panda@2003");

        // Check if the stock ID exists in the stocks table
        String stockCheckQuery = "SELECT * FROM stocks WHERE id = ?";
        pstmt = con.prepareStatement(stockCheckQuery);
        pstmt.setString(1, stockId);
        rsStock = pstmt.executeQuery();

        if (!rsStock.next()) {
            out.println("<p>Error: Stock ID not found in the database.</p>");
            return;
        }

        // Retrieve available stock quantity
        int availableQuantity = rsStock.getInt("available_quantity");

        // Check if the requested quantity is available
        if (quantity > availableQuantity) {
            out.println("<p>Error: Insufficient stock quantity available.</p>");
            return;
        }

        // Insert transaction details into the transactions table
        String insertQuery = "INSERT INTO transactions (user_id, stock_id, quantity, strategy, rate, amount, payment_method, transaction_status, payment_details) VALUES (?, ?, ?, ?, ?, ?, ?, 'Completed', ?)";
        pstmt = con.prepareStatement(insertQuery);
        pstmt.setString(1, userId);
        pstmt.setString(2, stockId);
        pstmt.setInt(3, quantity);
        pstmt.setString(4, "Default Strategy");
        pstmt.setString(5, "Default Rate");
        pstmt.setDouble(6, amount);
        pstmt.setString(7, paymentMethod);
        pstmt.setString(8, paymentDetails);

        // Execute the insert query
        int rowsAffected = pstmt.executeUpdate();

        if (rowsAffected > 0) {
            // Update the stock quantity in the stocks table
            String updateStockQuery = "UPDATE stocks SET available_quantity = available_quantity - ? WHERE id = ?";
            pstmt = con.prepareStatement(updateStockQuery);
            pstmt.setInt(1, quantity); // Decrease the stock by the purchased quantity
            pstmt.setString(2, stockId); // Ensure that stockId is correct
            pstmt.executeUpdate();

            // Retrieve the latest transaction ID
            String transactionIdQuery = "SELECT MAX(transaction_id) AS last_transaction_id FROM transactions WHERE user_id = ?";
            pstmt = con.prepareStatement(transactionIdQuery);
            pstmt.setString(1, userId);
            rsTransaction = pstmt.executeQuery();

            String transactionId = "";
            if (rsTransaction.next()) {
                transactionId = rsTransaction.getString("last_transaction_id");
            }

            // Display success message with dynamic data
%>
            <div class="container">
                <div class="header">
                    <h1>Transaction Successful!</h1>
                    <p>Your payment has been successfully processed.</p>
                </div>

                <div class="success-message">
                    Transaction ID: <strong><%= transactionId %></strong><br>
                    Total Amount: <strong><%= amount %></strong><br>
                    Payment Method: <strong><%= paymentMethod %></strong><br>
                    Payment Details: <strong><%= paymentDetails %></strong>
                </div>

                <a href="update.html" class="button">Go to Home</a>
            </div>
<%
        } else {
            out.println("<p>Error: Transaction failed to insert into the database.</p>");
        }

    } catch (Exception e) {
        out.println("<h3>Error occurred during payment processing</h3>");
        out.println("<pre>");
        e.printStackTrace(new java.io.PrintWriter(out)); // Print stack trace for debugging
        out.println("</pre>");
    } finally {
        try {
            if (rsStock != null) rsStock.close();
            if (rsTransaction != null) rsTransaction.close();
            if (pstmt != null) pstmt.close();
            if (con != null) con.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>

</body>
</html>
