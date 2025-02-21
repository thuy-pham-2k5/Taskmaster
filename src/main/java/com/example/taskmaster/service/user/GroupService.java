package com.example.taskmaster.service.user;

import com.example.taskmaster.database.ConnectDatabase;
import com.example.taskmaster.model.Group;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

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
        }    }

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
}
