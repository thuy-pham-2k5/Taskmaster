<%--
  Created by IntelliJ IDEA.
  User: tranz_quyzn
  Date: 17/02/2025
  Time: 2:53 CH
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Taskmaster - Đăng ký</title>
    <link rel="stylesheet" href="css/register.css">
</head>
<body>
<div class="container">
    <div class="register-box">
        <div class="logo">
            <img src="image/logo.png" alt="Taskmaster Logo">
            <span class="logo-text">Taskmaster</span>
        </div>
        <h2>Đăng ký để tiếp tục</h2>
        <form action="RegisterServlet" method="post">
            <input type="text" name="fullname" placeholder="Họ và tên....." required>
            <input type="email" name="email" placeholder="Email....." required>
            <input type="password" name="password" placeholder="Mật khẩu....." required>
            <div class="checkbox">
                <input type="checkbox" id="agree" required>
                <label for="agree">Tôi đồng ý với điều khoản dịch vụ và chính sách quyền riêng tư của Taskmaster
                    Cloud</label>
            </div>
            <button type="submit">Đăng ký</button>
        </form>

        <p class="login-link">
            <a href="#">Bạn đã có tài khoản? <span>Đăng nhập</span></a>
        </p>
    </div>
</div>
</body>
</html>
