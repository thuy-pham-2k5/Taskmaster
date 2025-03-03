package com.example.taskmaster.controller.user.group;

import com.example.taskmaster.service.user.GroupService;
import com.example.taskmaster.service.user.IGroupService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet (value = "/group_setting")
public class GroupSettingServlet extends HttpServlet {
    IGroupService groupService = new GroupService();
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) action = "";
        switch (action) {
            default:
                break;
        }
    }

    private void deleteGroupById(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        int groupId = Integer.parseInt((String) req.getSession().getAttribute("groupId"));
        groupService.deleteGroup(groupId);
        resp.sendRedirect("/account_home");
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action==null) action = "";
        switch (action) {
            case "deleteGroup":
                deleteGroupById (req, resp);
                break;
            default:
                showGroupSetting (req, resp);
                break;
        }
    }

    private void showGroupSetting(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/view/user/group/setting_workspace.jsp").forward(req, resp);
    }
}
