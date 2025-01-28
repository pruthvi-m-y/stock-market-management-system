<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>

<%
    String stockid = request.getParameter("stockid");
    String url = "jdbc:mysql://localhost:3306/userdb";
    String dbUser = "root";
    String dbPassword = "Panda@2003";
    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection(url, dbUser, dbPassword);

        String query = "SELECT price FROM stocks WHERE id = ?";
        ps = con.prepareStatement(query);
        ps.setString(1, stockid);
        rs = ps.executeQuery();

        if (rs.next()) {
            out.print(rs.getDouble("price"));
        } else {
            out.print("0");
        }
    } catch (Exception e) {
        e.printStackTrace();
        out.print("0");
    } finally {
        if (rs != null) rs.close();
        if (ps != null) ps.close();
        if (con != null) con.close();
    }
%>
