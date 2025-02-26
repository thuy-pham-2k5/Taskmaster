package com.example.taskmaster.controller.user.board;

import com.example.taskmaster.model.Board;
import com.example.taskmaster.service.user.BoardService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(value = "/board")
public class BoardServlet extends HttpServlet{
    BoardService boardService = new BoardService();
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html; charset=UTF-8");
        String action = req.getParameter("action");
        System.out.println(action);
        if (action == null)
            action = "";
        switch (action) {
            case "create":
               req.getRequestDispatcher("/view/user/board/createBoard.jsp").forward(req, resp);
                break;
            case "task":
                break;
            case "board":
                req.getRequestDispatcher("/view/user/board/board.jsp").forward(req, resp);
                break;
            case "deleteBoard":
                deleteBoardById (req, resp);
            default:
                break;
        }
    }

    private void deleteBoardById(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        int boardId = Integer.parseInt(req.getParameter("boardId"));
        boardService.deleteBoard(boardId);
        resp.sendRedirect("group_home");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html; charset=UTF-8");
        String action = req.getParameter("action");
        if (action == null)
            action = "";
        switch (action) {
            case "create":
                createBoard(req, resp);
                resp.sendRedirect("/group_home");
                break;
            case "task":
                break;
            case "board":
                break;
        }
    }

    public void createBoard (HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String boardName = req.getParameter("title");
        int backgroundId = 1;
        HttpSession session = req.getSession();
        int groupId = Integer.parseInt((String)session.getAttribute("groupId"));
        Board board = new Board(boardName, backgroundId , groupId);
        boardService.createBoard(board);
    }
}
