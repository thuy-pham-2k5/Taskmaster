<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Taskmaster - Đăng ký</title>
    <link rel="stylesheet" href="/css/authenticate/register.css">
</head>
<body>
<div class="container">
    <div class="register-box">
        <div class="logo">
            <img src="images/logo.png" alt="Taskmaster Logo">
            <span class="logo-text">Taskmaster</span>
        </div>
        <h2>Đăng ký để tiếp tục</h2>
        <c:if test="${not empty message}">
            <label style=" display: block; padding: 10px; border-radius: 5px; color: red; background-color: #f7ebbe;">${message}</label>
        </c:if>
        <form action="/authenticate?action=register" method="post">
            <input type="text" id="fullName" name="full-name" placeholder="Họ và tên..." required>
            <input type="email" name="email" placeholder="Email..." required>
            <input type="password" id="password" name="password" pattern=".{7,}"
                   title="Mật khẩu yếu, vui lòng sử dụng mật khẩu lớn hơn 6 ký tự" placeholder="Mật khẩu..." required>
            <input type="password" id="re_password" name="re_password" placeholder="Nhập lại mật khẩu..." required>
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

<script>
    const password = document.getElementById('password');
    const rePassword = document.getElementById('re_password');

    function validatePassword() {
        if (password.value !== rePassword.value) {
            rePassword.setCustomValidity("Mật khẩu nhập lại không khớp");
        } else {
            rePassword.setCustomValidity("");
        }
    }

    rePassword.addEventListener('input', validatePassword);
    password.addEventListener('input', validatePassword);

    $(document).on('click', '.toggle-password', function () {
        var input = $('#password');
        if (input.attr('type') === 'password') {
            input.attr('type', 'text');
            $(this).find('i').removeClass('fa-eye').addClass('fa-eye-slash');
        } else {
            input.attr('type', 'password');
            $(this).find('i').removeClass('fa-eye-slash').addClass('fa-eye');
        }
    });
</script>

</body>
</html>
