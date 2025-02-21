package com.example.taskmaster.controller.user.group;

import com.example.taskmaster.model.Group;
import com.example.taskmaster.model.User;
import com.example.taskmaster.service.user.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(value = "/group_home")
public class GroupHomeServlet extends HttpServlet {
    IUserService userService = new UserService();
    IGroupService groupService = new GroupService();
    IBoardService boardService = new BoardService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        String action = request.getParameter("action");
        if (action == null)
            action = "";
        switch (action) {
            default:
                break;
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        String action = request.getParameter("action");
        if (action == null)
            action = "";
        switch (action) {
            case "sortType":
                sortTypeListBoards(request, response);
                break;
            case "search":
                searchBoardByKeyword (request, response);
                break;
            default:
                showGroupInfo(request, response);
                break;
        }
    }

    private void searchBoardByKeyword(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String keyword = request.getParameter("keyword");
        System.out.println(keyword);
        request.setAttribute("boards", boardService.searchBoardsByName((int) session.getAttribute("groupId"), keyword));
        request.getRequestDispatcher("view/user/group/home_workspace.jsp").forward(request, response);
    }

    private void sortTypeListBoards(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String sortType = request.getParameter("mySelect");
        if (sortType.equals("option1")) {
            response.sendRedirect("group_home");
        } else {
            HttpSession session = request.getSession();
            int groupId = (int) session.getAttribute("groupId");
            request.setAttribute("boards", boardService.getAllBoardInGroup(groupId, false));
            request.getRequestDispatcher("/view/user/group/home_workspace.jsp").forward(request, response);
        }
    }

    private void showGroupInfo(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        int groupId = userService.getGroupByUserId(user.getUserId());
        int roleId = userService.getRoleUserInGroup(user.getUserId(), groupId);
        session.setAttribute("groupId", groupId);
        request.setAttribute("roleIdUser", roleId);
        request.setAttribute("groupInfo", groupService.getGroupInfoById(groupId));
        request.setAttribute("boards", boardService.getAllBoardInGroup(groupId, true));
        request.getRequestDispatcher("/view/user/group/home_workspace.jsp").forward(request, response);
    }
}
