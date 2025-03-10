package com.example.taskmaster.service.user;

import com.example.taskmaster.model.Board;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

public interface IBoardService {
    List<Board> getAllBoardInGroup(int groupId, boolean sortType);
    Board getBoardById (int boardId);
    void saveTimestampToBoard (int userId, int boardId);
    void changeStarredBoard (int userId, int boardId, boolean starred);

    List<Board> searchBoardsByName(int groupId, String keyword);

    List<Board> getAllBoardClosedInGroup(int groupId);

    void createBoard(int userId, String boardTitle, int groupId);

    boolean deleteBoard( int boardId) throws SQLException;

    void closeBoard(int boardId);
}
