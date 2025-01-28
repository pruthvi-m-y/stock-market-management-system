<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Complete Payment</title>
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .form-container {
            background-color: #fff;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            width: 400px;
        }
        h2 {
            color: #333;
            margin-bottom: 20px;
            font-size: 1.5em;
            text-align: center;
        }
        .form-group {
            margin-bottom: 15px;
        }
        label {
            font-weight: bold;
            display: block;
            margin-bottom: 5px;
        }
        select, input[type="text"], input[type="number"], .btn, input[type="hidden"] {
            width: 100%;
            padding: 10px;
            border-radius: 5px;
            border: 1px solid #ccc;
            font-size: 1em;
            box-sizing: border-box; /* Ensures padding and border are included in the element's total width and height */
        }
        .btn {
            background-color: #4CAF50;
            color: white;
            border: none;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }
        .btn:hover {
            background-color: #45a049;
        }
        .payment-details {
            display: none;
        }
    </style>
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

        function calculateTotal() {
            const price = parseFloat(document.getElementById('stockPrice').value);
            const quantity = parseInt(document.getElementById('quantity').value);
            const total = price * quantity;
            document.getElementById('amount').value = total;
            document.getElementById('calculatedAmount').value = total.toFixed(2);
        }
    </script>
</head>
<body>
    <div class="form-container">
        <h2>Complete Payment</h2>
        <form id="paymentForm" action="payment_action.jsp" method="post">
            <input type="hidden" name="userId" value="<%= session.getAttribute("userId") %>">
            <input type="hidden" name="stockPrice" id="stockPrice" value="<%= request.getParameter("stockPrice") %>">
            <input type="hidden" name="stockName" value="<%= request.getParameter("stockName") %>">
            <div class="form-group">
                <label for="stockId">Stock ID</label>
                <input type="text" name="stockId" value="<%= request.getParameter("stockId") %>">
            </div>
            <div class="form-group">
                <label for="quantity">Quantity</label>
                <input type="number" name="quantity" id="quantity" value="1" min="1" onchange="calculateTotal()" required>
            </div>

            <div class="form-group">
                <label for="calculatedAmount">Total Amount (USD)</label>
                <input type="text" id="calculatedAmount" readonly>
                <input type="hidden" id="amount" name="amount">
            </div>

            <div class="form-group">
                <label for="payment_method">Payment Method</label>
                <select id="payment_method" name="payment_method" onchange="showPaymentDetails(this.value)" required>
                    <option value="">Select Payment Method</option>
                    <option value="Credit Card">Credit Card</option>
                    <option value="Debit Card">Debit Card</option>
                    <option value="UPI">UPI</option>
                </select>
            </div>

            <div id="creditCardDetails" class="payment-details">
                <div class="form-group">
                    <label for="cardnumber">Credit Card Number</label>
                    <input type="text" id="cardnumber" name="cardnumber" placeholder="Enter Card Number">
                </div>
                <div class="form-group">
                    <label for="expiry">Expiry Date (MM/YY)</label>
                    <input type="text" id="expiry" name="expiry" placeholder="MM/YY">
                </div>
                <div class="form-group">
                    <label for="cvv">CVV</label>
                    <input type="text" id="cvv" name="cvv" placeholder="Enter CVV">
                </div>
            </div>

            <div id="debitCardDetails" class="payment-details">
                <div class="form-group">
                    <label for="debitCardNumber">Debit Card Number</label>
                    <input type="text" id="debitCardNumber" name="debitCardNumber" placeholder="Enter Debit Card Number">
                </div>
                <div class="form-group">
                    <label for="debitExpiry">Expiry Date (MM/YY)</label>
                    <input type="text" id="debitExpiry" name="debitExpiry" placeholder="MM/YY">
                </div>
                <div class="form-group">
                    <label for="debitCvv">CVV</label>
                    <input type="text" id="debitCvv" name="debitCvv" placeholder="Enter CVV">
                </div>
            </div>

            <div id="upiDetails" class="payment-details">
                <div class="form-group">
                    <label for="upiId">UPI ID</label>
                    <input type="text" id="upiId" name="upiId" placeholder="Enter UPI ID">
                </div>
            </div>

            <button type="submit" class="btn">Pay Now</button>
        </form>
    </div>

    <script>
        window.onload = function() {
            calculateTotal();
        };
    </script>
</body>
</html>
