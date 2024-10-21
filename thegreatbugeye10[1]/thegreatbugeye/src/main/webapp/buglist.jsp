<%@ page import="java.util.List" %>
<%@ page import="com.thebugeye.entity.Bug" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Bug List - BugEye</title>
    <style>
        /* Add some basic styling for the page */
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
        }
        .container {
            width: 80%;
            margin: 0 auto;
            padding: 20px;
            background-color: white;
            border-radius: 5px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        table {
            width: 100%;
            border-collapse: collapse;
        }
        th, td {
            border: 1px solid #ccc;
            padding: 10px;
            text-align: left;
        }
        th {
            background-color: #007bff;
            color: white;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Reported Bugs</h2>
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Title</th>
                    <th>Description</th>
                    <th>Status</th>
                    <th>Priority</th>
                    <th>Assigned by</th>
                </tr>
            </thead>
            <tbody>
                <%
                // Retrieve the list of bugs from the request
                List<Bug> bugs = (List<Bug>) request.getAttribute("bug_reports");

                if (bugs == null || bugs.isEmpty()) {
                    %>
                    <tr>
                        <td colspan="5">No bugs reported.</td>
                    </tr>
                    <%
                } else {
                    for (Bug bug : bugs) {
                    %>
                    <tr>
                        <td><%= bug.getId() %></td>
                        <td><%= bug.getTitle() %></td>
                        <td><%= bug.getDescription() %></td>
                        <td><%= bug.getStatus() %></td>
                        <td><%= bug.getPriority() %></td>
                        <td><%= bug.getReportedBy() %></td>
                    </tr>
                    <%
                    }
                }
                %>
            </tbody>
        </table>
    </div>
</body>
</html>
