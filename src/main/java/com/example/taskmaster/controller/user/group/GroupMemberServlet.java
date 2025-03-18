package com.example.taskmaster.controller.user.group;

import com.example.taskmaster.model.User;
import com.example.taskmaster.service.authenticate.AuthenticateService;
import com.example.taskmaster.service.user.*;
import com.google.gson.Gson;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet(value = "/group_member")
public class GroupMemberServlet extends HttpServlet {
    AuthenticateService authenticateService = new AuthenticateService();
    IUserService userService = new UserService();
    IBoardService boardService = new BoardService();
    IGroupService groupService = new GroupService();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) action = "";
        switch (action) {
            case "inviteMember":
                inviteMemberInGroup(req, resp);
                break;
            default:
                break;
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) action = "";
        switch (action) {
            default:
                showGroupMember(req, resp);
                break;
        }
    }

    private void inviteMemberInGroup(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String email = request.getParameter("email");
        User user = authenticateService.getUserByEmail(email);
        int groupId = (Integer) request.getSession().getAttribute("groupId");
        Map<String, Object> info = new HashMap<>();
        String result;
        if (user != null) {
            if (groupService.getUserInGroupByUserId(user.getUserId(), groupId)) {
                result = "added";
            } else {
                boolean success = groupService.inviteMember(user.getUserId(), groupId, 4);
                result = success ? "success" : "false";
                info.put("infoNewMember", authenticateService.getUserByEmail(email));
            }
        } else {
            result = "not exist";
        }
        info.put("result", result);
        String resultJson = new Gson().toJson(info);
        System.out.println(resultJson);
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(resultJson);
    }

    private void showGroupMember(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int groupId = (Integer) req.getSession().getAttribute("groupId");
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
