<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="/css/user/group/homeWorkspace.css">
    <script src="/js/user/group/home_workspace.js" defer></script>
</head>
<body>

<div>
    <div id="header">
        <div id="logo">
            <img style="height: 40px; width: 40px" src="/images/logo.png">
            <p>Taskmaster</p>
        </div>
        <div id="headerTopic">
            <div class="topic"><p>Các không gian làm vệc </p> <img class="listImage" src="/images/list.png"></div>
            <div class="topic"><p>Gần đây</p> <img class="listImage" src="/images/list.png"></div>
            <div class="topic"><P>Đã đánh dấu sao</P> <img class="listImage" src="/images/list.png"></div>
            <a href="/view/user/group/create_workspace.jsp">
                <button>Tạo không gian làm việc mới</button>
            </a>
        </div>
        <div id="accountSearchNotification">
            <div id="search">
                <input type="text" style="width: 170px ; height: 30px; border-radius: 5px;"
                       placeholder="Tìm kiếm bảng...">
            </div>
            <img src="/images/bell.png">
            <img src="https://vivureviews.com/wp-content/uploads/2022/08/avatar-vo-danh-9.png">
        </div>
    </div>

    <div class="container">
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
        <div id="homeRight">
            <div id="groupInformation">

                <div id="information">
                    <div style="display: flex; align-items: center">
                        <button id="group"><p>P</p></button>
                        <div>
                            <div style="display: flex">
                                <p id="groupName">${groupInfo.title}</p>
                                <img class="edit_group_pen" src="/images/edit.png">
                            </div>
                            <br>
                            <p style="color: white; margin-left: 15px">${groupInfo.visibility}</p>
                        </div>

                    </div>
                    <br>
                    <p id="content">${groupInfo.description}</p>
                </div>

                <c:if test="${roleIdUser == 3}">
                    <div id="addAccount">
                        <button style="background-color: #1B5B94">
                            <img style="width: 15px; height: 15px" src="images/account.png" alt="">
                            Mời thành viên vào Không gian làm việc
                        </button>
                    </div>
                </c:if>
            </div>
        </div>
    </div>
</div>
</body>
</html>
