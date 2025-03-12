package com.example.taskmaster.service.user;

import com.example.taskmaster.database.ConnectDatabase;
import com.example.taskmaster.model.Column;
import com.example.taskmaster.model.Group;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ColumnService implements IColumnService {
    @Override
    public List<Column> getAllColumn(int boardId) {
        List<Column> columns = new ArrayList<>();
        String query = "select * from lists where board_id = ?";
        try (Connection connection = ConnectDatabase.getConnection()) {
            PreparedStatement preparedStatement = connection.prepareStatement(query);
            preparedStatement.setInt(1, boardId);
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                int columnId = resultSet.getInt(1);
                String name = resultSet.getString(2);
                int position = resultSet.getInt(4);
                columns.add(new Column(columnId, name, boardId, position));
            }
            return columns;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }


    // Thêm cột vào bảng.
    @Override
    public Column addNewColumnInBoard(int boardId, String name) {
        String query = "{call createNewList (?, ?)}";
        try (Connection connection = ConnectDatabase.getConnection()) {
            CallableStatement callableStatement = connection.prepareCall(query);
            callableStatement.setInt(1, boardId);
            callableStatement.setString(2, name);
            ResultSet resultSet = callableStatement.executeQuery();
            if (resultSet.next()) {
                int columnId = resultSet.getInt(1);
                int position = resultSet.getInt(2);
                return new Column(columnId, name, boardId, position);
            }
            return null;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    // Đóng cột có trong bảng.
    @Override
    public void deleteColumnInBoard(int columnId) {
        String query = "delete from lists where list_id = ?";
        try (Connection connection = ConnectDatabase.getConnection()) {
            PreparedStatement preparedStatement = connection.prepareStatement(query);
            preparedStatement.setInt(1, columnId);
            preparedStatement.executeQuery();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    // Chỉnh sửa tên cột có trong bảng.
    @Override
    public void updateColumnNameInBoard(int columnId, String name) {
        String query = "update lists set name = ? where list_id = ?";
        try (Connection connection = ConnectDatabase.getConnection()) {
            PreparedStatement preparedStatement = connection.prepareStatement(query);
            preparedStatement.setString(1, name);
            preparedStatement.setInt(2, columnId);
            preparedStatement.executeQuery();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }


}
