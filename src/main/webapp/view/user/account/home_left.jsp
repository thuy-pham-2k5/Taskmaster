<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<style>
    .position-home-left {
        width: 260px;
        position: sticky;
        top: 48px;
        left: 0;
        height: calc(100vh - 50px);
    }

    .home-left {
        width: 260px;
        z-index: 5;
        background: #3179ba;
    }

    .home-left-child {
        color: white;
        width: inherit;
        position: absolute;
        top: 0;
        bottom: 0;
        left: 0;
        display: flex;
        flex-direction: column;
        background: inherit;
        box-shadow: 1px 0 0 #fff;
        font-size: 15px;
    }

    .home-left-child span {
        color: white;
    }

    .hl-group-info {
        margin: 0;
        padding: 8px 12px;
        display: flex;
        box-shadow: 0 0.8px 0 #fff;
        align-items: center;
    }

    .group-logo-link {
        width: 32px;
        height: 32px;
        background: linear-gradient(180deg, #006644, #4bce97);
        border-radius: 5px;
        font-size: 20px;
        font-weight: bold;
        color: white;
        display: flex;
        align-items: center;
        justify-content: center;
        color: white;
    }

    .group-info-text {
        flex: 1;
        margin: 0 4px 0 8px;
        text-align: left;
    }

    .group-info-text span {
        font-size: 20px;
    }

    .group-info-text span a {
        color: white;
    }

    .group-info-text p {
        color: white;
        margin: 8px 0 0 0;
        font-size: 14px;
    }

    a {
        text-decoration: none;
    }

    .closed-home-left {
        background: none;
        padding: 2px;
        font-size: 14px;
        font-family: -apple-system, BlinkMacSystemFont, Segoe UI, Roboto, Noto Sans, Ubuntu, Droid Sans, Helvetica Neue, sans-serif;
        border: 0;
    }

    .closed-home-left img {
        width: 15px;
        transform: rotate(90deg);
    }

    .hl-group-basic-features {
        padding-top: 12px;
        padding-bottom: 9px;
        display: flex;
        flex-direction: column;
    }

    .hl-group-basic-features a {
        padding: 10px 0 10px 10px;
        display: flex;
        align-items: center;
    }

    .hl-group-basic-features a:hover {
        background: rgb(106 103 103 / 50%);
        border-radius: 5px;
    }

    .hl-group-basic-features a span {
        margin-left: 10px;
        line-height: 20px;
    }

    .hl-img {
        width: 18px;
    }

    .hl-general-info {
        flex: 1;
    }

    .hl-list-boards {
        margin-top: 6px;
    }

    .hl-list-boards-title {
        display: flex;
        padding: 0 10px;
        justify-content: space-between;
        height: 22px;
    }

    .hl-list-boards-title h3 {
        margin: 0;
    }

    .hl-list-boards-title div {
        display: flex;
        align-items: center;
    }

    .hl-list-boards-title-closed-board-img {
        display: none;
        padding: 5px;
        width: 13px;
        height: 13px;
        border-radius: 5px;
        margin-right: 10px;
    }

    .hl-list-boards-title:hover .hl-list-boards-title-closed-board-img {
        display: block;
        background: rgb(227 226 226 / 50%);
    }

    .hl-list-boards-title-add-board-img {
        width: 18px;
        height: 18px;
    }

    .hl-list-boards-ul {
        scrollbar-color: #fff6 #00000026;
        scrollbar-width: thin;
        overflow-y: auto;
        max-height: 457px;
        margin: 5px 0 0 0;
        padding: 0;
    }

    .hl-list-boards-ul li {
        padding: 5px 12px 0 12px;
        height: 32px;
        display: flex;
        align-items: center;
        justify-content: space-between;
    }

    .hl-list-boards-ul li a {
        text-overflow: ellipsis;
        overflow: hidden;
        display: block;
        white-space: nowrap;
        color: white;
    }

    .hl-list-boards-ul li:hover {
        background: rgb(227 226 226 / 50%);
        cursor: pointer;
    }

    .hl-list-boards-ul li:hover img {
        display: block;
    }

    .hl-list-boards-ul li img {
        width: 15px;
        height: 15px;
        display: none;
        margin: 0 0 0 15px;
    }


    /*đóng và rời bảng.*/
    /* Container của dropdown */
    .dropdown-menubar-leave-board {
        position: relative;
        display: inline-block;
    }

    /* Danh sách dropdown (ẩn mặc định) */
    .dropdown-content-leave-board {
        transform: translateY(8px);
        display: none;
        position: absolute;
        padding: 12px;
        background-color: #1d71bc;
        width: 300px;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        border-radius: 5px;
        z-index: 9999;
    }

    .form-first-action {
        width: 100%;
        color: white;
        padding: 10px;
        display: flex;
        justify-content: space-between;
        text-decoration: none;
        cursor: pointer;
    }


    .form-first-action:hover {
        border-radius: 5px;
        background-color: rgb(0, 185, 255);
    }


    .form-second-action {
        display: flex;
        width: 100%;
        color: white;
        background-color: #d71212;
        padding: 5px;
        border-radius: 5px;
        justify-content: center;
        text-decoration: none;
        cursor: pointer;
    }

    .form-second-action:hover {
        background-color: #ff0000;
        padding: 5px;
        border-radius: 5px;
        justify-content: center;
    }

    .form-title-first-board {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 10px;
    }

    .form-title-second-board {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 10px;
    }

    .content-leave-board {
        color: white;
        align-items: center;
        margin-bottom: 10px;
    }


    .dropdown-menubar-leave-board button.active,
    .dropdown-menubar-leave-board button:hover {
        background-color: rgb(227 226 226 / 50%);
        border-radius: 5px;
    }
</style>

<div class="position-home-left">
    <nav class="home-left">
        <div class="home-left-child">
            <div class="hl-group-info">
                <div class="hl-group-info-logo">
                    <a class="group-logo-link" href="group_home">${groupInfo.title.substring(0,1).toUpperCase()}</a>
                </div>
                <div class="group-info-text">
                    <span style="line-height: 20px"><a href="group_home">${groupInfo.title}</a></span>
                    <p>Riêng tư</p>
                </div>
                <button class="closed-home-left">
                    <img class="hl-img" src="/images/list.png" alt="closed-menu.png">
                </button>
            </div>
            <div class="hl-general-info">
                <div>
                    <div class="hl-group-basic-features">
                        <a href="group_home">
                            <img class="hl-img" src="/images/board.png" alt="board.png">
                            <span>Bảng</span>
                        </a>
                        <a href="group_member">
                            <img class="hl-img" src="/images/account.png" alt="account.png">
                            <span>Thành viên</span>
                        </a>
                        <a href="group_setting">
                            <img class="hl-img" src="/images/setting.png" alt="setting.png">
                            <span>Các cài đặt không gian làm việc</span>
                        </a>
                    </div>
                    <div class="hl-list-boards">
                        <div class="hl-list-boards-title">
                            <h3>Các bảng của bạn</h3>
                            <div>
                                <img class="hl-list-boards-title-closed-board-img" src="/images/ellipsis.png"
                                     alt="closed-board"/>
                                <img class="hl-list-boards-title-add-board-img" src="/images/plus.png" alt="plus.png">
                            </div>
                        </div>
                        <ul class="hl-list-boards-ul">
                            <c:forEach items="${boards}" var="board">
                                <li>
                                    <a href="board_home?boardId=${board.boardId}">${board.title}</a>
                                    <div class="dropdown-menubar-leave-board">
                                        <img id="${board.boardId}" src="/images/ellipsis.png" alt="dropdown.png"
                                             class="dropdown-img button-menubar"
                                             onclick="toggleDropdownMenubar('${board.boardId}', this)">
                                        <div class="dropdown-content-leave-board" id="dropdown-${board.boardId}">
                                            <div class="form-title-first-board">
                                                <span style="color: white; font-weight: bold">${board.title}</span>
                                                <button style="background: none; border: 0;">
                                                    <img src="/images/closed.png" onclick="closeDropdown(event)" alt="back.png"
                                                         style="width: 20px;">
                                                </button>
                                            </div>
                                            <hr>
                                            <div class="form-action-board">
                                                <a class="form-first-action" onclick="toggleDisplayMenubar(event, 'leave-board', this)">
                                                    Rời khỏi bảng
                                                    <span class="arrow">›</span>
                                                </a>
                                            </div>
                                            <div class="form-action-board">
                                                <a class="form-first-action" onclick="toggleDisplayMenubar(event, 'delete-board', this)">
                                                    Xóa bảng
                                                    <span class="arrow">›</span>
                                                </a>
                                            </div>
                                        </div>
                                        <div class="dropdown-content-leave-board" id="leave-board">
                                            <div class="form-title-second-board">
                                                <button style="background: none; border: 0; transform: rotate(90deg);">
                                                    <img src="/images/list.png"
                                                         onclick="goBack(event, 'leave-board', 'dropdown-${board.boardId}')"
                                                         alt="back.png"
                                                         style="width: 15px;">
                                                </button>
                                                <span style="color: white; font-weight: bold">${board.title}</span>
                                                <button style="background: none; border: 0;">
                                                    <img src="/images/closed.png" onclick="closeDropdown(event)"
                                                         alt="back.png"
                                                         style="width: 20px;">
                                                </button>
                                            </div>
                                            <hr>
                                            <p class="content-leave-board">Bạn sẽ bị loại bỏ khỏi toàn bộ thẻ trong
                                                bảng này.</p>
                                            <div class="form-action-board">
                                                <a class="form-second-action" onclick="closeDropdown(event)">Rời
                                                    khỏi bảng</a>
                                            </div>
                                        </div>
                                        <div class="dropdown-content-leave-board" id="delete-board">
                                            <div class="form-title-second-board">
                                                <button style="background: none; border: 0; transform: rotate(90deg);">
                                                    <img src="/images/list.png"
                                                         onclick="goBack(event, 'delete-board', 'dropdown-${board.boardId}')"
                                                         alt="back.png"
                                                         style="width: 15px;">
                                                </button>
                                                <span style="color: white; font-weight: bold">${board.title}</span>
                                                <button style="background: none; border: 0;">
                                                    <img src="/images/closed.png" onclick="closeDropdown(event)"
                                                         alt="back.png"
                                                         style="width: 20px;">
                                                </button>
                                            </div>
                                            <hr>
                                            <p class="content-leave-board">Bạn sẽ bị loại bỏ khỏi toàn bộ thẻ trong
                                                bảng này.</p>
                                            <div class="form-action-board">
                                                <a class="form-second-action" onclick="closeDropdown(event)">Xóa
                                                    khỏi bảng</a>
                                            </div>
                                        </div>
                                    </div>
                                </li>
                            </c:forEach>
                        </ul>
                    </div>
                </div>
            </div>
            <%--        <div class="hl-auxiliary-part">--%>
            <%--            <div class="role-guest-workspace">--%>
            <%--                <p>Bạn là khách của không gian làm việc.</p>--%>
            <%--                <p>Để xem các bảng và thành viên khác trong không gian làm việc này, quản trị viên phải thêm bạn làm--%>
            <%--                    thành viên không gian làm việc</p>--%>
            <%--                <button>Yêu cầu tham gia</button>--%>
            <%--            </div>--%>
            <%--        </div>--%>
        </div>
    </nav>
</div>
<script>

    function toggleDropdownMenubar(boardId, img) {
        let dropdown = document.getElementById("dropdown-" + boardId);

        // Đóng tất cả dropdown khác
        document.querySelectorAll(".dropdown-content-leave-board").forEach(menu => {
            if (menu.id !== "dropdown-" + boardId) {
                menu.style.display = "none";
            }
        });

        // Xóa class active khỏi tất cả hình ảnh khác
        document.querySelectorAll(".dropdown-menubar-leave-board img").forEach(imgEl => {
            if (imgEl !== img) {
                imgEl.classList.remove("active");
            }
        });

        // Kiểm tra trạng thái dropdown và toggle active class
        if (dropdown.style.display === "block") {
            dropdown.style.display = "none";
            img.classList.remove("active");
        } else {
            dropdown.style.display = "block";
            img.classList.add("active");

            // Lấy vị trí của dấu ba chấm
            let rect = img.getBoundingClientRect();
            let dropdownWidth = dropdown.offsetWidth;
            let windowWidth = window.innerWidth;

            // Đặt vị trí dropdown ngay dưới dấu ba chấm
            dropdown.style.position = "absolute";

            // Kiểm tra nếu dropdown bị tràn khỏi màn hình bên phải
            if (rect.left + dropdownWidth > windowWidth) {
                dropdown.style.left = (rect.right - dropdownWidth) + "px"; // Căn phải
            }
        }
    }

    // Ẩn dropdown khi click ra ngoài
    window.onclick = function (event) {
        let img = event.target.closest(".dropdown-menubar-leave-board img");
        let dropdownContent = event.target.closest(".dropdown-content-leave-board");

        if (!img && !dropdownContent) {
            document.querySelectorAll(".dropdown-content-leave-board").forEach(menu => {
                menu.style.display = "none";
            });
            document.querySelectorAll(".dropdown-menubar-leave-board img").forEach(imgEl => {
                imgEl.classList.remove("active");
            });
        }
    };


    function toggleDisplayMenubar(event, id, link) {
        event.stopPropagation(); // Ngăn chặn sự kiện click lan lên window

        let dropdown = document.getElementById(id);

        // Ẩn dropdown cha của thẻ a được nhấn
        let parentDropdown = link.closest(".dropdown-content-leave-board");
        if (parentDropdown) {
            parentDropdown.style.display = "none";
        }

        // Ẩn tất cả các dropdown khác
        document.querySelectorAll(".dropdown-content-leave-board").forEach(div => {
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
        document.querySelectorAll(".dropdown-content-leave-board").forEach(menu => {
            if (menu.style.display === "block") {
                menu.style.display = "none";
            }
        });
    }
</script>