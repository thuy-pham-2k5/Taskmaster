<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Đăng nhập - Taskmaster</title>
    <link rel="stylesheet" href="/css/authenticate/login.css">
</head>
<body>
<div class="login-box">
    <div class="logo-container">
        <img src="image/logo.png" alt="Taskmaster" class="logo">
        <span class="logo-text">Taskmaster</span>
    </div>
    <h2>Đăng nhập để tiếp tục</h2>
    <form action="login" method="post">
        <input type="email" name="email" placeholder="Email....." required>
        <input type="password" name="password" placeholder="Mật khẩu....." required>
        <button type="submit">Đăng nhập</button>
    </form>

    <p class="register-link">
        <a href="#">Bạn chưa có tài khoản? <span>Đăng ký</span></a>
    </p>
</div>
</body>
</html>
