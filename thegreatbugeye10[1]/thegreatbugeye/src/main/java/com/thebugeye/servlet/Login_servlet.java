package com.thebugeye.servlet;

import com.thebugeye.util.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession; // Import HttpSession
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

@WebServlet("/login")
public class Login_servlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
       
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String role = request.getParameter("role"); 

        String sql = "";
        
        // Using switch to determine the SQL query based on the role
        switch (role) {
            case "DEVELOPER":
                sql = "SELECT username FROM developers WHERE email = ? AND password = ?"; 
                break;
            case "ADMIN":
                sql = "SELECT username FROM admins WHERE email = ? AND password = ?";
                break;
            case "USER":
                sql = "SELECT username FROM users WHERE email = ? AND password = ?";
                break;
            default:
                // If role is invalid, handle it here
                request.setAttribute("errorMessage", "Invalid role selected!");
                request.getRequestDispatcher("/login.jsp").forward(request, response);
                return; // Exit the method
        }

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            preparedStatement.setString(1, email);
            preparedStatement.setString(2, password); 
            ResultSet resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
               
                String username = resultSet.getString("username");

              
                HttpSession session = request.getSession();
                session.setAttribute("username", username);

               
                switch (role) {
                    case "DEVELOPER":
                        response.sendRedirect("developerDashboard");
                        break;
                    case "ADMIN":
                        response.sendRedirect("admin.jsp");
                        break;
                    case "USER":
                        response.sendRedirect("user.jsp");
                        break;
                    default:
                        request.setAttribute("errorMessage", "Invalid role selected!");
                        request.getRequestDispatcher("/login.jsp").forward(request, response);
                }
            } else {
              
                request.setAttribute("errorMessage", "Invalid email or password!");
                request.getRequestDispatcher("/login.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Database error: " + e.getMessage());
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        }
    }
}
