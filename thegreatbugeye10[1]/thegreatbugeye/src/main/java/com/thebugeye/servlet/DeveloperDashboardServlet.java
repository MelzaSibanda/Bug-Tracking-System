/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.thebugeye.servlet;

/**
 *
 * @author KHOMOTSO
 */


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
import java.util.ArrayList;
import java.util.List;

@WebServlet("/developerDashboard")
public class DeveloperDashboardServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get the logged-in developer's username from the session
        HttpSession session = request.getSession();
        String developerUsername = (String) session.getAttribute("username"); // Assuming username is stored in the session

        if (developerUsername == null) {
            response.sendRedirect("login.jsp"); // Redirect to login if not logged in
            return;
        }

        List<Bug> assignedBugs = new ArrayList<>();

        // Retrieve assigned bugs from the database
        try (Connection connection = DBConnection.getConnection()) {
            String sql = "SELECT id, title, description, status, priority FROM bug_reports WHERE assigned_to = ?";
            try (PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
                preparedStatement.setString(1, developerUsername);
                try (ResultSet resultSet = preparedStatement.executeQuery()) {
                    while (resultSet.next()) {
                        Bug bug = new Bug();
                        bug.setId(resultSet.getInt("id"));
                        bug.setTitle(resultSet.getString("title"));
                        bug.setDescription(resultSet.getString("description"));
                        bug.setStatus(resultSet.getString("status"));
                        bug.setPriority(resultSet.getString("priority"));
                        assignedBugs.add(bug);
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        // Set the assigned bugs as a request attribute to pass to the JSP
        request.setAttribute("assignedBugs", assignedBugs);

        // Forward to the developer dashboard JSP
        request.getRequestDispatcher("/developer.jsp").forward(request, response);
    }
}
