package com.example.taskmaster.service.user;

import com.example.taskmaster.database.ConnectDatabase;
import com.example.taskmaster.model.Group;
import com.example.taskmaster.model.User;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class GroupService implements IGroupService {
    @Override
    public Group getGroupInfoById(int groupId) {
        String query = "select * from `groups` where group_id = ?";
        Group group = null;
        try (Connection connection = ConnectDatabase.getConnection()) {
            PreparedStatement preparedStatement = connection.prepareStatement(query);
            preparedStatement.setInt(1, groupId);
            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                String title = resultSet.getString(2);
                String linkWeb = resultSet.getString(3);
                String description = resultSet.getString(4);
                String visibility = resultSet.getString(5);
                group = new Group(groupId, title, linkWeb, description, visibility);
            }
            return group;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public Group getGroupInfoByTitleAndDescription(String title, String description) {
        String query = "select * from `groups` where title = ? and description = ?";
        Group group = null;
        try (Connection connection = ConnectDatabase.getConnection()) {
            PreparedStatement preparedStatement = connection.prepareStatement(query);
            preparedStatement.setString(1, title);
            preparedStatement.setString(2, description);
            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                int groupId = resultSet.getInt(1);
                String linkWeb = resultSet.getString(3);
                String visibility = resultSet.getString(5);
                group = new Group(groupId, title, linkWeb, description, visibility);
            }
            return group;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public void inviteMember(int userId, int groupId, int roleId) {
        String query = "INSERT INTO user_group_relationships (`user_id`, `group_id`, `role_id`) VALUES ('?, ?, ?)";
        try (Connection connection = ConnectDatabase.getConnection()) {
            PreparedStatement preparedStatement = connection.prepareStatement(query);
            preparedStatement.setInt(1, userId);
            preparedStatement.setInt(2, groupId);
            preparedStatement.setInt(3, roleId);
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }


    @Override
    public List<Group> getTitleGroupByUserId(int user_id) {
        String query = "SELECT `groups`.group_id, `groups`.title FROM `groups` JOIN user_group_relationships ON `groups`.group_id = user_group_relationships.group_id JOIN users ON user_group_relationships.user_id = users.user_id WHERE users.user_id = ?";
        List<Group> titleGroupList = new ArrayList<>();
        try (Connection connection = ConnectDatabase.getConnection()) {
            PreparedStatement preparedStatement = connection.prepareStatement(query);
            preparedStatement.setInt(1, user_id);
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()){
                int groupId = resultSet.getInt("group_id");
                String title = resultSet.getString("title");
                Group group = new Group(groupId, title);
                titleGroupList.add(group);
            }
            return titleGroupList;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public void createGroup(Group group, int userId) {
        String query = "{call createNewGroup (?, ?, ?)}";
        try (Connection connection = ConnectDatabase.getConnection()) {
            PreparedStatement preparedStatement = connection.prepareStatement(query);
            preparedStatement.setInt(1, userId);
            preparedStatement.setString(2, group.getTitle());
            preparedStatement.setString(3, group.getDescription());
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public void updateGroup(int groupId, Group group) {
        String query = "UPDATE `groups` SET `title` = ?, `link_web` = ?, `description` = ? WHERE `group_id` = ?;";
        try (Connection connection = ConnectDatabase.getConnection()) {
            PreparedStatement preparedStatement = connection.prepareStatement(query);
            preparedStatement.setString(1, group.getTitle());
            preparedStatement.setString(2, group.getLinkWeb());
            preparedStatement.setString(3, group.getDescription());
            preparedStatement.setInt(4, groupId);
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
