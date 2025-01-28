<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
 pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*,java.util.*"%>
<%
String fname = request.getParameter("fname");
String lname = request.getParameter("lname");
String email = request.getParameter("email");
String userid = request.getParameter("userid");
String password = request.getParameter("password");
try {
 Class.forName("com.mysql.jdbc.Driver");
 Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/userdb", "root", "Panda@2003");
 Statement st = conn.createStatement();
 int i = st.executeUpdate("insert into users(fname,lname,email,userid,password)values('" + fname + "','" + lname
 + "','" + email + "','" + userid + "','" + password + "')");
 response.sendRedirect("index.html");

} catch (Exception e) {
 System.out.print(e);
 e.printStackTrace();
}
%>