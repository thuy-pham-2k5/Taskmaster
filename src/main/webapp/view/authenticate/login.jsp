<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Đăng nhập - Taskmaster</title>
    <link rel="stylesheet" href="/css/authenticate/login.css">
    <script>
        function togglePasswordVisibility() {
            let passwordField = document.getElementById("password");
            let toggleIcon = document.getElementById("togglePassword");

            if (passwordField.type === "password") {
                passwordField.type = "text";
                toggleIcon.src = "images/eye_open.png";
            } else {
                passwordField.type = "password";
                toggleIcon.src = "images/eye_close.png";
            }
        }
    </script>
</head>
<body>
<div class="login-box">
    <div class="logo-container">
        <img src="images/logo.png" alt="Taskmaster" class="logo">
        <span class="logo-text">Taskmaster</span>
    </div>
    <h2>Đăng nhập để tiếp tục</h2>
    <c:if test="${not empty message}">
        <label style=" display: block; padding: 10px; border-radius: 5px; color: red; background-color: #f7ebbe;">${message}</label>
    </c:if>
    <form action="/authenticate?action=login" method="post">
        <input type="email" name="email" placeholder="Email..." required>
        <div class="password-container">
            <input type="password" id="password" name="password" placeholder="Mật khẩu..." required>
            <img src="images/eye_close.png" id="togglePassword" class="toggle-password"
                 onclick="togglePasswordVisibility()" alt="eye">
        </div>
        <p class="forgot-password">
            <a href="/authenticate?action=resetPassword">Quên mật khẩu?</a>
        </p>
        <button type="submit">Đăng nhập</button>
    </form>

    <p class="register-link">
        <a href="/authenticate?action=register">Bạn chưa có tài khoản? <span>Đăng ký</span></a>
    </p>
</div>
</body>
</html>
