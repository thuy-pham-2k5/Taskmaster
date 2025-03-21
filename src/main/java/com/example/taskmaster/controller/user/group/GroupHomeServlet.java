package com.example.taskmaster.controller.user.group;

import com.example.taskmaster.model.Board;
import com.example.taskmaster.model.Group;
import com.example.taskmaster.model.Permission;
import com.example.taskmaster.model.User;
import com.example.taskmaster.service.authenticate.AuthenticateService;
import com.example.taskmaster.service.permission.IPermissionService;
import com.example.taskmaster.service.permission.PermissionService;
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
    IPermissionService permissionService = new PermissionService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        String action = request.getParameter("action");
        System.out.println(action);
        if (action == null)
            action = "";
        switch (action) {
            case "createGroup":
                createNewGroup(request, response);
                break;
            case "editInfoGroup":
                editInfoGroup(request, response);
                break;
            default:
                break;
        }
    }

    private void editInfoGroup(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession();

        try {
            int groupId = (Integer) session.getAttribute("groupId");
            String title = request.getParameter("title");
            String short_title = request.getParameter("short_title");
            String description = request.getParameter("description");

            System.out.println(groupId);
            System.out.println(title);
            System.out.println(short_title);
            System.out.println(description);
            // Cập nhật dữ liệu nhóm
            groupService.updateGroup(groupId, new Group(short_title, title, "https://trello.com/b/KX3U0lwT/backlog-sprint", description));

            // Lấy lại dữ liệu mới từ database
            Group updatedGroup = groupService.getGroupInfoById(groupId);
            session.setAttribute("groupInfo", updatedGroup);
            String groupJson = new Gson().toJson(updatedGroup);
            response.getWriter().write(groupJson);
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().print("{\"success\": false, \"message\": \"Có lỗi xảy ra khi cập nhật nhóm!\"}");
        }
    }

    protected void createNewGroup(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        User user = (User) request.getSession().getAttribute("user");
        String title = request.getParameter("title");
        String description = request.getParameter("description");
        groupService.createGroup(new Group(title, description), user.getUserId());
        Group group = groupService.getGroupInfoByShortTitle(null);
        request.getSession().setAttribute("groupId", group.getGroupId());
        request.getSession().setAttribute("groupInfo", group);
        response.sendRedirect("/group_home");
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
            case "showCreateGroup":
                response.sendRedirect("/view/user/group/create_workspace.jsp");
                break;
            case "getClosedBoards":
                showClosedBoards (request, response);
                break;
            default:
                showGroupInfo(request, response);
                break;
        }
    }

    private void showClosedBoards(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int groupId = (Integer) request.getSession().getAttribute("groupId");
        List<Board> closedBoard = boardService.getAllBoardClosedInGroup(groupId);
        String closedBoardJson = new Gson().toJson(closedBoard);
        System.out.println(closedBoard);
        System.out.println(closedBoardJson);
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(closedBoardJson);
    }

    private void switchToBoardView(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            int groupId = Integer.parseInt(request.getParameter("groupId"));
            System.out.println(groupId);
            request.getSession().setAttribute("groupId", groupId);
            request.getSession().setAttribute("groupInfo", groupService.getGroupInfoById(groupId));
        } catch (NumberFormatException | NullPointerException e) {
            // Không làm gì, groupId vẫn giữ giá trị -1 nếu lỗi
        }
        int boardId = Integer.parseInt(request.getParameter("boardId"));
        request.getSession().setAttribute("boardId", boardId);
        response.sendRedirect("board_home");
    }

    private void sortTypeListBoards(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Board> boards;
        String sortType = request.getParameter("option");
        int groupId = (Integer) request.getSession().getAttribute("groupId");
        System.out.println(sortType);
        boards = boardService.getAllBoardInGroup(groupId, sortType);
        String boardsJson = new Gson().toJson(boards);
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(boardsJson);
    }


    private void showGroupInfo(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        int groupId = (Integer) session.getAttribute("groupId");
        int roleId = userService.getRoleUserInGroup(user.getUserId(), groupId);
        List<Permission> permissions = permissionService.getAllMyPermissionInGroup(user.getUserId(), groupId);
        System.out.println(permissions);
        session.setAttribute("groupPermissions", permissions);
        request.setAttribute("closedBoards", boardService.getAllBoardClosedInGroup(groupId));
        session.setAttribute("boardJoined", boardService.getAllBoardInGroupJoined(groupId, user.getUserId()));
        request.setAttribute("roleIdUser", roleId);
        request.setAttribute("boards", boardService.getAllBoardInGroup(groupId, "option1"));
        request.getRequestDispatcher("/view/user/group/home_workspace.jsp").forward(request, response);
    }
}
