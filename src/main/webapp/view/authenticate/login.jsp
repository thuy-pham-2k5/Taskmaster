<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Đăng nhập - Taskmaster</title>
    <link rel="stylesheet" href="css/login.css">
</head>
<body><div class="login-box">
    <div class="logo-container">
        <img src="image/image 11.png" alt="Taskmaster" class="logo">
        <h3>Taskmaster</h3>
    </div>
    <h5>Đăng nhập để tiếp tục</h5>
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
