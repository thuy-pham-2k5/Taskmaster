<%--
  Created by IntelliJ IDEA.
  User: This  PC
  Date: 27/02/2025
  Time: 3:09 CH
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="css/user/group/home_left.css">
</head>
<body>
<div id="homeLeft">
    <div id="workspaceName">
        <button id="workspace"><p class="represent">P</p></button>
        <p>${groupInfo.title}</p>
    </div>

    <div id="workspaceList">
        <div><img class="icon" src="/images/table.png">
            <p>Bảng</p></div>
        <div><img class="icon" src="/images/number.png">
            <p>Thành viên</p></div>
        <div><img class="icon" src="/images/setting.png">
            <p>Các cài đặt không gian làm việc</p></div>

        <div style="display: flex; justify-content: space-between"><p style="font-size: 20px">Các bảng của
            bạn</p> <img class="icon" src="/images/add.png"></div>
        <div style="display: flex; justify-content: space-between ; padding-left: 30px"><p>Bảng 1</p> <img
                class="icon" src="/images/start.png"></div>
    </div>
</div>
</body>
</html>
