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
</head>
<body>
<div>
    <div id="header">
        <div id="logo">
            <img style="height: 40px; width: 40px" src="/images/logo.png">
            <p>Taskmaster</p>
        </div>
        <div id="headerTopic">
            <a href="group_home?action=viewGroups" style="text-decoration: none">
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
            <a href="javascript:void(0);" id="logoutBtn">
                <img src="https://png.pngtree.com/png-clipart/20230314/original/pngtree-log-out-vector-icon-design-illustration-png-image_8987853.png">
            </a>
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
            <div id="groupInformation">

                <div id="information">
                    <div style="display: flex; align-items: center">
                        <button id="group"><p>T</p></button>
                        <div>
                            <div style="display: flex">
                                <p id="groupName">${groupInfo.title}</p>
                                <img class="edit_group_pen"  src="/images/edit.png" onclick="showEditModal()">

                                <div id="modalContainer"></div>
                            </div>
                            <br>
                            <p style="color: white; margin-left: 15px">${groupInfo.visibility}</p>
                        </div>

                    </div>
                    <br>
                    <p id="content">${groupInfo.description}</p>
                </div>

                <c:if test="${roleIdUser == 3}">
                    <div id="addAccount">
                        <button style="background-color: #1B5B94" onclick="invite_member()">
                            <img style="width: 15px; height: 15px" src="/images/account.png" alt="">
                            <p style="color:white;">Mời thành viên vào Không gian làm việc</p>
                        </button>
                    </div>
                </c:if>
            </div>

            <div id="workspaces">
                <p style="color: white; font-weight: bold; font-size: 22px">Bảng</p>
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
                                <button class="titleBoardWorkspace">${board.title}</button>
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


    function showEditModal() {
        fetch('/view/user/group/edit_group.jsp') // Đường dẫn đến file JSP của bạn
            .then(response => response.text())
            .then(html => {
                document.getElementById("modalContainer").innerHTML = html;
                document.getElementById("editGroupModal").style.display = "block"; // Hiển thị modal
            })
            .catch(error => console.error('Error loading modal:', error));
    }

    function closeEditModal() {
        document.getElementById("editGroupModal").style.display = "none"; // Ẩn modal
    }
</script>
</body>
</html>