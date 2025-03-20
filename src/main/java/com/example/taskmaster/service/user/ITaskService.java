package com.example.taskmaster.service.user;

import com.example.taskmaster.model.DetailTask;
import com.example.taskmaster.model.Task;
import com.mysql.cj.x.protobuf.MysqlxPrepare;

import java.sql.Timestamp;
import java.util.List;
import java.util.Map;

public interface ITaskService {
    List<Integer> getAllColumnId (int boardId);
    Map<Integer, List<Task>> getAllTask (List<Integer> columnIds);
    Task getTask (int taskId);
    List<DetailTask> getDetailTask (int taskId);
    Task createTask (String title, int listId);
    boolean deleteTask (int taskId);
    boolean deleteAllTaskInColumn (int columnId);
    void saveDescriptionOfTask (int taskId, String description);
    void saveDueTimeOfTask (int taskId, Timestamp dueTime);
    void deleteDueTimeOfTask (int taskId);
    boolean assignMemberForTask (int taskId, int userId, boolean type);

}
