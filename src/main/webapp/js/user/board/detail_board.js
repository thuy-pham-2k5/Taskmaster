$(document).on("click", ".task", function () {
    let taskId = $(this).data('task');
    getInfoTask(taskId, function (response) {
        openTaskModal(response.task, response.details)
    });
})
function getInfoTask (taskId, callback) {
    $.ajax({
        type: "POST",
        url: "/board_home?action=getInfoTask",
        data: {
            taskId: taskId
        },
        dataType: "json",
        success: function (response) {
            console.log("task", response.task);
            console.log("details", response.details);
            callback(response);
        }
    })
}

// Hiển thị modal task với thông tin từ task
function openTaskModal(task, details) {
    $('.modal_content').attr("data-task", task.taskId);
    document.getElementById("modalTaskTitle").value = task.title;
    document.querySelector(".listName").textContent = task.columnName || "To Do";
    document.getElementById("description_display").textContent = task.description || "Thêm mô tả chi tiết...";
    document.getElementById("description_textarea").textContent = task.description || "Thêm mô tả chi tiết...";
    if (task.dueTime) {
        document.getElementById("selected_date").textContent = task.dueTime || "Chưa có ngày hết hạn";
        countChangeDueTime = 0;
    } else {
        $(".due-date").hide();
    }

    let seenUsers = new Set();
    let memberIconHtml = "";
    let seenLabels = new Set();
    let labelHtml = "";

    details.forEach(detail => {
        if (detail.assignedUserId && !seenUsers.has(detail.assignedUserId)) {
            seenUsers.add(detail.assignedUserId);
            let words = detail.assignUserFullName.split(" ");
            let initials = (words[0]?.charAt(0) || "") + (words.length > 1 ? words[words.length - 1].charAt(0) : "");
            memberIconHtml += '<span data-id="' + detail.assignedUserId + '" class="icon">' + initials + '</span>'
        }
        if (detail.nameLabel && !seenLabels.has(detail.nameLabel)) {
            seenLabels.add(detail.nameLabel);
            labelHtml += '<span class="label" style="background: ' + detail.colorLabel + '">' + detail.nameLabel + '</span>';
        }
        let button = $('.assign-member-for-task'); // Lấy nút cần thay đổi
        if (parseInt(detail.assignedUserId) === parseInt(currentUser.userId)) {
            button.html('<i class="fas fa-user-minus"></i> Rời khỏi');
        } else {
            button.html('<i class="fas fa-user-plus"></i> Tham gia');
        }
    })

    if (seenUsers.size===0) {
        $('.members').hide();
    } if (seenLabels.size===0) {
        $('.labels').hide();
    }

    document.querySelector(".member-icons").innerHTML = memberIconHtml;
    document.querySelector(".works_together").innerHTML = labelHtml;

    document.getElementById("taskModal").style.display = "block";
}

// Đóng modal
function closeTaskModal() {
    let taskId = $('.modal_content').data("task");
    console.log(taskId)
    document.getElementById("taskModal").style.display = "none";
    console.log(selectedDate)
    checkIsHidden(".due-date", ".members", ".labels");
    if (countChangeDueTime === 1) {
        if (selectedDate) {
            saveDueTimeOfTask (taskId, selectedDate.toISOString());
            selectedDate = null;
        } else {
            deleteDueTimeOfTask(taskId);
        }
        countChangeDueTime = 0;
    }
}

function checkIsHidden (...divs) {
    divs.forEach(div => {
        if ($(div).is(":hidden")) {
            $(div).show()
        }
    })
}

// Hiển thị phần chỉnh sửa mô tả
function editDescription() {
    document.getElementById("description_display").classList.add("hidden");
    document.getElementById("description_edit").classList.remove("hidden");
}

// Lưu mô tả
function saveDescription() {
    let descText = document.getElementById("description_textarea").value;
    let taskId = $('.modal_content').data("task");
    saveEditDescription (taskId, descText);
    console.log(taskId, " ", descText)
    document.getElementById("description_display").textContent = descText;
    document.getElementById("description_display").classList.remove("hidden");
    document.getElementById("description_edit").classList.add("hidden");
}

// Hủy chỉnh sửa mô tả
function cancelDescription() {
    document.getElementById("description_display").classList.remove("hidden");
    document.getElementById("description_edit").classList.add("hidden");
}


document.getElementById("open_calendar").addEventListener("click", function () {
    document.getElementById("date_picker").showPicker(); // Hiển thị bộ chọn ngày
});

let selectedDate = null;
let countChangeDueTime = 0;

document.getElementById("date_picker").addEventListener("change", function () {
     selectedDate = new Date(this.value);
     countChangeDueTime = 1;

    // Lấy ngày, tháng, năm, giờ, phút, giây từ đối tượng Date
    let day = selectedDate.getDate();
    let month = selectedDate.getMonth() + 1; // Tháng trong JS bắt đầu từ 0
    let year = selectedDate.getFullYear();
    let hours = selectedDate.getHours();
    let minutes = selectedDate.getMinutes();
    let seconds = selectedDate.getSeconds();

    // Định dạng thành "dd/mm/yyyy HH:MM:SS"
    let formattedDate =
        (day < 10 ? "0" : "") + day + "/" +
        (month < 10 ? "0" : "") + month + "/" + year + " " +
        (hours < 10 ? "0" : "") + hours + ":" +
        (minutes < 10 ? "0" : "") + minutes + ":" +
        (seconds < 10 ? "0" : "") + seconds;

    // Cập nhật vào phần "Ngày hết hạn"
    checkIsHidden(".due-date");
    document.getElementById("selected_date").textContent = formattedDate;
});

$(".delete-selected_date").on("click", function () {
    $(".due-date").hide();
    selectedDate = null;
    countChangeDueTime = 1;
})

function deleteDueTimeOfTask (taskId) {
    $.ajax({
        type: "POST",
        url: "/board_home?action=deleteDueTimeOfTask",
        data: {taskId: taskId},
        success: function (status, xhr) {
            if (xhr.status === 200)
                console.log("Xoa thoi han thanh cong")
        },
        error: function () {
            console.log("Loi xu ly servlet")
        }
    })
}

function saveDueTimeOfTask (taskId, selectedDate) {
    $.ajax({
        type: "POST",
        url: "/board_home?action=saveDueTimeOfTask",
        data: {
            taskId: taskId,
            dueTime: selectedDate
        },
        success: function (status, xhr) {
            if (xhr.status === 200) {
                console.log("Đã cập nhật thời hạn của task");
            }
        },
        error: function () {
            console.log("Loi khi xu ly trong servlet")
        }
    })
}

function saveEditDescription (taskId, description) {
    $.ajax({
        type: "POST",
        url: "/board_home?action=saveDescriptionOfTask",
        data: {
            taskId: taskId,
            description: description
        },
        success: function (status, xhr) {
            if (xhr.status === 200) {
                console.log("Đã cập nhật thời hạn của task");
            }
        },
        error: function () {
            console.log("Loi khi xu ly trong servlet")
        }
    })
}

function assignTaskForMember(taskId, userId, type) {
    $.ajax({
        type: "POST",
        url: "/board_home?action=assignTaskForMember",
        data: {
            taskId: taskId,
            userId: userId,
            type: type
        },
        success: function () {
            console.log("Đã cập nhật trạng thái gắn thẻ của task");
        },
        error: function (xhr) {
            console.log("Lỗi khi xử lý trong servlet: ", xhr.responseText);
        }
    });
}



$('.assign-member-for-task').on("click", function () {
    let taskId = $('.modal_content').data("task");
    let button = $(this);
    let icon = button.find("i");

    if (icon.hasClass("fa-user-plus")) {
        assignTaskForMember(taskId, 0, 1);  // Gắn thẻ task
        icon.removeClass("fa-user-plus").addClass("fa-user-minus");
        button.contents().filter(function() {
            return this.nodeType === 3;
        }).replaceWith(" Rời khỏi");

        // Lấy ký tự viết tắt từ tên
        let words = currentUser.publicName.split(" ");
        let initials = (words[0]?.charAt(0) || "") + (words.length > 1 ? words[words.length - 1].charAt(0) : "");

        // Tạo span icon
        let span = $('<span>', {
            class: 'icon',
            'data-id': $('.modal_content').data("task"),
            text: initials
        });

        $('.member-icons').append(span); // Thêm span vào danh sách
        checkIsHidden(".members");
    } else {
        assignTaskForMember(taskId, 0, 0); // Bỏ gắn thẻ task
        icon.removeClass("fa-user-minus").addClass("fa-user-plus");
        button.contents().filter(function() {
            return this.nodeType === 3;
        }).replaceWith(" Tham gia");

        // Xóa icon của user khi rời khỏi task
        $('.member-icons .icon[data-id="' + currentUser.userId + '"]').remove();
        if ($('.member-icons').children().length === 0) {
            $('.members').hide();
        }
    }
});

