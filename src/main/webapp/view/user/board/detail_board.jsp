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
            <c:forEach items="${columns}" var="column">
                <div class="container-list">
                    <div class="detail-list">
                        <div class="title-list">
                            <h2>${column.name}</h2>
                        </div>
                        <ol class="list-task">
                            <c:forEach items="${tasks}" var="entry">
                                <c:set var="key" value="${entry.key}"/>
                                <c:set var="taskList" value="${entry.value}"/>
                                <c:if test="${column.columnId==key}">
                                    <c:forEach var="task" items="${taskList}">
                                        <li class="task">${task.title}</li>
                                    </c:forEach>
                                </c:if>
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
            <div  class="container-list">
                <div id="inputAddNewList" class="detail-list">
                    <div class="enter_add_list">
                        <div class="input_add_list">
                            <input type="text" name="inputName" placeholder="Nhập tên danh sách...">
                        </div>
                        <div class="action_add_list">
                            <button id="addNewList">Thêm danh sách</button>
                            <img src="/images/black_closed.png" alt="closed.png" onclick="showAndClosed('inputAddNewList', 'openAddNewList')">
                        </div>
                    </div>
                </div>
                <div  id="openAddNewList" class="detail-list" style="background: rgb(141 176 210 / 35%);">
                    <div class="btn_add_list" onclick="showAndClosed('openAddNewList', 'inputAddNewList')">
                        <button>
                            <img src="/images/add.png"/>
                            Thêm danh sách khác
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</main>
<script>
    function setupAutoHide(idHidden, idReplacement) {
        document.addEventListener("click", function (event) {
            let div = document.getElementById(idHidden);
            if (div.style.display === "block" && !div.contains(event.target)) {
                div.style.display = "none";
                if (idReplacement !== null) {
                    document.getElementById(idReplacement).style.display = 'block';
                }
            }
        });
    }

    function showAndClosed(idClosed, idShow) {
        event.stopPropagation();
        document.getElementById(idClosed).style.display = "none";
        let showElement = document.getElementById(idShow);
        showElement.style.display = "block";

        let input = showElement.querySelector("input");
        if (input) {
            setTimeout(() => input.focus(), 50);
        }
    }

    setupAutoHide('inputAddNewList', 'openAddNewList');

    $(document).on("click", "#addNewList", function() {
        console.log("Name Board: " + $(this).val());
        const selectedValue = $(this).val();
        $.get(`/group_home?action=sortType&option=` + selectedValue, function(responseJson) {
            const $listBoards = $("#listBoards");
            $listBoards.empty();
            $.each(responseJson, function(index, board) {
                $("<div>").addClass("workspaceTable")
                    .append($("<label>").addClass("title_bar").text(board.title))
                    .appendTo($listBoards);
            });
        });
    });

</script>
</body>
</html>