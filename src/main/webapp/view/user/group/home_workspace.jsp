<%@ page import="com.google.gson.Gson" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="/css/user/group/homeWorkspace.css">
    <link rel="stylesheet" href="/css/user/group/invite_member.css">
    <link rel="stylesheet" href="/css/user/group/closed_board.css">
    <script src="/js/user/group/invite_member.js" defer></script>
    <script src="/js/user/board/closed_board.js" defer></script>
    <script src="/js/user/group/home_workspace.js" defer></script>

    <script src="/js/user/group/edit_group.js" defer></script>
    <link rel="stylesheet" href="/css/user/group/edit_group.css">

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</head>
<body>
<div style="height: 100%;">
    <div class="menubar-home-workspace">
        <jsp:include page="../account/menubar.jsp"/>
    </div>
    <div class="container">
        <div style="position: relative; height: 100%">
            <jsp:include page="../account/home_left.jsp"/>
        </div>
        <div id="homeRight">
            <div class="group-info">
                <div style="flex: 1;">
                    <div id="information">
                        <div id="group-info">
                            <div class="group-info-logo">
                                <button class="group-title">${groupInfo.title.substring(0,1).toUpperCase()}</button>
                            </div>
                            <div id="main_info">
                                <div class="group-info-detail">
                                    <h2 id="titleGroup">
                                        ${groupInfo.title}

                                    </h2>
                                    <c:set var="hasPermission" value="false" />
                                    <c:forEach var="permission" items="${groupPermissions}">
                                        <c:if test="${permission.permissionId == 2}">
                                            <c:set var="hasPermission" value="true" />
                                        </c:if>
                                    </c:forEach>

                                    <button style="background: none; border: 0;
                                    <c:if test='${hasPermission ne "true"}'>pointer-events: none; opacity: 0.5;</c:if>">
                                        <img class="img-edit-group" src="/images/edit.png" onclick="showEditModal()">
                                    </button>
                                </div>
                                <span>${groupInfo.visibility}</span>
                            </div>
                            <br>
                        </div>
                        <p id="content">${groupInfo.description}</p>
                    </div>
                </div>
                <!-- Phần chỉnh sửa, Ẩn mặc định -->

                <div id="edit_frame">
                  <jsp:include page="edit_group.jsp"/>
                </div>


                <c:forEach var="permission" items="${groupPermissions}">
                    <c:if test="${permission.permissionId == 3}">
                        <div id="addAccount">
                            <button id="btnAddAccount" onclick="openInviteMember()">
                                <img style="width: 18px; height: 18px" src="/images/add_account.png" alt="">

                                <p style="color:white;">Mời thành viên vào không gian làm việc</p>
                            </button>
                        </div>
                    </c:if>
                </c:forEach>
            </div>
            <div id="workspaces">
                <p style="color: white; font-weight: bold; font-size: 22px; margin-bottom: 0px">Bảng</p>
                <div id="sortAndSearch">
                    <div id="sort">
                        <p><label for="mySelect" style="color: white">Sắp xếp theo</label></p>
                        <select id="mySelect">
                            <option value="option1" selected>Hoạt động gần đây nhất</option>
                            <option value="option2">Ít hoạt động nhất gần đây</option>
                            <option value="option3">Theo bảng chữ cái từ A - Z</option>
                            <option value="option4">Theo bảng chữ cái từ Z - A</option>
                        </select>
                    </div>
                    <div id="searchTable">
                        <p style="color: white">Tìm kiếm</p>
                        <input type="text" id="keyword" name="keyword" placeholder="Tìm kiếm các bảng"
                               onkeyup="filterBoards()">
                    </div>
                </div>

                <div class="flex-container">
                    <div class="workspaceTable-createBoard">
                        <a href="/board?action=create">
                            <button style="background-color: #0D599D; color: white; border: none"
                                    class="create-board-btn">Tạo bảng
                            </button>
                        </a>
                    </div>
                    <div id="listBoards" class="card-container">
                        <c:forEach var="board" items="${boards}">
                            <div style="background-image: url('${board.backgroundLink}');" class="workspaceTable">
                                <a class="workspaceTableLink" href="/group_home?action=boardView&boardId=${board.boardId}">
                                    <button class="titleBoardWorkspace">${board.title}</button>
                                </a>
                            </div>
                        </c:forEach>
                    </div>
                </div>

                <button id="openModalButton">Xem các bảng đã đóng</button>
            </div>
        </div>
    </div>
</div>

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
<script defer>
    let boards = <%= new Gson().toJson(request.getAttribute("boards")) %>;
</script>
</body>
</html>