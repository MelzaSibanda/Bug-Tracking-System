


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - BugEye</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
            color: #333;
        }

        .admin-container {
            width: 90%;
            max-width: 1200px;
            margin: 50px auto;
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        }

        .admin-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 20px;
            background-color: #007bff;
            color: white;
            border-radius: 8px 8px 0 0;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }

        .admin-header h1 {
            margin: 0;
            font-size: 24px;
            font-weight: bold;
        }

        .email-history-btn {
            background-color: #007bff;
            border: none;
            color: white;
            padding: 10px 20px;
            font-size: 16px;
            border-radius: 5px;
            cursor: pointer;
            display: flex;
            align-items: center;
            transition: background-color 0.3s ease;
        }

        .email-history-btn:hover {
            background-color: #0056b3;
        }

        .email-history-btn i {
            margin-right: 10px;
            font-size: 20px;
        }

        .admin-content {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-between;
            margin-top: 30px;
        }

        .admin-card {
            flex: 1;
            margin: 10px;
            padding: 20px;
            background-color: #f8f9fa;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
            text-align: center;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .admin-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
        }

        .admin-card h3 {
            margin-bottom: 10px;
            font-size: 18px;
            font-weight: bold;
            color: #333;
        }

        .admin-card p {
            font-size: 14px;
            margin-bottom: 20px;
            color: #666;
        }

        .admin-card a {
            display: inline-block;
            padding: 10px 20px;
            background-color: #28a745;
            color: white;
            text-decoration: none;
            font-size: 14px;
            border-radius: 5px;
            transition: background-color 0.3s ease;
        }

        .admin-card a:hover {
            background-color: #218838;
        }

        
        .email-form {
            width: 100%;
            margin-top: 30px;
            padding: 20px;
            background-color: #f8f9fa;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
        }

        .email-form h2 {
            text-align: center;
            margin-bottom: 20px;
            font-size: 22px;
            color: #007bff;
        }

        .email-form form {
            display: flex;
            flex-direction: column;
            gap: 15px;
        }

        .email-form input, .email-form textarea {
            width: 100%;
            padding: 10px;
            font-size: 14px;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-sizing: border-box;
        }

        .email-form button {
            padding: 10px 20px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            transition: background-color 0.3s ease;
        }

        .email-form button:hover {
            background-color: #0056b3;
        }

        footer {
            text-align: center;
            padding: 20px;
            margin-top: 40px;
            background-color: #007bff;
            color: white;
            font-size: 14px;
        }

        @media (max-width: 768px) {
            .admin-content {
                flex-direction: column;
                align-items: center;
            }

            .admin-card {
                width: 100%;
                margin-bottom: 20px;
            }
        }
    </style>
</head>
<body>
    <div class="admin-container">
        <div class="admin-header">
            <h1>Admin Dashboard</h1>
            <button class="email-history-btn" onclick="window.location.href='emailHistory.jsp'">
                <i class="fa fa-envelope"></i> Emails
            </button>
        </div>

        <div class="admin-content">
            
            <div class="admin-card">
                <h3>VIEW & ASSIGN BUGS</h3>
                <p>View and manage all reported bugs from users, assign the bugs to developers.</p>
                <a href="manage-users.jsp">Manage Bugs</a>
            </div>
        </div>

        <div class="email-form">
            <h2>Notify Developers</h2>
            <form action="sendEmail.jsp" method="post">
                <input type="text" name="recipient" placeholder="Recipient Email" required />
                <input type="text" name="subject" placeholder="Email Subject" required />
                <textarea name="body" rows="4" placeholder="Email Body" required></textarea>
                <button type="submit">Send Email</button>
            </form>
        </div>
    </div>

    <footer>
        &copy; 2024 BugEye. All rights reserved.
    </footer>
    
    <script src="https://kit.fontawesome.com/a076d05399.js"></script>
</body>
</html>