package com.example.taskmaster.database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConnectDatabase {

    public static Connection getConnection() {
        Connection connection;
        try {
            Class.forName("com.mysql.jdbc.Driver");
            String password = System.getenv("dbPassword");
<<<<<<< HEAD
            System.out.println("Value of password: " + password);
=======
>>>>>>> 5f2150360dbb9b698523a50e20440b063a0b2105
            connection = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/taskmaster", "root", password);
        } catch (ClassNotFoundException | SQLException e) {
            throw new RuntimeException(e);
        }
        return connection;
    }
}