package com.example.taskmaster.service.user;

import com.example.taskmaster.model.Column;
import com.example.taskmaster.model.Task;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface ITaskService {
    List<Integer> getAllColumnId (int boardId);
    Map<Integer, List<Task>> getAllTask (List<Integer> columnIds);
}
