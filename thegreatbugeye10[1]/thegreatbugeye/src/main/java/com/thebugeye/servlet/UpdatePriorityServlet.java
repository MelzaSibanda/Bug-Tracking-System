package com.thebugeye.servlet;

import com.thebugeye.util.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet("/updatePriority")
public class UpdatePriorityServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String bugId = request.getParameter("bugId");
        String priority = request.getParameter("priority");

        if (bugId != null && priority != null) {
            try (Connection connection = DBConnection.getConnection()) {
                String sql = "UPDATE bug_reports SET priority = ? WHERE id = ?";
                PreparedStatement preparedStatement = connection.prepareStatement(sql);
                preparedStatement.setString(1, priority);
                preparedStatement.setInt(2, Integer.parseInt(bugId));

                int rowsUpdated = preparedStatement.executeUpdate();
                if (rowsUpdated > 0) {
                    response.sendRedirect("manage-users.jsp"); // Redirect back to the bug list page
                } else {
                    response.getWriter().println("Error: Bug not found or priority update failed.");
                }
            } catch (SQLException e) {
                e.printStackTrace();
                response.getWriter().println("SQL Exception: " + e.getMessage());
            } catch (NumberFormatException e) {
                response.getWriter().println("Error: Invalid Bug ID format.");
            }
        } else {
            response.getWriter().println("Invalid input: Bug ID or priority is missing.");
        }
    }
}