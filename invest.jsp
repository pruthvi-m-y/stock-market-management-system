<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Invest</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet">
	<style>
		* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: 'Roboto', sans-serif;
    background-color: #F7F7F7;
    color: #333;
    line-height: 1.6;
}

/* Header */
header {
    background-color: #1F3A64;
    color: white;
    text-align: center;
    padding: 30px;
    margin-bottom: 30px;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

header h1 {
    font-size: 2.5rem;
    font-weight: 700;
    margin: 10px 0;
}

header p {
    font-size: 1.2rem;
    margin-top: 10px;
    color: #ECF0F1;
}

.logo {
    width: 50px;
    height: 50px;
    margin-bottom: 10px;
}

        /* Navigation styles */
        .nav-container {
            background-color: #2980B9;
            padding: 15px 40px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-radius: 8px;
            margin: 0 20px 40px 20px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        .nav-links a {
            color: white;
            font-size: 1.1rem;
            font-weight: 600;
            padding: 10px 20px;
            text-decoration: none;
            transition: background-color 0.3s ease;
            display: inline-block;
        }

.nav-links a:hover {
    background-color: #1F618D;
}

.logout-button a {
    color: white;
    font-size: 1.1rem;
    font-weight: 600;
    padding: 10px 20px;
    background-color: #E74C3C;
    border-radius: 5px;
    text-decoration: none;
    transition: background-color 0.3s ease;
}

.logout-button a:hover {
    background-color: #C0392B;
}

/* Investment Form Section */
.invest-section {
    max-width: 800px;
    margin: 0 auto;
    padding: 30px;
    background-color: white;
    border-radius: 8px;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

.invest-section h2 {
    color: #2980B9;
    font-size: 1.8rem;
    margin-bottom: 25px;
    text-align: center;
}

.form-group {
    margin-bottom: 20px;
}

.form-group label {
    display: block;
    margin-bottom: 8px;
    font-weight: 600;
    color: #333;
}

.form-control {
    width: 100%;
    padding: 12px;
    border: 1px solid #ddd;
    border-radius: 5px;
    font-size: 1rem;
    transition: border-color 0.3s ease;
}

.form-control:focus {
    border-color: #2980B9;
    outline: none;
    box-shadow: 0 0 0 2px rgba(41, 128, 185, 0.2);
}

select.form-control {
    cursor: pointer;
}

/* Button Styling */
.btn-primary {
    background-color: #2980B9;
    color: white;
    border: none;
    padding: 12px 25px;
    border-radius: 5px;
    font-size: 1.1rem;
    font-weight: 600;
    cursor: pointer;
    transition: background-color 0.3s ease;
    width: 100%;
    margin-top: 20px;
}

.btn-primary:hover {
    background-color: #1F618D;
}

/* Responsive Design */
@media (max-width: 768px) {
    .nav-container {
        flex-direction: column;
        padding: 15px;
    }

    .nav-links {
        margin-bottom: 15px;
    }

    .nav-links a {
        display: block;
        margin: 5px 0;
        text-align: center;
    }

    .invest-section {
        margin: 20px;
        padding: 20px;
    }

    .form-group {
        margin-bottom: 15px;
    }
}
	</style>
    <script>
        function fetchStockPrice(stockId) {
            if (stockId === "") {
                document.getElementById('stockPrice').value = "";
                return;
            }
            var xhr = new XMLHttpRequest();
            xhr.onreadystatechange = function() {
                if (xhr.readyState == 4 && xhr.status == 200) {
                    document.getElementById('stockPrice').value = xhr.responseText;
                }
            };
            xhr.open("GET", "fetch_stock_price.jsp?stockid=" + stockId, true);
            xhr.send();
        }
        
        function calculateAmount() {
            var quantity = document.getElementById('quantity').value;
            var stockPrice = document.getElementById('stockPrice').value;
            var amount = quantity * stockPrice;
            document.getElementById('amount').value = amount;
        }
    </script>
</head>
<body>
    <header>
     <img src="sm.png" alt="Stock Market Logo" class="logo">
        <h1>Invest on your stocks</h1>
        <p>The Future is Yours to Invest In.</p>
    </header>
    <!-- Navigation Section -->
    <div class="nav-container">
        <div class="nav-links">
            <a href="success.html"><b>Home</b></a>
            <a href="about.html"><b>About Us</b></a>
            <a href="market.jsp"><b>Market</b></a>
            <a href="fund.html"><b>Mutual Funds</b></a>
            <a href="update.html"><b>Growth</b></a>
            <a href="contact.html"><b>Contact Us</b></a>
        </div>
        <div class="logout-button">
            <a href="logout.html"><b>Logout</b></a>
        </div>
    </div>

    <div class="invest-section">
        <h2>Make an Investment</h2>
        <form action="payment_invest.jsp" method="post" onsubmit="calculateAmount()">
            <div class="form-group">
                <label for="userid">User ID:</label>
                <input type="text" class="form-control" id="userid" name="userid" required>
            </div>

            <div class="form-group">
                <label for="stockid">Stock:</label>
                <select class="form-control" id="stockid" name="stockid" onchange="fetchStockPrice(this.value)" required>
                    <option value="">---Select Stock---</option>
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

                            // Query to fetch available stocks
                            String query = "SELECT id, name FROM stocks";
                            ps = con.prepareStatement(query);
                            rs = ps.executeQuery();

                            // Populate the dropdown list
                            while (rs.next()) {
                                String stockId = rs.getString("id");
                                String stockName = rs.getString("name");
                                out.println("<option value='" + stockId + "'>" + stockName + "</option>");
                            }
                        } catch (Exception e) {
                            e.printStackTrace();
                            out.println("<option value=''>Error loading stocks</option>");
                        } finally {
                            if (rs != null) rs.close();
                            if (ps != null) ps.close();
                            if (con != null) con.close();
                        }
                    %>
                </select>
            </div>

            <div class="form-group">
                <label for="quantity">Quantity to Invest:</label>
                <input type="number" class="form-control" id="quantity" name="quantity" min="1" required>
            </div>

            <div class="form-group">
                <label for="strategy">Investment Strategy:</label>
                <select class="form-control" id="strategy" name="strategy" required>
                    <option value="choice">---Select your strategy---</option>
                    <option value="long-term">Long Term</option>
                    <option value="short-term">Short Term</option>
                </select>
            </div>

            <div class="form-group">
                <label for="rate">Rate (%):</label>
                <select class="form-control" id="rate" name="rate" required>
                    <option value="choice">---Select the type fund---</option>
                    <option value="equity">Equity Fund</option>
                    <option value="debt">Debt Fund</option>
                    <option value="balanced">Balanced Fund</option>
                </select>
            </div>

            <div class="form-group">
                <label for="amount">Amount (USD):</label>
                <input type="text" class="form-control" id="amount_display" name="amount_display" readonly>
                <input type="hidden" id="amount" name="amount">
            </div>

            <!-- Hidden field for storing stock price -->
            <input type="hidden" id="stockPrice" name="stockPrice">

            <button type="submit" class="btn btn-primary">Proceed to Payment</button>
        </form>
    </div>
</body>
</html>
