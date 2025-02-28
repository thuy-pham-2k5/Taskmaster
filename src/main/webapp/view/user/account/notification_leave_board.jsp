
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body><!-- Modal thoát bảng -->
<div id="boardModal" class="modal">
    <div class="modal-content">
        <p>Bạn có chắc chắn muốn rời khỏi bảng này?</p>
        <div class="modal-buttons">
            <button onclick="leaveBoard()">Rời khỏi</button>
            <button onclick="closeModal()">Hủy</button>
        </div>
    </div>
</div>

<script>
    function openModal(event, boardId) {
        var modal = document.getElementById("boardModal");

        // Hiển thị modal ngay bên cạnh nút ba chấm
        modal.style.display = "block";
        modal.style.position = "absolute";

        // Lấy vị trí của nút ba chấm
        var rect = event.target.getBoundingClientRect();

        // Đặt modal bên cạnh nút ba chấm
        modal.style.top = (rect.top + window.scrollY) + "px";
        modal.style.left = (rect.left + window.scrollX + 20) + "px"; // Dịch sang phải 20px

        // Lưu boardId để dùng sau
        modal.setAttribute("data-board-id", boardId);
    }

    function closeModal() {
        var modal = document.getElementById("boardModal");
        modal.style.display = "none";
    }

    function leaveBoard() {
        var boardId = document.getElementById("boardModal").getAttribute("data-board-id");
        window.location.href = "group_home?action=leaveBoard&boardId=" + boardId;
    }
</script>

<style>
    .modal {
        display: none;
        background: white;
        padding: 15px;
        border-radius: 5px;
        box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.2);
        z-index: 1000;
    }

    .modal-content {
        text-align: center;
    }

    .modal-buttons {
        margin-top: 10px;
        display: flex;
        justify-content: space-around;
    }

    .modal-buttons button {
        padding: 5px 10px;
        border: none;
        cursor: pointer;
    }

    .modal-buttons button:first-child {
        background: red;
        color: white;
    }

    .modal-buttons button:last-child {
        background: gray;
        color: white;
    }
</style>
</body>
</html>
