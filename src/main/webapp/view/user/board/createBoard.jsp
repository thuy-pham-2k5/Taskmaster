<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <title>Task Management</title>
    <link rel="stylesheet" href="../../css/user/board/createBoard.css">
    <script src="../../../js/board/createBoard.js"></script>
</head>
<body>
<div class="container">
    <div>
        <h1 style="text-align: center; color: white">Tạo Bảng Mới</h1>
    </div>

    <div class="wallpaper-form">
        <img src="../../image/imageCreateBoard.png" alt="imageCreateBoard">
    </div>

    <div style="margin-bottom: 5px">
        <p style="color: white">Phông nền</p>
    </div>

    <div id="wallPaper1" style="display: flex; justify-content: center;">
        <c:forEach var="i" begin="1" end="3">
            <div class="wallpaper-item">
                <img class="wallpaper-img" src="../../image/imageWallpaper${i}.png" alt="imageWallpaper${i}">
                <div class="overlay"></div>
            </div>
        </c:forEach>
        <div class="more-options">...</div>
    </div>

    <div>
        <p style="color: white">Tiêu đề bảng *</p>
    </div>

    <div>
        <input class="information-form" type="text" name="title" required>
    </div>
    <div>
        <p style="color: white; font-size: 10px; margin-top: 0; margin-left: 5px">Tiêu đề của bảng là bắt
            buộc.</p>
    </div>

    <div>
        <p style="color: white">Không gian làm việc *</p>
    </div>

    <div>
        <select class="spaceWork-form" name="Không gian làm việc">
            <option value="1">Quản lý không gian làm việc Taskmaster.</option>
            <option value="2">Các không gian làm việc.</option>
        </select>
    </div>

    <div>
        <p style="color: white">Quyền xem *</p>
    </div>

    <div class="custom-select">
        <div class="selected-option">
            <span>Không gian làm việc</span>
            <i class="bi bi-caret-down-fill"></i>
        </div>
        <div class="options">
            <div class="option" data-value="private">
                <strong>Riêng tư</strong>
                <p>Chỉ thành viên bảng thông tin mới có quyền xem bảng này.</p>
            </div>
            <div class="option selected" data-value="workspace">
                <strong>Không gian làm việc</strong>
                <p>Tất cả thành viên của Không gian làm việc có thể xem.</p>
            </div>
            <div class="option" data-value="public">
                <strong>Công khai</strong>
                <p>Bất kỳ ai trên internet đều có thể xem.</p>
            </div>
        </div>
    </div>

    <a href="">
        <button type="submit" name="addColumn">Tạo mới</button>
    </a>
    <button type="submit" name="createTable">Bắt đầu với Mẫu</button>
</div>
</body>
</html>
