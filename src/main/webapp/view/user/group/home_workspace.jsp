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
    <script src="/js/user/group/home_workspace.js" defer></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link rel="stylesheet" href="https://unpkg.com/sweet-modal/dist/min/jquery.sweet-modal.min.css">
    <script src="https://unpkg.com/sweet-modal/dist/min/jquery.sweet-modal.min.js"></script>
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
                                    <button style="background: none; border: 0"><img class="img-edit-group"
                                                                                     src="/images/edit.png"
                                                                                     onclick="showEditModal()">
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
                    <form action="/group_home?action=editInfoGroup&groupId=${groupInfo.groupId}" method="post">
                        <label>🏢 Tên không gian làm việc</label>
                        <input name="title" type="text" id="groupNameInput" style="margin-bottom: 20px"
                               value="${groupInfo.title}">

                        <label>🔠 Tên ngắn gọn</label>
                        <input name="short_title" type="text" id="shortNameInput" style="margin-bottom: 20px"
                               value="${groupInfo.short_title}">

                        <label>📝 Mô tả (tùy chỉnh)</label>
                        <textarea name="description" id="groupDescInput">${groupInfo.description}</textarea>

                        <div class="button-group">
                            <button onclick="saveEditGroup(event)" class="save-btn" type="submit" id="save" disabled>
                                Lưu
                            </button>

                            <button type="button" class="cancel-btn" onclick="cancelEdit()">Hủy</button>
                        </div>
                    </form>
                </div>


                <c:if test="${roleIdUser == 3}">
                    <div id="addAccount">
                        <button id="btnAddAccount" onclick="openInviteMember()">
                            <img style="width: 18px; height: 18px" src="/images/add_account.png" alt="">

                            <p style="color:white;">Mời thành viên vào không gian làm việc</p>
                        </button>
                    </div>
                </c:if>
            </div>
            <div id="workspaces">
                <p style="color: white; font-weight: bold; font-size: 22px; margin-bottom: 0px">Bảng</p>
                <div id="sortAndSearch">
                    <div id="sort">
                        <p><label for="mySelect" style="color: white">Sắp xếp theo</label></p>
                        <select id="mySelect">
                            <option value="option1" selected>Theo bảng chữ cái từ A - Z</option>
                            <option value="option2">Theo bảng chữ cái từ Z - A</option>
                        </select>
                    </div>
                    <div id="searchTable">
                        <p style="color: white">Tìm kiếm</p>
                        <input type="text" id="keyword" name="keyword" placeholder="Tìm kiếm các bảng"
                               onkeyup="filterBoards()">
                    </div>
                </div>

                <div class="flex-container">
                    <div class="workspaceTable">
                        <a href="/board?action=create">
                            <button style="background-color: #0D599D; color: white; border: none"
                                    class="create-board-btn">Tạo bảng
                            </button>
                        </a>
                    </div>
                    <div id="listBoards" class="card-container">
                        <c:forEach var="board" items="${boards}">
                            <div style="background-color: #0D599D;" class="workspaceTable">
                                <a href="/group_home?action=boardView&boardId=${board.boardId}">
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

    // chỉnh sửa group không cho chỉnh sửa tiêu đề quá 100 ký tự
    document.addEventListener("DOMContentLoaded", function () {
        let nameSp = document.getElementById("groupNameInput");
        let submitBtn = document.getElementById("save");

        nameSp.addEventListener("input", function () {
            if (this.value.length > 100) {
                this.setCustomValidity("Bạn chỉ được nhập tối đa 100 ký tự!");
                this.reportValidity(); // Hiển thị lỗi ngay lập tức
                submitBtn.disabled = true;
            } else {
                this.setCustomValidity("");
                submitBtn.disabled = false;
            }
        });

        submitBtn.addEventListener("click", function (event) {
            if (nameSp.value.length > 100) {
                nameSp.setCustomValidity("Bạn chỉ được nhập tối đa 100 ký tự!");
                nameSp.reportValidity(); // Hiển thị lỗi khi bấm nút
                event.preventDefault(); // Ngăn chặn form submit nếu lỗi
            }
        });
    });


    function cancelEdit() {
        // Hủy chỉnh sửa, quay về ban đầu
        document.getElementById("edit_frame").style.display = "none";
        document.getElementById("information").style.display = "block";
    }


    function showEditModal() {
        // Ẩn div information và hiển thị div edit_frame
        document.getElementById("information").style.display = "none";
        document.getElementById("edit_frame").style.display = "block";

    }

    // Gửi dữ liệu bằng AJAX khi nhấn "Lưu"
    function saveEditGroup(event) {
        event.preventDefault(); // Ngăn form gửi request mặc định

        let title = document.getElementById("groupNameInput").value.trim();
        let short_title = document.getElementById("shortNameInput").value.trim();
        let description = document.getElementById("groupDescInput").value.trim();


        $.ajax({
            type: "POST",
            url: "/group_home?action=editInfoGroup",
            data: {
                title: title,
                short_title: short_title,
                description: description
            },
            dataType: "json",
            success: function (group) {

                document.getElementById("titleGroup").innerText = group.title;
                document.getElementById("titleGroupHomeLeft").innerText = group.title;
                document.getElementById("shortNameInput").innerText = group.title;
                document.getElementById("content").innerText = group.description;
                cancelEdit();
            }
        })

    }


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
    let closedBoards = null;

    $('#openModalButton').click(function () {
        getClosedBoards();

        let contentDiv = document.createElement("div");

        closedBoards.forEach(board => {
            contentDiv.appendChild(createClosedBoard(board));
        });

        function createClosedBoard(board) {
            let parentDiv = document.createElement("div");
            parentDiv.className = "closed-board-container";
            parentDiv.dataset.board = board.boardId;
            parentDiv.innerHTML = `
                  <div class="closed-board-info">
                      <img src="" alt="error.png" class="image-closed-board"/>
                      <div>
                          <div class="closed-board-title"></div>
                          <div class="closed-board-group-title"></div>
                      </div>
                  </div>
                  <div class="closed-board-action">
                      <button class="open-closed-board">Mở lại</button>
                      <button class="delete-closed-board">Xóa</button>
                  </div>
            `;
            parentDiv.querySelector(".image-closed-board").src = board.backgroundLink || "error.png";
            parentDiv.querySelector(".closed-board-title").textContent = board.title || "";
            parentDiv.querySelector(".closed-board-group-title").textContent = board.groupName || "";
            return parentDiv;
        }

        showClosedBoard(contentDiv);
    });

    function getClosedBoards () {
        $.ajax({
            type: "GET",
            url: "/group_home?action=getClosedBoards",
            dataType: "json",
            success: function (response) {
                closedBoards = response;
            },
            error: function (xhr, status, error) {
                console.error("Lỗi khi lấy danh sách bảng đã đóng:", error);
            }
        })
    }

    function showClosedBoard (contentDiv) {
        let content = $(contentDiv).html().trim();
        if (!content) {
            content = '<div class="no-closed-board">Chưa có bảng nào được đóng.</div>';
        }
        Swal.fire({
            title: 'Các bảng đã đóng',
            html: content,
            showCloseButton: true,
            showConfirmButton: false,
            showClass: {
                popup: ""
            },
            didOpen: () => {
                $('.open-closed-board').on("click", function () {
                    let parentDiv = $(this).closest(".closed-board-container");
                    let boardId = parentDiv.data("board");
                    console.log(boardId);
                    Swal.fire({
                        title: "Xác nhận",
                        text: "Bạn có chắc chắn muốn mở lại bảng?",
                        icon: "question"
                    })
                        .then((result) => {
                            if (result.isConfirmed) {
                                actionClosedBoard(boardId, "open");
                            }
                        })
                })
                $('.delete-closed-board').on("click", function () {
                    let parentDiv = $(this).closest(".closed-board-container");
                    let boardId = parentDiv.data("board");
                    console.log(boardId);
                    Swal.fire({
                        title: "Bạn chắc chắn xóa bảng?",
                        text: "Tất cả danh sách, thẻ và hành động sẽ bị xóa và không thể mở lại bảng.",
                        icon: "question"
                    })
                        .then((result) => {
                            if (result.isConfirmed) {
                                actionClosedBoard(boardId, "delete");
                            }
                        })
                })
            }
        });
    }

    function actionClosedBoard(boardId, typeAction) {
        let url = typeAction === "open" ? "/board?action=openBoard" : "/board?action=deleteBoard";
        let text = typeAction === "open" ? "Đã mở lại bảng" : "Đã xóa bảng";
        console.log(url)
        $.ajax({
            type: "POST",
            url: url,
            data: {boardId: boardId},
            success: function (response, status, xhr) {
                if (xhr.status === 200) {
                    console.log("Thành công xóa/mở");
                    alertShowSuccess("Thành công!", text);
                }
            },
            error: function () {
                console.log("Lỗi khi xóa / mở bảng!");
            }
        })
    }
</script>
</body>
</html>