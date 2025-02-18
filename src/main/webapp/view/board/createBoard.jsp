<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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

        .wallPaper {
            width: 15%;
            height: 25px;
            border-radius: 5px;
            margin-right: 5px;
            margin-left: 5px
        }

        #wallPaper1 {
            width: 100%;
            height: 60px;
            display: flex;
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
</head>
<body>
<div class="container">
    <div>
        <h1 style="text-align: center; color: white">Tạo Bảng Mới</h1>
    </div>

    <div>
        <img src="imageCrateBoard.png" alt="imageCrateBoard">
    </div>

    <div style="margin-bottom: 5px">
        <p style="color: white">Phông nền</p>
    </div>

    <div id="wallPaper1">
        <img style="width: 100%; height: 50px; border-radius: 5px; margin-right: 5px; margin-left: 5px"
             src="../../image/imageWallpaper1.png" alt="imageWallpaper1">
        <img style="width: 100%; height: 50px; border-radius: 5px; margin-right: 5px; margin-left: 5px"
             src="../../image/imageWallpaper2.png" alt="imageWallpaper2">
        <img style="width: 100%; height: 50px; border-radius: 5px; margin-right: 5px; margin-left: 5px"
             src="../../image/imageWallpaper3.png" alt="imageWallpaper3">
        <img style="width: 100%; height: 50px; border-radius: 5px; margin-right: 5px; margin-left: 5px"
             src="../../image/imageWallpaper4.png" alt="imageWallpaper4">
    </div>

    <div id="wallPaper2">
        <div class="wallPaper" style="background-color: #691875"></div>
        <div class="wallPaper" style="background-color: #2f2f6b"></div>
        <div class="wallPaper" style="background-color: #81430f"></div>
        <div class="wallPaper" style="background-color: #1f736d"></div>
        <div class="wallPaper" style="background-color: #7e8788"></div>
        <div class="wallPaper" style="background-color: #2e7a3f"></div>
        <img style="width: 15%; height: 25px; border-radius: 5px; margin-right: 5px; margin-left: 5px"
             src="../../image/moreWallpaperButton.png " alt="moreWallpaperButton">
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
