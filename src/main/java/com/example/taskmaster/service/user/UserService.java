package com.example.taskmaster.service.user;

import com.example.taskmaster.database.ConnectDatabase;
import com.example.taskmaster.model.User;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class UserService implements IUserService {
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
    public List<User> getAllMemberGroup(int groupId) {
        String query = "select users.user_id, users.full_name, users.username, roles.name as role_name from users join user_group_relationships on users.user_id = user_group_relationships.user_id join roles on user_group_relationships.role_id = roles.role_id where user_group_relationships.group_id = ? and roles.role_id = 3 or roles.role_id = 4";
        List<User> users = new ArrayList<>();
        try (Connection connection = ConnectDatabase.getConnection()) {
            PreparedStatement preparedStatement = connection.prepareStatement(query);
            preparedStatement.setInt(1, groupId);
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                int userId = resultSet.getInt(1);
                String fullName = resultSet.getString(2);
                String username = resultSet.getString(3);
                String roleName;
                if (resultSet.getString(4).equals("Admin Workspace")) {
                    roleName = "Quản trị viên";
                } else {
                    roleName = "Thành viên";
                }
                users.add(new User(userId, fullName, username, roleName));
            }
            return users;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public List<User> getAllGuestGroup(int groupId) {
        String query = "select users.user_id, users.full_name, users.username, roles.name as role_name from users join user_group_relationships on users.user_id = user_group_relationships.user_id join roles on user_group_relationships.role_id = roles.role_id where user_group_relationships.group_id = ? and roles.role_id = 5";
        List<User> users = new ArrayList<>();
        try (Connection connection = ConnectDatabase.getConnection()) {
            PreparedStatement preparedStatement = connection.prepareStatement(query);
            preparedStatement.setInt(1, groupId);
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                int userId = resultSet.getInt(1);
                String fullName = resultSet.getString(2);
                String username = resultSet.getString(3);
                String roleName = "Khách";
                users.add(new User(userId, fullName, username, roleName));
            }
            return users;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public List<User> getAllRequestToJoinGroup(int groupId) {
        String query = "select users.user_id, users.full_name, users.username from users join request_to_join_group on users.user_id = request_to_join_group.user_id where request_to_join_group.group_id = ?";
        List<User> users = new ArrayList<>();
        try (Connection connection = ConnectDatabase.getConnection()) {
            PreparedStatement preparedStatement = connection.prepareStatement(query);
            preparedStatement.setInt(1, groupId);
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                int userId = resultSet.getInt(1);
                String fullName = resultSet.getString(2);
                String username = resultSet.getString(3);
                users.add(new User(userId, fullName, username));
            }
            return users;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
