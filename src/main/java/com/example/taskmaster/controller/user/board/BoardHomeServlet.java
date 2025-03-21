package com.example.taskmaster.controller.user.board;

import com.example.taskmaster.model.*;
import com.example.taskmaster.service.user.*;
import com.google.gson.Gson;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.*;

@WebServlet(value = "/board_home")
public class BoardHomeServlet extends HttpServlet {
    GroupService groupService = new GroupService();
    BoardService boardService = new BoardService();
    IColumnService columnService = new ColumnService();
    ITaskService taskService = new TaskService();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        System.out.println(action);
        if (action == null) action = "";
        switch (action) {
            case "addNewTask":
                addNewTaskInTasks(req, resp);
                break;
            case "addNewColumn":
                addNewColumnInLists(req, resp);
                break;
            case "deleteColumn":
                deleteColumnInLists(req, resp);
                break;
            case "deleteAllTaskInColumn":
                deleteAllTaskInColumn(req, resp);
                break;
            case "deleteTask":
                deleteTaskById (req, resp);
                break;
            case "getInfoTask":
                getDetailTask(req, resp);
                break;
            case "saveDueTimeOfTask":
                saveDueTimeOfTask(req, resp);
                break;
            case "deleteDueTimeOfTask":
                deleteDueTimeOfTask(req, resp);
                break;
            case "saveDescriptionOfTask":
                saveDescriptionOfTask(req, resp);
                break;
            case "assignTaskForMember":
                assignTaskForMember(req, resp);
                break;
            case "editTitleBoard":
                editTitleBoard (req, resp);
                break;
            default:
                break;
        }
    }

    private void editTitleBoard(HttpServletRequest req, HttpServletResponse resp) {
        String title = req.getParameter("title");
        int boardId = (Integer) req.getSession().getAttribute("boardId");
        boardService.editTitleBoard(boardId, title);
        resp.setStatus(HttpServletResponse.SC_OK);
    }

    private void deleteTaskById(HttpServletRequest req, HttpServletResponse resp) {
        int taskId = Integer.parseInt(req.getParameter("taskId"));
        taskService.deleteTask(taskId);
        resp.setStatus(HttpServletResponse.SC_OK);
    }

    private void assignTaskForMember(HttpServletRequest req, HttpServletResponse resp) {
        int type = Integer.parseInt(req.getParameter("type"));
        int taskId = Integer.parseInt(req.getParameter("taskId"));
        int userId = Integer.parseInt(req.getParameter("userId"));
        if (userId == 0) {
            User user = (User) req.getSession().getAttribute("user");
            userId = user.getUserId();
        }
        if (type == 1) { // gắn thẻ
            taskService.assignMemberForTask(taskId, userId, true);
        } else {
            taskService.assignMemberForTask(taskId, userId, false);
        }
        resp.setStatus(HttpServletResponse.SC_OK);
    }

    private void saveDescriptionOfTask(HttpServletRequest req, HttpServletResponse resp) {
        int taskId = Integer.parseInt(req.getParameter("taskId"));
        String description = req.getParameter("description");
        taskService.saveDescriptionOfTask(taskId, description);
        resp.setStatus(HttpServletResponse.SC_OK);
    }

    private void deleteDueTimeOfTask(HttpServletRequest req, HttpServletResponse resp) {
        int taskId = Integer.parseInt(req.getParameter("taskId"));
        taskService.deleteDueTimeOfTask(taskId);
        resp.setStatus(HttpServletResponse.SC_OK);
    }

    private void saveDueTimeOfTask(HttpServletRequest req, HttpServletResponse resp) {
        String dueTime = req.getParameter("dueTime");
        Timestamp timestamp = Timestamp.valueOf(LocalDateTime.parse(dueTime.replace("Z", "")));
        System.out.println(timestamp);
        int taskId = Integer.parseInt(req.getParameter("taskId"));
        taskService.saveDueTimeOfTask(taskId, timestamp);
        resp.setStatus(HttpServletResponse.SC_OK);
    }

    private void getDetailTask(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        int taskId = Integer.parseInt(req.getParameter("taskId"));

        Task task = taskService.getTask(taskId);
        List<DetailTask> detailTask = taskService.getDetailTask(taskId);

        Map<String, Object> responseMap = new HashMap<>();
        responseMap.put("task", task);
        responseMap.put("details", detailTask);
        String responseJson = new Gson().toJson(responseMap);
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        resp.getWriter().write(responseJson);
    }

    private void deleteAllTaskInColumn(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        int columnId = Integer.parseInt(req.getParameter("columnId"));
        boolean success = taskService.deleteAllTaskInColumn(columnId);
        String messageJson = new Gson().toJson(success);
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        resp.getWriter().write(messageJson);
    }

    private void deleteColumnInLists(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        int columnId = Integer.parseInt(req.getParameter("columnId"));
        System.out.println("Column id: " + columnId);
        boolean success = columnService.deleteColumnInBoard(columnId);
        String messageJson = new Gson().toJson(success);
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        resp.getWriter().write(messageJson);
    }

    private void addNewTaskInTasks(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String title = req.getParameter("nameTask");
        int columnId = Integer.parseInt(req.getParameter("columnId"));
        Task task = taskService.createTask(title, columnId);
        String taskJson = new Gson().toJson(task);
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        resp.getWriter().write(taskJson);
    }

    private void addNewColumnInLists(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        int boardId = (Integer) req.getSession().getAttribute("boardId");
        String title = req.getParameter("columnName");
        Column column = columnService.addNewColumnInBoard(boardId, title);
        String columnJson = new Gson().toJson(column);
        System.out.println(columnJson);
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        resp.getWriter().write(columnJson);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) action = "";
        switch (action) {
            case "changeBoardStarredStatus":
                starredBoardByBoardId(req, resp);
                break;
            default:
                setTimestampToBoard(req);
                showDetailBoard(req, resp);
                break;
        }
    }

    private void starredBoardByBoardId(HttpServletRequest req, HttpServletResponse resp) {
        int boardId = (Integer) req.getSession().getAttribute("boardId");
        User user = (User) req.getSession().getAttribute("user");
        boolean boardStarredStatus = Boolean.parseBoolean(req.getParameter("boardStarredStatus"));
        boardService.changeStarredBoard(user.getUserId(), boardId, boardStarredStatus);
    }

    private void setTimestampToBoard(HttpServletRequest req) {
        User user = (User) req.getSession().getAttribute("user");
        int boardId = (Integer) req.getSession().getAttribute("boardId");
        boardService.saveTimestampToBoard(user.getUserId(), boardId);
    }


    private void showDetailBoard(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        int groupId = (Integer) session.getAttribute("groupId");
        int boardId = (Integer) session.getAttribute("boardId");
        req.setAttribute("groupInfo", groupService.getGroupInfoById(groupId));
        req.setAttribute("boards", boardService.getAllBoardInGroup(groupId, "option1"));
        req.setAttribute("boardDetail", boardService.getBoardById(boardId));
        List<Column> columns = columnService.getAllColumn(boardId);
        Map<Integer, List<Task>> tasks = taskService.getAllTask(taskService.getAllColumnId(boardId));
        String columnsJson = new Gson().toJson(columns);
        String tasksJson = new Gson().toJson(tasks);
        req.setAttribute("columns", columnsJson);
        req.setAttribute("tasks", tasksJson);
        req.getRequestDispatcher("/view/user/board/detail_board.jsp").forward(req, resp);
    }
}