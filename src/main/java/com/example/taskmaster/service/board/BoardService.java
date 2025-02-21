package com.example.taskmaster.service.board;

import com.example.taskmaster.database.ConnectDatabase;
import com.example.taskmaster.model.Board;

import java.sql.Connection;
import java.sql.PreparedStatement;

public class BoardService implements IBoardService {
    private ConnectDatabase connectDatabase = new ConnectDatabase();
    public void createBoard(Board board) {
        PreparedStatement preparedStatement = null;
        Connection connection = connectDatabase.getConnection();
        try {
            preparedStatement = connection.prepareStatement("INSERT INTO boards (title, status, background_id, group_id) VALUES (?, ?, ?, ?);");
            preparedStatement.setString(1, board.getTitle());
            preparedStatement.setInt(2, board.getStatus());
            preparedStatement.setInt(3, board.getBackgroundId());
            preparedStatement.setInt(4, board.getGroupId());
            preparedStatement.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
