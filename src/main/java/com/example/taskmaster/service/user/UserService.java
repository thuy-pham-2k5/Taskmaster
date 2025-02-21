package com.example.taskmaster.service.user;

import com.example.taskmaster.database.ConnectDatabase;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserService implements IUserService{
    @Override
    public int getRoleUserInGroup(int userId, int groupId) {  // sử dụng tạm thời để làm tính năng group
        String query = "SELECT * FROM user_group_relationships where user_id = ? and group_id = ?";
        int roleId = 0;
        try (Connection connection = ConnectDatabase.getConnection()) {
            PreparedStatement preparedStatement = connection.prepareStatement(query);
            preparedStatement.setInt(1, userId);
            preparedStatement.setInt(2, groupId);
            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                roleId = resultSet.getInt("role_id");
            }
            return roleId;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public int getGroupByUserId(int userId) {  // sử dụng tạm thời để làm tính năng group
        String query = "SELECT `groups`.group_id FROM `groups` join user_group_relationships on `groups`.group_id = user_group_relationships.group_id join users on user_group_relationships.user_id = users.user_id where users.user_id = ?";
        int groupId = 0;
        try (Connection connection = ConnectDatabase.getConnection()) {
            PreparedStatement preparedStatement = connection.prepareStatement(query);
            preparedStatement.setInt(1, userId);
            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                groupId = resultSet.getInt(1);
            }
            return groupId;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
