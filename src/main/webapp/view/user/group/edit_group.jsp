<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="css/user/group/edit_group.css">

</head>
<body>
<div id="editGroupModal" class="modal">
        <div class="modal-title">Chỉnh sửa</div>
        <div id="editFrame">
            <label>🏢 Tên không gian làm việc</label>
            <input type="text" id="groupNameInput" value="${groupInfo.title}">

            <label>📝 Mô tả (tùy chỉnh)</label>
            <textarea id="groupDescInput">${groupInfo.description}</textarea>

            <button style="background-color: #0c66e4; color: white">
                💾 Lưu
            </button>

            <button onclick="document.getElementById('editGroupModal').style.display='none'">
                ❌ Hủy
            </button>
        </div>
</div>
</body>
</html>



