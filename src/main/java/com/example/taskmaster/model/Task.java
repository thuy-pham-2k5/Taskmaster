package com.example.taskmaster.model;

public class Task {
    private int taskId;
    private String title, description;
    private int columnId, position;

    public Task(int taskId, String title, String description, int columnId, int position) {
        this.taskId = taskId;
        this.title = title;
        this.description = description;
        this.columnId = columnId;
        this.position = position;
    }

    @Override
    public String toString() {
        return "Task{" +
                "taskId=" + taskId +
                ", title='" + title + '\'' +
                ", description='" + description + '\'' +
                ", listId=" + columnId +
                ", position=" + position +
                '}';
    }

    public int getTaskId() {
        return taskId;
    }

    public void setTaskId(int taskId) {
        this.taskId = taskId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getColumnId() {
        return columnId;
    }

    public void setColumnId(int columnId) {
        this.columnId = columnId;
    }

    public int getPosition() {
        return position;
    }

    public void setPosition(int position) {
        this.position = position;
    }
}
