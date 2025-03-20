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
                        Swal.fire({
                            title: "Thành công!",
                            text: "Thành viên đã được mời.",
                            icon: "success",
                            timer: 1500,
                            timerProgressBar: true
                        });
                        let listMember = document.querySelector('#listMember');
                        if (listMember != null) {
                            let newListHtml = createNewUserHtml(response.infoNewMember);
                            console.log(newListHtml);
                            listMember.insertAdjacentHTML("beforebegin", newListHtml);
                        }
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
