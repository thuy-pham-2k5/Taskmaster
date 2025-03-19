// Mời thành viên vào không gian làm việc
function openInviteMember() {
    Swal.fire({
        title: '<span style="font-size: 24px; font-weight: 400;">Mời vào không gian làm việc</span>',
        input: "email",
        inputPlaceholder: "Nhập email...",
        showCancelButton: true,
        confirmButtonText: "Gửi lời mời",
        cancelButtonText: "Hủy",
        confirmButtonColor: "#0f60a7",
        showLoaderOnConfirm: true,
        customClass: {
            title: "popup-title",
            actions: "swal-actions-right",
        },
        showClass: {
            popup: ""
        },
        preConfirm: (email) => {
            console.log(email);
            if (!email) {
                Swal.showValidationMessage("Vui lòng nhập email!");
                return;
            }
            return fetch("/group_member?action=inviteMember", {
                method: "POST",
                headers: {
                    "Content-Type": "application/x-www-form-urlencoded",
                },
                body: new URLSearchParams({email: email})
            })
                .then(response => response.json())
                .then(response => {
                    console.log(response);
                    if (response.result === "success") {
                        alertShowSuccess("Thành công!", "Thành viên đã được mời.");
                        let user = response.infoNewMember;
                        let listMember = document.querySelector('#listMember');
                        if (listMember != null) {
                            let newListHtml = createNewUserHtml(user);
                            console.log(newListHtml);
                            listMember.insertAdjacentHTML("beforebegin", newListHtml);
                        }
                        let guestId = document.querySelector(`[data-guestid="${user.userId}"]`);
                        let requestId = document.querySelector(`[data-requestid="${user.userId}"]`);
                        console.log(guestId, " ", requestId)
                        if (guestId)
                            guestId.remove();
                        if (requestId)
                            requestId.remove();
                    } else if (response.result === "false") {
                        Swal.showValidationMessage("Không thể gửi lời mời");
                    } else if (response.result === "added") {
                        Swal.showValidationMessage("Thành viên đã được thêm vào group");
                    } else if (response.result === "not exist") {
                        Swal.showValidationMessage("Người dùng không tồn tại");
                    }
                })
                .catch(() => {
                    Swal.showValidationMessage("Lỗi! Vui lòng thử lại.");
                });
        }
    })
}

function createNewUserHtml (user) {
    let startHtml = `<div class="user-general-info"><div class="user-info"><p class="user-info-name">`;
    let middleHtml = `</p><p>`;
    let middle2Html = `</p></div><div class="user-button-change"><button>Thành viên</button><button class="remove-btn">Loại bỏ</button><div class="confirm-box"><p>Bạn có chắc muốn loại bỏ `;
    let middle4Html = `?</p><button class="confirm-remove" onclick="deleteMember(`;
    let end = `)">Có</button><button class="cancel-remove">Hủy</button></div></div></div>`;
    return startHtml + user.fullName + middleHtml + user.username + middle2Html + user.fullName + middle4Html + user.userId + end;
}

function alertShowSuccess (title, text) {
    Swal.fire({
        title: title,
        text: text,
        icon: "success",
        timer: 1000,
        timerProgressBar: true
    });
}
