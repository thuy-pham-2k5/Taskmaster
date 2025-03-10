<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Cài đặt Không gian làm việc</title>
    <link rel="stylesheet" href="/css/user/group/setting_workspace.css">
    <link rel="stylesheet" href="/css/user/group/header.css">

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link rel="stylesheet" href="https://unpkg.com/sweet-modal/dist/min/jquery.sweet-modal.min.css">
    <script src="https://unpkg.com/sweet-modal/dist/min/jquery.sweet-modal.min.js"></script>
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
    <jsp:include page="../account/menubar.jsp"/>
</div>

<!-- Container chính -->
<div class="container">
    <div class="main-content">
        <div class="child-content-1">
            <jsp:include page="../account/home_left.jsp"/>
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
                <a id="deleteWorkspaceBtn" style="color: red; text-decoration: underline;">
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
        <button class="btn btn-danger" onclick="confirmDelete()">Xóa</button>
        <button class="btn btn-close" onclick="closeDeleteModal()">Hủy</button>
    </div>
</div>
</body>
<script>
    document.getElementById("deleteWorkspaceBtn").addEventListener("click", function () {
        document.getElementById("deleteWorkspaceModal").style.display = "block";
    });

    function closeDeleteModal() {
        document.getElementById("deleteWorkspaceModal").style.display = "none";
    }

    function confirmDelete() {
        window.location.href = "/group_setting?action=deleteGroup";
    }
</script>
</html>
