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
            if (passwordField.type === "password") {
                passwordField.type = "text";
            } else {
                passwordField.type = "password";
            }
        }
    </script>
</head>
<body>
<div class="login-box">
    <div class="logo-container">
        <img src="image/logo.png" alt="Taskmaster" class="logo">
        <span class="logo-text">Taskmaster</span>
    </div>
    <h2>Đăng nhập để tiếp tục</h2>
    <c:if test="${not empty message}">
        <label>${message}</label>
    </c:if>
    <form action="/authenticate?action=login" method="post">
        <input type="email" name="email" placeholder="Email....." required>
        <div class="password-container">
            <input type="password" id="password" name="password" placeholder="Mật khẩu....." required>
            <span class="toggle-password" onclick="togglePasswordVisibility()">👁️</span>
        </div>
        <button type="submit">Đăng nhập</button>
    </form>

    <p class="register-link">
        <a href="/authenticate?action=register">Bạn chưa có tài khoản? <span>Đăng ký</span></a>
    </p>
</div>
</body>
</html>
