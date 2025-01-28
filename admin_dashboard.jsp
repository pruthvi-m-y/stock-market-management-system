<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        /* Body Styling */
        body {
            font-family: 'Roboto', sans-serif;
            background-color: #e3f2fd;  /* Light blue background */
            color: #333;  /* Dark text for readability */
            margin: 0;
            padding: 0;
        }

        /* Container Styling */
        .container {
            max-width: 900px;
            margin: 50px auto;
            background: #ffffff;  /* White background for content */
            padding: 40px;
            border-radius: 8px;
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.1);
            position: relative;
        }

        /* Logout Button Styling */
        .btn-danger {
            position: absolute;
            top: 20px;
            right: 20px;
            background-color: #dc3545;  /* Red button color */
            border: none;
            padding: 10px 20px;
            color: #ffffff;
            font-size: 14px;
            font-weight: bold;
            border-radius: 8px;
            transition: background 0.3s ease, transform 0.2s ease;
        }

        .btn-danger:hover, .btn-danger:focus {
            background-color: #c82333;
            transform: scale(1.05);
        }

        /* Heading Styling */
        h2 {
            text-align: center;
            margin-bottom: 30px;
            color: #1e2a37;  /* Darker color for the heading */
            font-size: 28px;
            font-weight: 600;
        }

        /* Card Styling */
        .card {
            background-color: #ffffff;  /* White background for each card */
            border: 1px solid #e1e8f0;  /* Light border */
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 6px 18px rgba(0, 0, 0, 0.15);
        }

        .card a {
            text-decoration: none;
            color: #333;  /* Dark color for links */
            font-weight: 500;
            display: block;
            padding: 20px;
            border-radius: 8px;
            transition: background 0.3s ease, color 0.3s ease;
            font-size: 18px;
            text-align: center;
        }

        .card a:hover, .card a:focus {
            background-color: #f0f1f6;  /* Light gray hover effect */
            color: #007bff; /* Link color on hover/focus */
        }

        /* Grid Layout */
        .row {
            display: grid;
            grid-template-columns: repeat(2, 1fr); /* 2 columns */
            gap: 20px;
        }

        /* Responsive Design for Small Screens */
        @media (max-width: 768px) {
            h2 {
                font-size: 24px;
            }

            .card a {
                font-size: 16px;
                padding: 15px;
            }

            .btn-danger {
                font-size: 14px;
                padding: 10px;
            }

            .row {
                grid-template-columns: 1fr; /* Stack cards on smaller screens */
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <button class="btn btn-danger" onclick="window.location.href='front.html'">Logout</button>
        <h2>Admin Dashboard</h2>
        <div class="row">
            <div class="card">
                <a href="manage_users.jsp"><b>Manage Users</b></a>
            </div>
            <div class="card">
                <a href="manage_stocks.jsp"><b>Manage Stocks</b></a>
            </div>
            <div class="card">
                <a href="admin_investment_details.jsp"><b>Investment Details</b></a>
            </div>
            <div class="card">
                <a href="admin_feedback_view.jsp"><b>View Contact Support</b></a>
            </div>
        </div>
    </div>
</body>
</html>
