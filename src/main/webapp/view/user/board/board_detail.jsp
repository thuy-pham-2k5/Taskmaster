<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="/css/user/board/board_detail.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script src="/js/user/board/board_detail.js" defer></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweet-modal@1.3.3/dist/min/jquery.sweet-modal.min.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweet-modal@1.3.3/dist/min/jquery.sweet-modal.min.js"></script>
</head>
<body>
<div>
    <div>
        <jsp:include page="../account/menubar.jsp"/>
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
                <div>
                    <img class="icon" src="/images/setting.png">
                    <p>Các cài đặt không gian làm việc</p>
                </div>
                <div style="display: flex; justify-content: space-between;">
                    <p style="font-size: 20px">Các bảng của bạn</p>
                    <img class="icon" src="/images/add.png"/>
                </div>
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
