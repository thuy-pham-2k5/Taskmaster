<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<meta charset="UTF-8">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Italianno&display=swap" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>


<style>
    body {
        margin: 0;
    }

    .parent {
        display: flex;
        padding: 8px;
        background: #3179ba;
        user-select: none;
        border-bottom: 0.1px solid white;
    }

    .child-1 {
        display: flex;
        position: relative;
        flex-basis: 0;
        flex-grow: 1;
        flex-shrink: 0;
        align-items: stretch;
    }

    .basic-list {
        display: flex;
    }

    .create-new-one {
        display: flex;
        margin: 0 4px;
        height: 32px;
        line-height: 32px;
        border: 0;
        border-radius: 5px;
        font-size: 17px;
        background: #0d599d;
        color: white;
        white-space: nowrap;
        transition: background-color 0.3s ease;
    }

    .create-new-one:hover {
        border-radius: 5px;
        background-color: #00d4ff;
    }

    .create-new-one label {
        cursor: pointer;
    }

    button {
        cursor: pointer;
    }

    .button-menubar {
        border: 0;
        height: 32px;
        margin-right: 18px;
        line-height: 32px;
        white-space: nowrap;
        background: none;
        color: white;
        font-size: 17px;
    }

    /* Container của dropdown */
    .dropdown-menubar {
        position: relative;
        display: inline-block;
    }

    /* Danh sách dropdown (ẩn mặc định) */
    .dropdown-content {
        transform: translateY(8px);
        display: none;
        position: absolute;
        padding: 12px;
        background-color: #1d71bc;
        min-width: 292px;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        border-radius: 5px;
        z-index: 9999;
    }

    /* Các item trong dropdown */
    .dropdown-content a {
        color: white;
        padding: 10px;
        display: block;
        text-decoration: none;
        cursor: pointer;
    }

    .dropdown-content a:hover {
        border-radius: 5px;
        background-color: rgb(59 139 210);
    }

    .dropdown-menubar button.active,
    .dropdown-menubar button:hover {
        background-color: rgb(227 226 226 / 50%);
        border-radius: 5px;
    }

    .child-2 {
        display: flex;
        justify-content: flex-end;
    }

    .img-menubar {
        width: 20px;
        height: 20px;
    }

    .img-account {
        border-radius: 50%;
        border: 1px solid;
        padding: 3px;
        height: 25px;
        width: 25px;
    }

    .logo-web {
        display: flex;
        align-items: center;
        text-decoration: none;
        color: white;
        font-family: inherit;
        padding: 4px;
        margin-right: 15px;
    }

    .logo-web:hover {
        border-radius: 5px;
        background-color: rgba(217, 217, 217, 0.5);
    }

    .logo-web div {
        margin-right: 4px;
        margin-left: 4px;
    }

    .img-logo {
        transform: translateY(-3px);
        width: 24px;
        height: 24px;
    }

    .text-logo {
        transform: translateY(2px);
        display: flex;
        line-height: 0;
        font-size: 30px;
        font-family: "Italianno", serif;
        font-style: normal;
    }

    .backup-list {
        display: flex;
    }

    .dropdown-img {
        width: 14px;
        margin-left: 4px;
        transform: translateY(2px);
    }

    .input-search {
        height: 32px;
        margin-right: 10px;
        background: none;
        border: 1px solid white;
        border-radius: 5px;
        padding: 9px;
    }

    .input-search:focus {
        border: 2px solid #a7f5ff;
        outline: none;
        width: 350px;
    }

    .notification {
        display: inline-block;
        position: relative;
        margin-right: 10px;
    }

    .img-notification {
        margin-right: 9px;
    }

    .img-notification img {
        width: 32px;
        height: 32px;
    }

    .number-of-notification {
        position: absolute;
        top: 0;
        right: 0;
        background-color: red;
        color: white;
        border-radius: 50%;
        font-size: 10px;
        width: 17px;
        height: 17px;
        display: flex;
        justify-content: center;
        align-items: center;
    }

    .input-search::placeholder {
        color: #dcd8d8; /* Màu placeholder (xám nhạt) */
        font-style: italic; /* Làm nghiêng chữ */
        opacity: 1; /* Đảm bảo độ rõ nét */
    }

    @media screen {
        .backup-list {
            display: none;
        }

        .create-new-one img {
            display: none;
        }
    }

    @media (max-width: 1170px) {
        .basic-list-3, #link-add-workspace, #link-add-recent {
            display: none;
        }

        .backup-list {
            display: block;
        }

        .create-new-one label {
            display: none;
        }

        .create-new-one img {
            display: inline-block;
        }
    }

    @media (max-width: 1000px) {
        .basic-list-2 {
            display: none;
        }

        #link-add-recent {
            display: block;
        }
    }

    @media (max-width: 900px) {
        .basic-list-1 {
            display: none;
        }

        #link-add-workspace {
            display: block;
        }
    }
</style>

<div class="parent">
    <div class="child-1">
        <a href="/account_home" class="logo-web">
            <div>
                <img class="img-logo" src="/images/logo.png" alt="logo.png">
            </div>
            <div>
                <span class="text-logo">Taskmaster</span>
            </div>
        </a>
        <div class="basic-list">
            <div class="dropdown-menubar">
                <button class="button-hover button-menubar basic-list-1" onclick="toggleDropdownMenubar('workspace', this)">
                    Các không gian làm việc
                    <img src="/images/list.png" alt="dropdown.png" class="dropdown-img">
                </button>
                <div class="dropdown-content" id="workspace">
                    <c:forEach items="${groups}" var="group">
                        <a href="/account_home?action=showGroupHomeView&groupId=${group.groupId}">${group.title}</a>
                    </c:forEach>
                </div>
            </div>
            <div class="dropdown-menubar">
                <button class="button-hover button-menubar basic-list-2" onclick="toggleDropdownMenubar('recent', this)">
                    Gần đây
                    <img src="/images/list.png" alt="dropdown.png" class="dropdown-img">
                </button>
                <div class="dropdown-content" id="recent">
                    <a href="#">Tùy chọn 3</a>
                    <a>Tùy chọn 4</a>
                    <a>Tùy chọn 5</a>
                </div>
            </div>
            <div class="dropdown-menubar">
                <button class="button-hover button-menubar basic-list-3" onclick="toggleDropdownMenubar('stars', this)">
                    Đã đánh dấu sao
                    <img src="/images/list.png" alt="dropdown.png" class="dropdown-img">
                </button>
                <div class="dropdown-content" id="stars">
                    <a href="#">Tùy chọn 6</a>
                    <a href="#">Tùy chọn 7</a>
                    <a href="#">Tùy chọn 8</a>
                </div>
            </div>
        </div>
        <div class="backup-list">
            <div class="dropdown-menubar">
                <button class="button-hover button-menubar" onclick="toggleDropdownMenubar('add', this)">
                    Thêm
                    <img src="/images/list.png" alt="dropdown.png" class="dropdown-img">
                </button>
                <div>
                    <div class="dropdown-content" id="add">
                        <a id="link-add-workspace" onclick="toggleDisplayMenubar(event, 'add-workspace', this)">Các không gian làm việc</a>
                        <a id="link-add-recent" onclick="toggleDisplayMenubar(event, 'add-recent', this)">Gần đây</a>
                        <a id="link-add-stars" onclick="toggleDisplayMenubar(event, 'add-stars', this)">Đã đánh dấu sao</a>
                    </div>
                    <div class="dropdown-content" id="add-workspace">
                        <div style="display: flex; justify-content: space-between; margin-bottom: 15px">
                            <button style="background: none; border: 0; transform: rotate(90deg);">
                                <img src="/images/list.png" onclick="goBack(event, 'add-workspace', 'add')" alt="back.png" style="width: 15px;">
                            </button>
                            <span style="color: white; font-weight: bold">Các không gian làm việc</span>
                            <button style="background: none; border: 0;">
                                <img src="/images/closed.png" onclick="closeDropdown(event)" alt="back.png" style="width: 20px;">
                            </button>
                        </div>
                        <c:forEach items="${groups}" var="group">
                            <a href="/account_home?action=showGroupHomeView&groupId=${group.groupId}">${group.title}</a>
                        </c:forEach>
                    </div>
                    <div class="dropdown-content" id="add-recent">
                        <div style="display: flex; justify-content: space-between; margin-bottom: 15px">
                            <button style="background: none; border: 0; transform: rotate(90deg);">
                                <img src="/images/list.png" onclick="goBack(event, 'add-recent', 'add')" alt="back.png" style="width: 15px;">
                            </button>
                            <span style="color: white; font-weight: bold">Gần đây</span>
                            <button style="background: none; border: 0;">
                                <img src="/images/closed.png" onclick="closeDropdown(event)" alt="back.png" style="width: 20px;">
                            </button>
                        </div>
                        <a>Tùy chọn 3</a>
                        <a>Tùy chọn 4</a>
                    </div>
                    <div class="dropdown-content" id="add-stars">
                        <div style="display: flex; justify-content: space-between; margin-bottom: 15px;">
                            <button style="background: none; border: 0; transform: rotate(90deg);">
                                <img src="/images/list.png" onclick="goBack(event, 'add-stars', 'add')" alt="back.png" style="width: 15px;">
                            </button>
                            <span style="color: white; font-weight: bold">Đã đánh dấu sao</span>
                            <button style="background: none; border: 0;">
                                <img src="/images/closed.png" onclick="closeDropdown(event)" alt="back.png" style="width: 20px;">
                            </button>
                        </div>
                        <a>Tùy chọn 5</a>
                        <a>Tùy chọn 6</a>
                    </div>
                </div>
            </div>
        </div>
        <div>
            <div class="dropdown-menubar">
                <button class="create-new-one" onclick="toggleDropdownMenubar('create-new', this)">
                    <label>Tạo mới</label>
                    <img class="img-menubar" src="/images/plus.png" alt="plus.png" style="margin: auto">
                </button>
                <div class="dropdown-content" id="create-new">
                    <p>Tạo bảng</p>
                    <p>Phông nền</p>
                    <p>Tiêu đề bảng</p>
                </div>
            </div>
        </div>
    </div>
    <div class="child-2">
        <div>
            <input class="input-search" placeholder="🔍 Tìm kiếm...">
        </div>
        <div class="notification" style="cursor: pointer">
            <div class="img-notification"><img class="img-menubar" src="/images/bell.png" alt="notice.png"></div>
            <div class="number-of-notification"><span>3</span></div>
        </div>
        <div>
            <div class="dropdown-menubar">
                <button class="button-menubar" style="padding: 0" onclick="toggleDropdownMenubar('account', this)"><img
                        class="img-account" src="/images/account.png" alt="account.png"></button>
                <div class="dropdown-content" id="account">
                    <h4 style="color: white">Tài khoản</h4>
                    <a>Hồ sơ và hiển thị</a>
                    <a>Hoạt động</a>
                    <a>Thẻ</a>
                    <a>Cài đặt</a>
                    <hr>
                    <a href="group_home?action=showCreateGroup">Tạo Không gian làm việc</a>
                    <hr>
                    <a href="javascript:void(0);" id="logoutBtn">Đăng xuất</a>
                </div>
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

    function toggleDropdownMenubar(dataId, button) {
        let dropdown = document.getElementById(dataId);

        // Đóng tất cả dropdown khác và xóa class active của tất cả button
        document.querySelectorAll(".dropdown-content").forEach(menu => {
            if (menu.id !== dataId) {
                menu.style.display = "none";
            }
        });
        document.querySelectorAll(".dropdown-menubar button").forEach(btn => {
            if (btn !== button) {
                btn.classList.remove("active");
            }
        });

        // Kiểm tra trạng thái dropdown và toggle active class
        if (dropdown.style.display === "block") {
            dropdown.style.display = "none";
            button.classList.remove("active"); // Xóa active khi đóng dropdown
        } else {
            dropdown.style.display = "block";
            button.classList.add("active"); // Thêm active khi mở dropdown

            let rect = dropdown.getBoundingClientRect();
            let windowWidth = window.innerWidth;

            if (rect.left < 0) {
                dropdown.style.left = "0px";
                dropdown.style.right = "auto";
            } else if (rect.right > windowWidth) {
                dropdown.style.left = "auto";
                dropdown.style.right = "0px";
            }
        }
    }

    // Ẩn tất cả dropdown khi click ra ngoài
    window.onclick = function (event) {
        let button = event.target.closest(".dropdown-menubar button"); // Tìm button cha nếu có
        let dropdownContent = event.target.closest(".dropdown-content"); // Tìm dropdown đang chứa phần tử click vào

        if (!button && !dropdownContent) { // Nếu không phải button hoặc phần tử trong dropdown
            document.querySelectorAll(".dropdown-content").forEach(menu => {
                menu.style.display = "none";
            });
            document.querySelectorAll(".dropdown-menubar button").forEach(btn => {
                btn.classList.remove("active");
            });
        }
    };

    function toggleDisplayMenubar(event, id, link) {
        event.stopPropagation(); // Ngăn chặn sự kiện click lan lên window

        let dropdown = document.getElementById(id);

        // Ẩn dropdown cha của thẻ a được nhấn
        let parentDropdown = link.closest(".dropdown-content");
        if (parentDropdown) {
            parentDropdown.style.display = "none";
        }

        // Ẩn tất cả các dropdown khác
        document.querySelectorAll(".dropdown-content").forEach(div => {
            if (div.id !== id) {
                div.style.display = "none";
            }
        });

        // Toggle hiển thị dropdown con
        dropdown.style.display = (dropdown.style.display === "block") ? "none" : "block";
    }

    function goBack(event, currentId, needId) {
        event.stopPropagation(); // Ngăn sự kiện click lan lên window
        document.getElementById(currentId).style.display = "none"; // Ẩn dropdown hiện tại
        document.getElementById(needId).style.display = "block"; // Hiển thị lại dropdown chính
    }

    function closeDropdown(event) {
        event.stopPropagation();
        document.querySelectorAll(".dropdown-content").forEach(menu => {
            if (menu.style.display === "block") {
                menu.style.display = "none";
            }
        });
    }
</script>

