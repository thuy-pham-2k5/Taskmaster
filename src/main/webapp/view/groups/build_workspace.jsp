<%--
  Created by IntelliJ IDEA.
  User: This  PC
  Date: 18/02/2025
  Time: 3:12 CH
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="css/groups/build_workspace.css">
</head>
<body>
<div id="buildWorkspaceCart">
    <div id="inputInformationWorkspace">
        <p style="font-size: 27px">Hãy xây dựng một không gian làm việc</p>
        <p style="font-size: 18px">Tăng năng suất của bạn bằng cách giúp mọi người dễ dàng truy cập bảng ở một vị trí.</p>
        <label for="nameSp">Tên không gian làm việc</label>
        <input id="nameSp" type="text">
        <label for="typeSp">Loại không gian làm việc</label>
        <select id="typeSp">
            <option>Điều hành</option>
            <option>Kinh doanh CRM</option>
            <option>Kỹ thuật - CNTT</option>
            <option>Giáo dục</option>
            <option>Nhân sự</option>
            <option>Doanh nghiệp nhỏ</option>
            <option>Marketing</option>
        </select>
        <label for="describe" >Mô tả không gian làm việc</label>
        <textarea id="describe" placeholder="Nhóm của chúng tôi tổ chức mọi thứ ở đây"></textarea>
        <button>Tiếp tục</button>
    </div>
    <div id="imageBackgroud">
        <img src="https://png.pngtree.com/png-vector/20220708/ourmid/pngtree-calendar-with-selected-date-png-image_5811645.png">
    </div>
</div>
</body>
</html>
