<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Taskmaster - Đăng ký</title>
    <link rel="stylesheet" href="/css/authenticate/register.css">
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
<div class="container">
    <div class="register-box">
        <div class="logo">
            <img src="image/logo.png" alt="Taskmaster Logo">
            <span class="logo-text">Taskmaster</span>
        </div>
        <h2>Đăng ký để tiếp tục</h2>
        <form action="RegisterServlet" method="post">
            <input type="text" id="fullName" name="full-name" pattern="\p{L}+\s*\p{L}+"
                   title="Họ và tên không hợp lệ: chỉ chấp nhận chữ cái in hoa và chữ cái thường"
                   placeholder="Họ và tên....." required>
            <input type="email" name="email" placeholder="Email....." required>
            <div class="password-container">
                <input type="password" id="password" name="password" pattern=".{7,}" title="Mật khẩu yếu, vui lòng sử dụng mật khẩu lớn hơn 6 ký tự" placeholder="Mật khẩu....." required>
                <span class="toggle-password" onclick="togglePasswordVisibility()">👁️</span>
            </div>
            <div id="error-message"></div>
            <div class="checkbox">
                <input type="checkbox" id="agree" required>
                <label for="agree">Tôi đồng ý với điều khoản dịch vụ và chính sách quyền riêng tư của Taskmaster
                    Cloud</label>
            </div>
            <button type="submit">Đăng ký</button>
        </form>
        <p class="login-link">
            <a href="/authenticate?action=login">Bạn đã có tài khoản? <span>Đăng nhập</span></a>
        </p>
    </div>
</div>
</body>
</html>
