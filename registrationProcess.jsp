<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
 pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*,java.util.*"%>
<%
String fname = request.getParameter("fname");
String lname = request.getParameter("lname");
String email = request.getParameter("email");
String userid = request.getParameter("userid");
String password = request.getParameter("password");
String phn_num = request.getParameter("phn_num");
try {
 Class.forName("com.mysql.jdbc.Driver");
 Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/userdb", "root", "Panda@2003");
 Statement st = conn.createStatement();
 int i = st.executeUpdate("INSERT INTO users(fname, lname, email, userid, password, phn_num) VALUES ('" + fname + "','" + lname + "','" + email + "','" + userid + "','" + password + "','" + phn_num + "')");
 response.sendRedirect("user_login.html");

} catch (Exception e) {
 System.out.print(e);
 e.printStackTrace();
}
%>