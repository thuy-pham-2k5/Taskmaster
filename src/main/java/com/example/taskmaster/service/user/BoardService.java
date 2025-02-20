package com.example.taskmaster.service.user;

import com.example.taskmaster.database.ConnectDatabase;
import com.example.taskmaster.model.Board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class BoardService implements IBoardService{
    @Override
    public List<Board> getAllBoardInGroup(int groupId) {
        String query = "select * from boards join board_backgrounds where group_id = ?";
        List<Board> boards = new ArrayList<>();
        try (Connection connection = ConnectDatabase.getConnection()) {
            PreparedStatement preparedStatement = connection.prepareStatement(query);
            preparedStatement.setInt(1, groupId);
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                int boardId = resultSet.getInt(1);
                String title = resultSet.getString(2);
                int backgroundId = resultSet.getInt(3);
                String backgroundLink = resultSet.getString(8);
                int status = resultSet.getInt(5);
                boards.add(new Board(boardId, title, backgroundId, backgroundLink, status, groupId));
            }
            return boards;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
