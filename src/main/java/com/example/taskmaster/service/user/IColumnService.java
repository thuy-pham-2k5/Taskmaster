package com.example.taskmaster.service.user;

import com.example.taskmaster.model.Column;

import java.util.List;

public interface IColumnService {
    List<Column> getAllColumn(int boardId);
    void addNewColumnInBoard (int boardId, String columnName);
}
