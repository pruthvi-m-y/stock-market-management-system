<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Registration Result</title>
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
            String fname = request.getParameter("fname");
            String lname = request.getParameter("lname");
            String email = request.getParameter("email");
            String adminid = request.getParameter("adminid");
            String password = request.getParameter("password");

            // Database connection details
            String url = "jdbc:mysql://localhost:3306/userdb";
            String dbUser = "root";
            String dbPassword = "Panda@2003";

            Connection con = null;
            PreparedStatement ps = null;

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                con = DriverManager.getConnection(url, dbUser, dbPassword);

                // Query to insert admin data
                String query = "INSERT INTO admins (fname, lname, email, adminid, password) VALUES (?, ?, ?, ?, ?)";
                ps = con.prepareStatement(query);
                ps.setString(1, fname);
                ps.setString(2, lname);
                ps.setString(3, email);
                ps.setString(4, adminid);
                ps.setString(5, password);

                int result = ps.executeUpdate();

                if (result > 0) {
                    out.println("<h2>Registration Successful!</h2>");
                    out.println("<p>Admin " + fname + " " + lname + " has been registered successfully.</p>");
                    out.println("<a href='admin_login.jsp' class='btn btn-primary'>Go to Login</a>");
                } else {
                    out.println("<h2>Registration Failed!</h2>");
                    out.println("<p>There was an error processing your registration. Please try again.</p>");
                    out.println("<a href='admin_register.jsp' class='btn btn-danger'>Try Again</a>");
                }
            } catch (Exception e) {
                e.printStackTrace();
                out.println("<h2>Error</h2>");
                out.println("<p>" + e.getMessage() + "</p>");
                out.println("<a href='admin_register.jsp' class='btn btn-danger'>Go Back</a>");
            } finally {
                if (ps != null) ps.close();
                if (con != null) con.close();
            }
        %>
    </div>
</body>
</html>
