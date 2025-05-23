<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login Result</title>
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
            text-align: center;
        }
        h2 {
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <div class="container">
        <%
            String adminid = request.getParameter("adminid");
            String password = request.getParameter("password");

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

                // Query to get admin data
                String query = "SELECT password FROM admins WHERE adminid = ?";
                ps = con.prepareStatement(query);
                ps.setString(1, adminid);
                rs = ps.executeQuery();

                if (rs.next()) {
                    String storedPassword = rs.getString("password");

                    if (password.equals(storedPassword)) {
                        out.println("<h2>Login Successful!</h2>");
                        out.println("<p>Welcome, " + adminid + ".</p>");
                        out.println("<a href='admin_dashboard.jsp' class='btn btn-primary'>Go to Dashboard</a>");
                    } else {
                        out.println("<h2>Login Failed!</h2>");
                        out.println("<p>Invalid admin ID or password. Please try again.</p>");
                        out.println("<a href='admin_login.jsp' class='btn btn-danger'>Try Again</a>");
                    }
                } else {
                    out.println("<h2>Login Failed!</h2>");
                    out.println("<p>Invalid admin ID or password. Please try again.</p>");
                    out.println("<a href='admin_login.jsp' class='btn btn-danger'>Try Again</a>");
                }
            } catch (Exception e) {
                e.printStackTrace();
                out.println("<h2>Error</h2>");
                out.println("<p>" + e.getMessage() + "</p>");
                out.println("<a href='admin_login.jsp' class='btn btn-danger'>Go Back</a>");
            } finally {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (con != null) con.close();
            }
        %>
    </div>
</body>
</html>
