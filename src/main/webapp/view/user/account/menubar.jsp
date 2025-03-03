<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<meta charset="UTF-8">
<style>
    body {
        margin: 0;
    }

    .parent {
        display: flex;
        padding: 8px;
        background: #3FB5CC;
    }

    .child-1 {
        display: flex;
        position: relative;
        flex-basis: 0;
        flex-grow: 1;
        flex-shrink: 0;
        align-items: stretch;
        height: 100%;
    }

    .create-new-one {
        display: flex;
        margin: 0 4px;
    }

    .button-menubar {
        height: 32px;
        margin-right: 4px;
        line-height: 32px;
        white-space: nowrap;
    }

    .child-2 {
        display: flex;
        justify-content: flex-end;
    }

    .img-menubar {
        width: 20px;
        height: 20px;
    }

    .img-logo {
        width: 28px;
        height: 28px;
    }

    .notification {
        display: inline-block;
        position: relative;
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
        <a href="#" class="logo-web">
            <div style="display: inline-block">
                <img class="img-logo" src="/images/logo.png" alt="logo.png">
            </div>
            <div>
                <span>Taskmaster</span>
            </div>
        </a>
        <div class="basic-list">
            <button class="button-menubar basic-list-1">Các không gian làm việc</button>
            <button class="button-menubar basic-list-2">Gần đây</button>
            <button class="button-menubar basic-list-3">Đã đánh dấu sao</button>
        </div>
        <div class="backup-list">
            <button class="button-menubar">Thêm</button>
        </div>
        <div>
            <button class="button-menubar create-new-one">
                <label>Tạo mới</label>
                <img class="img-menubar" src="/images/add.png" alt="plus.png" style="margin: auto">
            </button>
        </div>
    </div>
    <div class="child-2">
        <div>
            <input placeholder="🔍 Tìm kiếm..." style="height: 32px; margin-right: 4px;">
        </div>
        <div class="notification">
            <div class="img-notification"><img class="img-menubar" src="/images/bell.png" alt="notice.png"></div>
            <div class="number-of-notification"><span>3</span></div>
        </div>
        <div>
            <button class="button-menubar"><img class="img-menubar" src="/images/account.png" alt="account.png"></button>
        </div>
    </div>
</div>

<%--<!DOCTYPE html>--%>
<%--<html lang="en">--%>
<%--<head>--%>
<%--    <meta charset="UTF-8">--%>
<%--    <meta name="viewport" content="width=device-width, initial-scale=1.0">--%>
<%--    <title>Image Notification Example</title>--%>
<%--    <style>--%>
<%--        .image-container {--%>
<%--            position: relative;--%>
<%--            display: inline-block;--%>
<%--        }--%>

<%--        .image-container img {--%>
<%--            width: 100px; /* Bạn có thể điều chỉnh kích thước hình ảnh */--%>
<%--            height: auto;--%>
<%--        }--%>


<%--    </style>--%>
<%--</head>--%>
<%--<body>--%>
<%--<div class="image-container">--%>
<%--    <img src="/images/logo.png" alt="Example Image">--%>
<%--    <div class="notification"><span>3</span></div>--%>
<%--</div>--%>
<%--</body>--%>
<%--</html>--%>
