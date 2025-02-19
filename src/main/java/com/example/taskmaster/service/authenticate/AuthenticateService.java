package com.example.taskmaster.service.authenticate;

import com.example.taskmaster.database.ConnectDatabase;
import com.example.taskmaster.model.User;

import javax.management.Notification;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Random;

public class AuthenticateService implements IAuthenticateService{
    @Override
    public Boolean signUp(User user) {
        if (getUserByField("email", user.getEmail())) {
            return false;
        } else {
            String username = createNewUsername();
            while (getUserByField("username", username)) {
                username = createNewUsername();
            }
            insertNewUser(user.getEmail(), user.getPassword(), user.getFullName(), username);
            return true;
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

    public void insertNewUser (String email, String password, String fullName, String username) {
        String query = "INSERT INTO users (email, password, full_name, username) VALUES (?, ?, ?, ?)";
        try (Connection connection = ConnectDatabase.getConnection()) {
            PreparedStatement preparedStatement = connection.prepareStatement(query);
            preparedStatement.setString(1, email);
            preparedStatement.setString(2, password);
            preparedStatement.setString(3, fullName);
            preparedStatement.setString(4, username);
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    private static final String ALLOWED_CHARACTERS = "abcdefghijklmnopqrstuvwxyz0123456789_";
    private static final Random RANDOM = new Random();

    public String createNewUsername () {
        int lengthUsername = RANDOM.nextInt(14) + 4;
        StringBuilder username = new StringBuilder(lengthUsername);
        for (int i = 0; i < lengthUsername; i++) {
            username.append(ALLOWED_CHARACTERS.charAt(RANDOM.nextInt(ALLOWED_CHARACTERS.length())));
        }
        return username.toString();
    }
}