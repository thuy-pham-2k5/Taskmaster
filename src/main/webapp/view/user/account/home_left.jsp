<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<style>
    .position-home-left {
        width: 260px;
        position: sticky;
        left: 0;
        height: calc(100% - 50px);
    }

    .home-left {
        min-height: 100%;
        height: auto;
        width: 260px;
        z-index: 5;
        background: #3179ba;
    }

    .home-left-child {
        min-height: 100%;
        height: auto;
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

        display: inline-block;
        max-width: 160px;
        white-space: nowrap;
        overflow: hidden;
        text-overflow: ellipsis;
        line-height: 20px;
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
        max-height: 457px;
        margin: 5px 0 0 0;
        padding: 0;
    }

    .hl-list-boards-ul li {
        padding: 5px 12px 0 12px;
        height: 32px;
        display: flex;
    }

    .hl-list-boards-ul li a {
        width: 100%;
        text-overflow: ellipsis;
        overflow: hidden;
        display: flex;
        white-space: nowrap;
        color: white;
        align-items: center;
        justify-content: space-between;
    }

    .hl-list-boards-ul li:hover {
        background: rgb(227 226 226 / 50%);
        cursor: pointer;
    }

    .hl-list-boards-ul li:hover img {
        display: block;
    }

    .hl-list-boards-ul li:hover img,
    .hl-list-boards-ul li img.dropdown-open {
        display: block !important;
    }

    .hl-list-boards-ul li img {
        width: 15px;
        height: 15px;
        display: none;
        margin: 0 0 0 15px;
    }
    .hl-dropdown-action button {
        border: 0;
        background: none;
        padding: 10px;
        font-size: 15px;
    }

    .hl-dropdown-action-board {
        position: absolute;
        display: none; /* Ẩn mặc định */
        background-color: white;
        border: 1px solid #ccc;
        box-shadow: 2px 2px 5px rgba(0, 0, 0, 0.2);
        min-width: 120px;
        list-style: none;
        border-radius: 10px;
    }

    .hl-dropdown-action-board div h4 {
        display: flex;
        justify-content: center;
    }

    .hl-dropdown-action {
        cursor: pointer;
        width: 290px;
    }

    .hl-dropdown-action:hover {
        background-color: #d4e4f3;
    }

    .hl-dropdown-lists {
        list-style-type: none;
        padding: 0;
        margin: 0;
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
                    <span style="line-height: 20px"><a id="titleGroupHomeLeft" href="group_home">${groupInfo.title}</a></span>
                    <p>${groupInfo.visibility}</p>
                </div>
                <button class="closed-home-left">
                    <img class="hl-img" src="/images/list.png" alt="closed-menu.png">
                </button>
            </div>
            <div class="hl-general-info">
                <div style="overflow-y: auto; scrollbar-color: #fff6 #00000026; scrollbar-width: thin; height: calc(100% - 20px);">
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
                                    <a href="group_home?action=boardView&boardId=${board.boardId}">
                                            ${board.title}
                                        <img class="openOperationBoard" src="/images/ellipsis.png" alt="closed-board"/>
                                    </a>
                                </li>
                            </c:forEach>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </nav>
</div>
<div class="hl-dropdown-action-board" id="operationBoard">
    <div>
        <h4>Thao tác</h4>
    </div>
    <ul class="hl-dropdown-lists">
        <li id="operation-addTask" class="hl-dropdown-action">
            <button>Rời khỏi bảng</button>
        </li>
        <li id="operation-copyList" class="hl-dropdown-action">
            <button>Đóng bảng</button>
        </li>
    </ul>
</div>
<script>
    let currentOpenOperationBoard = null;

    $(document).on("click", ".openOperationBoard", function (event) {
        event.stopPropagation();
        event.preventDefault();

        let openDropdown = $(this);
        let dropdown = $("#operationBoard");

        if (currentOpenOperationBoard) {
            currentOpenOperationBoard.removeClass("dropdown-open");
        }

        if (currentOpenOperationList) {
            hideDropdown("#operationList");
        }

        openDropdown.addClass("dropdown-open");
        updateDropdownBoardPosition(openDropdown, dropdown);

        $('.hl-general-info div').on("scroll", function () {
            if (dropdown.is(":visible")) {
                updateDropdownBoardPosition(openDropdown, dropdown);
            }
        });
        currentOpenOperationBoard = openDropdown;
    });

    function updateDropdownBoardPosition(openDropdown, dropdown) {
        const offset = openDropdown.offset();
        dropdown.css({
            left: offset.left + "px",
            top: offset.top + openDropdown.outerHeight() + "px",
            display: "block"
        });
    }

    // Đóng dropdown khi nhấn ra ngoài
    $(document).on("click", function (event) {
        if (!$(event.target).closest(".openOperationBoard, #operationBoard").length) {
            hideDropdown("#operationBoard");
            if (currentOpenOperationBoard) {
                currentOpenOperationBoard.removeClass("dropdown-open");
            }
            currentOpenOperationBoard = null;
        }
    });
</script>