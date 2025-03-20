package com.example.taskmaster.service.user;

import com.example.taskmaster.database.ConnectDatabase;
import com.example.taskmaster.model.Column;
import com.example.taskmaster.model.DetailTask;
import com.example.taskmaster.model.Task;
import jdk.vm.ci.code.site.Call;

import java.sql.*;
import java.util.*;
import java.util.regex.Pattern;

public class  TaskService implements ITaskService {
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

    @Override
    public Task getTask(int taskId) {
        String query = "{call getDetailTask(?)}";
        Map<Task, List<DetailTask>> detailTask = new HashMap<>();
        try (Connection connection = ConnectDatabase.getConnection()) {
            CallableStatement callableStatement = connection.prepareCall(query);
            callableStatement.setInt(1, taskId);
            ResultSet resultSet = callableStatement.executeQuery();
            if (resultSet.next()) {
                String titleTask = resultSet.getString("title");
                String description = resultSet.getString("description");
                int listId = resultSet.getInt("list_id");
                String listName = resultSet.getString("name");
                int position = resultSet.getInt("position");
                String dueTime = resultSet.getString("due_time");
                return new Task(taskId, titleTask, description, listId, listName, position, dueTime);
            } else
                return null;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public List<DetailTask> getDetailTask(int taskId) {
        String query = "{call getDetailTask(?)}";
        List<DetailTask> detailTask = new ArrayList<>();
        try (Connection connection = ConnectDatabase.getConnection()) {
            CallableStatement callableStatement = connection.prepareCall(query);
            callableStatement.setInt(1, taskId);
            ResultSet resultSet = callableStatement.executeQuery();
            while (resultSet.next()) {
                int userId = resultSet.getInt("user_id");
                String fullName = resultSet.getString("full_name");
                String colorLabel = resultSet.getString("color_label");
                String nameLabel = resultSet.getString("name_label");
                boolean isFollowing = resultSet.getBoolean("is_following");
                detailTask.add(new DetailTask(userId, fullName, isFollowing, colorLabel, nameLabel));
            }
            return detailTask;
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

    @Override
    public void saveDescriptionOfTask(int taskId, String description) {
        String query = "UPDATE `taskmaster`.`tasks` SET `description` = ? WHERE (`task_id` = ?)";
        try (Connection connection = ConnectDatabase.getConnection()) {
            PreparedStatement preparedStatement = connection.prepareStatement(query);
            preparedStatement.setString(1, description);
            preparedStatement.setInt(2, taskId);
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public void saveDueTimeOfTask(int taskId, Timestamp dueTime) {
        String query = "{call saveDueTimeInTask (?, ?)}";
        try (Connection connection = ConnectDatabase.getConnection()) {
            CallableStatement callableStatement = connection.prepareCall(query);
            callableStatement.setInt(2, taskId);
            callableStatement.setTimestamp(1, dueTime);
            callableStatement.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public void deleteDueTimeOfTask(int taskId) {
        String query = "delete from dates where task_id = ?";
        try (Connection connection = ConnectDatabase.getConnection()) {
            PreparedStatement preparedStatement = connection.prepareStatement(query);
            preparedStatement.setInt(1, taskId);
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}

