package com.example.taskmaster.controller.user.board;

import com.example.taskmaster.model.Group;
import com.example.taskmaster.model.User;
import com.example.taskmaster.service.user.BoardService;
import com.example.taskmaster.service.user.GroupService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet (value = "/board_home")
public class BoardHomeServlet extends HttpServlet {
    GroupService groupService = new GroupService();
    BoardService boardService = new BoardService();
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) action = "";
        switch (action) {
            default:
                showDetailBoard (req, resp);
                break;
        }
    }

    private void showDetailBoard(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        int groupId = (Integer) session.getAttribute("groupId");
        System.out.println(groupId);
        req.setAttribute("groupInfo", groupService.getGroupInfoById(groupId));
        req.setAttribute("boards", boardService.getAllBoardInGroup(groupId, true));
        req.setAttribute("boardId", req.getParameter("boardId"));
        req.getRequestDispatcher("/view/user/board/board_detail.jsp").forward(req, resp);
    }
}
