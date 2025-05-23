<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Buy Stocks</title>
    <style>
    	/* Base styles */
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

/* Container */
.container {
    max-width: 1200px;
    margin: 0 auto;
    padding: 20px;
}

/* Table Styles */
table {
    width: 100%;
    background-color: white;
    border-radius: 8px;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    border-collapse: collapse;
    margin-top: 20px;
    overflow: hidden;
}

th {
    background-color: #2980B9;
    color: white;
    padding: 15px;
    text-align: left;
    font-weight: 600;
}

td {
    padding: 12px 15px;
    border-bottom: 1px solid #eee;
}

tr:hover {
    background-color: #f5f8fa;
}

/* Button Styles */
button {
    background-color: #2980B9;
    color: white;
    border: none;
    padding: 8px 16px;
    border-radius: 5px;
    cursor: pointer;
    font-weight: 600;
    transition: background-color 0.3s ease;
}

button:hover {
    background-color: #1F618D;
}

/* Form Styles */
form {
    margin: 0;
}

input[type="number"] {
    width: 80px;
    padding: 6px;
    border: 1px solid #ddd;
    border-radius: 4px;
    margin-right: 8px;
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

    table {
        display: block;
        overflow-x: auto;
        white-space: nowrap;
    }

    th, td {
        min-width: 120px;
    }
}
    </style>
</head>

<body>
    <header>
     <img src="sm.png" alt="Stock Market Logo" class="logo">
        <h1>Buy Stocks</h1>
        <p>The Stock Market: Where Dreams Take Flight.</p>
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
        <table>
            <tr>
                <th>Stock ID</th>
                <th>Symbol</th>
                <th>Name</th>
                <th>Price (USD)</th>
                <th>Sector</th>
                <th>Available Quantity</th>
                <th>Action</th>
            </tr>
            <%
                Connection conn = null;
                Statement stmt = null;
                ResultSet rs = null;

                try {
                    // Database connection
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/userdb", "root", "Panda@2003");

                    // Query to fetch stocks
                    String query = "SELECT * FROM stocks";
                    stmt = conn.createStatement();
                    rs = stmt.executeQuery(query);

                    while (rs.next()) {
                        int stockId = rs.getInt("id");
                        String symbol = rs.getString("symbol");
                        String name = rs.getString("name");
                        float price = rs.getFloat("price");
                        String sector = rs.getString("sector");
                        int availableQuantity = rs.getInt("available_quantity");
            %>
            <tr>
                <td><%= stockId %></td>
                <td><%= symbol %></td>
                <td><%= name %></td>
                <td><%= price %></td>
                <td><%= sector %></td>
                <td><%= availableQuantity %></td>
                <td>
                    <form action="payment.jsp" method="post" onsubmit="return calculateTotal(this)">
                        <input type="hidden" name="stockId" value="<%= stockId %>">
                        <input type="hidden" name="stockPrice" value="<%= price %>">
						<input type="hidden" name="availableQuantity" value="<%= availableQuantity %>">
						
                        <input type="hidden" name="totalAmount" id="totalAmount<%= stockId %>">
                        <button type="submit">Buy</button>
                    </form>
                </td>
            </tr>
            <%
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    if (rs != null) rs.close();
                    if (stmt != null) stmt.close();
                    if (conn != null) conn.close();
                }
            %>
        </table>
    </div>
    <script>
        function calculateTotal(form) {
            const price = parseFloat(form.stockPrice.value);
            const quantity = parseInt(form.quantity.value, 10);
            const total = price * quantity;
            form.totalAmount.value = total.toFixed(2);
            return true;
        }
    </script>
</body>
</html>
