package com.example.taskmaster.controller.user.board;

import com.example.taskmaster.model.User;
import com.example.taskmaster.service.user.BoardService;
import com.google.gson.Gson;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(value = "/board")
public class BoardServlet extends HttpServlet {
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
                req.getRequestDispatcher("/view/user/board/board_detail.jsp").forward(req, resp);
                break;
            case "deleteBoard":
                req.getRequestDispatcher("/view/user/board/deleteBoard.jsp").forward(req, resp);
            case "back":
                resp.sendRedirect("group_home");
                break;
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
                break;
            case "deleteBoard":
                deleteBoardById(req, resp);
                break;
            case "task":
                break;
            case "board":
                break;
        }
    }

    public void createBoard(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html; charset=UTF-8");

        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");
        int groupId = (Integer) session.getAttribute("groupId");
        String selectedImageLink = req.getParameter("selectedWallpaper");
        if (selectedImageLink == null || selectedImageLink.isEmpty()) {
            selectedImageLink = req.getParameter("selectedImage");
        }
        System.out.println("Ảnh được chọn: " + selectedImageLink);

        String boardName = req.getParameter("title");

        if (boardName == null || boardName.trim().isEmpty()) {
            resp.getWriter().println("Tiêu đề bảng không được để trống.");
            return;
        }

        if (selectedImageLink == null || selectedImageLink.trim().isEmpty()) {
            selectedImageLink = "https://default-image.com/default.jpg"; // Ảnh mặc định nếu không chọn gì
        }

        boardService.createBoard(user.getUserId(), boardName, groupId, selectedImageLink);
        resp.sendRedirect("group_home");
    }


    private void deleteBoardById(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        int boardId = Integer.parseInt(req.getParameter("boardId"));
        boolean success = boardService.deleteBoard(boardId);
        String successJson  = new Gson().toJson(success);
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        resp.getWriter().write(successJson);
    }

}
