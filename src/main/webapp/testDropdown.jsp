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
    <link rel="stylesheet" href="testDropdown.css">
    <style>
        .dropdown-menu {
            transform: translateX(20px) translateY(10px); /* Chỉnh lệch phải và xuống */
            min-width: 300px;
        }

        .dropdown-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 10px;
            font-weight: bold;
        }

        .close-btn {
            cursor: pointer;
            font-size: 18px;
        }

        .dropdown-item-button {
            display: flex;
            justify-content: space-between;
            width: 100%;
            background: none;
            border: none;
            padding: 10px;
            text-align: left;
        }

        .confirm-btn {
            width: 100%;
            padding: 10px;
            background-color: red;
            color: white;
            border: none;
            cursor: pointer;
        }

        #dropdownMenu2 {
            min-width: 250px;
        }
    </style>
</head>
<body class="bg-dark">

<div class="container mt-5">
    <div class="btn-group">
        <button type="button" class="btn btn-light dropdown-toggle" data-bs-toggle="dropdown">
            ...
        </button>
        <ul class="dropdown-menu" id="dropdownMenu1">
            <div class="dropdown-header">
                Backlog sprint
                <span class="close-btn" onclick="closeDropdown()">x</span>
            </div>
            <li>
                <button class="dropdown-item-button" onclick="switchToConfirmation()">
                    <span>Rời khỏi bảng</span>
                    <span class="arrow">›</span>
                </button>
            </li>
            <li>
                <button class="dropdown-item-button">
                    <span>xóa bảng</span>
                    <span class="arrow">›</span>
                </button>
            </li>
        </ul>
        <ul class="dropdown-menu" id="dropdownMenu2">
            <div class="dropdown-header">
                Bạn muốn rời khỏi bảng?
                <span class="close-btn" onclick="closeDropdown()">x</span>
            </div>
            <li>
                <p style="font-size: 14px;">Bạn sẽ bị loại bỏ khỏi toàn bộ thẻ trong bảng này.</p>
                <button class="confirm-btn mt-3" onclick="leaveBoard()">Rời bỏ</button>
            </li>
        </ul>
    </div>
</div>

<!-- Bootstrap 5 JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<script>
    function switchToConfirmation() {
        // Ẩn dropdown 1
        let dropdown1 = document.getElementById("dropdownMenu1");
        dropdown1.classList.remove("show");

        // Hiện dropdown 2 ngay tại vị trí dropdown 1
        let dropdown2 = document.getElementById("dropdownMenu2");
        dropdown2.style.left = dropdown1.getBoundingClientRect().left + "px";
        dropdown2.style.top = dropdown1.getBoundingClientRect().top + "px";
        dropdown2.classList.add("show");
    }

    function closeDropdown() {
        document.querySelectorAll(".dropdown-menu").forEach(menu => {
            menu.classList.remove("show");
        });
    }

    // Đóng dropdown khi click ra ngoài
    window.onclick = function (event) {
        if (!event.target.closest('.dropdown-menu') && !event.target.matches('.dropdown-toggle')) {
            closeDropdown();
        }
    };
</script>
</body>
</html>