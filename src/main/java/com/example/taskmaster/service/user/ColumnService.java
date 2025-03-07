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

    @Override
    public void addNewColumnInBoard(int boardId, String columnName) {

    }
}
