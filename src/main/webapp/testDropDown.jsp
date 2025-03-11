<%@ page import="java.util.ArrayList" %>
<%@ page import="com.example.taskmaster.model.Board" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Dropdown Button</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="testDropDown.css">
</head>
    <%
Board board1 = new Board(1, "Board 1", 1);
Board board2 = new Board(2, "Board 2", 1);
Board board3 = new Board(3, "Board 3", 1);
ArrayList boards = new ArrayList();
boards.add(board1);
boards.add(board2);
boards.add(board3);
request.setAttribute("boards", boards);
%>
<body class="bg-dark">
<div class="backup-list">
    <ul>
        <c:forEach items="${boards}" var="board">
            <li>
                <div class="dropdown-menubar-leave-board">
                    <a href="board_home?boardId=${board.boardId}">${board.title}</a>
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
                        <c:if test="${board.boardId == 2}">
                            <div class="form-action-board">
                                <a class="form-first-action"
                                   onclick="toggleDisplayMenubar(event, 'delete-board', this)">
                                    Xóa bảng
                                    <span class="arrow">›</span>
                                </a>
                            </div>
                        </c:if>
                    </div>
                    <div class="dropdown-content-leave-board" id="leave-board">
                        <div class="form-title-second-board">
                            <button style="background: none; border: 0; transform: rotate(90deg);">
                                <img src="/images/list.png"
                                     onclick="goBack(event, 'leave-board', 'dropdown-${board.boardId}')"
                                     alt="back.png"
                                     style="width: 15px;">
                            </button>
                            <span style="color: white; font-weight: bold">Không gian làm việc</span>
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
                            <span style="color: white; font-weight: bold">Không gian làm việc</span>
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
            dropdown.style.left = rect.left + "px";

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