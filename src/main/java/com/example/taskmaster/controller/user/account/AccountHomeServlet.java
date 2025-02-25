package com.example.taskmaster.controller.user.account;

import com.example.taskmaster.model.Group;
import com.example.taskmaster.model.User;
import com.example.taskmaster.service.user.GroupService;
import com.example.taskmaster.service.user.IGroupService;

import javax.servlet.RequestDispatcher;
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
            default:
                getAllTitleGroup(req, resp);
                break;
        }
    }

    private void getAllTitleGroup(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        List<Group> titleGroupList = groupService.getTitleGroupByUserId(user.getUserId());
        request.setAttribute("titleGroups", titleGroupList);
        request.getRequestDispatcher("view/user/group/home_account.jsp").forward(request, response);
    }
}
