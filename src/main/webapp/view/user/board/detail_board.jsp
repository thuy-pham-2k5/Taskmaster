<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Chi tiết bảng</title>
    <link rel="stylesheet" href="/css/user/board/detail_board.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
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
        <div class="content_detail_board_parent">
            <div class="lists">
            </div>
            <div class="container-list">
                <div id="inputAddNewList" class="detail-list">
                    <div class="enter_add_list">
                        <div class="input_add_list">
                            <input id="titleNewColumn" type="text" name="inputName" placeholder="Nhập tên danh sách...">
                        </div>
                        <div class="action_add_list">
                            <button id="addNewList">Thêm danh sách</button>
                            <img src="/images/black_closed.png" alt="closed.png"
                                 onclick="showAndClosed('inputAddNewList', 'openAddNewList')">
                        </div>
                    </div>
                </div>
                <div id="openAddNewList" class="detail-list" style="background: rgb(141 176 210 / 35%);">
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
</script>

<script defer>
    let boardId = ${boardDetail.boardId};
    let columns = JSON.parse('${columns}');
    let tasks = JSON.parse('${tasks}');
    console.log(boardId);
    console.log("Columns", columns);
    console.log("Tasks", tasks);

    columns = new Proxy(columns, {
        set(target, property, value) {
            target[property] = value;
            console.log("Columns updated: ", target);
            if (!isNaN(property)) {
                renderBoard(columns, tasks);
            }
            return true;
        }
    })

    document.getElementById("addNewTask").addEventListener("click", function () {
        addNewTask();
    })
    document.getElementById("titleNewTask").addEventListener("keydown", function (event) {
        if (event.key === "Enter")
            addNewTask();
    })
    function addNewTask (titleTask, columnId) {
        $.ajax({
            type: "POST",
            url: "/board_home?action=addNewTask",
            data: {
                nameTask: titleTask,
                columnId: columnId
            },
            dataType: "json",
            success: function (response) {
                console.log("Du lieu task nhan duoc:", response)
                if (response) {
                    let newTask = {

                    }
                }
            }
        })
    }

    // gửi ajax khi tạo cột mới
    $(document).ready(function () {
        $("#addNewList").on("click", addNewColumn);
        $("#titleNewColumn").on("keydown", function (event) {
            if (event.key === "Enter") {
                addNewColumn();
            }
        });

        function addNewColumn() {
            let inputField = $("#titleNewColumn");
            let columnName = inputField.val().trim();

            if (columnName === "") {
                alert("Tên danh sách không thể để trống");
                return;
            }

            if (typeof boardId === "undefined" || boardId === null || boardId === "") {
                alert("Lỗi: boardId không tồn tại!");
                return;
            }

            // Gửi dữ liệu lên Servlet
            $.ajax({
                type: "POST",
                url: "/board_home?action=addNewColumn",
                data: {
                    boardId: boardId,
                    columnName: columnName
                },
                dataType: "json",
                success: function (response) {
                    console.log("Du lieu nhan duoc tu servlet:", response)
                    if (response) {
                        let newColumn = {
                            columnId: response.columnId,
                            name: response.name,
                            boardId: response.boardId,
                            position: response.position
                        };
                        console.log("New column", newColumn);
                        columns.push(newColumn);
                        inputField.val("");
                        inputField.focus();
                    } else {
                        alert("Không thể thêm danh sách, thử lại sau!");
                    }
                },
                error: function () {
                    alert("Lỗi kết nối đến server!");
                }
            });
        }
    });

    function renderBoard(columns, tasks) {
        const listsContainer = document.querySelector('.lists'); // Container để chứa các cột
        listsContainer.innerHTML = ''; // Reset nội dung trước khi render mới

        // Lặp qua các column
        const boardHtml = columns.map(column => {
            const taskList = Object.values(tasks || {}).flat().filter(task => task.columnId === column.columnId);
            const taskListHtml = taskList.map(task => `<li class="task">` + task.title + `</li>`).join('');
            return repeatColumnAndTask(column, taskListHtml);
        });
        listsContainer.innerHTML = boardHtml.join('');
        setTimeout(() => {
            setupAutoHide('inputAddNewList', 'openAddNewList');
            document.querySelectorAll("[id^='inputAddTask_']").forEach(element => {
                let idHidden = element.id;
                let idReplacement = idHidden.replace("inputAddTask_", "openAddTask_");
                setupAutoHide(idHidden, idReplacement);
            });
        }, 0);
    }

    function repeatColumnAndTask (column, tasks) {
        return '<div class="container-list">' +
                    '<div class="detail-list">' +
                        '<div class="title-list">' +
                            '<h2>' + column.name + '</h2>' +
                        '</div>' +
                        '<ol class="list-task">' +
                            tasks +
                        '</ol>' +
                        '<div class="add_task">' +
                            '<div id="openAddTask_' + column.columnId + '" class="btn_add_task" onclick="showAndClosed(\'openAddTask_' + column.columnId + '\', \'inputAddTask_' + column.columnId + '\')">' +
                                '<button>' +
                                    '<img src="/images/add.png"/>' +
                                    'Thêm thẻ' +
                                '</button>' +
                            '</div>' +
                            '<div id="inputAddTask_' + column.columnId + '" class="input_add_task">' +
                                '<div class="enter_add_task">' +
                                    '<div class="input_add_list">' +
                                        '<input id="titleNewTask_' + column.columnId + '" type="text" name="inputNameTask" placeholder="Nhập tên danh sách...">' +
                                    '</div>' +
                                    '<div class="action_add_list">' +
                                        '<button id="addNewTask">Thêm thẻ</button>' +
                                            '<img src="/images/black_closed.png" alt="closed.png" onclick="showAndClosed(\'inputAddTask_' + column.columnId + '\', \'openAddTask_' + column.columnId + '\')">' +
                                    '</div>' +
                                '</div>' +
                            '</div>' +
                        '</div>' +
                    '</div>' +
                '</div>';
    }

    document.addEventListener('DOMContentLoaded', () => {
        renderBoard(columns, tasks);
    });
</script>
</body>
</html>