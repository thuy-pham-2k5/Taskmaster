<%@ page import="com.example.taskmaster.model.Task" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Chi tiết bảng</title>
    <link rel="stylesheet" href="/css/user/board/detail_board.css">
</head>
<body>
<header style="position: sticky;top: 0; z-index: 1000;">
    <jsp:include page="../account/menubar.jsp"/>
</header>
<main style="display: flex">
    <div id="homeLeft"
         style="width: 260px;position: sticky;top: 48px;left: 0;height: calc(100vh - 48px);background: #afe4f1;">
        <jsp:include page="../account/home_left.jsp"/>
    </div>
    <%
        Map<Integer, List<Task>> tasks = (Map<Integer, List<Task>>) request.getAttribute("tasks");
        if (tasks == null) {
            System.out.println("Tasks in JSP is NULL");
        } else {
            for (Map.Entry<Integer, List<Task>> entry : tasks.entrySet()) {
                System.out.println("Column ID: " + entry.getKey());
                for (Task task : entry.getValue()) {
                    System.out.println(" - Task Name: " + task.getTitle());
                }
            }
        }
    %>
    <div class="board_detail">
        <div class="board_name">
            ${boardDetail.title}
        </div>
        <div class="board_lists" style="display: flex">
            <c:forEach items="${columns}" var="column">
                <div class="list_detail">
                    <div class="list_name">
                        <div>${column.name}</div>
                    </div>
                    <div>
                        <c:forEach var="entry" items="${tasks}">
                            <c:if test="${entry.key eq column.columnId}">
                                <c:set var="taskList" value="${entry.value}"/>
                                <c:forEach var="task" items="${taskList}">
                                    <div class="task_name">
                                        <span>${task.title}</span>
                                    </div>
                                </c:forEach>
                            </c:if>
                        </c:forEach>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
</main>
</body>
</html>
