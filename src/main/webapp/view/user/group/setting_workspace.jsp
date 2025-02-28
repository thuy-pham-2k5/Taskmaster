<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Cài đặt của Không gian làm việc</title>
    <link rel="stylesheet" href="/css/user/group/setting_workspace.css">
    <link rel="stylesheet" href="css/user/group/header.css">
</head>
<body>
<div class="sidebar">
    <jsp:include page="../group/header.jsp"/>
</div>
<div class="container">

<div class="main-content">
<div class="child-content-1">
    <jsp:include page="../group/home_left.jsp"/>
</div>
<div class="child-content-2">
<div class="child-content workspace-header">
<img src="https://via.placeholder.com/50" alt="Logo">
<div class="workspace-info">
<a href="group_home"></a>
<h2>Quản lý công việc Taskmaster</h2>
<c:forEach items="${groups}" var="group">
    <p> ${group.title}</p>
    <p>${group.description}</p>
    </div>
    </c:forEach>
    </div>

<%--    <div class="child-content settings">--%>
    <%--                <h3>Các cài đặt Không gian làm việc</h3>--%>

    <%--                <div class="setting-item">--%>
    <%--                    <h4>Khả năng hiển thị trong Không gian làm việc</h4>--%>
    <%--                    <p>🔒 Riêng tư - Đây là Không gian làm việc riêng tư. Chỉ những người trong Không gian làm việc có thể truy cập.</p>--%>
    <%--                    <button class="btn">Thay đổi</button>--%>
    <%--                </div>--%>

    <%--                <div class="setting-item">--%>
    <%--                    <h4>Chính sách hạn chế tạo bảng</h4>--%>
    <%--                    <p>Bất kỳ thành viên nào cũng có thể tạo 📋 bảng thông tin công khai.</p>--%>
    <%--                    <p>Bất kỳ thành viên nào cũng có thể tạo 📋 bảng thông tin hiển thị.</p>--%>
    <%--                    <p>Bất kỳ thành viên nào cũng có thể tạo 📋 bảng thông tin riêng tư.</p>--%>
    <%--                    <button class="btn">Thay đổi</button>--%>
    <%--                </div>--%>

    <%--                <div class="setting-item">--%>
    <%--                    <h4>Chính sách hạn chế xóa bảng</h4>--%>
    <%--                    <p>Bất kỳ thành viên nào cũng có thể xóa 🗑️ bảng công khai.</p>--%>
    <%--                    <p>Bất kỳ thành viên nào cũng có thể xóa 🗑️ bảng hiển thị.</p>--%>
    <%--                    <p>Bất kỳ thành viên nào cũng có thể xóa 🗑️ bảng riêng tư.</p>--%>
    <%--                    <button class="btn">Thay đổi</button>--%>
    <%--                </div>--%>

    <%--                <div class="setting-item">--%>
    <%--                    <h4>Chia sẻ các bảng với khách</h4>--%>
    <%--                    <p>Bất kỳ ai cũng có thể gửi hoặc nhận lời mời tham gia các bảng trong Không gian làm việc.</p>--%>
    <%--                    <button class="btn">Thay đổi</button>--%>
    <%--                </div>--%>
    </div>
    <div>
        <div>
            <a href="#" onclick="showWorkspaces()" style="color: red">Xoá không gian làm việc này</a>
        </div>

        <div id="workspaceList" style="display: none; margin-top: 10px;">
            <h3>Chọn không gian làm việc để xóa:</h3>
            <ul>
                <c:forEach items="${workspaces}" var="workspace">
                    <li>
                        <span>${workspace.name}</span>
                        <button onclick="deleteWorkspace('${workspace.id}')">Xóa</button>
                    </li>
                </c:forEach>
            </ul>
        </div>

        <script>
            function showWorkspaces() {
                var workspaceList = document.getElementById("workspaceList");
                workspaceList.style.display = (workspaceList.style.display === "none") ? "block" : "none";
            }

            function deleteWorkspace(workspaceId) {
                if (confirm("Bạn có chắc chắn muốn xóa không gian làm việc này?")) {
                    window.location.href = "deleteWorkspace?id=" + workspaceId;
                }
            }
        </script>

    </div>
    </div>


    </body>
    </html>
