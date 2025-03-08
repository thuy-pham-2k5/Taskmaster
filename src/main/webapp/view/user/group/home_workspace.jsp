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
                            <div class="dropdown-menubar">
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
                            <div style="display: flex; justify-content: center; align-items: center">
                                <p id="groupName">${groupInfo.title}</p>
                                <img class="edit_group_pen"  src="/images/edit.png" onclick="showEditModal()">

                                <div id="modalContainer"></div>
                            </div>
                            <p style="color: white; margin-left: 40px; margin-top: 0px">${groupInfo.visibility}</p>
                        </div>

                    </div>
                    <br>
                    <p id="content">${groupInfo.description}</p>
                </div>
                <!-- Phần chỉnh sửa, Ẩn mặc định -->
                <div id="edit_frame">
                    <label>🏢 Tên không gian làm việc</label>
                    <input type="text" id="groupNameInput" style="margin-bottom: 20px" value="${groupInfo.title}">

                    <label>📝 Mô tả (tùy chỉnh)</label>
                    <textarea id="groupDescInput">${groupInfo.description}</textarea>

                    <div class="button-group">
                        <button class="save-btn" onclick="saveEditGroup()">Lưu</button>
                        <button class="cancel-btn" onclick="cancelEdit()">Hủy</button>
                    </div>
                </div>


                <c:if test="${roleIdUser == 3}">
                    <div id="addAccount">
                        <button style="background-color: #1B5B94; padding: 10px;cursor: pointer;border-radius: 5px;align-items: center;height: 35px;justify-content: space-around;display: flex;width: 285px;border: none;" onclick="invite_member()">
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

    function showEditModal() {
        // Ẩn div information và hiển thị div edit_frame
        document.getElementById("information").style.display = "none";
        document.getElementById("edit_frame").style.display = "block";

        // Copy nội dung cũ vào input
        document.getElementById("editInput").value = document.getElementById("groupName").textContent;
    }

    function saveChanges() {
        // Cập nhật nội dung mới
        document.getElementById("groupName").textContent = document.getElementById("editInput").value;

        // Quay về trạng thái hiển thị ban đầu
        document.getElementById("edit_frame").style.display = "none";
        document.getElementById("information").style.display = "block";
    }

    function cancelEdit() {
        // Hủy chỉnh sửa, quay về ban đầu
        document.getElementById("edit_frame").style.display = "none";
        document.getElementById("information").style.display = "block";
    }















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

</script>
</body>
</html>