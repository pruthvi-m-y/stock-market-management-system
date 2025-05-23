<%@ page language="java" contentType="text/html; charset=ISO-8859-1"%>
<%@ page import="java.sql.*, java.io.*" %>
<%
    String stockId = request.getParameter("stock_id");
    int availableQuantity = 0;
    
    if (stockId != null && !stockId.isEmpty()) {
        String query = "SELECT available_quantity FROM stocks WHERE id = ?";
        
        try (Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/userdb", "root", "Panda@2003");
             PreparedStatement ps = con.prepareStatement(query)) {
            
            ps.setString(1, stockId);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                availableQuantity = rs.getInt("available_quantity");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    out.print(availableQuantity);
%>
