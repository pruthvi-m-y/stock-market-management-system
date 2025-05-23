<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Complete Your Investment</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #f8f9fa;
        }
        .payment-section {
            margin: 20px;
            padding: 20px;
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        .payment-section h2 {
            color: #007bff;
        }
        .form-group {
            margin-bottom: 15px;
        }
    </style>
</head>
<body>
    <div class="payment-section">
        <h2>Complete Your Payment</h2>
        <form id="paymentForm" action="payment_invest_action.jsp" method="post">
            <input type="hidden" name="userid" value="<%= request.getParameter("userid") %>">
            <input type="hidden" name="stockid" value="<%= request.getParameter("stockid") %>">
            <input type="hidden" name="quantity" value="<%= request.getParameter("quantity") %>">
            <input type="hidden" name="strategy" value="<%= request.getParameter("strategy") %>">
            <input type="hidden" name="rate" value="<%= request.getParameter("rate") %>">
            <input type="hidden" name="amount" value="<%= request.getParameter("amount") %>">

            <div class="form-group">
                <label for="payment_method">Payment Method:</label>
                <select class="form-control" id="payment_method" name="payment_method" onchange="showPaymentDetails(this.value)" required>
                    <option value="">Select Payment Method</option>
                    <option value="Credit Card">Credit Card</option>
                    <option value="Debit Card">Debit Card</option>
                    <option value="UPI">UPI</option>
                </select>
            </div>
            <div id="creditCardDetails" style="display:none;">
                <div class="form-group">
                    <label for="cardnumber">Card Number:</label>
                    <input type="text" class="form-control" id="cardnumber" name="cardnumber" placeholder="Enter Credit Card Number">
                </div>
                <div class="form-group">
                    <label for="expiry">Expiry Date:</label>
                    <input type="text" class="form-control" id="expiry" name="expiry" placeholder="MM/YY">
                </div>
                <div class="form-group">
                    <label for="cvv">CVV:</label>
                    <input type="password" class="form-control" id="cvv" name="cvv">
                </div>
            </div>
            <div id="debitCardDetails" style="display:none;">
                <div class="form-group">
                    <label for="debitCardNumber">Debit Card Number:</label>
                    <input type="text" class="form-control" id="debitCardNumber" name="debitCardNumber" placeholder="Enter Debit Card Number">
                </div>
                <div class="form-group">
                    <label for="debitExpiry">Expiry Date:</label>
                    <input type="text" class="form-control" id="debitExpiry" name="debitExpiry" placeholder="MM/YY">
                </div>
                <div class="form-group">
                    <label for="debitCvv">CVV:</label>
                    <input type="password" class="form-control" id="debitCvv" name="debitCvv">
                </div>
            </div>
            <div id="upiDetails" style="display:none;">
                <div class="form-group">
                    <label for="upiId">UPI ID:</label>
                    <input type="text" class="form-control" id="upiId" name="upiId" placeholder="Enter UPI ID">
                </div>
            </div>
            <button type="submit" class="btn btn-success">Pay Now</button>
        </form>
    </div>
    <script>
        function showPaymentDetails(paymentMethod) {
            document.getElementById('creditCardDetails').style.display = 'none';
            document.getElementById('debitCardDetails').style.display = 'none';
            document.getElementById('upiDetails').style.display = 'none';

            if (paymentMethod === 'Credit Card') {
                document.getElementById('creditCardDetails').style.display = 'block';
            } else if (paymentMethod === 'Debit Card') {
                document.getElementById('debitCardDetails').style.display = 'block';
            } else if (paymentMethod === 'UPI') {
                document.getElementById('upiDetails').style.display = 'block';
            }
        }
    </script>
</body>
</html>
