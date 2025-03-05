<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <title>Task Management</title>
    <link rel="stylesheet" href="../../css/user/board/createBoard.css">
    <script src="../../../js/user/board/createBoard.js"></script>
</head>
<body>
<a href="/group_home"><img style="width: 50px; height: 50px" src="https://png.pngtree.com/png-vector/20230311/ourmid/pngtree-logout-arrow-line-icon-vector-png-image_6644097.png"></a>
<div class="container">
    <div>
        <h1 style="text-align: center; color: white">Tạo Bảng Mới</h1>
    </div>

    <div class="wallpaper-form">
        <img src="../../images/imageCreateBoard.png" alt="imageCreateBoard">
    </div>
    <div id="actionForm">
        <form action="/board?action=create" method="post">
            <div>
                <p style="color: white">Tiêu đề bảng *</p>
            </div>

            <div>
                <input class="information-form" type="text" name="title" required>
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
            <button type="submit" name="addColumn">Tạo mới</button>
        </form>
    </div>
</div>
</body>
</html>
