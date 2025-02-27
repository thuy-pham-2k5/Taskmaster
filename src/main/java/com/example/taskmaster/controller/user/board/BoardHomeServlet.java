package com.example.taskmaster.controller.user.board;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet (value = "/board_home")
public class BoardHomeServlet extends HttpServlet {
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
        String boardId = req.getParameter("boardId");
        System.out.println(boardId);
        req.getRequestDispatcher("/view/user/board/board_detail.jsp").forward(req, resp);
    }
}
