<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Modal Rời Nhóm</title>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <style>
        /* CSS cho modal */
        .modal {
            display: none; /* Ẩn mặc định */
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background-color: #222; /* Màu tối */
            color: white;
            border-radius: 8px;
            width: 250px;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.3);
            padding: 15px;
        }

        .modal-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            font-size: 16px;
            font-weight: bold;
            border-bottom: 1px solid #333;
            padding-bottom: 8px;
        }

        .close-btn {
            cursor: pointer;
            font-size: 18px;
        }

        .modal-body {
            padding: 10px 0;
        }

        .modal-option {
            display: flex;
            justify-content: space-between;
            align-items: center;
            cursor: pointer;
            padding: 10px;
            border-radius: 5px;
            transition: background 0.3s;
        }

        .modal-option:hover {
            background: rgba(255, 255, 255, 0.1);
        }
    </style>
</head>
<body>
<!-- Modal -->
<div id="customModal" class="modal">
    <div class="modal-header">
        <span>Backlog sprint</span>
        <span class="close-btn" onclick="document.getElementById('customModal').style.display='none'">✕</span>
    </div>
    <div class="modal-body">
        <div class="modal-option" onclick="leaveBoard()">
            <span>Rời khỏi bảng</span>
            <span>›</span>
        </div>
    </div>
</div>

<script>
    function openModal() {
        document.getElementById("customModal").style.display = "block";
    }

    function leaveBoard() {
        let confirmLeave = confirm("Bạn có chắc chắn muốn rời khỏi bảng này?");

        if (confirmLeave) {
            alert("Bạn đã rời khỏi bảng!");
            closeModal();
        } else {
            alert("Bạn vẫn ở lại bảng!");
        }
    }


</script>

</body>
</html>
