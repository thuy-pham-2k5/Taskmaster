<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="/css/user/account/home_account.css">
    <script src="/js/user/account/home_account.js" defer></script>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script src="/js/user/group/home_workspace.js" defer></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweet-modal@1.3.3/dist/min/jquery.sweet-modal.min.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweet-modal@1.3.3/dist/min/jquery.sweet-modal.min.js"></script>
</head>
<body>

<div>
    <div id="header">
        <div id="logo">
            <img style="height: 40px; width: 40px" src="/images/logo.png">
            <p>Taskmaster</p>
        </div>
        <div id="headerTopic">
            <a href="group_home?action=viewGroups">
                <div class="topic"><p>Các không gian làm vệc </p><img class="listImage" src="/images/list.png"></div>
            </a>
            <div class="topic"><p>Gần đây</p> <img class="listImage" src="/images/list.png"></div>
            <div class="topic"><P>Đã đánh dấu sao</P><img class="listImage" src="/images/list.png"></div>
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
            <a href="javascript:void(0);" id="logoutBtn">
                <img src="https://png.pngtree.com/png-clipart/20230314/original/pngtree-log-out-vector-icon-design-illustration-png-image_8987853.png">
            </a>

        </div>
    </div>
    <div class="body">
        <div class="container">
            <nav id="homeLeft">
                <div id="workspaceList">
                    <ul>
                        <li class="contentIcon"><img style="width: 20px; height: 20px" src="../images/board.png"><a
                                href="">Bảng</a></li>
                        <li class="contentIcon"><img style="width: 20px; height: 20px" src="../images/homeTP.png"><a
                                href="">Trang chủ</a></li>
                    </ul>
                </div>
                <div id="groupList">
                    <hr style="color: white">
                    <ul class="title">Các Không gian làm việc</ul>
                    <c:forEach items="${groups}" var="group">
                        <div class="dropdown">
                            <button class="dropbtn">
                                    ${group.title}
                                <span class="arrow">▼</span>
                            </button>
                            <ul class="dropdown-content">
                                <li>
                                    <a href="/account_home?action=showGroupHomeView&groupId=${group.groupId}">Bảng</a>
                                </li>
                                <li>
                                    <a href="/account_home?action=showMemberViewInGroupHome&groupId=${group.groupId}">Thành
                                        viên</a>
                                </li>
                                <li>
                                    <a href="/account_home?action=showSettingViewInGroupHome&groupId=${group.groupId}">Cài
                                        đặt</a>
                                </li>
                            </ul>
                        </div>
                    </c:forEach>
                </div>
            </nav>
            <div id="homeRight">
            </div>
        </div>
    </div>
</div>
</body>
</html>

<script>
    document.getElementById("logoutBtn").addEventListener("click", function () {
        Swal.fire({
            title: "Xác nhận đăng xuất",
            text: "Bạn có chắc chắn muốn đăng xuất không?",
            icon: "warning",
            showCancelButton: true,
            confirmButtonColor: "#3085d6",
            cancelButtonColor: "#d33",
            confirmButtonText: "Đăng xuất",
            cancelButtonText: "Hủy"
        }).then((result) => {
            if (result.isConfirmed) {
                window.location.href = "/logout"; // Chuyển hướng đến trang đăng xuất
            }
        });
    });
</script>
