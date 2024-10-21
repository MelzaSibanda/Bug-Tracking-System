<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.thebugeye.entity.Bug"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Submit Bug Report - BugEye</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 20px;
        }

        .container {
            width: 60%;
            margin: 0 auto;
            background-color: #fff;
            padding: 25px;
            border-radius: 8px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
        }

        h2 {
            text-align: center;
            color: #17a2b8;
        }

        form {
            display: flex;
            flex-direction: column;
            margin-top: 20px;
        }

        label {
            margin-bottom: 8px;
            font-weight: bold;
        }

        input[type="text"], textarea, input[type="submit"] {
            padding: 10px;
            margin-bottom: 20px;
            border-radius: 5px;
            border: 1px solid #ddd;
        }

        textarea {
            resize: vertical;
            min-height: 100px;
        }

        input[type="submit"] {
            background-color: #17a2b8;
            color: white;
            cursor: pointer;
        }

        .message {
            text-align: center;
            margin-top: 10px;
            font-weight: bold;
        }

        .error {
            color: red;
        }

        .success {
            color: green;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Bug Report Submission</h2>

        <!-- Display error or success message -->
        <c:if test="${not empty errorMessage}">
            <div class="message error">${errorMessage}</div>
        </c:if>

        <c:if test="${not empty successMessage}">
            <div class="message success">${successMessage}</div>
        </c:if>

        <!-- Step 1: Enter the bug ID -->
        <form action="bug-reports" method="post">
            <label for="bugId">Enter Bug ID:</label>
            <input type="text" name="bugId" id="bugId" required value="${bug.id != null ? bug.id : ''}" />

            <c:if test="${bug == null}">
                <input type="submit" value="Check Bug">
            </c:if>
        </form>

        <!-- Step 2: If bug exists, show the form to submit a report -->
        <c:if test="${bug != null}">
            <h3>Bug: ${bug.title} (Status: ${bug.status})</h3>
            <form action="bug-report" method="post">
                <input type="hidden" name="bugId" value="${bug.id}" />
                <label for="report">Submit Report:</label>
                <textarea name="report" id="report" placeholder="Provide a brief update or comment on the bug..."></textarea>
                <input type="submit" value="Submit Report">
            </form>
        </c:if>
    </div>
</body>
</html>
