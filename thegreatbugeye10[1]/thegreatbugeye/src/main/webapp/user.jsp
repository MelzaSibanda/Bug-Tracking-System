<%@ page import="java.util.List" %>
<%@ page import="com.thebugeye.entity.Bug" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Dashboard - BugEye</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
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
        }

        .header {
            background-color: #007bff;
            color: white;
            padding: 15px;
            text-align: center;
            border-radius: 8px 8px 0 0;
        }

        .content {
            background-color: white;
            padding: 20px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            border-radius: 0 0 8px 8px;
        }

        .form-group {
            margin-bottom: 15px;
        }

        input, textarea {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        input[type="submit"] {
            background-color: #007bff;
            color: white;
            border: none;
            cursor: pointer;
        }

        input[type="submit"]:hover {
            background-color: #0056b3;
        }

        .view-bugs-button {
            margin-top: 20px;
            text-align: center;
        }

        .view-bugs-button button {
            padding: 10px 20px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        .view-bugs-button button:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>User Dashboard</h1>
            <p>Welcome! Here you can report bugs and track their status.</p>
        </div>

        <div class="content">
            <h2>Report a Bug</h2>
            <form id="bugReportForm">
                <div class="form-group">
                    <label for="title">Bug Title:</label>
                    <input type="text" id="title" name="title" required>
                </div>
                <div class="form-group">
                    <label for="description">Bug Description:</label>
                    <textarea id="description" name="description" rows="5" required></textarea>
                </div>
                <input type="submit" value="Submit Bug">
            </form>

            <!-- Add the View Bugs button here -->
            <div class="view-bugs-button">
                <button onclick="location.href='buglist'">View Bugs</button>
            </div>
        </div>
    </div>

    <script>
        $(document).ready(function() {
            $('#bugReportForm').submit(function(event) {
                event.preventDefault(); // Prevent default form submission

                // Gather form data
                var formData = $(this).serialize();

                $.ajax({
                    type: "POST",
                    url: "reportBug",
                    data: formData,
                    success: function(response) {
                        alert("Bug reported successfully!");
                        // You can add any additional actions or messages after bug submission
                    },
                    error: function(xhr, status, error) {
                        alert("Error reporting bug: " + error);
                    }
                });
            });
        });
    </script>
</body>
</html>
