<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<form action="/group_home?action=editInfoGroup&groupId=${groupInfo.groupId}" method="post">
    <label>🏢 Tên không gian làm việc</label>
    <input name="title" type="text" id="groupNameInput" style="margin-bottom: 20px"
           value="${groupInfo.title}">

    <label>🔠 Tên ngắn gọn</label>
    <input name="short_title" type="text" id="shortNameInput" style="margin-bottom: 20px"
           value="${groupInfo.short_title}">

    <label>📝 Mô tả (tùy chỉnh)</label>
    <textarea name="description" id="groupDescInput">${groupInfo.description}</textarea>

    <div class="button-group">
        <button onclick="saveEditGroup(event)" class="save-btn" type="submit" id="save" disabled>
            Lưu
        </button>

        <button type="button" class="cancel-btn" onclick="cancelEdit()">Hủy</button>
    </div>
</form>



