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
<body class="bg-dark">
<div class="backup-list">
    <div class="dropdown-menubar-leave-board">
        <button class="button-hover button-menubar" onclick="toggleDropdownMenubar('leave', this)">
            <img src="/images/ellipsis.png" alt="dropdown.png" class="dropdown-img">
        </button>
        <div>
            <div class="dropdown-content-leave-board" id="leave">
                <div class="form-title-first-board">
                    <span style="color: white; font-weight: bold">Không gian làm việc</span>
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
                        <img src="/images/list.png" onclick="goBack(event, 'leave-board', 'leave')" alt="back.png"
                             style="width: 15px;">
                    </button>
                    <span style="color: white; font-weight: bold">Không gian làm việc</span>
                    <button style="background: none; border: 0;">
                        <img src="/images/closed.png" onclick="closeDropdown(event)" alt="back.png"
                             style="width: 20px;">
                    </button>
                </div>
                <hr>
                <p class="content-leave-board">Bạn sẽ bị loại bỏ khỏi toàn bộ thẻ trong bảng này.</p>
                <div class="form-action-board">
                    <a class="form-second-action" onclick="closeDropdown(event)">Rời khỏi bảng</a>
                </div>
            </div>
            <div class="dropdown-content-leave-board" id="delete-board">
                <div class="form-title-second-board">
                    <button style="background: none; border: 0; transform: rotate(90deg);">
                        <img src="/images/list.png" onclick="goBack(event, 'delete-board', 'leave')" alt="back.png"
                             style="width: 15px;">
                    </button>
                    <span style="color: white; font-weight: bold">Không gian làm việc</span>
                    <button style="background: none; border: 0;">
                        <img src="/images/closed.png" onclick="closeDropdown(event)" alt="back.png"
                             style="width: 20px;">
                    </button>
                </div>
                <hr>
                <p class="content-leave-board">Bạn sẽ bị loại bỏ khỏi toàn bộ thẻ trong bảng này.</p>
                <div class="form-action-board">
                    <a class="form-second-action" onclick="closeDropdown(event)">Xóa khỏi bảng</a>
                </div>
            </div>
        </div>
    </div>
</div>


<script>

    function toggleDropdownMenubar(dataId, button) {
        let dropdown = document.getElementById(dataId);

        // Đóng tất cả dropdown khác và xóa class active của tất cả button
        document.querySelectorAll(".dropdown-content-leave-board").forEach(menu => {
            if (menu.id !== dataId) {
                menu.style.display = "none";
            }
        });
        document.querySelectorAll(".dropdown-menubar-leave-board button").forEach(btn => {
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
        let button = event.target.closest(".dropdown-menubar-leave-board button"); // Tìm button cha nếu có
        let dropdownContent = event.target.closest(".dropdown-content-leave-board"); // Tìm dropdown đang chứa phần tử click vào

        if (!button && !dropdownContent) { // Nếu không phải button hoặc phần tử trong dropdown
            document.querySelectorAll(".dropdown-content-leave-board").forEach(menu => {
                menu.style.display = "none";
            });
            document.querySelectorAll(".dropdown-menubar-leave-board button").forEach(btn => {
                btn.classList.remove("active");
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