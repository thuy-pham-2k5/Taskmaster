package com.example.taskmaster.service.authenticate;

import com.example.taskmaster.database.ConnectDatabase;
import com.example.taskmaster.model.User;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class AuthenticateService implements IAuthenticateService{
    @Override
    public void signUp(User user) {
        String query = "INSERT INTO users (email, password, full_name) VALUES (?, ?, ?)";
        try (Connection connection = ConnectDatabase.getConnection()) {
            PreparedStatement preparedStatement = connection.prepareStatement(query);
            preparedStatement.setString(1, user.getEmail());
            preparedStatement.setString(2, user.getPassword());
            preparedStatement.setString(3, user.getFullName());
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public void signIn(String email, String password) {

    }

    @Override
    public void logout() {

    }

    @Override
    public void resetPassword(String email) {

    }

    public Boolean getUserByField (String field, String value) {
        String query = "select * from users where " + field + " = ?";
        try (Connection connection = ConnectDatabase.getConnection()) {
            PreparedStatement preparedStatement = connection.prepareStatement(query);
            preparedStatement.setString(1, value);
            ResultSet resultSet = preparedStatement.executeQuery();
            return resultSet.next();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

}