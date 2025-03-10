package com.example.taskmaster.controller.user.board;

import com.example.taskmaster.model.Task;
import com.example.taskmaster.service.user.TaskService;

import java.util.List;
import java.util.Map;

public class Test {
    public static void main(String[] args) {
        TaskService taskService = new TaskService();

        Map<Integer, List<Task>> taskMap =  taskService.getAllTask(taskService.getAllColumnId(1));

        // In kết quả
        System.out.println("Final taskMap:");
        for (Map.Entry<Integer, List<Task>> entry : taskMap.entrySet()) {
            System.out.println("ListId: " + entry.getKey());
            for (Task task : entry.getValue()) {
                System.out.println("    TaskId: " + task.getTaskId() + ", Name: " + task.getTitle());
            }
        }
    }

}
