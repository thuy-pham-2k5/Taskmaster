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
            case "resetPassword":
                request.getRequestDispatcher("/view/authenticate/reset_password.jsp").forward(request, response);
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
        if (action == null)
            action = "";
        switch (action) {
            case "register":
                register(request, response);
                break;
            case "login":
                login(request, response);
                break;
            case "resetPassword":
                resetPassword(request, response);
                break;
            case "logout":
                logout(request, response);
                break;
            default:
                break;
        }
    }

    private void resetPassword(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        if (authenticateService.checkUserByField("email", email)) {
            authenticateService.resetPassword(email, password);
            request.setAttribute("message", "Đổi mật khẩu thành công");
            request.getRequestDispatcher("/view/authenticate/login.jsp").forward(request, response);
        } else {
            request.setAttribute("message", "Email chưa được đăng ký");
            request.getRequestDispatcher("/view/authenticate/reset_password.jsp").forward(request, response);
        }
    }

    private void logout(HttpServletRequest request, HttpServletResponse response) {

    }

    private void login(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        User user = authenticateService.getUserByEmail(email);
        if (user == null) {
            request.setAttribute("message", "Địa chỉ email chưa được đăng ký. Vui lòng đăng ký để tiếp tục");
            request.getRequestDispatcher("/view/authenticate/register.jsp").forward(request, response);
        } else {
            if (authenticateService.signIn(email, password)) {
                session.setAttribute("user", user);
                if (user.getRoleName().equals("User System")) {
                    response.sendRedirect("group_home");
                } else {
                    request.getRequestDispatcher("/view/admin/home_admin.jsp").forward(request, response);
                }
            } else {
                request.setAttribute("message", "Địa chỉ email hoặc mật khẩu không đúng. Hãy đặt lại mật khẩu nếu bạn quên mật khẩu");
                request.getRequestDispatcher("/view/authenticate/login.jsp").forward(request, response);
            }
        }
    }

    private void register(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String fullName = request.getParameter("fullName");
        User user = new User(email, password, fullName);
        System.out.println(user);
        if (authenticateService.signUp(user)) {
            session.setAttribute("user", authenticateService.getUserByEmail(email));
            request.getRequestDispatcher("/view/user/group/home_workspace.jsp").forward(request, response);    // chuyển trang sau khi đăng ký thành công
        } else {
            request.setAttribute("message", "Có vẻ như bạn đã có một tài khoản được liên kết với email này. Hãy đăng nhập thay thế hoặc đặt lại mật khẩu nếu bạn quên mật khẩu.");
            request.getRequestDispatcher("/view/authenticate/login.jsp").forward(request, response);
        }
    }
}