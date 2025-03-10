<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Chi tiết bảng</title>
    <link rel="stylesheet" href="/css/user/board/detail_board.css">
</head>
<body>
<header>
    <jsp:include page="../account/menubar.jsp"/>
</header>
<main>
    <div class="home-left">
        <jsp:include page="../account/home_left.jsp"/>
    </div>
    <div class="home-right">
        <div class="title-bar">
            <div class="board_title">${boardDetail.title}</div>
        </div>
        <div class="lists">
            <c:forEach items="columns" var="column">
                <div class="container-list">
                    <div class="detail-list">
                        <div class="title-list">
                            <h2>${column.name}</h2>
                        </div>
                        <ol class="list-task">
                            <c:forEach items="tasks" var="task">
                                <li class="task">he</li>
                            </c:forEach>
                        </ol>
                        <div class="add_task">
                            <div class="btn_add_task">
                                <button>
                                    <img src="/images/add.png"/>
                                    Thêm thẻ
                                </button>
                            </div>
                            <div class="input_add_task"></div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
</main>
</body>
</html>