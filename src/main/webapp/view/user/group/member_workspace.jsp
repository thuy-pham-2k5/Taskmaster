<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>Thành viên Không gian làm việc</title>
    <link rel="stylesheet" href="/css/user/group/memberWorkspace.css">
</head>
<body>
<main>
    <div class="content-container">
        <div class="content">
            <header class="header-content">
                <h2>Người cộng tác</h2>
            </header>
            <div class="main-content">
                <%--nội dung bên trái--%>
                <div class="main-content-sidebar">
                    <ul>
                        <li id="member" onclick="toggleDisplay('member')"><a>Thành viên Không gian làm việc</a></li>
                        <li id="guest" onclick="toggleDisplay('guest')"><a>Khách</a></li>
                        <hr>
                        <li id="request" onclick="toggleDisplay('request')"><a>Yêu cầu tham gia</a></li>
                    </ul>
                </div>

                <%--nội dung bên phải--%>
                <div class="main-content-show">
                    <div>
                        <%--thành viên Không gian--%>
                        <div class="member-section">
                            <h2>Thành viên Không gian làm việc</h2>
                            <p>Các thành viên trong Không gian làm việc có thể xem và tham gia tất cả các bảng Không
                                gian làm việc hiển thị và tạo ra các bảng mới trong Không gian làm việc.</p>
                        </div>
                        <%--khách--%>
                        <div class="guest-section" style="display: none;">
                            <h2>Khách</h2>
                            <p>Khách chỉ có thể xem và chỉnh sửa bảng mà họ được thêm vào.</p>
                        </div>
                        <%--yêu cầu tham gia--%>
                        <jsp:useBean id="user" scope="session" type="com.example.taskmaster.model.User"/>
                        <c:if test="${user.roleId == 3}">
                        <div class="request-section" style="display: none;">
                            <h2>Yêu cầu tham gia</h2>
                        </div>
                        </c:if>
                    </div>
                    <hr>
                    <div>
                        <input class="input-search" placeholder="Lọc theo tên">
                    </div>
                    <hr>
                    <div>
                        <div class="member-section">
                            <c:forEach items="${members}" var="user">
                                <div class="user-general-info">
                                    <div class="user-info">
                                        <p class="user-info-name">${user.fullName}</p>
                                        <p>@${user.username}</p>
                                    </div>
                                    <div class="user-button-change">
                                        <button>${user.roleName}</button>
                                        <button>Loại bỏ</button>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                        <div class="guest-section" style="display: none;">
                            <c:forEach items="${guests}" var="user">
                                <div>
                                    <label>${user.fullName}</label>
                                    <label>${user.username}</label>
                                    <label>${user.roleName}</label>
                                    <a href="/group_member?action=delete&userId=${user.userId}">
                                        <button>Loại bỏ</button>
                                    </a>
                                </div>
                            </c:forEach>
                        </div>
                        <div class="request-section" style="display: none;">
                            <c:forEach items="${requests}" var="user">
                                <div>
                                    <label>${user.fullName}</label>
                                    <label>${user.username}</label>
                                    <a href="/group_member?action=delete&userId=${user.userId}">
                                        <button>Loại bỏ</button>
                                    </a>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</main>
<script>
    let currentButtonId = "member"; // Đặt member là mặc định

    function toggleDisplay(buttonId) {
        if (currentButtonId === buttonId) {
            return; // Không làm gì nếu button hiện tại được nhấn lại
        }

        if (currentButtonId) {
            let currentSections = document.getElementsByClassName(currentButtonId + "-section");
            for (let section of currentSections) {
                section.style.display = "none";
            }
        }
        let sections = document.getElementsByClassName(buttonId + "-section");
        for (let section of sections) {
            section.style.display = "block";
        }
        document.querySelectorAll('.main-content-sidebar ul li').forEach(li => li.classList.remove('active'));
        document.getElementById(buttonId).classList.add('active');

        // Cập nhật button hiện tại
        currentButtonId = buttonId;
    }

    window.onload = function () {
        document.getElementById('member').classList.add('active');
        toggleDisplay("member"); // section mặc định
    }
</script>
</body>
</html>
