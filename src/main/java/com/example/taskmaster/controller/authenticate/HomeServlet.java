package com.example.taskmaster.controller.authenticate;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/home")
public class HomeServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/view/authenticate/home_taskmaster.jsp").forward(request, response);
//        String action=request.getParameter("action");
//        if(action==null){action="";}
//        switch (action){
//            case "register.css":response.sendRedirect("/sign-up");
//            case "login":response.sendRedirect("/sign-in");
//            case "logout":
//            default:
//                response.sendRedirect("/view/authenticate/home_taskmaster.css.jsp");
//        }
    }
}
