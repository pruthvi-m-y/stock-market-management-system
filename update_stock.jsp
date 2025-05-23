<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Update Stock</title>
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
    <div class="container mt-5">
        <h2>Update Stock</h2>
        <%
            int id = Integer.parseInt(request.getParameter("id"));

            String url = "jdbc:mysql://localhost:3306/userdb";
            String dbUser = "root";
            String dbPassword = "Panda@2003";

            Connection con = null;
            PreparedStatement ps = null;
            ResultSet rs = null;

            String symbol = "";
            String name = "";
            double price = 0.0;
            float priceChange = 0.0f;
            String marketCap = "";
            String volume = "";
            String lastTraded = "";
            String sector = "";
            int availableQuantity = 0;

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                con = DriverManager.getConnection(url, dbUser, dbPassword);

                String query = "SELECT symbol, name, price, price_change, market_cap, volume, last_traded, sector, available_quantity FROM stocks WHERE id = ?";
                ps = con.prepareStatement(query);
                ps.setInt(1, id);
                rs = ps.executeQuery();

                if (rs.next()) {
                    symbol = rs.getString("symbol");
                    name = rs.getString("name");
                    price = rs.getDouble("price");
                    priceChange = rs.getFloat("price_change");
                    marketCap = rs.getString("market_cap");
                    volume = rs.getString("volume");
                    lastTraded = rs.getString("last_traded");
                    sector = rs.getString("sector");
                    availableQuantity = rs.getInt("available_quantity");
                }
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                if (rs != null) try { rs.close(); } catch (SQLException e) {}
                if (ps != null) try { ps.close(); } catch (SQLException e) {}
                if (con != null) try { con.close(); } catch (SQLException e) {}
            }
        %>
        <form action="update_stock_action.jsp" method="post">
            <input type="hidden" name="id" value="<%=id%>">
            
            <div class="form-group">
                <label for="symbol">Stock Symbol:</label>
                <input type="text" class="form-control" id="symbol" name="symbol" value="<%=symbol%>" required>
            </div>

            <div class="form-group">
                <label for="name">Name:</label>
                <input type="text" class="form-control" id="name" name="name" value="<%=name%>" required>
            </div>

            <div class="form-group">
                <label for="price">Price:</label>
                <input type="number" class="form-control" id="price" name="price" value="<%=price%>" required>
            </div>

            <div class="form-group">
                <label for="price_change">Price Change:</label>
                <input type="number" step="0.01" class="form-control" id="price_change" name="price_change" value="<%=priceChange%>" required>
            </div>

            <div class="form-group">
                <label for="market_cap">Market Cap:</label>
                <input type="text" class="form-control" id="market_cap" name="market_cap" value="<%=marketCap%>" required>
            </div>

            <div class="form-group">
                <label for="volume">Volume:</label>
                <input type="text" class="form-control" id="volume" name="volume" value="<%=volume%>" required>
            </div>

            <div class="form-group">
                <label for="last_traded">Last Traded:</label>
                <input type="time" class="form-control" id="last_traded" name="last_traded" value="<%=lastTraded%>" required>
            </div>

            <div class="form-group">
                <label for="sector">Sector:</label>
                <input type="text" class="form-control" id="sector" name="sector" value="<%=sector%>" required>
            </div>

            <div class="form-group">
                <label for="available_quantity">Available Quantity:</label>
                <input type="number" class="form-control" id="available_quantity" name="available_quantity" value="<%=availableQuantity%>" required>
            </div>

            <button type="submit" class="btn btn-primary mt-3">Update Stock</button>
        </form>
    </div>
</body>
</html>
