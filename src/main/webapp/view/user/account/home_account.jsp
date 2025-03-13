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
                <div id="groupList">
                    <hr style="color: white">
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
                <div class="section">
                    <h2>⭐ Bảng đánh dấu sao</h2>
                    <div class="board-list">
                        <c:forEach items="${starredBoards}" var="board">
                            <div class="board-item">
                                <img src="${board.backgroundLink}" alt="Board Image">
                                <p>${board.title}</p>
                            </div>
                        </c:forEach>
                    </div>
                </div>

                <div class="section">
                    <h2>⏳ Đã xem gần đây</h2>
                    <div class="board-list">
                        <c:forEach items="${recentBoards}" var="board">
                            <div class="board-item">
                                <img src="${board.backgroundLink}" alt="Board Image">
                                <p>${board.title}</p>
                            </div>
                        </c:forEach>
                    </div>
                </div>

<%--                <div class="section">--%>
<%--                    <h2>Các Không gian làm việc của bạn</h2>--%>
<%--                    <c:forEach items="${groups}" var="group">--%>
<%--                        <div class="workspace-container">--%>
<%--                            <h3>${group.name}</h3>--%>
<%--                            <div class="workspace-options">--%>
<%--                                <a href="/account_home?action=showGroupHomeView&groupId=${group.groupId}">📋 Bảng</a>--%>
<%--                                <a href="/account_home?action=showMemberViewInGroupHome&groupId=${group.groupId}">👥 Thành viên (${group.memberCount})</a>--%>
<%--                                <a href="/account_home?action=showSettingViewInGroupHome&groupId=${group.groupId}">⚙️ Cài đặt</a>--%>
<%--                            </div>--%>
<%--                            <div class="board-list">--%>
<%--                                <c:forEach items="${group.boards}" var="board">--%>
<%--                                    <div class="board-item">--%>
<%--                                        <img src="${group.imageUrl}" alt="Board Image">--%>
<%--                                        <p>${group.title}</p>--%>
<%--                                    </div>--%>
<%--                                </c:forEach>--%>
<%--                            </div>--%>
<%--                        </div>--%>
<%--                    </c:forEach>--%>
<%--                </div>--%>

<%--                <div class="section">--%>
<%--                    <h2>Các Không gian làm việc khách</h2>--%>
<%--                    <c:forEach items="${guestWorkspaces}" var="workspace">--%>
<%--                        <div class="guest-workspace">--%>
<%--                            <h3>🏠 ${workspace.owner}</h3>--%>
<%--                            <div class="board-list">--%>
<%--                                <c:forEach items="${workspace.boards}" var="board">--%>
<%--                                    <div class="board-item board-item-red">--%>
<%--                                        <p>${board.title}</p>--%>
<%--                                    </div>--%>
<%--                                </c:forEach>--%>
<%--                            </div>--%>
<%--                        </div>--%>
<%--                    </c:forEach>--%>
<%--                </div>--%>

                <button class="view-all-closed-boards">Xem tất cả các bảng đã đóng</button>

            </div>
            </div>
        </div>
    </div>



</body>
</html>

<script>
    let groups = "${groups}";
    console.log(groups);
    let recentBoard = "${recentBoards}"; console.log(recentBoard);
    let starredBoards = "${starredBoards}"; console.log(starredBoards);
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
    document.querySelector(".view-all-closed-boards").addEventListener("click", function() {
        window.location.href = "/account_home?action=showClosedBoards";
    });

</script>
