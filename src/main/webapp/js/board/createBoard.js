document.addEventListener("DOMContentLoaded", function () {
    let images = document.querySelectorAll("#wallPaper1 img");

    images.forEach(img => {
        img.addEventListener("click", function () {
            // Xóa hiệu ứng của ảnh khác trước đó
            images.forEach(i => {
                i.style.opacity = "1"; // Hiển thị lại ảnh bình thường
                let checkIcon = i.parentElement.querySelector(".check-icon");
                if (checkIcon) checkIcon.remove();
            });

            // Làm mờ ảnh được chọn
            this.style.opacity = "0.5";

            // Thêm dấu tích (✔)
            let checkIcon = document.createElement("span");
            checkIcon.innerHTML = "✔";
            checkIcon.classList.add("check-icon");
            this.parentElement.appendChild(checkIcon);
        });
    });
});
