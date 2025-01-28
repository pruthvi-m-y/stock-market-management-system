<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Login</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            font-family: 'Roboto', sans-serif;
            background: linear-gradient(135deg, #1e90ff, #87cefa);
            color: #333;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .container {
            width: 100%;
            max-width: 400px;
            background: #fff;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
        }
        h2 {
            text-align: center;
            margin-bottom: 20px;
            color: #1e90ff;
            font-weight: bold;
        }
        .form-group {
            margin-bottom: 20px;
        }
        label {
            font-weight: bold;
        }
        .btn-primary {
            width: 100%;
            background-color: #1e90ff;
            border: none;
            padding: 10px;
        }
        .btn-primary:hover {
            background-color: #1565c0;
        }
        .new-user {
            text-align: center;
            margin-top: 20px;
        }
        .new-user p {
            font-size: 14px;
            color: #666;
        }
        .new-user a {
            color: #1e90ff;
            text-decoration: none;
            font-weight: bold;
        }
        .new-user a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Admin Login</h2>
        <form action="admin_login_action.jsp" method="post">
            <div class="form-group">
                <label for="adminid">Admin ID</label>
                <input type="text" class="form-control" id="adminid" name="adminid" placeholder="Enter Admin ID" required>
            </div>
            <div class="form-group">
                <label for="password">Password</label>
                <input type="password" class="form-control" id="password" name="password" placeholder="Enter Password" required>
            </div>
            <button type="submit" class="btn btn-primary">Login</button>
        </form>
        <div class="new-user">
            <p>New Admin? <a href="admin_register.jsp">Create an account</a></p>
        </div>
    </div>
</body>
</html>
