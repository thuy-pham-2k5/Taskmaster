
<%@ page contentType="text/html;charset=UTF-8" language="java" %>



<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Logout Modal</title>
    <link rel="stylesheet" href="css/user/account/notification_log_out.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body onload="$('#logoutModal').modal('show');">
<!-- Modal -->
<div class="modal fade" id="exampleModalCenter" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">ĐĂNG XUẤT</h5>
            </div>
            <div class="modal-body">
                Bạn chắc chắn muốn đăng xuất không?
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Hủy</button>
                <button type="button" class="btn btn-primary" id="confirmLogout">Chấp nhận</button>
            </div>
        </div>
    </div>
</div>


</body>
</html>


<script>
    document.addEventListener("DOMContentLoaded", function () {
        document.getElementById("confirmLogout").addEventListener("click", function () {
            window.location.href = "/logout"; // Chuyển hướng đến Servlet xử lý đăng xuất
        });
    });
</script>
