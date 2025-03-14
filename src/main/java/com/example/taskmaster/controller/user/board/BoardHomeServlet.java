package com.example.taskmaster.controller.user.board;

import com.example.taskmaster.model.Column;
import com.example.taskmaster.model.Group;
import com.example.taskmaster.model.Task;
import com.example.taskmaster.model.User;
import com.example.taskmaster.service.user.*;
import com.google.gson.Gson;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

@WebServlet (value = "/board_home")
public class BoardHomeServlet extends HttpServlet {
    GroupService groupService = new GroupService();
    BoardService boardService = new BoardService();
    IColumnService columnService = new ColumnService();
    ITaskService taskService = new TaskService();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) action = "";
        switch (action) {
            case "addNewTask":
                addNewTaskInTasks (req, resp);
                break;
            case "addNewColumn":
                addNewColumnInLists (req, resp);
                break;
            case "deleteColumn":
                deleteColumnInLists (req, resp);
                break;
            default:
                break;
        }
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
        int boardId = Integer.parseInt(req.getParameter("boardId"));
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
                starredBoardByBoardId (req, resp);
                break;
            default:
                setTimestampToBoard (req);
                showDetailBoard (req, resp);
                break;
        }
    }

    private void starredBoardByBoardId(HttpServletRequest req, HttpServletResponse resp) {
        int boardId = Integer.parseInt((String) req.getSession().getAttribute("boardId"));
        User user = (User) req.getSession().getAttribute("user");
        boolean boardStarredStatus = Boolean.parseBoolean(req.getParameter("boardStarredStatus"));
        boardService.changeStarredBoard(user.getUserId(), boardId, boardStarredStatus);
    }

    private void setTimestampToBoard(HttpServletRequest req) {
        User user = (User) req.getSession().getAttribute("user");
        int boardId = Integer.parseInt((String) req.getSession().getAttribute("boardId"));
        boardService.saveTimestampToBoard(user.getUserId(), boardId);
    }


    private void showDetailBoard(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        int groupId = Integer.parseInt((String) session.getAttribute("groupId"));
        int boardId = Integer.parseInt((String) session.getAttribute("boardId"));
        req.setAttribute("groupInfo", groupService.getGroupInfoById(groupId));
        req.setAttribute("boards", boardService.getAllBoardInGroup(groupId, true));
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