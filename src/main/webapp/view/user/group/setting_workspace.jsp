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

        /* Style cho phần thông tin nhóm */
        .group-info {
            display: flex;
            align-items: center;
            gap: 10px;
            background-color: #3179ba;
            padding: 20px;
            color: white;
            border-radius: 5px;
        }

        .group-info-logo {
            display: flex;
            align-items: center;
            justify-content: center;
            width: 60px;
            height: 60px;
            background-color: white;
            color: black;
            font-size: 24px;
            font-weight: bold;
            border-radius: 10px;
        }

        .group-info-detail h2 {
            margin: 0;
            font-size: 24px;
            font-weight: bold;
        }

        .group-info-detail span {
            font-size: 16px;
            color: #dcdcdc;
        }

        .workspace-description {
            margin: 15px 0;
            font-size: 16px;
        }

        .delete-workspace {
            margin-top: 20px;
        }
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
            <jsp:include page="../account/home_left.jsp" />
        </div>

        <div class="child-content-2">
            <!-- Phần tiêu đề không gian làm việc -->
            <div class="workspace-header">
                <div class="workspace-info">
                    <div class="group-info">
                        <div class="group-info-logo">
                            ${groupInfo.title.substring(0,1).toUpperCase()}
                        </div>
                        <div class="group-info-detail">
                            <h2>
                                ${groupInfo.title}
                                <button style="background: none; border: 0"></button>
                            </h2>
                            <span>${groupInfo.visibility}</span>
                        </div>
                        <p id="content">${groupInfo.description}</p>
                    </div>
                </div>
            </div>



            <!-- Nút xóa không gian làm việc -->
            <div class="delete-workspace">
                <a id="deleteWorkspaceBtn" style="color: #FF8C00; text-decoration: none;">
                    Xóa không gian làm việc này?
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
