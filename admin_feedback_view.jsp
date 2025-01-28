<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin - Feedback View</title>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Roboto', sans-serif;
            background-color: #f4f4f9;
            margin: 0;
            padding: 20px;
            color: #333;
        }

        h1 {
            text-align: center;
            font-size: 2.5rem;
            color: #2980b9;
        }

        .container {
            max-width: 1000px;
            margin: 20px auto;
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
        }

        table, th, td {
            border: 1px solid #ddd;
        }

        th, td {
            padding: 12px;
            text-align: left;
        }

        th {
            background-color: #2980b9;
            color: white;
        }

        tr:nth-child(even) {
            background-color: #f2f2f2;
        }

        .no-data {
            text-align: center;
            color: #888;
            font-size: 1.2rem;
        }
    </style>
</head>
<body>

    <h1>User Feedback</h1>
    <div class="container">
        <%
            // Database connection details
            String dbUrl = "jdbc:mysql://localhost:3306/userdb"; // Update database name
            String dbUser = "root"; // Your DB username
            String dbPassword = "Panda@2003"; // Your DB password

            Connection connection = null;
            Statement statement = null;
            ResultSet resultSet = null;

            try {
                // Load the MySQL JDBC driver
                Class.forName("com.mysql.cj.jdbc.Driver");

                // Establish a database connection
                connection = DriverManager.getConnection(dbUrl, dbUser, dbPassword);

                // Execute a query to retrieve feedback
                String query = "SELECT * FROM contact ORDER BY created_at DESC";
                statement = connection.createStatement();
                resultSet = statement.executeQuery(query);

                // Display the feedback in a table
                if (!resultSet.isBeforeFirst()) {
                    %>
                    <p class="no-data">No feedback available to display.</p>
                    <%
                } else {
                    %>
                    <table>
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Name</th>
                                <th>Email</th>
                                <th>Message</th>
                                <th>Date</th>
                            </tr>
                        </thead>
                        <tbody>
                        <%
                        while (resultSet.next()) {
                            int id = resultSet.getInt("id");
                            String name = resultSet.getString("name");
                            String email = resultSet.getString("email");
                            String message = resultSet.getString("message");
                            Timestamp createdAt = resultSet.getTimestamp("created_at");
                            %>
                            <tr>
                                <td><%= id %></td>
                                <td><%= name %></td>
                                <td><%= email %></td>
                                <td><%= message %></td>
                                <td><%= createdAt %></td>
                            </tr>
                            <%
                        }
                        %>
                        </tbody>
                    </table>
                    <%
                }
            } catch (Exception e) {
                out.println("<p>Error retrieving feedback: " + e.getMessage() + "</p>");
                e.printStackTrace();
            } finally {
                // Close resources
                if (resultSet != null) resultSet.close();
                if (statement != null) statement.close();
                if (connection != null) connection.close();
            }
        %>
    </div>

</body>
</html>
