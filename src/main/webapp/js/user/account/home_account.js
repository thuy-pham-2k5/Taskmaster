document.addEventListener("DOMContentLoaded", function () {
    // Lấy danh sách tất cả các nút dropdown
    const dropdownButtons = document.querySelectorAll(".dropbtn");

    dropdownButtons.forEach(button => {
        button.addEventListener("click", function (event) {
            event.stopPropagation(); // Ngăn sự kiện lan ra ngoài

            const dropdownContent = this.nextElementSibling; // Lấy <ul class="dropdown-content">
            const arrow = this.querySelector(".arrow"); // Lấy phần tử chứa mũi tên

            // Toggle hiển thị dropdown
            dropdownContent.classList.toggle("show");

            // Đổi mũi tên lên/xuống
            if (dropdownContent.classList.contains("show")) {
                arrow.textContent = "▲"; // Nếu mở, đổi thành mũi tên lên
            } else {
                arrow.textContent = "▼"; // Nếu đóng, đổi lại mũi tên xuống
            }
        });
    });
});
