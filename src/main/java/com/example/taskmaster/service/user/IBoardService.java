package com.example.taskmaster.service.user;

import com.example.taskmaster.model.Board;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

public interface IBoardService {
    List<Board> getAllBoardInGroup(int groupId, boolean sortType);

    List<Board> searchBoardsByName(int groupId, String keyword);

    List<Board> getAllBoardClosedInGroup(int groupId);

    void createBoard(Board board);

    boolean deleteBoard( int boardId) throws SQLException;
}
