<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>Thành viên Không gian làm việc</title>
    <link rel="stylesheet" href="/css/user/group/memberWorkspace.css">
</head>
<body>
<header>
    <jsp:include page="../account/menubar.jsp"/>
</header>
<main>
    <div class="home-left">
        Day la home left
    </div>
    <div class="content-member-workspace">
        <div class="group-general-info">
            <div class="group-info">
                <div class="group-info-logo">
                    <button class="group-title">T</button>
                </div>
                <div class="group-info-detail">
                    <h2>
                        Taskmaster
                        <button style="background: none; border: 0"><img class="img-edit-group" src="/images/edit.png">
                        </button>
                    </h2>
                    <span>Riêng tư</span>
                </div>
            </div>
            <div class="group-invite-member">
                <button>
                    <img src="/images/add_account.png" alt="add_member.png">
                    Mời các thành viên không gian làm việc
                </button>
            </div>
        </div>
        <div class="content-container">
            <div class="content">
                <div class="header-content">
                    <h2>Người cộng tác</h2>
                </div>
                <div class="main-content">
                    <%--nội dung bên trái--%>
                    <div class="main-content-sidebar">
                        <ul>
                            <li id="member" onclick="toggleDisplay('member')"><a>Thành viên không gian làm việc</a></li>
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
                                <h2>Thành viên không gian làm việc</h2>
                                <p>Các thành viên trong Không gian làm việc có thể xem và tham gia tất cả các bảng Không
                                    gian làm việc hiển thị và tạo ra các bảng mới trong Không gian làm việc.</p>
                            </div>
                            <%--khách--%>
                            <div class="guest-section" style="display: none;">
                                <h2>Khách</h2>
                                <p>Khách chỉ có thể xem và chỉnh sửa bảng mà họ được thêm vào.</p>
                            </div>
                            <%--yêu cầu tham gia--%>
                            <div class="request-section" style="display: none;">
                                <h2>Yêu cầu tham gia</h2>
                                <p>Những người này đã yêu cầu tham gia Không gian làm việc này.</p>
                            </div>
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
                                    <div class="user-general-info">
                                        <div class="user-info">
                                            <p class="user-info-name">${user.fullName}</p>
                                            <p>${user.username}</p>
                                        </div>
                                        <div class="user-button-change">
                                            <a href="#">
                                                <button>Xem bảng thông tin</button>
                                            </a>
                                            <a href="#">
                                                <button>Thêm vào không gian làm việc</button>
                                            </a>
                                            <a href="/group_member?action=delete&userId=${user.userId}">
                                                <button>Loại bỏ</button>
                                            </a>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                            <div class="request-section" style="display: none;">
                                <c:forEach items="${requests}" var="user">
                                    <div class="user-general-info">
                                        <div class="user-info">
                                            <p class="user-info-name">${user.fullName}</p>
                                            <p>${user.username}</p>
                                        </div>
                                        <div class="user-button-change">
                                            <p>Đã gửi yêu cầu vào 15/3/2025</p>
                                            <a>
                                                <button>Thêm vào không gian làm việc</button>
                                            </a>
                                            <a href="/group_member?action=delete&userId=${user.userId}">
                                                <button>Loại bỏ</button>
                                            </a>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
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
