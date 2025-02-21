<%--&lt;%&ndash;--%>
<%--  Created by IntelliJ IDEA.--%>
<%--  User: This  PC--%>
<%--  Date: 18/02/2025--%>
<%--  Time: 3:12 CH--%>
<%--  To change this template use File | Settings | File Templates.--%>
<%--&ndash;%&gt;--%>
<%--<%@ page contentType="text/html;charset=UTF-8" language="java" %>--%>
<%--<html>--%>
<%--<head>--%>
<%--    <title>Title</title>--%>
<%--    <link rel="stylesheet" href="css/groups/build_workspace.css">--%>
<%--</head>--%>
<%--<body>--%>
<%--<div id="buildWorkspaceCart">--%>
<%--    <form action="group?action=createGroup" method="post">--%>
<%--        <div id="inputInformationWorkspace">--%>
<%--            <p style="font-size: 27px">Hãy xây dựng một không gian làm việc</p>--%>
<%--            <p style="font-size: 18px">Tăng năng suất của bạn bằng cách giúp mọi người dễ dàng truy cập bảng ở một vị trí.</p>--%>
<%--            <label for="nameSp">Tên không gian làm việc</label>--%>
<%--            <input id="nameSp" type="text" name="nameSp">--%>
<%--            <label for="typeSp">Loại không gian làm việc</label>--%>
<%--            <select id="typeSp">--%>
<%--                <option>Điều hành</option>--%>
<%--                <option>Kinh doanh CRM</option>--%>
<%--                <option>Kỹ thuật - CNTT</option>--%>
<%--                <option>Giáo dục</option>--%>
<%--                <option>Nhân sự</option>--%>
<%--                <option>Doanh nghiệp nhỏ</option>--%>
<%--                <option>Marketing</option>--%>
<%--            </select>--%>
<%--            <label for="describe" >Mô tả không gian làm việc</label>--%>
<%--            <textarea id="describe" name="describe" placeholder="Nhóm của chúng tôi tổ chức mọi thứ ở đây"></textarea>--%>
<%--            <button type="submit">Tiếp tục</button>--%>
<%--        </div>--%>
<%--    </form>--%>

<%--    <div id="imageBackgroud">--%>
<%--        <img src="https://png.pngtree.com/png-vector/20220708/ourmid/pngtree-calendar-with-selected-date-png-image_5811645.png">--%>
<%--    </div>--%>
<%--</div>--%>
<%--</body>--%>
<%--</html>--%>



<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tạo Không Gian Làm Việc</title>
    <link rel="stylesheet" href="/css/groups/build_workspace.css">
</head>
<body>
<a href="/view/groups/homeWorkspace.jsp"><img style="width: 50px; height: 50px" src="https://png.pngtree.com/png-vector/20230311/ourmid/pngtree-logout-arrow-line-icon-vector-png-image_6644097.png"></a>
<div id="workspaceContainer">
    <div id="workspaceContent">
        <!-- Form nhập thông tin -->
        <form action="/group?action=createGroup" method="post" id="workspaceForm">
            <h1>Xây dựng không gian làm việc của bạn</h1>
            <p class="sub-text">Tăng năng suất bằng cách giúp mọi người dễ dàng truy cập bảng ở một vị trí.</p>

            <label for="nameSp">📌 Tên không gian làm việc</label>
            <input id="nameSp" type="text" name="nameSp" placeholder="Nhập tên không gian..." required>

            <label for="typeSp">📂 Loại không gian làm việc</label>
            <select id="typeSp" name="typeSp">
                <option>Điều hành</option>
                <option>Kinh doanh CRM</option>
                <option>Kỹ thuật - CNTT</option>
                <option>Giáo dục</option>
                <option>Nhân sự</option>
                <option>Doanh nghiệp nhỏ</option>
                <option>Marketing</option>
            </select>

            <label for="describe">📝 Mô tả không gian làm việc</label>
            <textarea id="describe" name="describe" placeholder="Nhóm của chúng tôi tổ chức mọi thứ ở đây..."></textarea>

            <button type="submit">✨ Tiếp tục</button>
        </form>

        <!-- Hình ảnh minh họa -->
        <div id="workspaceImage">
            <img src="https://png.pngtree.com/png-vector/20220708/ourmid/pngtree-calendar-with-selected-date-png-image_5811645.png" alt="Lịch làm việc">
        </div>
    </div>
</div>
</body>
</html>
