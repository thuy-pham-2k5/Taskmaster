package com.example.taskmaster.controller.user.group;

import com.example.taskmaster.model.Board;
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
import java.util.List;

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
            case "createGroup":
                createNewGroup(request, response);
                break;
            default:
                break;
        }
    }

    protected void createNewGroup(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
//        HttpSession session = request.getSession();
//        Integer userId = (Integer) session.getAttribute("userId");

        String title = request.getParameter("nameSp");
        System.out.println(title);
        String describe = request.getParameter("describe");
        System.out.println(describe);
        int userId = 5;
        System.out.println(userId);
        Group group = new Group(title, describe);
        groupService.createGroup(group, userId);
        request.setAttribute("title", title);
        request.setAttribute("describe", describe);
        request.getRequestDispatcher("/view/groups/homeWorkspace.jsp").forward(request, response);
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
        System.out.println(boardService.searchBoardsByName((int) session.getAttribute("groupId"), keyword));
        request.getRequestDispatcher("view/user/group/home_workspace.jsp").forward(request, response);
    }

    private void sortTypeListBoards(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String sortType = request.getParameter("mySelect");
        if (sortType.equals("option1")) {
            response.sendRedirect("group_home");
        } else {
            HttpSession session = request.getSession();
            int groupId = (int) session.getAttribute("groupId");
            List<Board> boards = boardService.getAllBoardInGroup(groupId, false);
            request.setAttribute("boards", boards);
            System.out.println(boardService.getAllBoardInGroup(groupId, false));
            request.getRequestDispatcher("view/authenticate/login.jsp").forward(request, response);
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
        request.setAttribute("closedBoards", boardService.getAllBoardClosedInGroup((int) session.getAttribute("groupId")));
        System.out.println(boardService.getAllBoardClosedInGroup((int) session.getAttribute("groupId")));

        request.getRequestDispatcher("/view/user/group/home_workspace.jsp").forward(request, response);
    }
}
