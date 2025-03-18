<%@ page import="com.google.gson.Gson" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="/css/user/group/homeWorkspace.css">
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
        <div id="homeLeft">
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
                            <button onclick="saveEditGroup(event)" class="save-btn" type="submit">Lưu</button>
                            <button type="button" class="cancel_btn" onclick="cancelEdit()">Hủy</button>
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
                            <div style=" background-color: #0D599D; " class="workspaceTable">
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

    // ✅ In ra console để kiểm tra dữ liệu JSON
    let closedBoards = <%= new Gson().toJson(request.getAttribute("closedBoards")) %>;

    $(document).ready(function () {
        $('#openModalButton').click(function () {
            let contentDiv = document.createElement("div");

            closedBoards.forEach(board => {
                let productDiv = document.createElement("div");
                productDiv.className = "product-container";

                let label = document.createElement("label");
                label.className = "product-label";
                label.textContent = board.title;

                let deleteButton = document.createElement("button");
                deleteButton.className = "delete-button";
                deleteButton.dataset.boardId = String(board.boardId);
                deleteButton.textContent = "Xóa";
                deleteButton.onclick = function () {
                    deleteProduct(board.boardId);
                };

                productDiv.appendChild(label);
                productDiv.appendChild(deleteButton);
                contentDiv.appendChild(productDiv);
            });

            // ✅ Hiển thị modal với nội dung vừa tạo
            $.sweetModal({
                title: 'Các bảng đã đóng',
                content: $(contentDiv).html()
            });
        });
    });

    function deleteProduct(title) {
        // ✅ Xử lý xóa ở đây
    }

    // ✅ Lưu danh sách sản phẩm vào JavaScript
    let boards = <%= new Gson().toJson(request.getAttribute("boards")) %>;

    function filterBoards() {
        let input = document.getElementById("keyword").value.toLowerCase();
        let listBoards = document.getElementById("listBoards");
        listBoards.innerHTML = "";

        // ✅ Lọc danh sách sản phẩm theo tên
        let filteredBoards = boards.filter(board => board.title.toLowerCase().includes(input));

        // ✅ Tạo danh sách mới và thêm vào MODAL
        filteredBoards.forEach(board => {
            let boardDiv = document.createElement("div");
            boardDiv.className = "workspaceTable";

            let button = document.createElement("button");
            button.className = "titleBoardWorkspace";
            button.textContent = board.title;

            boardDiv.appendChild(button);
            listBoards.appendChild(boardDiv);
        });
    }

    $('.delete-button').on("click", function (event) {
        let deleteButton = $(this);
        let deleteButtonId = deleteButton.attr("id"); // Sửa lỗi lấy ID
        console.log("Delete Button:", deleteButton);
        console.log("Delete Button ID:", deleteButtonId);

        $.ajax({
            type: "POST",
            url: "/board?action=deleteBoard",
            data: {boardId: deleteButtonId},
            dataType: "json",
            success: function (message) {
                if (message === true) {
                    let parentDiv = deleteButton.closest('.product-container');
                    parentDiv.remove();
                    alert("Xóa bảng thành công")
                }
            },
            error: function (xhr, status, error) {
                console.error("Lỗi khi xóa:", error);
            }
        });
    });

</script>
<%--Mời thành viên vào không gian làm việc--%>
<script>
    function openInviteMember() {
        Swal.fire({
            title: '<span style="font-size: 24px; font-weight: 400;">Mời vào không gian làm việc</span>',
            input: "email",
            inputPlaceholder: "Nhập email...",
            showCancelButton: true,
            confirmButtonText: "Gửi lời mời",
            cancelButtonText: "Hủy",
            confirmButtonColor: "#0f60a7",
            showLoaderOnConfirm: true,
            customClass: {
                title: "popup-title",
                actions: "swal-actions-right",
            },
            showClass: {
                popup: ""
            },
            preConfirm: (email) => {
                if (!email) {
                    Swal.showValidationMessage("Vui lòng nhập email!");
                    return;
                }
                return fetch("/invite", {
                    method: "POST",
                    headers: {
                        "Content-Type": "application/x-www-form-urlencoded",
                    },
                    body: new URLSearchParams({email: email})
                })
                    .then(response => response.json())
                    .then(response => {
                        if (!response.success) {
                            Swal.showValidationMessage("Không thể gửi lời mời.");
                        }
                    })
                    .catch(() => {
                        Swal.showValidationMessage("Lỗi! Vui lòng thử lại.");
                    });
            }
        }).then((result) => {
            if (result.isConfirmed) {
                Swal.fire({
                    title: "Thành công!",
                    text: "Thành viên đã được mời.",
                    icon: "success",
                    timer: 1500,
                    timerProgressBar: true
                });
            }
        });
    }
</script>
</body>
</html>