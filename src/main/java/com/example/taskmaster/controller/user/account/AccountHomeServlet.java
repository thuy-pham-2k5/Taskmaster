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
import java.util.List;
import java.util.Map;

@WebServlet (value = "/account_home")
public class AccountHomeServlet extends HttpServlet {
    IGroupService groupService = new GroupService();
    IBoardService boardService = new BoardService();
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) action = "";
        switch (action) {
            case "showSettingViewInGroupHome":
                redirectToPage (req, resp, "group_setting");
                break;
            case "showMemberViewInGroupHome":
                redirectToPage (req, resp, "group_member");
                break;
            case "showGroupHomeView":
                redirectToPage (req, resp, "group_home");
                break;
            default:
                getAllTitleGroup(req, resp);
                break;
        }
    }

    private void redirectToPage(HttpServletRequest req, HttpServletResponse resp, String namePage) throws IOException {
        HttpSession session = req.getSession();
        int groupId = Integer.parseInt(req.getParameter("groupId"));
        session.setAttribute("groupId", groupId);
        session.setAttribute("groupInfo", groupService.getGroupInfoById(groupId));
        resp.sendRedirect(namePage);
    }

    private void getAllTitleGroup(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        List<Group> titleGroupList = groupService.getTitleGroupByUserId(user.getUserId());
        List<Board> starredBoards = groupService.getGroupRecentOrStarred(user.getUserId(), "starred");
        List<Board> recentBoards = groupService.getGroupRecentOrStarred(user.getUserId(), "recent");
        Map<Integer, List<Board>> listBoards = groupService.getListBoardOfGroup(titleGroupList);
        session.setAttribute("starredBoards", starredBoards);
        session.setAttribute("recentBoards", recentBoards);
        session.setAttribute("groups", titleGroupList);
        request.setAttribute("listBoards", listBoards);
        System.out.println(listBoards);
        request.getRequestDispatcher("view/user/account/home_account.jsp").forward(request, response);
    }
}
