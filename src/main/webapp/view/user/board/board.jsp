<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="css/user/board/board.css">
</head>
<body>

<div>
    <div id="header">
        <div id="logo">
            <img style="width: 50px; width: 50px" src="images/logo.png">
            <p>Taskmaster</p>
        </div>
        <div id="headerTopic">
            <div class="topic"><p>Các không gian làm vệc </p> <img class="listImage" src="images/list.png"></div>
            <div class="topic"><p>Gần đây</p> <img class="listImage" src="images/list.png"></div>
            <div class="topic"><P>Đã đánh dấu sao</P> <img class="listImage" src="images/list.png"></div>
            <button>Tạo mới</button>
        </div>
        <div id="accountSearchNotification">
            <div id="search">
                <input type="text" style="width: 170px ; height: 30px; border-radius: 5px;"
                       placeholder="Tìm kiếm bảng...">
            </div>


            <img src="images/bell.png">
            <img src="https://vivureviews.com/wp-content/uploads/2022/08/avatar-vo-danh-9.png">
        </div>
    </div>

    <div class="container">
        <div id="homeLeft">
            <div id="workspaceName">
                <button id="workspace"><p class="represent">P</p></button>
                <p>Quản lý công việc Taskmaster</p>
            </div>

            <div id="workspaceList">
                <div><img class="icon" src="images/table.png">
                    <p>Bảng</p></div>
                <div><img class="icon" src="images/number.png">
                    <p>Thành viên</p></div>
                <div><img class="icon" src="images/setting.png">
                    <p>Các cài đặt không gian làm việc</p></div>
                <div style="display: flex; justify-content: space-between"><p style="font-size: 25px">Các bảng của
                    bạn</p> <img class="icon" src="images/add.png"></div>
                <div style="display: flex; justify-content: space-between ; padding-left: 30px"><p>Bảng 1</p> <img
                        class="icon" src="images/start.png"></div>
            </div>
        </div>
        <div id="homeRight">
        </div>
    </div>
</div>
</div>


</body>
</html>