package com.example.taskmaster.service.user;

import com.example.taskmaster.model.Column;

import java.util.List;

public interface IColumnService {
    List<Column> getAllColumn(int boardId);
    void addNewColumnInBoard (Column column);
    void deleteColumnInBoard (int columnId);
    void updateColumnNameInBoard (int columnId, String name);
}
