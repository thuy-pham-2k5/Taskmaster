<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Cài đặt Không gian làm việc</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/user/group/setting_workspace.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link rel="stylesheet" href="https://unpkg.com/sweet-modal/dist/min/jquery.sweet-modal.min.css">
    <script src="https://unpkg.com/sweet-modal/dist/min/jquery.sweet-modal.min.js"></script>
    <style>
        /* Style cho modal */
        .modal {
            display: none;
            position: fixed;
            z-index: 2000;
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
<header>
    <jsp:include page="../account/menubar.jsp"/>
</header>

<main>
    <div class="home-left">
        <jsp:include page="../account/home_left.jsp"/>
    </div>
    <div class="content-member-workspace">
        <div class="group-general-info">
            <div class="group-info">
                <div class="group-info-top">
                    <div class="group-info-logo">
                        <button class="group-title">T</button>
                    </div>
                    <div class="group-info-detail">
                        <h2>
                            ${groupInfo.title}
                            <button style="background: none; border: 0"><img class="img-edit-group" src="/images/edit.png">
                            </button>
                        </h2>
                        <span>${groupInfo.visibility}</span>
                    </div>
                </div>
                <div class="group-info-bottom">
                    <p>${groupInfo.description}</p>
                </div>
            </div>
            <div class="group-invite-member">
                <button>
                    <img src="/images/add_account.png" alt="add_member.png">
                    Mời các thành viên không gian làm việc
                </button>
            </div>
        </div>
        <hr class="horizontally-divide-content">
        <div class="content-container">
            <div class="delete-workspace">
                <a id="deleteWorkspaceBtn">
                    Xóa không gian làm việc này ?
                </a>
            </div>
        </div>
    </div>
</main>


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
