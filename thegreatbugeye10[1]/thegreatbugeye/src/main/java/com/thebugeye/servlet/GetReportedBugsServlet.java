package com.thebugeye.servlet;

import com.thebugeye.entity.Bug;
import com.thebugeye.util.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.sql.SQLException;

@WebServlet("/buglist")
public class GetReportedBugsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve the username from the session
        String username = (String) request.getSession().getAttribute("username");

        // If the user is not logged in, redirect them to the login page
        if (username == null) {
            response.sendRedirect("login.jsp");
            return;
        }


        List<Bug> userBugs = new ArrayList<>();

        
        try (Connection connection = DBConnection.getConnection()) {
            String sql = "SELECT id, title, description, status, priority, reported_by FROM bug_reports WHERE reported_by = ?";
            try (PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
                preparedStatement.setString(1, username); // Set the username parameter
                ResultSet resultSet = preparedStatement.executeQuery();

                while (resultSet.next()) {
                    Bug bug = new Bug();
                    bug.setId(resultSet.getInt("id"));
                    bug.setTitle(resultSet.getString("title"));
                    bug.setDescription(resultSet.getString("description"));
                    bug.setStatus(resultSet.getString("status"));
                    bug.setPriority(resultSet.getString("priority"));
                    bug.setReportedBy(resultSet.getString("reported_by"));  // Set reportedBy to the current user's username
                    userBugs.add(bug); 
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
           
            request.setAttribute("errorMessage", "Unable to retrieve bug reports at this time.");
        }

        
        request.setAttribute("bug_reports", userBugs);

        
        request.getRequestDispatcher("/buglist.jsp").forward(request, response);
    }
}
