package com.example.taskmaster.database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConnectDatabase {

    public Connection getConnection() {
        Connection connection = null;
        try {
            Class.forName("com.mysql.jdbc.Driver");
            String password = System.getenv("dbPassword");
            System.out.println("Value of password: " + password);
            connection = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/taskmaster", "root", password);
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return connection;
    }
}