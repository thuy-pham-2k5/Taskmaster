package com.example.taskmaster.controller.authenticate;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(value = "/authenticate")
public class AuthenticateServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null)
            action = "";
        switch (action) {
            case "register":
                response.sendRedirect("/view/authenticate/register.jsp");
                break;
            case "login":
                response.sendRedirect("/view/authenticate/login.jsp");
                break;
            case "logout":
            default:
                response.sendRedirect("/view/authenticate/home_taskmaster.jsp");
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action==null)
            action = "";
        switch (action) {
            case "register":
                register (request, response);
                break;
            case "login":
                login (request, response);
                break;
            case "logout":
                logout (request, response);
                break;
            default:
                break;
        }
    }

    private void logout (HttpServletRequest request, HttpServletResponse response) {

    }

    private void login (HttpServletRequest request, HttpServletResponse response) {

    }

    private void register (HttpServletRequest request, HttpServletResponse response) {
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String fullName = request.getParameter("fullName");

    }
}
