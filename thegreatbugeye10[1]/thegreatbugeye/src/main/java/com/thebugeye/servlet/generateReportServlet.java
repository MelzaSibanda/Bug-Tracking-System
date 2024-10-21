package com.thebugeye.servlet;

import com.thebugeye.entity.Bug;
import com.thebugeye.util.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

@WebServlet("/generate-reports")
public class generateReportServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/bug-reports.jsp").forward(request, response); // Show bug ID input form
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String bugId = request.getParameter("bugId");  // Get the entered bug ID
        String report = request.getParameter("report"); // Get the developer's report if it exists
        HttpSession session = request.getSession();
        String developerUsername = (String) session.getAttribute("username");

        if (bugId == null || bugId.isEmpty()) {
            request.setAttribute("errorMessage", "Please enter a bug ID.");
            request.getRequestDispatcher("/bug-reports.jsp").forward(request, response);
            return;
        }

        try (Connection connection = DBConnection.getConnection()) {
            if (report == null) {
                // Step 1: Check if the bug exists
                String sql = "SELECT id, title, status FROM bug_reports WHERE id = ? AND assigned_to = ?";
                try (PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
                    preparedStatement.setInt(1, Integer.parseInt(bugId));
                    preparedStatement.setString(2, developerUsername);
                    try (ResultSet resultSet = preparedStatement.executeQuery()) {
                        if (resultSet.next()) {
                            Bug bug = new Bug();
                            bug.setId(resultSet.getInt("id"));
                            bug.setTitle(resultSet.getString("title"));
                            bug.setStatus(resultSet.getString("status"));

                            request.setAttribute("bug", bug);
                            request.getRequestDispatcher("/bug-reports.jsp").forward(request, response); // Show form to submit a report
                        } else {
                            request.setAttribute("errorMessage", "Bug not found or not assigned to you.");
                            request.getRequestDispatcher("/bug-reports.jsp").forward(request, response);
                        }
                    }
                }
            } else {
                // Step 2: If the report is submitted, update the bug's status
                String sql = "UPDATE bug_reports SET developer_report = ?, status = 'In Progress' WHERE id = ? AND assigned_to = ?";
                try (PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
                    preparedStatement.setString(1, report);
                    preparedStatement.setInt(2, Integer.parseInt(bugId));
                    preparedStatement.setString(3, developerUsername);

                    int rowsUpdated = preparedStatement.executeUpdate();
                    if (rowsUpdated > 0) {
                        request.setAttribute("successMessage", "Bug report submitted successfully.");
                    } else {
                        request.setAttribute("errorMessage", "Error submitting bug report.");
                    }
                    request.getRequestDispatcher("/bug-reports.jsp").forward(request, response);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Database error: " + e.getMessage());
            request.getRequestDispatcher("/bug-reports.jsp").forward(request, response);
        }
    }
}
