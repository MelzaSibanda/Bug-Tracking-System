<%@page import="com.thebugeye.entity.Bug"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.thebugeye.entity.Email"%>
<%@page import="com.thebugeye.util.EmailUtil"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="javax.naming.NamingException"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Developer Dashboard - BugEye</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }

        .dev-container {
            width: 90%;
            margin: 50px auto;
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }

        .dev-header {
            text-align: center;
            padding: 20px;
            background-color: #17a2b8;
            color: white;
            border-radius: 8px 8px 0 0;
        }

        h1 {
            margin: 0;
        }

        .dev-content {
            display: flex;
            justify-content: space-between;
            margin-top: 20px;
        }

        .dev-card {
            flex: 1;
            margin: 10px;
            padding: 20px;
            background-color: #f8f9fa;
            border-radius: 8px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            text-align: center;
        }

        .dev-card h3 {
            margin-bottom: 15px;
        }

        .dev-card a {
            display: inline-block;
            padding: 10px 20px;
            background-color: #007bff;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            transition: background-color 0.3s ease;
        }

        .dev-card a:hover {
            background-color: #0056b3;
        }

        footer {
            text-align: center;
            padding: 10px;
            margin-top: 40px;
            background-color: #17a2b8;
            color: white;
        }

        .email-form {
            margin-top: 30px;
            padding: 20px;
            background-color: #f8f9fa;
            border-radius: 8px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }

        .email-form input, .email-form textarea {
            width: 100%;
            margin-bottom: 10px;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        .email-form button {
            padding: 10px 20px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        .email-form button:hover {
            background-color: #0056b3;
        }

        /* Style for the "Your Assigned Bugs" table */
        .bug-table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
            font-size: 16px;
            min-width: 400px;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }

        .bug-table th, .bug-table td {
            padding: 12px 15px;
            text-align: left;
        }

        .bug-table thead th {
            background-color: #007bff;
            color: white;
        }

        .bug-table tbody tr:nth-child(even) {
            background-color: #f3f3f3;
        }

        .bug-table tbody tr:nth-child(odd) {
            background-color: #ffffff;
        }

        .bug-table tbody tr:hover {
            background-color: #e2e6ea;
            cursor: pointer;
        }

        .bug-table th, .bug-table td {
            border-bottom: 1px solid #dddddd;
        }
    </style>
</head>
<body>
    <div class="dev-container">
        <div class="dev-header">
            <h1>Developer Dashboard</h1>
        </div>

        <div class="dev-card">
            <h2>Your Assigned Bugs</h2>
            <table class="bug-table">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Title</th>
                        <th>Description</th>
                        <th>Status</th>
                        <th>Priority</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                    List<Bug> assignedBugs = (List<Bug>) request.getAttribute("assignedBugs");
                    if (assignedBugs != null && !assignedBugs.isEmpty()) {
                        for (Bug bug : assignedBugs) {
                    %>
                    <tr>
                        <td><%= bug.getId() %></td>
                        <td><%= bug.getTitle() %></td>
                        <td><%= bug.getDescription() %></td>
                        <td><%= bug.getStatus() %></td>
                        <td><%= bug.getPriority() %></td>
                    </tr>
                    <%
                        }
                    } else { 
                    %>
                    <tr>
                        <td colspan="5">No bugs assigned to you.</td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>

        
        
        <div class="dev-card">
            <h3>Reports</h3>
            <p>Generate system-wide reports on bugs, team performance, and bug resolution.</p>
            <a href="generate-reports.jsp">Generate Reports</a>
        </div>

        <div class="email-form">
            <h2>Notify Admin</h2>
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
</body>
</html>
