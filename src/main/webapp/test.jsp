<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <style>
        nav a:hover {
            text-decoration: underline;
        }

        .content-parent {
            display: flex;
            justify-content: center;
            padding-bottom: 40px;
        }

        .home-left-sidebar {
            margin: 40px 0 0;
            max-height: 90vh;
            padding: 0 16px;
            position: sticky;
            top: 40px;
            width: 256px;
        }

        .ul-workspace {
            max-height: calc(100vh - 200px);
            overflow-y: auto;
        }

        .home-container-all-board {
            margin: 40px 16px 0;
            max-width: 825px;
            min-width: 288px;
            width: 100%;
        }
    </style>
</head>
<body>
<div>menubar</div>
<div class="content-parent">
    <nav class="home-left-sidebar">
        <div>
            <ul>
                <li>Home</li>
                <li>Heart</li>
                <li>Your boards</li>
            </ul>
        </div>
        <div>
            <ul style="max-height: calc(100vh - 200px); overflow-y: auto;">
                <div>Khong gian lam viec</div>
                <li class="ul-workspace">
                    <ul>Quản lý công việc Taskmaster
                        <li>Quản lý công việc T</li>
                        <li>Quản lý công việc A</li>
                        <li>Quản lý công việc T</li>
                        <li>Quản lý công việc A</li>
                        <li>Quản lý công việc T</li>
                        <li>Quản lý công việc A</li>
                        <li>Quản lý công việc T</li>
                        <li>Quản lý công việc A</li>
                        <li>Quản lý công việc T</li>
                        <li>Quản lý công việc A</li>
                    </ul>
                </li>
                <li class="ul-workspace">
                    <ul>Quản lý công việc Taskmaster
                        <li>Quản lý công việc T</li>
                        <li>Quản lý công việc A</li>
                        <li>Quản lý công việc T</li>
                        <li>Quản lý công việc A</li>
                        <li>Quản lý công việc T</li>
                        <li>Quản lý công việc A</li>
                        <li>Quản lý công việc T</li>
                        <li>Quản lý công việc A</li>
                        <li>Quản lý công việc T</li>
                        <li>Quản lý công việc A</li>
                    </ul>
                </li>
                <li class="ul-workspace">
                    <ul>Quản lý công việc Taskmaster
                        <li>Quản lý công việc T</li>
                        <li>Quản lý công việc A</li>
                        <li>Quản lý công việc T</li>
                        <li>Quản lý công việc A</li>
                        <li>Quản lý công việc T</li>
                        <li>Quản lý công việc A</li>
                        <li>Quản lý công việc T</li>
                        <li>Quản lý công việc A</li>
                        <li>Quản lý công việc T</li>
                        <li>Quản lý công việc A</li>
                    </ul>
                </li>
            </ul>
        </div>
    </nav>
    <div class="home-container-all-board">
        <div>
            <p>Bảng ở đây</p>
            <p>Content ở đây</p>
            <ul>Quản lý công việc Taskmaster
                <li>Quản lý công việc T</li>
                <li>Quản lý công việc A</li>
                <li>Quản lý công việc S</li>
                <li>Quản lý công việc K</li>
                <li>Quản lý công việc M</li>
                <li>Quản lý công việc A</li>
                <li>Quản lý công việc S</li>
                <li>Quản lý công việc T</li>
                <li>Quản lý công việc E</li>
                <li>Quản lý công việc R</li>
            </ul>
            <ul>Quản lý công việc Taskmaster
                <li>Quản lý công việc T</li>
                <li>Quản lý công việc A</li>
                <li>Quản lý công việc S</li>
                <li>Quản lý công việc K</li>
                <li>Quản lý công việc M</li>
                <li>Quản lý công việc A</li>
                <li>Quản lý công việc S</li>
                <li>Quản lý công việc T</li>
                <li>Quản lý công việc E</li>
                <li>Quản lý công việc R</li>
            </ul>
            <ul>Quản lý công việc Taskmaster
                <li>Quản lý công việc T</li>
                <li>Quản lý công việc A</li>
                <li>Quản lý công việc S</li>
                <li>Quản lý công việc K</li>
                <li>Quản lý công việc M</li>
                <li>Quản lý công việc A</li>
                <li>Quản lý công việc S</li>
                <li>Quản lý công việc T</li>
                <li>Quản lý công việc E</li>
                <li>Quản lý công việc R</li>
            </ul>
            <ul>Quản lý công việc Taskmaster
                <li>Quản lý công việc T</li>
                <li>Quản lý công việc A</li>
                <li>Quản lý công việc S</li>
                <li>Quản lý công việc K</li>
                <li>Quản lý công việc M</li>
                <li>Quản lý công việc A</li>
                <li>Quản lý công việc S</li>
                <li>Quản lý công việc T</li>
                <li>Quản lý công việc E</li>
                <li>Quản lý công việc R</li>
            </ul>
            <ul>Quản lý công việc Taskmaster
                <li>Quản lý công việc T</li>
                <li>Quản lý công việc A</li>
                <li>Quản lý công việc S</li>
                <li>Quản lý công việc K</li>
                <li>Quản lý công việc M</li>
                <li>Quản lý công việc A</li>
                <li>Quản lý công việc S</li>
                <li>Quản lý công việc T</li>
                <li>Quản lý công việc E</li>
                <li>Quản lý công việc R</li>
            </ul>
        </div>
    </div>
</div>
</body>
</html>