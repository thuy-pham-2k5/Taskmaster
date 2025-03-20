package com.example.taskmaster.controller.user.group;

import com.example.taskmaster.model.Permission;
import com.example.taskmaster.model.User;
import com.example.taskmaster.service.permission.IPermissionService;
import com.example.taskmaster.service.permission.PermissionService;
import com.example.taskmaster.service.user.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet (value = "/group_setting")
public class GroupSettingServlet extends HttpServlet {
    IBoardService boardService = new BoardService();
    IGroupService groupService = new GroupService();
    IPermissionService permissionService = new PermissionService();
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
        int groupId = (Integer) req.getSession().getAttribute("groupId");
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
        User user = (User) req.getSession().getAttribute("user");
        int groupId = (Integer) req.getSession().getAttribute("groupId");
        List<Permission> permissions = permissionService.getAllMyPermissionInGroup(user.getUserId(), groupId);
        System.out.println(permissions);
        req.getSession().setAttribute("groupPermissions", permissions);
        req.getSession().setAttribute("boardJoined", boardService.getAllBoardInGroupJoined(groupId, user.getUserId()));
        req.setAttribute("boards", boardService.getAllBoardInGroup(groupId, "option1"));
        req.getRequestDispatcher("/view/user/group/setting_workspace.jsp").forward(req, resp);
    }
}
