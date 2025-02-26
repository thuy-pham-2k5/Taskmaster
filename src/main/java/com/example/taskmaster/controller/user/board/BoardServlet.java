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
                req.getRequestDispatcher("/view/user/board/deleteBoard.jsp").forward (req, resp);
            default:
                break;
        }
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
                case "deleteBoard":
                    deleteBoardById (req, resp);
                    break;
            case "task":
                break;
            case "board":
                break;
        }
    }

    public void createBoard (HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html; charset=UTF-8");
        String boardName = req.getParameter("title");
        System.out.println(boardName);
        int backgroundId = 1;
        HttpSession session = req.getSession();
        System.out.println(session.getAttribute("groupId"));
        int groupId = Integer.parseInt( session.getAttribute("groupId").toString());
        Board board = new Board(boardName, backgroundId , groupId);
        boardService.createBoard(board);
    }
    private void deleteBoardById(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        try {
            // Lấy boardId từ request
            String boardIdParam = req.getParameter("boardId");
            if (boardIdParam == null || boardIdParam.isEmpty()) {
                resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Board ID is required.");
                return;
            }

            int boardId = Integer.parseInt(boardIdParam);
            // Xóa board
            boolean isDeleted = boardService.deleteBoard(boardId);
            if (!isDeleted) {
                resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Failed to delete board.");
                return;
            }
            // Xóa thành công -> Chuyển hướng về trang group_home
            resp.sendRedirect("group_home");

        } catch (NumberFormatException e) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid Board ID.");
        } catch (Exception e) {
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "An unexpected error occurred.");
        }
    }

}
