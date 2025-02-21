<%--
  Created by IntelliJ IDEA.
  User: This  PC
  Date: 17/02/2025
  Time: 10:26 SA
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="/css/groups/homeWorkspace.css">
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
            <a href="/view/groups/build_workspace.jsp"><button>Tạo không gian làm việc mới</button></a>
<%--            <button onclick="openModal()">Tạo không gian làm việc mới</button>--%>

<%--            <!-- Modal -->--%>
<%--            <div id="myModal" class="modal">--%>
<%--                <div class="modal-content">--%>
<%--                    <span style="padding: 20px" class="close" onclick="closeModal()">&times;</span>--%>
<%--                    <iframe src="view/groups/build_workspace.jsp"></iframe>--%>
<%--                </div>--%>
<%--            </div>--%>





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
                <p>${title}</p>
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
                                <p id="groupName">${title}</p>
                                <img class="edit_group_pen" src="/images/edit.png">
                            </div>
                            <br>
                            <p style="color: white; margin-left: 15px">Riêng tư</p>
                        </div>

                    </div>
                    <br>
                    <p id="content">${describe}</p>
                </div>

                <div id="addAcount">
                    <button style="background-color: #1B5B94">
                        <img style="width: 15px; height: 15px" src="/images/acount.png"> Mời thành viên vào không gian
                        làm việc
                    </button>
                </div>
            </div>

            <div id="workspaces">
                <p style="color: white; font-weight: bold; font-size: 22px">Bảng</p>
                <div id="sortAndSearch">
                    <div id="sort">
                        <p style="color: white">Sắp xếp theo</p>
                        <select id="mySelect">
                            <option value="option1">Hoạt động gần đây nhất</option>
                            <option value="option2">Ít hoạt động Nhất gần đây</option>
                            <option value="option3">Theo bảng chữ cái từ A-Z</option>
                            <option value="option4">Theo bảng chữ cái từ Z-A</option>
                        </select>
                    </div>
                    <div id="searchTable">
                        <p style="color: white">Tìm kiếm</p>
                        <input type="text" placeholder="Tìm kiếm các bảng">

                    </div>
                </div>
                <div id="workspaceTable">
                    <button>Tạo bảng mới</button>
                </div>
                <button id="viewOffTable">Xem các bảng đã đóng</button>

            </div>

        </div>
    </div>
</div>

<script src="js/groups/homeWorkspace.js"></script>
</body>
</html>
