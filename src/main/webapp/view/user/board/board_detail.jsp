<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
<<<<<<< HEAD
    <meta charset="UTF-8">
    <link rel="stylesheet" href="/css/user/board/board_detail.css">

    <!-- Thư viện jQuery -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    <!-- Thư viện SweetModal -->
    <script src="https://cdn.jsdelivr.net/npm/jquery-sweetmodal@1.3.3/dist/jquery.sweet-modal.min.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/jquery-sweetmodal@1.3.3/dist/jquery.sweet-modal.min.css">

    <!-- Script xử lý -->
    <script src="/js/user/board/board_detail.js" defer></script>
=======
    <link rel="stylesheet" href="css/user/board/board.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script src="/js/user/group/home_workspace.js" defer></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweet-modal@1.3.3/dist/min/jquery.sweet-modal.min.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweet-modal@1.3.3/dist/min/jquery.sweet-modal.min.js"></script>
>>>>>>> d0dd7498fb118214ddf2f376b933043ef34affc6
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
                <div class="topic"><p>Các không gian làm vệc </p> <img class="listImage" src="/images/list.png"></div>
            </a>
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
            <a href="javascript:void(0);" onclick="$('#exampleModalCenter').modal('show');"> <img
                    src="https://png.pngtree.com/png-clipart/20230314/original/pngtree-log-out-vector-icon-design-illustration-png-image_8987853.png"></a>
            <jsp:include page="../account/notification_log_out.jsp"/>
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
                <div style="display: flex; flex-direction: column">
                    <c:forEach var="board" items="${boards}">
                        <div class="board" style="display: flex; justify-content: space-between; align-items: center;">
                            <a href="group_home?action=boardView&boardId=${board.boardId}">
                                <p>${board.title}</p>
                            </a>
                            <div class="dropdown">
                                <a href="" class="openModal" data-boardid="${board.boardId}">
                                    <img style="width: 60%; height: 20px" src="../images/ellipsis.png">
                                </a>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>
        <div id="homeRight">
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
