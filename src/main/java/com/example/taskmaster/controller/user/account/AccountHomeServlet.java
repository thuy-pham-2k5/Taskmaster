package com.example.taskmaster.controller.user.account;

import com.example.taskmaster.model.Board;
import com.example.taskmaster.model.Group;
import com.example.taskmaster.model.User;
import com.example.taskmaster.service.user.BoardService;
import com.example.taskmaster.service.user.GroupService;
import com.example.taskmaster.service.user.IBoardService;
import com.example.taskmaster.service.user.IGroupService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

@WebServlet(value = "/account_home")
public class AccountHomeServlet extends HttpServlet {
    IGroupService groupService = new GroupService();
    IBoardService boardService = new BoardService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) action = "";
        switch (action) {
            case "showSettingViewInGroupHome":
                showSettingViewInGroupHome(req, resp);
                break;
            case "showMemberViewInGroupHome":
                showMemberViewInGroupHome(req, resp);
                break;
            case "showGroupHomeView":
                showGroupHomeViewById(req, resp);
                break;
            case "getGroupsByUser":
                try {
                    getGroupsByUser (req, resp);
                } catch (SQLException e) {
                    throw new RuntimeException(e);
                }
                break;
            default:
                getAllTitleGroup(req, resp);
                break;
        }
    }

    private void getGroupsByUser(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException, SQLException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            resp.sendRedirect("login.jsp"); // Nếu chưa đăng nhập, chuyển hướng về trang đăng nhập
            return;
        }

        Map<Group, List<Board>> boardsByGroup = groupService.getBoardsInGroupWithRole(user.getUserId(), 1);
        req.setAttribute("boardsByGroup", boardsByGroup);

        req.getRequestDispatcher("home_account.jsp").forward(req, resp);
    }



    private void showSettingViewInGroupHome(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        HttpSession session = req.getSession();
        int groupId = Integer.parseInt(req.getParameter("groupId"));
        session.setAttribute("groupId", req.getParameter("groupId"));
        session.setAttribute("groupInfo", groupService.getGroupInfoById(groupId));
        resp.sendRedirect("group_home?action=settingView");
    }

    private void showMemberViewInGroupHome(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        HttpSession session = req.getSession();
        int groupId = Integer.parseInt(req.getParameter("groupId"));
        session.setAttribute("groupId", req.getParameter("groupId"));
        session.setAttribute("groupInfo", groupService.getGroupInfoById(groupId));
        resp.sendRedirect("group_home?action=memberView");
    }

    private void showGroupHomeViewById(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        HttpSession session = req.getSession();
        int groupId = Integer.parseInt(req.getParameter("groupId"));
        session.setAttribute("groupId", req.getParameter("groupId"));
        session.setAttribute("groupInfo", groupService.getGroupInfoById(groupId));
        resp.sendRedirect("group_home");
    }

    private void getAllTitleGroup(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        List<Group> titleGroupList = groupService.getTitleGroupByUserId(user.getUserId());
        List<Board> recentBoards = groupService.getStarredOrRecentBoards(user.getUserId(), "recent");
        List<Board> starredBoards = groupService.getStarredOrRecentBoards(user.getUserId(), "starred");
        System.out.println(titleGroupList);
        System.out.println(recentBoards);
        System.out.println(starredBoards);
        session.setAttribute("groups", titleGroupList);
        session.setAttribute("recentBoards", recentBoards);
        session.setAttribute("starredBoards", starredBoards);
        request.getRequestDispatcher("view/user/account/home_account.jsp").forward(request, response);
    }
}
