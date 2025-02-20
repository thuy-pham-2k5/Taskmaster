package com.example.taskmaster.controller.authenticate;

import com.example.taskmaster.model.User;
import com.example.taskmaster.service.authenticate.AuthenticateService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(value = "/authenticate")
public class AuthenticateServlet extends HttpServlet {
    AuthenticateService authenticateService = new AuthenticateService();
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null)
            action = "";
        switch (action) {
            case "register":
                request.getRequestDispatcher("/view/authenticate/register.jsp").forward(request, response);
                break;
            case "login":
                request.getRequestDispatcher("/view/authenticate/login.jsp").forward(request, response);
                break;
            case "logout":
            default:
                request.getRequestDispatcher("/view/authenticate/home_taskmaster.jsp").forward(request, response);
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

    private void login (HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        if (authenticateService.signIn(email, password)) {
            request.getRequestDispatcher("/view/groups/home_workspace.jsp").forward(request, response);
        } else {
            request.setAttribute("message", "Địa chỉ email hoặc mật khẩu không đúng. Hãy đặt lại mật khẩu nếu bạn quên mật khẩu");
            request.getRequestDispatcher("/view/authenticate/login.jsp").forward(request, response);
        }
    }

    private void register (HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String fullName = request.getParameter("fullName");
        User user = new User(email, password, fullName);
        System.out.println(user);
        if (authenticateService.signUp(user)) {
            session.setAttribute("user", authenticateService.getUserByEmail(email));
            request.getRequestDispatcher("/view/groups/home_workspace.jsp").forward(request, response);    // chuyển trang sau khi đăng ký thành công
        } else {
            request.setAttribute("message", "Có vẻ như bạn đã có một tài khoản được liên kết với email này. Hãy đăng nhập thay thế hoặc đặt lại mật khẩu nếu bạn quên mật khẩu.");
            request.getRequestDispatcher("/view/authenticate/login.jsp").forward(request, response);
        }
    }
}
