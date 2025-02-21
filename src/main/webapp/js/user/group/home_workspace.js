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

function startTimer() {
    clearInterval(timer);
    timer = setInterval(sendRequest, 3000); // Gửi yêu cầu mỗi 3 giây
}

function inputChanged() {
    startTimer();
}