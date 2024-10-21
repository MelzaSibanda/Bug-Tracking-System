package com.thebugeye.servlet;

import com.thebugeye.util.DBConnection; // Import your DB connection utility
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import org.mindrot.jbcrypt.BCrypt;

@WebServlet("/signup")
public class UserSignupServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get the form data
        String username = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirm-password");
        String role = request.getParameter("role"); // Get the user's role

        // Check if the passwords match
        if (!password.equals(confirmPassword)) {
            request.setAttribute("errorMessage", "Passwords do not match!");
            request.getRequestDispatcher("/signup.jsp").forward(request, response);
            return;
        }

        

        // Database connection and insertion
        try (Connection connection = DBConnection.getConnection()) {
            // Choose the table based on the role
            String sql = null;

            switch (role) {
                case "DEVELOPER":
                    sql = "INSERT INTO developers (username, email, password) VALUES (?, ?, ?)";
                    break;
                case "ADMIN":
                    sql = "INSERT INTO admins (username, email, password) VALUES (?, ?, ?)";
                    break;
                case "USER":
                    sql = "INSERT INTO users (username, email, password) VALUES (?, ?, ?)";
                    break;
                default:
                    // Handle invalid role
                    request.setAttribute("errorMessage", "Invalid role selected!");
                    request.getRequestDispatcher("/signup.jsp").forward(request, response);
                    return;
            }

            try (PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
                preparedStatement.setString(1, username);
                preparedStatement.setString(2, email);
                preparedStatement.setString(3, password);
                preparedStatement.executeUpdate();
            }

            response.sendRedirect("login.jsp"); // Redirect to login after successful signup
        } catch (SQLException e) {
            e.printStackTrace(); // Consider logging this instead of printing
            request.setAttribute("errorMessage", "Error saving user: " + e.getMessage());
            request.getRequestDispatcher("/signup.jsp").forward(request, response);
        }
    }

    // Implement a method to hash the password
   
}
