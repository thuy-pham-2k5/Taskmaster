document.querySelector(".toggle-btn").addEventListener("click", function(event) {
    event.preventDefault(); // Ngăn chặn chuyển trang
    var dropdown = document.querySelector(".dropdown-list");
    dropdown.style.display = dropdown.style.display === "block" ? "none" : "block";
});
