package com.example.taskmaster.controller.user.group;

import com.example.taskmaster.model.Group;
import com.example.taskmaster.model.User;
import com.example.taskmaster.service.user.GroupService;
import com.example.taskmaster.service.user.IGroupService;
import com.example.taskmaster.service.user.IUserService;
import com.example.taskmaster.service.user.UserService;

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
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        String action = request.getParameter("action");
        if (action==null)
            action = "";
        switch (action) {
            default:
                showGroupInfo (request, response);
                break;
        }
    }

    private void showGroupInfo(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        int groupId = userService.getGroupByUserId(user.getUserId());
        int roleId = userService.getRoleUserInGroup(user.getUserId(), groupId);
        request.setAttribute("roleIdUser", roleId);
        request.setAttribute("groupInfo", groupService.getGroupInfoById(groupId));

        System.out.println(groupId);
        System.out.println(roleId);
        System.out.println(groupService.getGroupInfoById(groupId));

        request.getRequestDispatcher("/view/user/group/home_workspace.jsp").forward(request, response);
    }
}
