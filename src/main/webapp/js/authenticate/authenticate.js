function checkEmail() {
    var email = document.getElementById("email").value;
    var xhr = new XMLHttpRequest();
    xhr.open("GET", "checkEmail?email=" + encodeURIComponent(email), true);
    xhr.onreadystatechange = function () {
        if (xhr.readyState === 4 && xhr.status === 200) {
            var response = JSON.parse(xhr.responseText);
            var message = document.getElementById("message");
            if (response.exists) {
                message.innerHTML = "Email already exists.";
            } else {
                message.innerHTML = "Email is available.";
            }
        }
    };
    xhr.send();
}