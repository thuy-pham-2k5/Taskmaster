<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <title>Task Management</title>
    <style>
        body {
            font-family: Arial, sans-serif;
        }

        .container {
            max-width: 400px;
            background-color: #286398;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
            padding: 20px;
            border-radius: 5px;
            margin: 0 auto;
            align-content: center;
        }

        img {
            width: 70%;
            height: auto;
            display: block;
            margin-left: auto;
            margin-right: auto;
            border-radius: 5px;
        }

        #wallPaper2 {
            width: 100%;
            height: 30px;
            display: flex;
        }

        input {
            width: 90%;
            height: 30px;
            border-radius: 5px;
            margin: 5px 5px 5px 5px;
            padding: 10px;
            background-color: #286398;
            border: 2px solid white;
        }

        select {
            width: 98%;
            height: 45px;
            border-radius: 5px;
            margin: 5px 5px 5px 5px;
            padding: 10px;
            background-color: #286398;
            border: 2px solid white;
            color: white;
        }

        button {
            text-align: center;
            width: 98%;
            height: 30px;
            border-radius: 5px;
            margin: 5px 5px 5px 5px;
            padding: 10px;
            background-color: rgba(45, 52, 58, 0.45);
            color: white;
            border: 0;
        }
    </style>
    <link rel="stylesheet" href="../../css/board/createBoard.css">
    <script src="../../js/board/createBoard.js"></script>
</head>
<body>
<div class="container">
    <div>
        <h1 style="text-align: center; color: white">Tạo Bảng Mới</h1>
    </div>

    <div>
        <img src="../../image/imageCrateBoard.png" alt="imageCrateBoard">
    </div>

    <div style="margin-bottom: 5px">
        <p style="color: white">Phông nền</p>
    </div>

    <div id="wallPaper1" style="position: relative;">
        <c:forEach var="i" begin="1" end="4">
            <div style="position: relative; width: 25%; text-align: center;">
                <img style="width: 100%; height: 50px; border-radius: 5px; margin-right: 5px; margin-left: 5px"
                     src="../../image/imageWallpaper${i}.png" alt="imageWallpaper${i}">
            </div>
        </c:forEach>
    </div>

    <div id="wallPaper2">

    </div>

    <div>
        <p style="color: white">Tiêu đề bảng *</p>
    </div>

    <div>
        <input class="information-form" type="text" name="title" required>
        <p style="color: white; font-size: 10px; margin-top: 0; margin-left: 5px">Tiêu đề của bảng là bắt
            buộc.</p>
    </div>

    <div>
        <p style="color: white">Không gian làm việc *</p>
    </div>

    <div>
        <select class="information-form" name="Không gian làm việc">
            <option value="1">Quản lý không gian làm việc Taskmaster</option>
            <option value="2">2</option>
        </select>
    </div>

    <div>
        <p style="color: white">Quyền xem *</p>
    </div>

    <div>
        <select class="information-form" style="margin-bottom: 15px" name="Không gian làm việc">
            <option value="1">không gian làm việc</option>
            <option value="2">2</option>
        </select>
    </div>
    <button type="submit" name="addColumn">Tạo mới</button>
    <button type="submit" name="createTable">Bắt đầu với Mẫu</button>
</div>
</body>
</html>
