<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tạo Không Gian Làm Việc</title>
    <link rel="stylesheet" href="/css/user/group/build_workspace.css">
</head>
<body>
    <div id="workspaceContent">
        <!-- Form nhập thông tin -->
        <form action="/group_home?action=createGroup" method="post" id="workspaceForm">
            <h1>Xây dựng không gian làm việc của bạn</h1>
            <p class="sub-text">Tăng năng suất bằng cách giúp mọi người dễ dàng truy cập bảng ở một vị trí.</p>

            <label for="nameSp">📌 Tên không gian làm việc</label>
            <input id="nameSp" type="text" name="title" placeholder="Nhập tên không gian..." required >


            <label for="typeSp">📂 Loại không gian làm việc</label>
            <select id="typeSp" name="type">
                <option>Điều hành</option>
                <option>Kinh doanh CRM</option>
                <option>Kỹ thuật - CNTT</option>
                <option>Giáo dục</option>
                <option>Nhân sự</option>
                <option>Doanh nghiệp nhỏ</option>
                <option>Marketing</option>
            </select>

            <label for="describe">📝 Mô tả không gian làm việc</label>
            <textarea id="describe" name="description" placeholder="Nhóm của chúng tôi tổ chức mọi thứ ở đây..."></textarea>

            <button type="submit" disabled>✨ Tiếp tục</button>
        </form>

        <!-- Hình ảnh minh họa -->
        <div id="workspaceImage">
            <a href="/account_home"><img style="width: 50px; height: 50px" src="https://png.pngtree.com/png-vector/20230311/ourmid/pngtree-logout-arrow-line-icon-vector-png-image_6644097.png"></a>
            <img class="schedule" src="https://png.pngtree.com/png-vector/20220708/ourmid/pngtree-calendar-with-selected-date-png-image_5811645.png" alt="Lịch làm việc">
        </div>
    </div>
</body>
</html>
<script>
    document.addEventListener("DOMContentLoaded", function () {
        let nameSp = document.getElementById("nameSp");
        let submitBtn = document.querySelector("#workspaceForm button[type='submit']");

        nameSp.addEventListener("input", function () {
            if (this.value.length > 100) {
                this.setCustomValidity("Bạn chỉ được nhập tối đa 100 ký tự!");
                this.reportValidity(); // Hiển thị lỗi ngay lập tức
                submitBtn.disabled = true;
            } else {
                this.setCustomValidity("");
                submitBtn.disabled = false;
            }
        });

        submitBtn.addEventListener("click", function (event) {
            if (nameSp.value.length > 100) {
                nameSp.setCustomValidity("Bạn chỉ được nhập tối đa 100 ký tự!");
                nameSp.reportValidity(); // Hiển thị lỗi khi bấm nút
                event.preventDefault(); // Ngăn chặn form submit nếu lỗi
            }
        });
    });
</script>


