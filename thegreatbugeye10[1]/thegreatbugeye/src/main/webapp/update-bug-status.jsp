<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Update Bug Status - BugEye</title>
    <style>
        /* Add your CSS styles here */
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

        select, input[type="submit"] {
            padding: 10px;
            margin-bottom: 20px;
            border-radius: 5px;
            border: 1px solid #ddd;
        }

        input[type="submit"] {
            background-color: #17a2b8;
            color: white;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        input[type="submit"]:hover {
            background-color: #138496;
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
        <h2>Update Bug Status</h2>

        <c:if test="${not empty errorMessage}">
            <div class="message error">${errorMessage}</div>
        </c:if>

        <c:if test="${not empty successMessage}">
            <div class="message success">${successMessage}</div>
        </c:if>

        <form action="update-bug-status" method="post">
            <label for="bugId">Select Bug:</label>
            <select name="bugId" id="bugId" required>
                <option value="" disabled selected>-- Select a Bug --</option>
                <c:forEach var="bug" items="${assignedBugs}">
                    <option value="${bug.id}">${bug.title} (Status: ${bug.status})</option>
                </c:forEach>
            </select>

            <label for="status">New Status:</label>
            <select name="status" id="status" required>
                <option value="" disabled selected>-- Select New Status --</option>
                <option value="IN_PROGRESS">In Progress</option>
                <option value="RESOLVED">Resolved</option>
                <option value="CLOSED">Closed</option>
            </select>

            <input type="submit" value="Update Status">
        </form>
    </div>
</body>
</html>
