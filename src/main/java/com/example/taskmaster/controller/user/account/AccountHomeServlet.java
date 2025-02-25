package com.example.taskmaster.controller.user.account;

import com.example.taskmaster.model.Group;
import com.example.taskmaster.model.User;
import com.example.taskmaster.service.user.GroupService;
import com.example.taskmaster.service.user.IGroupService;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet (value = "/account_home")
public class AccountHomeServlet extends HttpServlet {
    IGroupService groupService = new GroupService();
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) action = "";
        switch (action) {
            case "showSettingViewInGroupHome":
                showSettingViewInGroupHome (req, resp);
            case "showMemberViewInGroupHome":
                showMemberViewInGroupHome (req, resp);
                break;
            case "showGroupHomeView":
                showGroupHomeViewById (req, resp);
                break;
            default:
                getAllTitleGroup(req, resp);
                break;
        }
    }

    private void showSettingViewInGroupHome(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        HttpSession session = req.getSession();
        session.setAttribute("groupId", req.getParameter("groupId"));
        resp.sendRedirect("group_home?action=settingView");
    }

    private void showMemberViewInGroupHome(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        HttpSession session = req.getSession();
        session.setAttribute("groupId", req.getParameter("groupId"));
        resp.sendRedirect("group_home?action=memberView");
    }

    private void showGroupHomeViewById(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        HttpSession session = req.getSession();
        session.setAttribute("groupId", req.getParameter("groupId"));
        resp.sendRedirect("group_home");
    }

    private void getAllTitleGroup(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        List<Group> titleGroupList = groupService.getTitleGroupByUserId(user.getUserId());
        request.setAttribute("groups", titleGroupList);
        request.getRequestDispatcher("view/user/account/home_account.jsp").forward(request, response);
    }
}
