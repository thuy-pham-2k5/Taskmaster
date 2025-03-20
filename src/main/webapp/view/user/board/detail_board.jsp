<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Chi tiết bảng</title>
    <link rel="stylesheet" href="/css/user/board/detail_board.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
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
    <div class="db-dropdown-action-task" id="operationList">
        <div>
            <h4>Thao tác</h4>
        </div>
        <ul class="db-dropdown-lists">
            <li id="operation-addTask" class="db-dropdown-action">
                <button>Thêm thẻ</button>
            </li>
            <li id="operation-copyList" class="db-dropdown-action">
                <button>Sao chép danh sách</button>
            </li>
            <li id="operation-moveList" class="db-dropdown-action">
                <button>Di chuyển danh sách</button>
            </li>
            <li id="operation-sortType" class="db-dropdown-action">
                <button>Sắp xếp theo...</button>
            </li>
            <li id="operation-track" class="db-dropdown-action">
                <button>Theo dõi</button>
            </li>
            <li id="operation-deleteList" class="db-dropdown-action">
                <button>Xóa danh sách</button>
            </li>
            <li id="operation-deleteAllTask" class="db-dropdown-action">
                <button>Xóa tất cả thẻ trong danh sách</button>
            </li>
        </ul>
    </div>
</main>
<!-- Task Modal -->
<div id="taskModal">
    <div class="modal_content">
        <div id="header_task">
            <div id="title_task_info">
                <input id="modalTaskTitle" type="text" name="title_task" value="Tiêu đề Task"/>
                <p>trong danh sách <span class="status">To Do</span></p>
            </div>
            <div id="block">
                <span class="close" onclick="closeTaskModal()">&times;</span>
            </div>
        </div>

        <div id="content_task">
            <div id="navigation_task">
                <div id="expire_task">
                    <section class="members">
                        <p>Thành viên</p>
                        <div class="member-icons">
                            <span class="icon">T</span>
                            <button>+</button>
                        </div>
                    </section>
                    <section class="labels">
                        <p>Nhãn</p>
                        <div class="works_together">
                            <span class="label">Công việc chung</span>
                            <button>+</button>
                        </div>
                    </section>
                    <section class="due-date">
                        <p>Ngày hết hạn</p>
                        <div>
                            <span id="selected_date"></span>
                        </div>
                    </section>
                </div>

                <section class="description_task">
                    <p>Mô tả</p>
                    <div id="description_display" onclick="editDescription()">Thêm mô tả chi tiết...</div>
                    <div id="description_edit" class="hidden">
                        <textarea id="description_textarea" placeholder="Viết mô tả task..."></textarea>
                        <div class="buttons_description">
                            <button class="save_description_button" onclick="saveDescription()">Lưu</button>
                            <button class="cancel_description_button" onclick="cancelDescription()">Hủy</button>
                        </div>
                    </div>
                </section>

                <section class="comment_task">
                    <span class="icon">T</span>
                    <div class="comment_input_container">
                        <input type="text" placeholder="Viết bình luận..." id="comment_input"/>
                        <button class="send_comment_button"><i class="fas fa-paper-plane"></i></button>
                    </div>
                </section>
            </div>

            <div id="tools_task">
                <button><i class="fas fa-user-plus"></i> Tham gia</button>
                <button><i class="fas fa-users"></i> Thành viên</button>
                <button><i class="fas fa-tags"></i> Nhãn</button>
                <button><i class="fas fa-tasks"></i> Việc cần làm</button>
                <button><i class="fas fa-archive"></i> Lưu trữ</button>
                <section style="background-color: #0079bf; width: 100%; height: 30px; border-radius: 5px;"
                         class="date-picker-section">
                    <button id="open_calendar"><i class="fas fa-calendar-alt"></i> Ngày</button>
                    <input type="date" id="date_picker">
                </section>
            </div>
        </div>
    </div>
</div>
<script>
    let task = null;
    $(".task").on("click", function () {
        let taskId = $(this).data('task');
        getInfoTask(taskId);
        openTaskModal(task)
    })
    function getInfoTask (taskId) {
        $.ajax({
            type: "POST",
            url: "/board_home?action=getInfoTask",
            data: {
                taskId: taskId
            },
            dataType: "json",
            success: function (task) {

            }
        })
    }
    // Hiển thị modal task với thông tin từ task
    function openTaskModal(task) {
        document.getElementById("modalTaskTitle").value = task.title;
        document.querySelector(".status").textContent = task.status || "To Do";
        document.getElementById("description_display").textContent = task.description || "Thêm mô tả chi tiết...";
        document.getElementById("selected_date").textContent = task.dueDate || "Chưa có ngày hết hạn";

        document.getElementById("taskModal").style.display = "block";
    }

    // Đóng modal
    function closeTaskModal() {
        document.getElementById("taskModal").style.display = "none";
    }

    // Hiển thị phần chỉnh sửa mô tả
    function editDescription() {
        document.getElementById("description_display").classList.add("hidden");
        document.getElementById("description_edit").classList.remove("hidden");
    }

    // Lưu mô tả
    function saveDescription() {
        let descText = document.getElementById("description_textarea").value;
        document.getElementById("description_display").textContent = descText || "Thêm mô tả chi tiết...";
        document.getElementById("description_display").classList.remove("hidden");
        document.getElementById("description_edit").classList.add("hidden");
    }

    // Hủy chỉnh sửa mô tả
    function cancelDescription() {
        document.getElementById("description_display").classList.remove("hidden");
        document.getElementById("description_edit").classList.add("hidden");
    }


    document.getElementById("open_calendar").addEventListener("click", function () {
        document.getElementById("date_picker").showPicker(); // Hiển thị bộ chọn ngày
    });

    document.getElementById("date_picker").addEventListener("change", function () {
        let selectedDate = new Date(this.value);

        // Lấy ngày, tháng, năm từ đối tượng Date
        let day = selectedDate.getDate();
        let month = selectedDate.getMonth() + 1; // Tháng trong JS bắt đầu từ 0
        let year = selectedDate.getFullYear();

        // Định dạng thành "dd/mm/yyyy"
        let formattedDate = (day < 10 ? "0" : "") + day + "/" +
            (month < 10 ? "0" : "") + month + "/" + year;

        // Cập nhật vào phần "Ngày hết hạn"
        document.getElementById("selected_date").textContent = formattedDate;
    });

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

    setupAutoHide('inputAddNewList', 'openAddNewList');
</script>
<script defer>
    let boardId = ${boardDetail.boardId};
    let columns = JSON.parse('${columns}');
    let tasks = JSON.parse('${tasks}');
    console.log(boardId);
    console.log("Columns", columns);
    console.log("Tasks", tasks);

    document.addEventListener("click", function (event) {
        if (event.target.tagName === "BUTTON" && event.target.classList.contains("addNewTask")) {
            addNewTask(event);
            console.log(tasks);
        }
    })
    document.addEventListener("keydown", function (event) {
        if (event.target.tagName === "INPUT" && event.target.name === "inputNameTask" && event.key === "Enter") {
            addNewTask(event);
        }
    })

    function addNewTask(event) {
        let parentDiv = event.target.closest(".add_task");
        let inputField = parentDiv.querySelector("input[name=inputNameTask]");
        let titleTask = inputField.value;

        if (titleTask === null || titleTask === "") {
            return;
        }

        let columnId = inputField.dataset.column;
        console.log("Id cua column cha:", columnId);

        $.ajax({
            type: "POST",
            url: "/board_home?action=addNewTask",
            data: {
                nameTask: titleTask,
                columnId: columnId
            },
            dataType: "json",
            success: function (task) {
                console.log("Du lieu task nhan duoc:", task)
                if (task) {
                    let newTask = {
                        taskId: task.taskId,
                        title: task,
                        columnId: columnId,
                        position: task.position
                    }

                    if (!tasks[columnId]) {
                        tasks[columnId] = [];
                    }

                    tasks[columnId].push(newTask);

                    let bigParentDiv = event.target.closest(".detail-list");
                    let listTask = bigParentDiv?.querySelector(".list-task");
                    let newTaskHtml = document.createElement("li");
                    newTaskHtml.classList.add("task");
                    newTaskHtml.setAttribute("data-task", task.taskId);
                    newTaskHtml.setAttribute("data-position", task.position);
                    newTaskHtml.onclick = function () {
                        openTaskModal({ title: titleTask, status: "To Do", description: "Mô tả task" });
                    };
                    newTaskHtml.textContent = titleTask;

                    if (listTask === null) {
                        return;
                    }

                    listTask.appendChild(newTaskHtml);
                    inputField.value = "";
                }
            }
        })
    }

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
            success: function (column) {
                console.log("Du lieu nhan duoc tu servlet:", column)
                if (column) {
                    let newColumn = {
                        columnId: column.columnId,
                        name: column.name,
                        boardId: column.boardId,
                        position: column.position
                    };
                    console.log("New column", newColumn);
                    columns.push(newColumn);
                    inputField.val("");
                    inputField.focus();

                    let lists = document.querySelector('.lists');
                    let newListHtml = repeatColumnAndTask(column, "");
                    console.log(newListHtml)
                    lists.insertAdjacentHTML("beforeend", newListHtml);
                }
            }
        });
    }
</script>
<script>
    function renderBoard(columns, tasks) {
        const listsContainer = document.querySelector('.lists'); // Container để chứa các cột
        listsContainer.innerHTML = ''; // Reset nội dung trước khi render mới

        // Lặp qua các column
        const boardHtml = columns.map(column => {
            const taskList = Object.values(tasks || {}).flat().filter(task => task.columnId === column.columnId);
            const taskListHtml = taskList.map(task => `<li onclick="openTaskModal({ title: 'Tiêu đề Task', status: 'To Do', description: 'Mô tả task'})" class="task" data-task="` + task.taskId + `" data-position="` + task.position + `">` + task.title + `</li>`).join('');
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


    function repeatColumnAndTask(column, tasks) {
        return '<div class="container-list">' +
            '<div class="detail-list" data-column="' + column.columnId + '">' +
            '<div class="title-list">' +
            '<h2>' + column.name + '</h2>' +
            '<img class="openOperationList" src="/images/ellipsis_black.png" alt="closed-board"/>' +
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
            '<input data-column="' + column.columnId + '" type="text" name="inputNameTask" placeholder="Nhập tên danh sách...">' +
            '</div>' +
            '<div class="action_add_list">' +
            '<button class="addNewTask">Thêm thẻ</button>' +
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
<script defer>
    let currentOpenOperationList = null;
    // mở thao tác cột
    $(document).on("click", ".openOperationList", function (event) {
        let openDropdown = $(this);
        let dropdown = $("#operationList");

        if (currentOpenOperationBoard) {
            currentOpenOperationBoard.removeClass("dropdown-open");
            hideDropdown("#operationBoard");
            currentOpenOperationBoard = null;
        }

        updateDropdownPosition(openDropdown, dropdown);

        $('.content_detail_board_parent').scroll(function () {
            if (dropdown.is(":visible")) {
                openDropdown.addClass("active");
                updateDropdownPosition(openDropdown, dropdown);
            }
        })
        currentOpenOperationList = openDropdown;
        console.log(currentOpenOperationList);
        event.stopPropagation();
    });

    function updateDropdownPosition(openDropdown, dropdown) {
        const offset = openDropdown.offset();
        console.log(offset.left, " ", offset.top);
        dropdown.css({
            left: offset.left + "px",
            top: offset.top + openDropdown.outerHeight() + "px",
            display: "block"
        });
    }

    $(document).on("click", function (event) {
        if (!$(event.target).closest(".openOperationList, #operationList").length) {
            hideDropdown("#operationList");
            currentOpenOperationList = null;
        }
    });

</script>
<script>
    document.querySelectorAll(".db-dropdown-action").forEach(item => {
        item.addEventListener("click", function () {
            if (currentOpenOperationList) {
                let parentContainer = currentOpenOperationList.closest(".detail-list").get(0); // Lấy thẻ cha chứa button
                let columnData = Number(parentContainer.dataset.column);
                console.log("Thẻ cha của button này có ID: " + columnData);
                if (item.id === "operation-deleteList") {
                    deleteList(columnData)
                } else if (item.id === "operation-deleteAllTask") {
                    deleteAllTask(columnData);
                }
            }
        })
    });

    function deleteList(columnData) {
        $.ajax({
            type: "POST",
            url: "/board_home?action=deleteColumn",
            data: {
                columnId: columnData
            },
            dataType: "json",
            success: function (response) {
                let notification;
                if (response === true) {
                    const indexColumn = columns.findIndex(c => c.id === columnData);
                    columns.splice(indexColumn, 1);
                    if (tasks.hasOwnProperty(columnData)) {
                        delete tasks[columnData];
                    }
                    let removeElement = currentOpenOperationList.closest(".container-list");
                    if (removeElement) {
                        removeElement.remove();
                    }
                    hideDropdown();
                    notification = "Xóa cột thành công";
                } else {
                    notification = "Xóa cột thất bại";
                }
                alert(notification)
            },
            error: function (error) {
                console.log("Lỗi AJAX:", error);
            }
        })
    }

    function deleteAllTask(columnData) {
        $.ajax({
            type: "POST",
            url: "board_home?action=deleteAllTaskInColumn",
            data: {
                columnId: columnData
            },
            dataType: "json",
            success: function (message) {
                let notification;
                if (message === true) {
                    if (tasks.hasOwnProperty(columnData)) {
                        delete tasks[columnData];
                        console.log(tasks)
                    }
                    let removeParentElement = currentOpenOperationList.closest(".detail-list");
                    let removeElement = $(removeParentElement).children(".list-task");
                    removeElement.empty();
                    hideDropdown();
                    notification = "Xóa tất cả thẻ trong danh sách thành công";
                } else {
                    notification = "Xóa tất cả thẻ trong danh sách thất bại";
                }
                alert(notification)
            },
            error: function (error) {
                console.log("Loi ajax:", error)
            }
        })
    }
</script>
</body>
</html>