document.addEventListener("DOMContentLoaded", function () {
    // 🔹 Lựa chọn hình nền (thumbnail)
    let images = document.querySelectorAll("#wallPaper1 img");

    images.forEach(img => {
        img.addEventListener("click", function () {
            // 🟢 Xóa hiệu ứng của ảnh trước đó
            images.forEach(i => {
                i.style.opacity = "1";
            });

            // 🟡 Làm mờ ảnh được chọn
            this.style.opacity = "0.5";
        });
    });

    // 🔹 Cập nhật ảnh lớn (background chính)
    const wallpaperImages = document.querySelectorAll("#wallPaper1 img");
    const mainImage = document.querySelector("img[alt='imageCreateBoard']");

    wallpaperImages.forEach((img) => {
        img.addEventListener("click", function () {
            mainImage.src = img.src;
        });
    });

    // 🔹 Đổi màu nền của ảnh lớn khi chọn box màu
    const colorBoxes = document.querySelectorAll(".colorBox");
    const mainImageBox = document.querySelector("img[alt='imageCreateBoard']");

    colorBoxes.forEach((box) => {
        box.addEventListener("click", function () {
            mainImageBox.style.backgroundColor = box.style.backgroundColor;
            mainImageBox.src = "";
        });
    });
});


/* Lựa chọn các quyền xem*/
document.addEventListener("DOMContentLoaded", function () {
    const colorBoxes = document.querySelectorAll(".colorBox");
    const mainImage = document.querySelector("img[alt='imageCrateBoard']");

    colorBoxes.forEach((box) => {
        box.addEventListener("click", function () {
            // Cập nhật màu nền của ảnh chính thành màu của box
            mainImage.style.backgroundColor = box.style.backgroundColor;
            mainImage.src = img.src;
        });
    });
});

document.addEventListener("DOMContentLoaded", function () {
    const selectBox = document.querySelector(".custom-select");
    const selectedOption = document.querySelector(".selected-option");
    const options = document.querySelector(".options");
    const optionItems = document.querySelectorAll(".option");

    // Khi click vào ô chọn, mở/đóng danh sách
    selectedOption.addEventListener("click", function () {
        selectBox.classList.toggle("open");
    });

    // Khi chọn một tùy chọn
    optionItems.forEach(option => {
        option.addEventListener("click", function () {
            selectedOption.querySelector("span").textContent = this.querySelector("strong").textContent;
            selectBox.classList.remove("open");
        });
    });

    // Ẩn dropdown khi click ra ngoài
    document.addEventListener("click", function (event) {
        if (!selectBox.contains(event.target)) {
            selectBox.classList.remove("open");
        }
    });
});