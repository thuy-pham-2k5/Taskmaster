<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<style>
    .create_board_body {
        font-family: Arial, sans-serif;
        background-color: rgba(255, 255, 255, 0);
        color: white;
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
        margin: 0;
    }

    .container_board_body {
        background-color: #3179BA;
        padding: 20px;
        border-radius: 5px;
        width: 250px;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
    }

    .board-modal {
        display: flex;
        flex-direction: column;
        gap: 15px;
    }

    .board-modal-header {
        display: flex;
        align-items: center;
        justify-content: center;
        position: relative;
        width: 100%;
    }

    .modal-header h1 {
        margin: 0;
        font-size: 22px;
        flex-grow: 1;
        text-align: center;
    }

    .close-button-add-form {
        position: absolute;
        right: 15px;
        top: 50%;
        transform: translateY(-50%);
        background: none;
        border: none;
        font-size: 20px;
        color: white;
        cursor: pointer;
    }

    .wallpaper-form {
        display: flex;
        gap: 10px;
        justify-content: center;
        margin-top: 10px;
    }

    .wallpaper-form img {
        width: 80px;
        height: 60px;
        object-fit: cover;
        border-radius: 5px;
        cursor: pointer;
        position: relative;
        transition: transform 0.2s ease-in-out;
        border: 2px solid transparent;
    }

    .wallpaper-form .wallpaper-container {
        position: relative;
        display: inline-block;
    }

    .wallpaper-form img.selected {
        position: relative;
        border: 3px solid #0079bf;
    }

    .wallpaper-form img.selected::after {
        content: "✔";
        position: absolute;
        top: 50%;
        left: 50%;
        transform: translate(-50%, -50%);
        font-size: 24px;
        color: white;
        background-color: rgba(0, 0, 0, 0.5);
        padding: 5px 10px;
        border-radius: 50%;
    }

    .checkmark {
        position: absolute;
        top: 50%;
        left: 50%;
        transform: translate(-50%, -50%);
        background: rgba(0, 121, 191, 0.7);
        color: white;
        width: 30px;
        height: 30px;
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 16px;
        font-weight: bold;
    }


    .board-information-form {
        width: 100%;
        padding: 8px;
        border-radius: 5px;
        border: 1px solid #ffffff;
        margin-top: 5px;
        background-color: rgba(255, 255, 255, 0);
        color: white;
    }

    /* thay đổi màu chữa placeholder*/
    .board-information-form::placeholder {
        background-color: rgba(255, 255, 255, 0);
        color: white;
        opacity: 1;
    }

    .board-information-form:focus {
        outline: none;
        border: 1px solid #ffffff;
        color: white;
        background-color: rgba(255, 255, 255, 0);

    }

    .board-action-buttons {
        display: flex;
        flex-direction: column;
        justify-content: space-between;
        margin-top: 15px;
    }

    .board-action-buttons a {
        text-decoration: none;
        color: white;
        font-size: 16px;
    }

    .create-board-button {
        width: 100%;
        padding: 10px;
        border-radius: 5px;
        border: none;
        cursor: pointer;
        background-color: #0054a6;
        color: white;
    }

    .create-board-button:hover {
        background-color: #1969b4;
    }

</style>

<div class="create_board_body">
    <div class="container_board_body">
        <div id="addBoard" class="board-modal">
            <div class="board-modal-header">
                <h1>Tạo bảng</h1>
                <button class="close-button-add-form">
                    <a style="text-decoration: none; color: white" href="board?action=back">&times;</a>
                </button>
            </div>
            <div id="action-form-add-board">
                <form action="board?action=create" method="post">
                    <div>
                        <p class="board-title-form">Phông nền</p>
                        <div class="wallpaper-form">
                            <div class="wallpaper-container">
                                <img id="1" data-id="1"
                                     src="https://img4.thuthuatphanmem.vn/uploads/2020/04/28/anh-nen-bien-song-xanh_014557180.jpg"
                                     alt="Wallpaper 1"
                                     onclick="selectWallpaper(this)">
                            </div>
                            <div class="wallpaper-container">
                                <img id="2" data-id="2"
                                     src="https://img.meta.com.vn/Data/image/2022/01/13/anh-dep-thien-nhien-6.jpg"
                                     onclick="selectWallpaper(this)">
                            </div>
                            <div class="wallpaper-container">
                                <img id="3" data-id="3"
                                     src="https://png.pngtree.com/thumb_back/fh260/background/20230511/pngtree-nature-background-sunset-wallpaer-with-beautiful-flower-farms-image_2592160.jpg"
                                     onclick="selectWallpaper(this)">
                            </div>
                        </div>
                        <input type="hidden" id="selectedImageFinal" name="selectedImageFinal">
                    </div>
                    <div>
                        <p class="board-title-form">Sử dụng ảnh khác bằng link.</p>
                        <input id="selectedImage" class="board-information-form" type="text" name="selectedImage"
                               placeholder="Nhập link ảnh vào đây"
                               pattern="https?://.*"
                               title="Vui lòng nhập một đường link hợp lệ (bắt đầu bằng http:// hoặc https://)">
                        <span id="imageLinkMessage" style="font-size: 14px;"></span>
                    </div>
                    <div>
                        <p class="board-title-form">Tiêu đề bảng *</p>
                        <input class="board-information-form" type="text" name="title"
                               placeholder="✋ Tiêu đề bảng là bắt buộc" required>
                    </div>
                    <div class="board-action-buttons">
                        <button type="submit" name="addColumn" class="create-board-button">Tạo mới</button>
                    </div>
                </form>
            </div>
        </div>

    </div>
</div>

<script>
    /*Hiển thị lỗi khi nhập đờng link không đúng hợp lệ */
    document.getElementById("selectedImage").addEventListener("input", function () {
        let messageSpan = document.getElementById("imageLinkMessage");
        let inputValue = this.value.trim();

        if (inputValue === "") {
            // Khi ô input trống, reset mọi thứ
            this.style.borderColor = "";
            messageSpan.innerHTML = "";
            return;
        }

        if (this.validity.patternMismatch) {
            this.style.borderColor = "red";
            messageSpan.innerHTML = "❌ Link không hợp lệ! Phải bắt đầu bằng http:// hoặc https://";
            messageSpan.style.color = "red";
        } else {
            this.style.borderColor = "green";
            messageSpan.innerHTML = "✔ Link hợp lệ!";
            messageSpan.style.color = "green";
        }
    });


    /*Thông tin sẽ là null nếu không điền gì*/
    document.querySelector("form").addEventListener("submit", function (event) {
        let selectedImageFinal = document.getElementById("selectedImageFinal");
        if (!selectedImageFinal.value.trim()) {
            selectedImageFinal.value = null; // Đặt giá trị mặc định nếu rỗng
        }
    });



    /*Chọn các ảnh và xử lý dấu x*/
    function selectWallpaper(img) {
        // Xóa class selected và dấu tích khỏi tất cả ảnh
        document.querySelectorAll(".wallpaper-form img").forEach(image => {
            image.classList.remove("selected");
            let checkmark = image.parentElement.querySelector(".checkmark");
            if (checkmark) checkmark.remove();
        });

        // Thêm class selected vào ảnh được chọn
        img.classList.add("selected");

        // Tạo dấu tích mới nếu chưa có
        let checkmark = document.createElement("div");
        checkmark.classList.add("checkmark");
        checkmark.innerHTML = "✔";
        img.parentElement.appendChild(checkmark);

        // Cập nhật giá trị vào input ẩn duy nhất
        document.getElementById("selectedImageFinal").value = img.src;

        // Xóa nội dung ô nhập URL (nếu có)
        document.getElementById("selectedImage").value = "";
    }


    // Khi nhập link ảnh, xóa lựa chọn ảnh có sẵn
    document.getElementById("selectedImage").addEventListener("input", function () {
        let inputValue = this.value.trim();
        let finalInput = document.getElementById("selectedImageFinal");

        if (inputValue === "") {
            return;
        }

        // Kiểm tra URL có hợp lệ hay không
        if (this.validity.patternMismatch) {
            this.style.borderColor = "red";
            document.getElementById("imageLinkMessage").innerHTML = "❌ Link không hợp lệ!";
            document.getElementById("imageLinkMessage").style.color = "red";
            finalInput.value = ""; // Không lưu link không hợp lệ
        } else {
            this.style.borderColor = "green";
            document.getElementById("imageLinkMessage").innerHTML = "✔ Link hợp lệ!";
            document.getElementById("imageLinkMessage").style.color = "green";

            // Lưu vào input ẩn duy nhất
            finalInput.value = inputValue;

            // Xóa lựa chọn ảnh có sẵn
            document.querySelectorAll(".wallpaper-form img").forEach(img => {
                img.classList.remove("selected");
                let checkmark = img.parentElement.querySelector(".checkmark");
                if (checkmark) checkmark.remove();
            });

            document.getElementById("selectedWallpaper").value = ""; // Đặt về rỗng để tránh xung đột
        }
    });

</script>

