package com.thebugeye.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
     private static final String URL = "jdbc:mysql://localhost:3306/signup?allowPublicKeyRetrieval=true&useSSL=false";  // Update with your database URL
    private static final String USER = "root"; // Update with your database username
    private static final String PASSWORD = "665390"; // Update with your database password

    public static Connection getConnection() throws SQLException {
        try {
            // Register JDBC driver
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new SQLException("JDBC Driver not found.", e);
        }
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }
}
