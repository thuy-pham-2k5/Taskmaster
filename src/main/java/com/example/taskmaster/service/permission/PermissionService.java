package com.example.taskmaster.service.permission;

import com.example.taskmaster.database.ConnectDatabase;
import com.example.taskmaster.model.Permission;
import jdk.vm.ci.code.site.Call;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PermissionService implements IPermissionService {
    @Override
    public List<Permission> getAllMyPermissionInGroup(int userId, int groupId) {
        List<Permission> permissions = new ArrayList<>();
        String query = "{call getAllPermissionInGroup (?, ?)}";
        try (Connection connection = ConnectDatabase.getConnection()) {
            CallableStatement callableStatement = connection.prepareCall(query);
            callableStatement.setInt(1, userId);
            callableStatement.setInt(2, groupId);
            ResultSet resultSet = callableStatement.executeQuery();
            while (resultSet.next()) {
                int permissionId = resultSet.getInt(1);
                String name = resultSet.getString(2);
                permissions.add(new Permission(permissionId, name));
            }
            return permissions;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public List<Permission> getAllMyPermissionInBoard(int userId, int boardId) {
        List<Permission> permissions = new ArrayList<>();
        String query = "{call getAllPermissionInBoard (?, ?)}";
        try (Connection connection = ConnectDatabase.getConnection()) {
            CallableStatement callableStatement = connection.prepareCall(query);
            callableStatement.setInt(1, userId);
            callableStatement.setInt(2, boardId);
            ResultSet resultSet = callableStatement.executeQuery();
            while (resultSet.next()) {
                int permissionId = resultSet.getInt(1);
                String name = resultSet.getString(2);
                permissions.add(new Permission(permissionId, name));
            }
            return permissions;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
