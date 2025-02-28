<%--<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>--%>
<%--&lt;%&ndash;--%>
<%--  Created by IntelliJ IDEA.--%>
<%--  User: ASUS--%>
<%--  Date: 2/25/2025--%>
<%--  Time: 10:35 AM--%>
<%--  To change this template use File | Settings | File Templates.--%>
<%--&ndash;%&gt;--%>
<%--<%@ page contentType="text/html;charset=UTF-8" language="java" %>--%>
<%--<html>--%>
<%--<head>--%>
<%--    <meta charset="UTF-8">--%>
<%--    <title>Thành viên Không gian làm việc</title>--%>
<%--    <link rel="stylesheet" href="/css/user/group/memberWorkspace.css">--%>
<%--</head>--%>
<%--<body>--%>
<%--<main>--%>
<%--    <div class="content-container">--%>
<%--        <div class="content">--%>
<%--            <header class="header-content">--%>
<%--                <h2>Người cộng tác</h2>--%>
<%--            </header>--%>
<%--            <div class="main-content">--%>
<%--                <div class="main-content-sidebar">--%>
<%--                    <ul>--%>
<%--                        <li onclick="showSection('section1')"><a>Thành viên Không gian làm việc</a></li>--%>
<%--                        <li onclick="showSection('section2')"><a>Khách</a></li>--%>
<%--                        <li onclick="showSection('default')"><a>Yêu cầu tham gia</a></li>--%>
<%--                    </ul>--%>
<%--                   </div>--%>
<%--                <div class="main-content-show">--%>
<%--                    &lt;%&ndash;Đây là trang thành viên Không gian làm việc&ndash;%&gt;--%>
<%--                    <c:if test="${param.showSection == null || param.showSection == 'default'}">--%>
<%--                        <div id="defaultSection">--%>
<%--                            <p>Đây là trang Thành viên Không gian làm việc</p>--%>

<%--                            <div class="title">--%>
<%--                                <button onclick="toggleDisplay()">Toggle Section</button>                                <div class="title-admin"></div>--%>
<%--                                <div class="title-guest"></div>--%>
<%--                                <div class="title-request-to-join"></div>--%>
<%--                            </div>--%>
<%--                            <div class="input-search">--%>

<%--                            </div>--%>
<%--                            <div class="info">--%>

<%--                            </div>--%>
<%--                        </div>--%>
<%--                    </c:if>--%>

<%--                    <!-- Đây là trang Khách -->--%>
<%--                    <c:if test="${param.showSection == 'section1'}">--%>
<%--                        <div id="section1"><p>Đây là trang Khách</p></div>--%>
<%--                    </c:if>--%>

<%--                    <!-- Đây là trang Yêu cầu tham gia -->--%>
<%--                    <c:if test="${param.showSection == 'section2'}">--%>
<%--                        <div id="section2"><p>Đây là trang Yêu cầu tham gia</p></div>--%>
<%--                    </c:if>--%>
<%--                </div>--%>
<%--            </div>--%>
<%--        </div>--%>
<%--    </div>--%>
<%--</main>--%>
<%--<script>--%>
<%--    function showSection(section) {--%>
<%--        window.location.href = window.location.href.split('?')[0] + "?showSection=" + section;--%>
<%--    }--%>
<%--    function toggleDisplay() {--%>
<%--        var section = document.getElementById("mySection");--%>
<%--        if (section.style.display === "none") {--%>
<%--            section.style.display = "block";--%>
<%--        } else {--%>
<%--            section.style.display = "none";--%>
<%--        }--%>
<%--    }--%>
<%--</script>--%>
<%--</body>--%>
<%--</html>--%>


<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Toggle Display</title>
    <style>
        #mySection {
            display: none;
        }
    </style>
</head>
<body>
<button onclick="toggleDisplay()">Toggle Section</button>

<div id="mySection">
    <p>Đây là nội dung của section.</p>
</div>

<script>
    function toggleDisplay() {
        var section = document.getElementById("mySection");
        if (section.style.display === "none") {
            section.style.display = "block";
        } else {
            section.style.display = "none";
        }
    }
</script>
</body>
</html>
