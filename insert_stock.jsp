<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Insert Stock</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            font-family: 'Roboto', sans-serif;
            background: #f5f7fa;
            color: #333;
            line-height: 1.6;
        }
        .container {
            width: 50%;
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
        .form-group {
            margin-bottom: 15px;
        }
        .btn-primary {
            width: 100%;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Insert Stock</h2>
        <form action="insert_stock_action.jsp" method="post">
            <div class="form-group">
                <label for="symbol">Stock Symbol:</label>
                <input type="text" class="form-control" id="symbol" name="symbol" required>
            </div>
            <div class="form-group">
                <label for="name">Name:</label>
                <input type="text" class="form-control" id="name" name="name" required>
            </div>
            <div class="form-group">
                <label for="price">Price:</label>
                <input type="number" class="form-control" id="price" name="price" required>
            </div>
            <div class="form-group">
                <label for="price_change">Price Change:</label>
                <input type="number" step="0.01" class="form-control" id="price_change" name="price_change">
            </div>
            <div class="form-group">
                <label for="market_cap">Market Cap:</label>
                <input type="text" class="form-control" id="market_cap" name="market_cap" required>
            </div>
            <div class="form-group">
                <label for="volume">Volume:</label>
                <input type="text" class="form-control" id="volume" name="volume" required>
            </div>
            <div class="form-group">
                <label for="last_traded">Last Traded:</label>
                <input type="time" class="form-control" id="last_traded" name="last_traded">
            </div>
            <div class="form-group">
                <label for="sector">Sector:</label>
                <input type="text" class="form-control" id="sector" name="sector" required>
            </div>
            <button type="submit" class="btn btn-primary">Insert Stock</button>
        </form>
    </div>
</body>
</html>
