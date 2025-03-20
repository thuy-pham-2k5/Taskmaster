// chỉnh sửa group không cho chỉnh sửa tiêu đề quá 100 ký tự
document.addEventListener("DOMContentLoaded", function () {
    let nameSp = document.getElementById("groupNameInput");
    let submitBtn = document.getElementById("save");

    function validateInput() {
        if (nameSp.value.length > 100) {
            nameSp.setCustomValidity("Bạn chỉ được nhập tối đa 100 ký tự!");
            submitBtn.disabled = true;
        } else {
            nameSp.setCustomValidity("");
            submitBtn.disabled = false;
        }
    }

    // Kiểm tra ngay khi trang tải xong
    validateInput();

    nameSp.addEventListener("input", function () {
        validateInput();
        this.reportValidity(); // Hiển thị lỗi ngay lập tức
    });

    submitBtn.addEventListener("click", function (event) {
        if (nameSp.value.length > 100) {
            nameSp.setCustomValidity("Bạn chỉ được nhập tối đa 100 ký tự!");
            nameSp.reportValidity();
            event.preventDefault();
        }
    });
});



function cancelEdit() {
    // Hủy chỉnh sửa, quay về ban đầu
    document.getElementById("edit_frame").style.display = "none";
    document.getElementById("information").style.display = "block";
}


function showEditModal() {
    // Ẩn div information và hiển thị div edit_frame
    document.getElementById("information").style.display = "none";
    document.getElementById("edit_frame").style.display = "block";

}

// Gửi dữ liệu bằng AJAX khi nhấn "Lưu"
function saveEditGroup(event) {
    event.preventDefault(); // Ngăn form gửi request mặc định

    let title = document.getElementById("groupNameInput").value.trim();
    let short_title = document.getElementById("shortNameInput").value.trim();
    let description = document.getElementById("groupDescInput").value.trim();


    $.ajax({
        type: "POST",
        url: "/group_home?action=editInfoGroup",
        data: {
            title: title,
            short_title: short_title,
            description: description
        },
        dataType: "json",
        success: function (group) {
            document.getElementById("titleGroup").innerText = group.title;
            document.getElementById("titleGroupHomeLeft").innerText = group.title;
            document.getElementById("shortNameInput").innerText = group.title;
            document.getElementById("content").innerText = group.description;
            cancelEdit();
        }
    })
}