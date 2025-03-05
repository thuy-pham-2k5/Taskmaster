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

    <style>
        /* Tùy chỉnh dropdown */
        .dropdown-menu {
            background-color: #1e1e1e; /* Màu nền tối */
            border-radius: 12px; /* Bo tròn góc */
            padding: 10px;
            min-width: 250px; /* Độ rộng tối thiểu */
            box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.3);
            border: none;
        }

        /* Tiêu đề bảng */
        .dropdown-header {
            color: #bbb;
            font-size: 14px;
            padding: 10px 15px;
            font-weight: bold;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        /* Nút đóng (X) */
        .close-btn {
            cursor: pointer;
            font-size: 16px;
            color: #999;
            transition: color 0.3s ease;
        }

        .close-btn:hover {
            color: white;
        }

        /* Nút trong dropdown */
        .dropdown-item-button {
            background: transparent;
            border: none;
            color: #d1d1d1;
            font-size: 16px;
            width: 100%;
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 12px 15px;
            border-radius: 8px;
            font-weight: 500;
        }

        /* Hiệu ứng hover */
        .dropdown-item-button:hover {
            background-color: #333;
            color: white;
        }

        /* Mũi tên › */
        .arrow {
            font-size: 16px;
            color: #999;
            transition: color 0.3s ease;
        }

        .dropdown-item-button:hover .arrow {
            color: white;
        }

        /* Bỏ mũi tên mặc định của Bootstrap */
        .dropdown-toggle::after {
            display: none !important;
        }

        /* Tùy chỉnh modal */
        .modal-content {
            background-color: #1e1e1e;
            color: white;
            border-radius: 12px;
            border: none;
        }

        .modal-header {
            border-bottom: none;
            padding-bottom: 0;
        }

        .modal-title {
            font-weight: bold;
        }

        .modal-body {
            color: #bbb;
            font-size: 16px;
        }

        /* Nút xác nhận */
        .confirm-btn {
            background-color: #e74c3c;
            color: white;
            font-size: 16px;
            padding: 10px;
            width: 100%;
            border-radius: 8px;
            border: none;
        }

        .confirm-btn:hover {
            background-color: #c0392b;
        }
    </style>
</head>
<body class="bg-dark">

<div class="container mt-5">
    <div class="btn-group dropend">
        <button type="button" class="btn btn-light dropdown-toggle" data-bs-toggle="dropdown">
            ...
        </button>
        <ul class="dropdown-menu">
            <div class="dropdown-header">
                Backlog sprint
                <span class="close-btn" onclick="closeDropdown()">✖</span>
            </div>
            <li>
                <button class="dropdown-item-button" data-bs-toggle="modal" data-bs-target="#confirmModal">
                    <span>Rời khỏi bảng</span>
                    <span class="arrow">›</span>
                </button>
            </li>
        </ul>
    </div>
</div>

<!-- Modal xác nhận -->
<div class="modal fade" id="confirmModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="btn-close text-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body text-center">
                <h5 class="modal-title">Bạn muốn rời bảng?</h5>
                <p>Bạn sẽ bị loại bỏ khỏi toàn bộ thẻ trong bảng này.</p>
                <button class="confirm-btn mt-3">Rời bỏ</button>
            </div>
        </div>
    </div>
</div>

<!-- Bootstrap 5 JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<script>
    function closeDropdown() {
        document.querySelector('.dropdown-menu').classList.remove('show');
    }
</script>

</body>
</html>
