<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Cài đặt Không gian làm việc</title>
    <link rel="stylesheet" href="/css/user/group/setting_workspace.css">
    <link rel="stylesheet" href="/css/user/group/header.css">
    <style>
        /* Style cho modal */
        .modal {
            display: none;
            position: fixed;
            z-index: 1;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
        }
        .modal-content {
            background-color: white;
            margin: 10% auto;
            padding: 20px;
            border-radius: 10px;
            width: 40%;
            text-align: center;
        }
        .btn {
            padding: 10px 15px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        .btn-danger { background-color: red; color: white; }
        .btn-close { background-color: gray; color: white; }
        #errorMessage { color: red; display: none; }
    </style>
</head>
<body>

<!-- Sidebar -->
<div class="sidebar">
    <jsp:include page="../group/header.jsp"/>
</div>

<!-- Container chính -->
<div class="container">
    <div class="main-content">
        <div class="child-content-1">
            <jsp:include page="../group/home_left.jsp"/>
        </div>

        <div class="child-content-2">
            <div class="workspace-header">
                <img src="https://via.placeholder.com/50" alt="Logo">
                <div class="workspace-info">
                    <h2>Quản lý công việc Taskmaster</h2>
                    <c:forEach items="${groups}" var="group">
                        <p><strong>${group.title}</strong></p>
                        <p>${group.description}</p>
                    </c:forEach>
                </div>
            </div>

            <!-- Nút xóa không gian làm việc -->
            <div>
                <a href="javascript:void(0);" onclick="openDeleteModal()" style="color: red; text-decoration: underline;">
                    Xóa không gian làm việc này
                </a>
            </div>
        </div>
    </div>
</div>

<!-- Modal xác nhận xóa -->
<div id="deleteWorkspaceModal" class="modal">
    <div class="modal-content">
        <h3>Xác nhận xóa không gian làm việc</h3>
        <p>Nhập tên không gian làm việc để xác nhận xóa:</p>
        <input type="text" id="workspaceNameInput" placeholder="Nhập tên không gian làm việc...">
        <p id="errorMessage"></p>
        <br>
        <button class="btn btn-danger" onclick="confirmDelete()">Xóa</button>
        <button class="btn btn-close" onclick="closeDeleteModal()">Hủy</button>
    </div>
</div>

<!-- Script xử lý modal và xác nhận xóa -->
<script>
    function confirmDelete() {
        let enteredName = document.getElementById("workspaceNameInput").value.trim();
        let workspaceName = "${group.title}".trim();

        if (enteredName === workspaceName) {
            fetch("group_setting", {
                method: "POST",
                headers: { "Content-Type": "application/x-www-form-urlencoded" },
                body: "id=" + encodeURIComponent("${group.group_id}")
            })
                .then(response => {
                    if (response.ok) {
                        alert("Xóa thành công!");
                        window.location.reload();
                    } else {
                        alert("Xóa thất bại!");
                    }
                })
                .catch(error => console.error("Lỗi:", error));
        } else {
            document.getElementById("errorMessage").style.display = "block";
            document.getElementById("errorMessage").innerHTML = "⚠️ Tên không gian làm việc không đúng!";
        }
    }

</script>

</body>
</html>
