function sortTypeChanged() {
    const selectElement = document.getElementById('mySelect');
    const selectedValue = selectElement.value;
    const xhr = new XMLHttpRequest();
    xhr.open('GET', '/group_home?action=sortType&mySelect=' + selectedValue, true);
    xhr.onreadystatechange = function () {
        if (xhr.readyState === 4) {
            if (xhr.status === 200) {
                const boards = JSON.parse(xhr.responseText);
                const listBoards = document.getElementById("listBoards");
                listBoards.innerHTML = '';  // Xóa nội dung cũ
                boards.forEach(board => {
                    const div = document.createElement('div');
                    div.className = 'workspaceTable';
                    const label = document.createElement('label');
                    label.textContent = board.title;
                    div.appendChild(label);
                    listBoards.appendChild(div);
                });
            } else {
                console.error("Error: " + xhr.status + " - " + xhr.statusText);
            }
        }
    };
    xhr.send();
}

document.getElementById("mySelect").addEventListener("change", sortTypeChanged);


// function sortTypeChanged() {
//     const selectElement = document.getElementById('mySelect');
//     const selectedValue = selectElement.value;
//     const xhr = new XMLHttpRequest();
//
//     xhr.open('GET', '/group_home?action=sortType&mySelect=' + selectedValue, true);
//
//     xhr.onreadystatechange = function() {
//         if (xhr.readyState === 4 && xhr.status === 200) {
//             // Xử lý phản hồi từ máy chủ nếu cần
//             console.log('Response:', xhr.responseText);
//             // Cập nhật giao diện người dùng nếu cần
//         }
//     };
//
//     xhr.send();
// }


let timer;

function sendRequest() {
    const inputElement = document.getElementById('keyword');
    const inputValue = inputElement.value;
    const xhr = new XMLHttpRequest();
    xhr.open('GET', '/group_home?action=search&keyword=' + inputValue, true);
    xhr.send();
}

function inputChanged() {
    clearTimeout(timer);
    timer = setTimeout(sendRequest, 1500);
}

document.getElementById('keyword').addEventListener('input', inputChanged);


//     document.addEventListener("DOMContentLoaded", function () {
//     const invite_member = document.getElementById("invite_member");
//     const popupContent = document.getElementById("popup-content");
//
//     function hidePopup() {
//     invite_member.style.display = "none";
// }
//
//     invite_member.addEventListener("click", function (event) {
//     if (!popupContent.contains(event.target)) {
//     hidePopup();
// }
// });
//
//     window.invite_member = newPost;
//     window.hidePopup = hidePopup;
// });
