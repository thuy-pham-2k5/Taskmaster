package com.example.taskmaster.controller.user.board;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(value = "/board")
public class BoardServlet extends HttpServlet{
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        System.out.println(action);
        if (action == null)
            action = "";
        switch (action) {
            case "create":
               resp.sendRedirect("/view/user/board/create_board.jsp");
                break;
            case "task":
                break;
            default:
                req.getRequestDispatcher("/view/user/board/board.jsp").forward(req, resp);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null)
            action = "";
        switch (action) {
            case "create":
                createBoard(req, resp);
                break;
            case "task":
                break;
            default:
                req.getRequestDispatcher("/view/user/board/board.jsp").forward(req, resp);
                break;
        }
    }

    public void createBoard (HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

    }
}
