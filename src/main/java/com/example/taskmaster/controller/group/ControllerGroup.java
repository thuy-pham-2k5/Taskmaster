package com.example.taskmaster.controller.group;

import com.example.taskmaster.model.Group;
import com.example.taskmaster.service.authenticate.GroupService;
import com.example.taskmaster.service.authenticate.GroupServiceInterface;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet( value = "/group")
public class ControllerGroup extends HttpServlet {

    GroupServiceInterface groupServiceInterface = new GroupService();
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html; charset=UTF-8");

        String action = req.getParameter("action");
        System.out.println(action);
        if (action == null) {
            action = "";
        }
        switch (action) {
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html; charset=UTF-8");

        String action = req.getParameter("action");
        System.out.println(action);
        if (action == null) {
            action = "";
        }
        switch (action) {
            case "createGroup":
                createNewGroup(req, resp);
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
        groupServiceInterface.createGroup(group, userId);
        request.setAttribute("title", title);
        request.setAttribute("describe", describe);
        request.getRequestDispatcher("/view/groups/homeWorkspace.jsp").forward(request, response);


    }
}
