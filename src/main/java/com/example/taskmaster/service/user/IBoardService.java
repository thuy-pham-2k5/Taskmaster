package com.example.taskmaster.service.user;

import com.example.taskmaster.model.Board;

import java.util.List;

public interface IBoardService {
    List<Board> getAllBoardInGroup (int groupId, boolean sortType);
    List<Board> searchBoardsByName (int groupId, String keyword);
    List<Board> getAllBoardClosedInGroup (int groupId);
}
