package com.example.taskmaster.controller.user.group;

import com.example.taskmaster.model.User;
import com.example.taskmaster.service.user.BoardService;
import com.example.taskmaster.service.user.IBoardService;
import com.example.taskmaster.service.user.IUserService;
import com.example.taskmaster.service.user.UserService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet (value = "/group_member")
public class GroupMemberServlet extends HttpServlet {
    IUserService userService = new UserService();
    IBoardService boardService = new BoardService();
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) action = "";
        switch (action) {
            default:
                break;
        }
    }
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action==null) action = "";
        switch (action) {
            default:
                showGroupMember (req, resp);
                break;
        }
    }

    private void showGroupMember(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int groupId = Integer.parseInt((String) req.getSession().getAttribute("groupId"));
        List<User> members = userService.getAllMemberGroup(groupId);
        List<User> guests = userService.getAllGuestGroup(groupId);
        List<User> requests = userService.getAllRequestToJoinGroup(groupId);
        req.setAttribute("boards", boardService.getAllBoardInGroup(groupId, true));
        req.setAttribute("members", members);
        req.setAttribute("guests", guests);
        req.setAttribute("requests", requests);
        req.getRequestDispatcher("/view/user/group/member_workspace.jsp").forward(req, resp);
    }
}
