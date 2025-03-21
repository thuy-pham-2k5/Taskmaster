<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="/css/user/account/home_account.css">
    <script src="/js/user/account/home_account.js" defer></script>

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweet-modal@1.3.3/dist/min/jquery.sweet-modal.min.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweet-modal@1.3.3/dist/min/jquery.sweet-modal.min.js"></script>
</head>
<body>
<div>
    <jsp:include page="menubar.jsp"/>
</div>
<div style="background: #3179ba; height: calc(100% - 50px);">
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
                <hr style="color: white">
                <div id="groupList">
                    <ul class="title">Các Không gian làm việc</ul>
                    <c:forEach items="${groups}" var="group">
                        <div class="dropdown-container-group">
                            <button class="dropbtn">
                                    ${group.title}
                                <span class="arrow">▼</span>
                            </button>
                            <ul class="dropdown-content-group">
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
                <c:if test="${not empty starredBoards}">
                    <div class="interface-board-ha">
                        <h4>Đã đánh dấu sao</h4>
                        <div class="parent-starred-lists-boards">
                            <c:forEach var="board" items="${starredBoards}">
                                <div class="starred-list-boards"
                                     style="background-image: url('${board.backgroundLink}');">
                                    <a href="/group_home?action=boardView&boardId=${board.boardId}&&groupId=${board.groupId}">
                                        <span>${board.title}</span>
                                    </a>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </c:if>
                <div class="recent-list-board">
                    <h4>Đã xem gần đây</h4>
                    <div class="parent-starred-lists-boards">
                        <c:forEach var="board" items="${recentBoards}" varStatus="loop" begin="0" end="3">
                            <div class="starred-list-boards" style="background-image: url('${board.backgroundLink}');">
                                <a href="/group_home?action=boardView&boardId=${board.boardId}&&groupId=${board.groupId}">
                                    <span>${board.title}</span>
                                </a>
                            </div>
                        </c:forEach>
                    </div>
                </div>
                <div class="ha-list-boards">
                    <h4>CÁC KHÔNG GIAN LÀM VIỆC CỦA BẠN</h4>
                    <div>

                    </div>
                </div>
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
