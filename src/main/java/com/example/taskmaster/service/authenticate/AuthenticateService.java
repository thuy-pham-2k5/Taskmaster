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

    }

    @Override
    public void signIn(String email, String password) {

    }

    @Override
    public void logOut() {

    }

    @Override
    public void resetPassword(String email) {

    }

    public Boolean getUserByEmail (String email) {
        String query = "select * from users where email = ?";
        try (Connection connection = ConnectDatabase.getConnection()) {
            PreparedStatement preparedStatement = connection.prepareStatement(query);
            preparedStatement.setString(1, email);
            ResultSet resultSet = preparedStatement.executeQuery();
            return resultSet.next();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
