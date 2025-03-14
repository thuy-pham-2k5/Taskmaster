package com.example.taskmaster.service.user;

import com.example.taskmaster.database.ConnectDatabase;
import com.example.taskmaster.model.Column;
import com.example.taskmaster.model.Task;

import java.sql.*;
import java.util.*;
import java.util.regex.Pattern;

public class TaskService implements ITaskService {
    @Override
    public List<Integer> getAllColumnId(int boardId) {
        List<Integer> columnIds = new ArrayList<>();
        String query = "select list_id from lists where board_id = ?";
        try (Connection connection = ConnectDatabase.getConnection()) {
            PreparedStatement preparedStatement = connection.prepareStatement(query);
            preparedStatement.setInt(1, boardId);
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next())
                columnIds.add(resultSet.getInt(1));
            return columnIds;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public Map<Integer, List<Task>> getAllTask(List<Integer> columnIds) {
        Map<Integer, List<Task>> taskMap = new HashMap<>();
        if (columnIds.isEmpty()) return taskMap; // Tránh SQL lỗi nếu danh sách rỗng

        String placeholders = String.join(",", Collections.nCopies(columnIds.size(), "?"));
        String query = "SELECT * FROM tasks WHERE list_id IN (" + placeholders + ")";

        try (Connection connection = ConnectDatabase.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            int index = 1;
            for (Integer columnId : columnIds) {
                preparedStatement.setInt(index++, columnId);
            }
            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                while (resultSet.next()) {
                    int columnId = resultSet.getInt("list_id");
                    taskMap.putIfAbsent(columnId, new ArrayList<>());
                    int taskId = resultSet.getInt("task_id");
                    String name = resultSet.getString("title");
                    String description = resultSet.getString("description");
                    int position = resultSet.getInt("position");
                    taskMap.get(columnId).add(new Task(taskId, name, description, columnId, position));
                }
            }
            return taskMap;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    // Thêm Task vào cột.
    @Override
    public Task createTask(String title, int listId) {
        String query = "{call createNewTask (?, ?)}";
        try (Connection connection = ConnectDatabase.getConnection()) {
            CallableStatement callableStatement = connection.prepareCall(query);
            callableStatement.setInt(2, listId);
            callableStatement.setString(1, title);
            ResultSet resultSet = callableStatement.executeQuery();
            if (resultSet.next()) {
                int taskId = resultSet.getInt(1);
                int position = resultSet.getInt(5);
                String description = resultSet.getString(3);
                return new Task(taskId, title, description, listId, position);
            }
            return null;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    // xóa Task khỏi cột.
    @Override
    public boolean deleteTask(int taskId) {
        String query = "delete from tasks where task_id= ?";
        try (Connection connection = ConnectDatabase.getConnection()) {
            PreparedStatement preparedStatement = connection.prepareStatement(query);
            preparedStatement.setInt(1, taskId);
            int success = preparedStatement.executeUpdate();
            return success > 0;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public boolean deleteAllTaskInColumn(int columnId) {
        String query = "delete from tasks where list_id = ?";
        try (Connection connection = ConnectDatabase.getConnection()) {
            PreparedStatement preparedStatement = connection.prepareStatement(query);
            preparedStatement.setInt(1, columnId);
            int success = preparedStatement.executeUpdate();
            return success > 0;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

}

