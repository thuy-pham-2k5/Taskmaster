<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<meta charset="UTF-8">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Italianno&display=swap" rel="stylesheet">
<style>
    body {
        margin: 0;
    }

    .parent {
        display: flex;
        padding: 8px;
        background: #3FB5CC;
        user-select: none;
    }

    .child-1 {
        display: flex;
        position: relative;
        flex-basis: 0;
        flex-grow: 1;
        flex-shrink: 0;
        align-items: stretch;
    }

    .create-new-one {
        display: flex;
        margin: 0 4px;
        height: 32px;
        line-height: 32px;
        border: 0;
        border-radius: 5px;
        font-size: 17px;
        background: #007f99;
        color: white;
        white-space: nowrap;
        transition: background-color 0.3s ease;
    }

    .create-new-one:hover {
        border-radius: 5px;
        background-color: #00d4ff;
    }

    .create-new-one label {
        cursor: pointer;
    }

    button {
        cursor: pointer;
    }

    .button-menubar {
        border: 0;
        height: 32px;
        margin-right: 4px;
        line-height: 32px;
        white-space: nowrap;
        background: none;
        color: white;
        font-size: 17px;
    }

    .button-hover:hover {
        border-radius: 5px;
        background-color: rgba(217, 217, 217, 0.5);
    }

    .child-2 {
        display: flex;
        justify-content: flex-end;
    }

    .img-menubar {
        width: 20px;
        height: 20px;
    }

    .img-account {
        border-radius: 50%;
        border: 1px solid;
        padding: 3px;
        height: 25px;
        width: 25px;
    }

    .logo-web {
        display: flex;
        align-items: center;
        text-decoration: none;
        color: white;
        font-family: inherit;
        padding: 4px;
    }

    .logo-web:hover {
        border-radius: 5px;
        background-color: rgba(217, 217, 217, 0.5);
    }

    .logo-web div {
        margin-right: 4px;
        margin-left: 4px;
    }

    .img-logo {
        transform: translateY(-3px);
        width: 24px;
        height: 24px;
    }

    .text-logo {
        transform: translateY(2px);
        display: flex;
        line-height: 0;
        font-size: 30px;
        font-family: "Italianno", serif;
        font-style: normal;
    }

    .backup-list {
        display: flex;
    }

    .input-search {
        height: 32px;
        margin-right: 4px;
        background: none;
        border: 1px solid white;
        border-radius: 5px;
        padding: 9px;
    }

    .input-search:focus {
        border: 2px solid #a7f5ff;
        outline: none;
        width: 350px;
    }

    .notification {
        display: inline-block;
        position: relative;
        margin-right: 4px;
    }

    .img-notification {
        margin-right: 9px;
    }

    .img-notification img {
        width: 32px;
        height: 32px;
    }

    .number-of-notification {
        position: absolute;
        top: 0;
        right: 0;
        background-color: red;
        color: white;
        border-radius: 50%;
        font-size: 10px;
        width: 17px;
        height: 17px;
        display: flex;
        justify-content: center;
        align-items: center;
    }

    /* Container của dropdown */
    .dropdown {
        position: relative;
        display: inline-block;
    }

    /* Danh sách dropdown (ẩn mặc định) */
    .dropdown-content {
        transform: translateY(8px);
        display: none;
        position: absolute;
        background-color: burlywood;
        min-width: 150px;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        border-radius: 5px;
    }

    /* Các item trong dropdown */
    .dropdown-content a {
        color: white;
        padding: 10px;
        display: block;
        text-decoration: none;
    }

    .dropdown-content a:hover {
        background-color: #f1f1f1;
    }

    @media screen {
        .backup-list {
            display: none;
        }

        .create-new-one img {
            display: none;
        }
    }

    @media (max-width: 1170px) {
        .basic-list-3 {
            display: none;
        }

        .backup-list {
            display: block;
        }

        .create-new-one label {
            display: none;
        }

        .create-new-one img {
            display: inline-block;
        }
    }

    @media (max-width: 1000px) {
        .basic-list-2 {
            display: none;
        }
    }

    @media (max-width: 900px) {
        .basic-list-1 {
            display: none;
        }
    }
</style>

<div class="parent">
    <div class="child-1">
        <a href="/account_home" class="logo-web">
            <div>
                <img class="img-logo" src="/images/logo.png" alt="logo.png">
            </div>
            <div>
                <span class="text-logo">Taskmaster</span>
            </div>
        </a>
        <div class="basic-list">
            <div class="dropdown">
                <button class="button-hover button-menubar basic-list-1" onclick="toggleDropdown('workspace')">Các không gian làm việc</button>
                <div class="dropdown-content" id="workspace">
                    <a href="#">Tùy chọn 1</a>
                    <a href="#">Tùy chọn 2</a>
                    <a href="#">Tùy chọn 3</a>
                </div>
            </div>
            <div class="dropdown">
                <button class="button-hover button-menubar basic-list-2" onclick="toggleDropdown('recent')">Gần đây</button>
                <div class="dropdown-content" id="recent">
                    <a href="#">Tùy chọn 3</a>
                    <a>Tùy chọn 4</a>
                    <a>Tùy chọn 5</a>
                </div>
            </div>
            <div class="dropdown">
                <button class="button-hover button-menubar basic-list-3" onclick="toggleDropdown('stars')">Đã đánh dấu sao</button>
                <div class="dropdown-content" id="stars">
                    <a href="#">Tùy chọn 6</a>
                    <a href="#">Tùy chọn 7</a>
                    <a href="#">Tùy chọn 8</a>
                </div>
            </div>
        </div>
        <div class="backup-list">
            <button class="button-hover button-menubar">Thêm</button>
        </div>
        <div>
            <button class="create-new-one">
                <label>Tạo mới</label>
                <img class="img-menubar" src="/images/add.png" alt="plus.png" style="margin: auto">
            </button>
        </div>
    </div>
    <div class="child-2">
        <div>
            <input class="input-search" placeholder="🔍 Tìm kiếm...">
        </div>
        <div class="notification" style="cursor: pointer">
            <div class="img-notification"><img class="img-menubar" src="/images/bell.png" alt="notice.png"></div>
            <div class="number-of-notification"><span>3</span></div>
        </div>
        <div>
            <button class="button-menubar" style="padding: 0"><img class="img-account" src="/images/account.png" alt="account.png">
            </button>
        </div>
    </div>
</div>

<script>
    function toggleDropdown(dataId) {
        let dropdown = document.getElementById(dataId);
        document.querySelectorAll(".dropdown-content").forEach(menu => {
            if (menu.id !== dataId) {
                menu.style.display = "none";
            }
        });
        dropdown.style.display = (dropdown.style.display === "block") ? "none" : "block";
    }

    // Ẩn dropdown khi click ra ngoài
    window.onclick = function(event) {
        if (!event.target.matches('.dropdown button')) {
            document.querySelectorAll(".dropdown-content").forEach(menu => {
                menu.style.display = "none";
            });
        }
    }
</script>

