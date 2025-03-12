<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý công việc</title>
    <link rel="stylesheet" href="style.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #e3f2fd;
            margin: 0;
            padding: 20px;
        }

        .main-content {
            background-color: #b3e5fc;
            padding: 20px;
            border-radius: 10px;
            max-width: 800px;
            margin: auto;
        }

        .workspace-header {
            display: flex;
            align-items: center;
            background-color: #29b6f6;
            padding: 15px;
            border-radius: 10px;
            color: white;
        }

        .workspace-header img {
            border-radius: 50%;
            width: 50px;
            height: 50px;
            margin-right: 15px;
        }

        .workspace-info h2 {
            margin: 0;
        }

        .workspace-info p {
            margin: 5px 0;
            font-size: 14px;
        }

        .workspace-info a {
            color: white;
            text-decoration: underline;
        }

        .settings {
            margin-top: 20px;
        }

        .setting-item {
            background-color: white;
            padding: 15px;
            margin-bottom: 15px;
            border-radius: 8px;
            box-shadow: 2px 2px 10px rgba(0, 0, 0, 0.1);
        }

        .setting-item h4 {
            margin: 0 0 10px;
        }

        .setting-item p {
            font-size: 14px;
            margin: 5px 0;
        }

        .btn {
            background-color: #0288d1;
            color: white;
            border: none;
            padding: 8px 12px;
            border-radius: 5px;
            cursor: pointer;
        }

        .btn:hover {
            background-color: #01579b;
        }

    </style>
</head>
<body>
<div class="main-content">
    <div class="workspace-header">
        <img src="https://via.placeholder.com/50" alt="Logo">
        <div class="workspace-info">
            <h2>Quản lý công việc Taskmaster</h2>
            <p>🔒 Riêng tư • <a href="#">Google Drive</a></p>
            <p>Dự án Quản lý công việc Taskmaster nổi bật với khả năng kéo thả các thẻ công việc.</p>
        </div>
    </div>

    <div class="settings">
        <h3>Các cài đặt Không gian làm việc</h3>

        <div class="setting-item">
            <h4>Khả năng hiển thị trong Không gian làm việc</h4>
            <p>🔒 Riêng tư - Đây là Không gian làm việc riêng tư. Chỉ những người trong Không gian làm việc có thể truy cập.</p>
            <button class="btn">Thay đổi</button>
        </div>

        <div class="setting-item">
            <h4>Chính sách hạn chế tạo bảng</h4>
            <p>Bất kỳ thành viên nào cũng có thể tạo 📋 bảng thông tin công khai.</p>
            <p>Bất kỳ thành viên nào cũng có thể tạo 📋 bảng thông tin hiển thị.</p>
            <p>Bất kỳ thành viên nào cũng có thể tạo 📋 bảng thông tin riêng tư.</p>
            <button class="btn">Thay đổi</button>
        </div>

        <div class="setting-item">
            <h4>Chính sách hạn chế xóa bảng</h4>
            <p>Bất kỳ thành viên nào cũng có thể xóa 🗑️ bảng công khai.</p>
            <p>Bất kỳ thành viên nào cũng có thể xóa 🗑️ bảng hiển thị.</p>
            <p>Bất kỳ thành viên nào cũng có thể xóa 🗑️ bảng riêng tư.</p>
            <button class="btn">Thay đổi</button>
        </div>

        <div class="setting-item">
            <h4>Chia sẻ các bảng với khách</h4>
            <p>Bất kỳ ai cũng có thể gửi hoặc nhận lời mời tham gia các bảng trong Không gian làm việc.</p>
            <button class="btn">Thay đổi</button>
        </div>
    </div>
</div>

<div>
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
                    <div id="openAddTask_${column.columnId}" class="btn_add_task" onclick="showAndClosed('openAddTask_${column.columnId}', 'inputAddTask_${column.columnId}')">
                        <button>
                            <img src="/images/add.png"/>
                            Thêm thẻ
                        </button>
                    </div>
                    <div id="inputAddTask_${column.columnId}" class="input_add_task">
                        <div class="enter_add_task">
                            <div class="input_add_list">
                                <input type="text" name="inputName" placeholder="Nhập tên danh sách...">
                            </div>
                            <div class="action_add_list">
                                <button id="addNewTask">Thêm thẻ</button>
                                <img src="/images/black_closed.png" alt="closed.png" onclick="showAndClosed('inputAddTask_${column.columnId}', 'openAddTask_${column.columnId}')">
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </c:forEach>
</div>
</body>
</html>

<script>
    const listsContainer = document.querySelector('.lists');

    // Hàm cập nhật một cột duy nhất thay vì render lại toàn bộ
    function updateColumnUI(column) {
        const existingColumn = document.querySelector(`[data-column-id="${column.columnId}"]`);
        if (existingColumn) {
            existingColumn.querySelector('.title-list h2').textContent = column.name;
        } else {
            listsContainer.insertAdjacentHTML('beforeend', repeatColumnAndTask(column, ''));
        }
    }

    // Hàm cập nhật một task duy nhất
    function updateTaskUI(task) {
        const columnContainer = document.querySelector(`[data-column-id="${task.columnId}"] .list-task`);
        if (columnContainer) {
            const existingTask = columnContainer.querySelector(`[data-task-id="${task.taskId}"]`);
            if (existingTask) {
                existingTask.textContent = task.title;
            } else {
                columnContainer.insertAdjacentHTML('beforeend', `<li class="task" data-task-id="${task.taskId}">${task.title}</li>`);
            }
        }
    }

    // Tạo Proxy theo dõi columns
    const columns = new Proxy([], {
        set(target, property, value) {
            target[property] = value;
            console.log("Columns updated:", target);
            if (!isNaN(property)) {
                updateColumnUI(value);
            }
            return true;
        },
        deleteProperty(target, property) {
            const columnId = target[property].columnId;
            const columnElement = document.querySelector(`[data-column-id="${columnId}"]`);
            if (columnElement) columnElement.remove();
            delete target[property];
            console.log("Column deleted:", target);
            return true;
        }
    });

    // Tạo Proxy theo dõi tasks
    const tasks = new Proxy({}, {
        set(target, columnId, taskList) {
            target[columnId] = taskList;
            console.log("Tasks updated:", target);
            document.querySelector(`[data-column-id="${columnId}"] .list-task`).innerHTML =
                taskList.map(task => `<li class="task" data-task-id="${task.taskId}">${task.title}</li>`).join('');
            return true;
        },
        deleteProperty(target, columnId) {
            delete target[columnId];
            console.log("Tasks deleted:", target);
            const columnContainer = document.querySelector(`[data-column-id="${columnId}"] .list-task`);
            if (columnContainer) columnContainer.innerHTML = '';
            return true;
        }
    });

    // Hàm tạo HTML cho cột
    function repeatColumnAndTask(column, tasksHtml) {
        return `<div class="container-list" data-column-id="${column.columnId}">
                <div class="detail-list">
                    <div class="title-list">
                        <h2>${column.name}</h2>
                    </div>
                    <ol class="list-task">${tasksHtml}</ol>
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
            </div>`;
    }

    // Thêm cột mới (tự động cập nhật UI)
    function addNewColumn(newColumn) {
        columns.push(newColumn);
    }

    // Thêm task mới vào cột (tự động cập nhật UI)
    function addNewTask(newTask) {
        if (!tasks[newTask.columnId]) {
            tasks[newTask.columnId] = [];
        }
        tasks[newTask.columnId].push(newTask);
    }

    // Xóa cột
    function deleteColumn(columnId) {
        const index = columns.findIndex(c => c.columnId === columnId);
        if (index !== -1) {
            delete columns[index];
        }
    }

    // Xóa task
    function deleteTask(taskId, columnId) {
        if (tasks[columnId]) {
            tasks[columnId] = tasks[columnId].filter(task => task.taskId !== taskId);
        }
    }

    // Khi DOM load xong, hiển thị dữ liệu ban đầu
    document.addEventListener('DOMContentLoaded', () => {
        columns.forEach(column => updateColumnUI(column));
    });
</script>
