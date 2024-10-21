<%@page import="com.thebugeye.util.DBConnection"%>
<%@page import="com.thebugeye.entity.Bug"%>
<%@page import="com.thebugeye.entity.Developer"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Bug List - BugEye</title>
    <style>
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
        .btn {
            padding: 5px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            color: white;
        }
        .btn-blue {
            background-color: blue;
        }
        .filter {
            margin-bottom: 20px;
        }
        .dropdown-status {
            width: 100%;
            padding: 5px;
            font-size: 14px;
            cursor: pointer;
            color: white;
            border: none;
        }
        .btn-red {
            background-color: #fa1414;
        }
        .btn-orange {
            background-color: #fafa14;
        }
        .btn-green {
            background-color: #6EC207;
        }
    </style>
    <script>
        function updateDropdownColor(selectElement) {
            const selectedValue = selectElement.value;
            if (selectedValue === 'Unexecuted') {
                selectElement.className = 'dropdown-status btn-red';
            } else if (selectedValue === 'In-progress') {
                selectElement.className = 'dropdown-status btn-orange';
            } else if (selectedValue === 'Complete') {
                selectElement.className = 'dropdown-status btn-green';
            } else {
                selectElement.className = 'dropdown-status'; // Default class
            }
        }

        document.addEventListener('DOMContentLoaded', () => {
            const statusSelects = document.querySelectorAll('.dropdown-status');
            statusSelects.forEach(select => updateDropdownColor(select)); // Initialize colors on page load
        });
    </script>
</head>
<body>
    <div class="container">
        <h2>Reported Bugs</h2>

        <!-- Filter by Priority Dropdown -->
        <div class="filter">
            <form method="get" action="">
                <label for="priorityFilter">Filter by Priority:</label>
                <select id="priorityFilter" name="priorityFilter" onchange="this.form.submit()">
                    <option value="all" <%= "all".equals(request.getParameter("priorityFilter")) ? "selected" : "" %>>All Bugs</option>
                    <option value="high" <%= "high".equals(request.getParameter("priorityFilter")) ? "selected" : "" %>>High</option>
                    <option value="medium" <%= "medium".equals(request.getParameter("priorityFilter")) ? "selected" : "" %>>Medium</option>
                    <option value="low" <%= "low".equals(request.getParameter("priorityFilter")) ? "selected" : "" %>>Low</option>
                </select>
            </form>
        </div>

        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Reported By</th>
                    <th>Title</th>
                    <th>Description</th>
                    <th>Status</th>
                    <th>Priority</th>
                    <th>Assign Developer</th>
                </tr>
            </thead>
            <tbody>
                <%
                List<Bug> bugs = new ArrayList<>();
                List<Developer> developers = new ArrayList<>(); 

                String selectedPriority = request.getParameter("priorityFilter");
                if (selectedPriority == null) {
                    selectedPriority = "all"; 
                }

                try (Connection connection = DBConnection.getConnection()) {
                    
                    String sql = "SELECT id, reported_by, title, description, status, priority FROM bug_reports";

                    if (!"all".equals(selectedPriority)) {
                        sql += " WHERE priority = ?";
                    }

                    PreparedStatement preparedStatement = connection.prepareStatement(sql);
                    if (!"all".equals(selectedPriority)) {
                        preparedStatement.setString(1, selectedPriority);
                    }

                    ResultSet resultSet = preparedStatement.executeQuery();

                    while (resultSet.next()) {
                        Bug bug = new Bug();
                        bug.setId(resultSet.getInt("id"));
                        bug.setReportedBy(resultSet.getString("reported_by"));
                        bug.setTitle(resultSet.getString("title"));
                        bug.setDescription(resultSet.getString("description"));
                        bug.setStatus(resultSet.getString("status"));
                        bug.setPriority(resultSet.getString("priority"));
                        bugs.add(bug);
                    }

                  
                    String developerSql = "SELECT id, username FROM developers";
                    PreparedStatement developerStatement = connection.prepareStatement(developerSql);
                    ResultSet developerResultSet = developerStatement.executeQuery();

                    while (developerResultSet.next()) {
                        Developer developer = new Developer();
                        developer.setDeveloperId(developerResultSet.getString("id"));
                        developer.setName(developerResultSet.getString("username"));
                        developers.add(developer);
                    }
                } catch (SQLException e) {
                    out.println("<tr><td colspan='7'>Error retrieving data: " + e.getMessage() + "</td></tr>");
                }

                for (Bug bug : bugs) {
                    // Set the appropriate dropdown color for each status
                    String dropdownClass = "";
                    if ("Unexecuted".equals(bug.getStatus())) {
                        dropdownClass = "btn-red";
                    } else if ("In-progress".equals(bug.getStatus())) {
                        dropdownClass = "btn-orange";
                    } else if ("Complete".equals(bug.getStatus())) {
                        dropdownClass = "btn-green";
                    }
                %>
                <tr>
                    <td><%= bug.getId() %></td>
                    <td><%= bug.getReportedBy() %></td>
                    <td><%= bug.getTitle() %></td>
                    <td><%= bug.getDescription() %></td>

                    <!-- Status dropdown with color coding -->
                    <td>
                        <form action="updateStatus" method="post">
                            <input type="hidden" name="bugId" value="<%= bug.getId() %>">
                            <select name="status" class="dropdown-status <%= dropdownClass %>" onchange="updateDropdownColor(this)">
                                <option value="Unexecuted" <%= "Unexecuted".equals(bug.getStatus()) ? "selected" : "" %>>Unexecuted</option>
                                <option value="In-progress" <%= "In-progress".equals(bug.getStatus()) ? "selected" : "" %>>In-progress</option>
                                <option value="Complete" <%= "Complete".equals(bug.getStatus()) ? "selected" : "" %>>Complete</option>
                            </select>
                            <button class="btn btn-blue" type="submit">Update Status</button>
                        </form>
                    </td>

                    <!-- Priority dropdown -->
                    <td>
                        <form action="updatePriority" method="post">
                            <input type="hidden" name="bugId" value="<%= bug.getId() %>">
                            <select name="priority" class="priority-dropdown">
                                <option value="low" <%= "low".equals(bug.getPriority()) ? "selected" : "" %>>Low</option>
                                <option value="medium" <%= "medium".equals(bug.getPriority()) ? "selected" : "" %>>Medium</option>
                                <option value="high" <%= "high".equals(bug.getPriority()) ? "selected" : "" %>>High</option>
                            </select>
                            <button class="btn btn-blue" type="submit">Update Priority</button>
                        </form>
                    </td>

                    <!-- Developer assignment dropdown -->
                    <td>
                        <form action="assignDeveloper" method="post">
                            <input type="hidden" name="bugId" value="<%= bug.getId() %>">
                            <select name="developer" class="developer-dropdown">
                                <option value="">Select Developer</option> <!-- Default option -->
                                <%
                                for (Developer developer : developers) {
                                %>
                                <option value="<%=  developer.getName() %>"><%= developer.getName() %></option>
                                <%
                                }
                                %>
                            </select>
                            <button class="btn btn-blue" type="submit">Assign</button>
                        </form>
                    </td>
                </tr>
                <%
                }
                %>
            </tbody>
        </table>
    </div>
</body>
</html>