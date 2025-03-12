package com.example.taskmaster.service.user;

import com.example.taskmaster.database.ConnectDatabase;
import com.example.taskmaster.model.Column;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
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
    public void addNewColumnInBoard(Column column) {
        String query = "INSERT INTO lists (name, board_id, position) VALUES (?, ?, ?);";
        try (Connection connection = ConnectDatabase.getConnection()) {
            PreparedStatement preparedStatement = connection.prepareStatement(query);
            preparedStatement.setString(1, column.getName());
            preparedStatement.setInt(2, column.getBoardId());
            preparedStatement.setInt(3, column.getPosition());
            preparedStatement.executeQuery();
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
