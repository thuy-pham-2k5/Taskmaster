<%@ page import="com.google.gson.Gson" %>
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
                <c:if test="${not empty starredBoards}">
                    <div class="section">
                        <h2>⭐ Bảng đánh dấu sao</h2>
                        <div class="board-list">
                            <c:forEach items="${starredBoards}" var="board">
                                <a href="/group_home?action=boardView&boardId=${board.boardId}&groupId=${board.groupId}">
                                    <div class="board-item">
                                        <img src="${board.backgroundLink}" alt="Board Image">
                                        <p>${board.title}</p>
                                    </div>
                                </a>
                            </c:forEach>
                        </div>
                    </div>
                </c:if>

                <div class="section">
                    <h2>⏳ Đã xem gần đây</h2>
                    <div class="board-list">
                        <c:forEach items="${recentBoards}" var="board">
                            <a href="/group_home?action=boardView&boardId=${board.boardId}&groupId=${board.groupId}">
                                <div class="board-item">
                                    <img src="${board.backgroundLink}" alt="Board Image">
                                    <p>${board.title}</p>
                                </div>
                            </a>
                        </c:forEach>
                    </div>
                </div>

<%--                <div class="section">--%>
<%--                    <h2>Các Không gian làm việc của bạn</h2>--%>
<%--                    <c:forEach items="${groups}" var="group">--%>
<%--                        <c:set var="key" value="${group.key}"/>--%>
<%--                        <c:set var="value" value="${group.value}"/>--%>
<%--                            <div class="workspace-container">--%>
<%--                                <h3>${key.title}</h3>--%>
<%--                                <div class="workspace-options">--%>
<%--                                    <a href="/account_home?action=showGroupHomeView&groupId=${group.groupId}">--%>
<%--                                        <img src="/images/table.png" alt="Bảng"--%>
<%--                                             style="width: 16px; height: 16px; margin-right: 5px;">--%>
<%--                                        Bảng--%>
<%--                                    </a>--%>
<%--                                    <a href="/account_home?action=showMemberViewInGroupHome&groupId=${group.groupId}">--%>
<%--                                        <img src="/images/account.png" alt="Thành viên"--%>
<%--                                             style="width: 16px; height: 16px; margin-right: 5px;">--%>
<%--                                        Thành viên--%>
<%--                                    </a>--%>
<%--                                    <a href="/account_home?action=showSettingViewInGroupHome&groupId=${group.groupId}">--%>
<%--                                        <img src="/images/setting.png" alt="Cài đặt"--%>
<%--                                             style="width: 16px; height: 16px; margin-right: 5px;">--%>
<%--                                        Cài đặt--%>
<%--                                    </a>--%>
<%--                                </div>--%>
<%--                            </div>--%>
<%--                        <div class="board-list">--%>
<%--                            <c:forEach items="${value}" var="board">--%>
<%--                                <a href="/group_home?action=boardView&boardId=${board.boardId}&groupId=${board.groupId}">--%>
<%--                                    <div class="board-item">--%>
<%--                                        <img src="${board.backgroundLink}" alt="Board Image">--%>
<%--                                        <p>${board.title}</p>--%>
<%--                                    </div>--%>
<%--                                </a>--%>
<%--                            </c:forEach>--%>
<%--                        </div>--%>
<%--                    </c:forEach>--%>

<%--                    <h2>Các Không gian làm việc khách</h2>--%>
<%--                    <c:forEach items="${groups}" var="group">--%>
<%--                        <c:if test="${group.accessType eq 'guest_workspace'}">--%>
<%--                            <div class="guest-workspace">--%>
<%--                                <h3>${group.title}</h3>--%>
<%--                                <div class="board-list">--%>
<%--                                    <div class="board-item board-item-red">--%>
<%--                                        <p>Chỉ có quyền xem nội dung</p>--%>
<%--                                    </div>--%>
<%--                                </div>--%>
<%--                            </div>--%>
<%--                        </c:if>--%>
<%--                    </c:forEach>--%>


                    <button id="openModalButton">Xem các bảng đã đóng</button>
                </div>
            </div>
        </div>
    </div>
</div>


</body>
</html>

<script>
    let groups = "${groups}";
    console.log(groups);
    let recentBoard = "${recentBoards}";
    console.log(recentBoard);
    let starredBoards = "${starredBoards}";
    console.log(starredBoards);
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
    document.querySelector("#openModalButton").addEventListener("click", function () {
        window.location.href = "/account_home?action=showClosedBoards";
    });


    let closedBoards = <%= new Gson().toJson(request.getAttribute("closedBoards")) %>;

    $(document).ready(function () {
        $('#openModalButton').click(function () {
            let contentHtml = '';

            closedBoards.forEach(board => {
                contentHtml += `
            <div class="product-container">
                <label class="product-label">${board.title}</label>
                <button class="delete-button" onclick="deleteProduct(${board.boardId})">Xóa</button>
            </div>
        `;
            });

            $.sweetModal({
                title: 'Các bảng đã đóng',
                content: contentHtml
            });
        });

    });
</script>
