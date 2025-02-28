package com.example.taskmaster.service.user;

import com.example.taskmaster.database.ConnectDatabase;
import com.example.taskmaster.model.Group;
import com.example.taskmaster.model.User;

import java.sql.*;
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
        String query = "INSERT INTO user_group_relationships (`user_id`, `group_id`, `role_id`) VALUES (?, ?, ?)";
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

    private String queryCreateGroup = "INSERT INTO `groups` (title, link_web, description, visibility) VALUES ( ?, ?, ?, ?)";
    private String queryAddCreatorInformation = "INSERT INTO user_group_relationships (user_id, group_id, role_id, permission_id) VALUES ( ?, ?, ?, ?)";

    //    3, 1
    @Override
    public void createGroup(Group group, int userId) {
        Connection conn = null;
        PreparedStatement stmtGroup = null;
        PreparedStatement stmtRelationship = null;
        ResultSet generatedKeys = null;

        try {
            conn = ConnectDatabase.getConnection();
            conn.setAutoCommit(false); // Bắt đầu transaction

            // Thêm dữ liệu vào bảng `groups`
            stmtGroup = conn.prepareStatement(queryCreateGroup, PreparedStatement.RETURN_GENERATED_KEYS);
            stmtGroup.setString(1, group.getTitle());
            stmtGroup.setString(2, "https://trello.com/invite/b/67a5e7887bf5b4b68aaeab61/ATTI065dfce7d566bfe6834a51aa09d0f41c00FC93EC/backlog-sprint");
            stmtGroup.setString(3, group.getDescription());
            stmtGroup.setString(4, "riêng tư");
            stmtGroup.executeUpdate();
            System.out.println("da them group");

            // Lấy group_id vừa được tạo
            generatedKeys = stmtGroup.getGeneratedKeys();
            int groupId = -1;
            if (generatedKeys.next()) {
                groupId = generatedKeys.getInt(1);
            }

            if (groupId > 0) {
                // Thêm vào bảng `user_group_relationships`
                stmtRelationship = conn.prepareStatement(queryAddCreatorInformation);
                stmtRelationship.setInt(1, userId);
                stmtRelationship.setInt(2, groupId);
                stmtRelationship.setInt(3, 3);
                stmtRelationship.setInt(4, 1);
                stmtRelationship.executeUpdate();
                System.out.println("Da them relationship");
            }

            conn.commit(); // Xác nhận transaction

        } catch (SQLException e) {
            if (conn != null) {
                try {
                    conn.rollback(); // Quay lại trạng thái trước transaction nếu có lỗi
                } catch (SQLException rollbackEx) {
                    rollbackEx.printStackTrace();
                }
            }
            e.printStackTrace();
        } finally {
            // Đóng tài nguyên
            try {
                if (generatedKeys != null) generatedKeys.close();
                if (stmtGroup != null) stmtGroup.close();
                if (stmtRelationship != null) stmtRelationship.close();
                if (conn != null) conn.setAutoCommit(true);
                if (conn != null) conn.close();
            } catch (SQLException closeEx) {
                closeEx.printStackTrace();
            }
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

    @Override
    public void deleteGroup(int groupId) {
        String query = "select * from `groups` where group_id = ?";
        try (Connection connection = ConnectDatabase.getConnection()) {
            PreparedStatement preparedStatement = connection.prepareStatement(query);
            preparedStatement.setInt(1, groupId);
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
