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

function showOverlay() {
    document.getElementById('overlay').style.display = 'block';
}

// Ẩn overlay
function hideOverlay() {
    document.getElementById('overlay').style.display = 'none';
}