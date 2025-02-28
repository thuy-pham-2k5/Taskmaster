<%--
  Created by IntelliJ IDEA.
  User: This  PC
  Date: 26/02/2025
  Time: 3:42 CH
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<div id="header">
    <div id="logo">
        <img style="height: 40px; width: 40px" src="/images/logo.png">
        <p>Taskmaster</p>
    </div>
    <div id="headerTopic">
        <a href="group_home?action=viewGroups">
            <div class="topic"><p>Các không gian làm vệc </p> <img class="listImage" src="/images/list.png"></div>
        </a>
        <div class="topic"><p>Gần đây</p> <img class="listImage" src="/images/list.png"></div>
        <div class="topic"><P>Đã đánh dấu sao</P> <img class="listImage" src="/images/list.png"></div>
        <a href="/view/user/group/create_workspace.jsp">
            <button>Tạo không gian làm việc mới</button>
        </a>
    </div>
    <div id="accountSearchNotification">
        <div id="search">
            <input type="text" style="width: 170px ; height: 30px; border-radius: 5px;"
                   placeholder="Tìm kiếm bảng...">
        </div>
        <img src="/images/bell.png">
        <img src="https://vivureviews.com/wp-content/uploads/2022/08/avatar-vo-danh-9.png">

        <a href="javascript:void(0);" onclick="$('#exampleModalCenter').modal('show');"> <img
                src="https://png.pngtree.com/png-clipart/20230314/original/pngtree-log-out-vector-icon-design-illustration-png-image_8987853.png"></a>
        <jsp:include page="../account/notification_log_out.jsp" />
    </div>
</div>
</body>
</html>
