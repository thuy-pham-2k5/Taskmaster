package com.example.taskmaster.service.user;

import com.example.taskmaster.model.DetailTask;
import com.example.taskmaster.model.Task;
import com.mysql.cj.x.protobuf.MysqlxPrepare;

import java.util.List;
import java.util.Map;

public interface ITaskService {
    List<Integer> getAllColumnId (int boardId);
    Map<Integer, List<Task>> getAllTask (List<Integer> columnIds);
    Map<Task, List<DetailTask>> getDetailTask (int taskId);
    Task createTask (String title, int listId);
    boolean deleteTask (int taskId);
    boolean deleteAllTaskInColumn (int columnId);


}
