package com.example.taskmaster.controller.user.group;

import com.example.taskmaster.model.Board;
import com.example.taskmaster.model.Group;
import com.example.taskmaster.model.User;
import com.example.taskmaster.service.authenticate.AuthenticateService;
import com.example.taskmaster.service.user.*;
import com.google.gson.Gson;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(value = "/group_home")
public class GroupHomeServlet extends HttpServlet {
    IUserService userService = new UserService();
    IGroupService groupService = new GroupService();
    IBoardService boardService = new BoardService();
    AuthenticateService authenticateService = new AuthenticateService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        String action = request.getParameter("action");
        if (action == null)
            action = "";
        switch (action) {
            case "createGroup":
                createNewGroup(request, response);
                break;
            case "editInfoGroup":
                editInfoGroup(request, response);
                break;
            case "inviteMember":
                inviteMemberInGroup(request, response);
                break;
            default:
                break;
        }
    }

    private void inviteMemberInGroup(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String email = request.getParameter("email");
        User user = authenticateService.getUserByEmail(email);
        HttpSession session = request.getSession();
        int groupId = (int) session.getAttribute("groupId");
        groupService.inviteMember(user.getUserId(), groupId, 4);
        response.sendRedirect("group_home");
    }

    private void editInfoGroup(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession();
        int groupId = (int) session.getAttribute("groupId");
        String title = request.getParameter("title");
        String linkWeb = request.getParameter("linkWeb");
        String description = request.getParameter("description");
        groupService.updateGroup(groupId, new Group(title, linkWeb, description));
        response.sendRedirect("/group_home");
    }

    protected void createNewGroup(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        String title = request.getParameter("title");
        String description = request.getParameter("description");
        groupService.createGroup(new Group(title, description), user.getUserId());
        Group group = groupService.getGroupInfoByTitleAndDescription(title, description);
        int roleId = userService.getRoleUserInGroup(user.getUserId(), group.getGroupId());
        session.setAttribute("groupId", group.getGroupId());
        request.setAttribute("roleIdUser", roleId);
        request.setAttribute("groupInfo", group);
        request.getRequestDispatcher("/view/user/group/home_workspace.jsp").forward(request, response);
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
            case "boardView":
                switchToBoardView(request, response);
                break;
            case "sortType":
                sortTypeListBoards(request, response);
                break;
            case "memberView":
                response.sendRedirect("/group_member");
                break;
            case "settingView":
                response.sendRedirect("/group_setting");
                break;
            default:
                showGroupInfo(request, response);
                break;
        }
    }

    private void switchToBoardView(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String boardId = request.getParameter("boardId");
        response.sendRedirect("/board_home?boardId=" + boardId);
    }

    private void sortTypeListBoards(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Board> boards;
        String sortType = request.getParameter("option");
        int groupId = Integer.parseInt((String) request.getSession().getAttribute("groupId"));
        if (sortType.equals("option1")) {
            boards = boardService.getAllBoardInGroup(groupId, true);
        } else {
            boards = boardService.getAllBoardInGroup(groupId, false);
        }
        String boardsJson = new Gson().toJson(boards);
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(boardsJson);
    }


    private void showGroupInfo(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        int groupId = Integer.parseInt((String) session.getAttribute("groupId"));
        int roleId = userService.getRoleUserInGroup(user.getUserId(), groupId);
        request.setAttribute("roleIdUser", roleId);
        request.setAttribute("groupInfo", groupService.getGroupInfoById(groupId));
        request.setAttribute("boards", boardService.getAllBoardInGroup(groupId, true));
        request.setAttribute("closedBoards", boardService.getAllBoardClosedInGroup(groupId));
        request.getRequestDispatcher("/view/user/group/home_workspace.jsp").forward(request, response);
    }
}
