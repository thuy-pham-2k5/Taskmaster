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
        int boardId = Integer.parseInt(req.getParameter("boardId"));
        User user = (User) req.getSession().getAttribute("user");
        boolean boardStarredStatus = Boolean.parseBoolean(req.getParameter("boardStarredStatus"));
        boardService.changeStarredBoard(user.getUserId(), boardId, boardStarredStatus);
    }

    private void setTimestampToBoard(HttpServletRequest req) {
        User user = (User) req.getSession().getAttribute("user");
        int boardId = Integer.parseInt(req.getParameter("boardId"));
        boardService.saveTimestampToBoard(user.getUserId(), boardId);
    }


    private void showDetailBoard(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        int groupId = Integer.parseInt((String) session.getAttribute("groupId"));
        int boardId = Integer.parseInt(req.getParameter("boardId"));
        req.setAttribute("groupInfo", groupService.getGroupInfoById(groupId));
        req.setAttribute("boards", boardService.getAllBoardInGroup(groupId, true));
        req.setAttribute("boardDetail", boardService.getBoardById(boardId));
        req.setAttribute("boardId", boardId);
        List<Column> columns = columnService.getAllColumn(boardId);
        Map<Integer, List<Task>> tasks = taskService.getAllTask(taskService.getAllColumnId(boardId));
//        String columnsJson = new Gson().toJson(columns);
//        String tasksJson = new Gson().toJson(tasks);
        req.setAttribute("columns", columns);
        req.setAttribute("tasks", tasks);
        req.getRequestDispatcher("/view/user/board/detail_board.jsp").forward(req, resp);
    }
}