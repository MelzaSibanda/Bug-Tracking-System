package com.thebugeye.servlet;


import com.thebugeye.util.DBConnection; // Import your DB connection utility
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;


@WebServlet("/reportBug")
public class ReportBugServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get the form data
        String title = request.getParameter("title"); // Get the bug title
        String description = request.getParameter("description"); // Get the bug description
        String status = "New"; // Set default status for new bugs
        String priority = "Medium"; // Set default priority

        // Retrieve user email from session
        HttpSession session = request.getSession(false);
        String username = (session != null) ? (String) session.getAttribute("username") : null;

        if (username == null) {
            request.setAttribute("errorMessage", "You must be logged in to report a bug.");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
            return;
        }

        // Database connection and insertion
        try (Connection connection = DBConnection.getConnection()) {
            // Corrected SQL query with all five placeholders
            String sql = "INSERT INTO bug_reports (reported_by, title, description, status, priority) VALUES (?, ?, ?, ?, ?)";
            try (PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
                preparedStatement.setString(1, username); // Set the reported_by username
                preparedStatement.setString(2, title); // Set the title
                preparedStatement.setString(3, description); // Set the description
                preparedStatement.setString(4, status); // Set the status
                preparedStatement.setString(5, priority); // Set the priority
                preparedStatement.executeUpdate(); // Execute the update
            }

           
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Error saving bug report: " + e.getMessage());
            request.getRequestDispatcher("/bug_list.jsp").forward(request, response);
        }
    }

    
}
