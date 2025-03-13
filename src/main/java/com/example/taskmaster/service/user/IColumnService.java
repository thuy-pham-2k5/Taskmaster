package com.example.taskmaster.service.user;

import com.example.taskmaster.model.Column;

import java.util.List;

public interface IColumnService {
    List<Column> getAllColumn(int boardId);
    Column addNewColumnInBoard (int boardId, String name);
    void deleteColumnInBoard (int columnId);
    void updateColumnNameInBoard (int columnId, String name);
}
