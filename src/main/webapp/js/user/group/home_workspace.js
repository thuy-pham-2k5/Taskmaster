function sortTypeChanged() {
    const selectElement = document.getElementById('mySelect');
    const selectedValue = selectElement.value;
    const xhr = new XMLHttpRequest();
    xhr.open('GET', '/group_home?action=sortType&mySelect=' + selectedValue, true);
    xhr.send();
}

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
