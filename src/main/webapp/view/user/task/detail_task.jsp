<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Task Manager</title>
    <!-- Import Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        body{
            background-color: blue;
        }
        #taskModal {
            display: none; /* Ẩn mặc định */
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%); /* Căn giữa modal */
            height: auto;
            width: 800px;
            background: #355d83;
            border-radius: 8px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            padding: 20px;
            z-index: 1001;
        }



        /* Header Task */
        #header_task {
            display: flex;
            align-items: center; /* Căn giữa theo chiều dọc */
            justify-content: space-between; /* Đưa dấu "x" sang bên phải */
            border-radius: 5px;
            position: relative;
            flex-direction: column;
            gap: 5px;
            padding-bottom: 10px;
            border-bottom: 1px solid #ddd;

        }

        #header_task input {
            color: white;
            padding: 0px 10px;
            height: 40px;
            font-size: 23px;
            font-weight: bold;
            width: 100%;
            border: none;
            background: transparent;
        }

        #header_task:focus-within input {
            border: 2px solid white; /* Màu viền khi bấm vào nút */
            border-radius: 5px;
            outline: none;
        }


        #header_task p {
            margin: 5px 0px 0px 12px;
            font-size: 14px;
            color: white;
        }

        .status {
            font-weight: bold;
            color: #1effde;
        }

        /* Content Task */
        #content_task {
            display: flex;
            flex-direction: column;
            gap: 15px;
            margin-top: 15px;
        }

        /* Navigation Task */
        #navigation_task {
            flex: 3;
        }



        #expire_task{
            display: flex;
            justify-content: space-between;
        }


        #navigation_task section {
            margin-bottom: 10px;
        }

        #navigation_task p {
            color: white;
            font-weight: bold;
            margin-bottom: 5px;
        }

        .member-icons, .labels span, .works_together {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .comment_task .icon {
            width: 34px;
            height: 30px;
            display: flex;
            align-items: center;
            justify-content: center;
            background: #0079bf;
            color: white;
            border-radius: 50%;
            font-weight: bold;
        }

        .member-icons .icon {
            width: 33px;
            height: 30px;
            display: flex;
            align-items: center;
            justify-content: center;
            background: #0079bf;
            color: white;
            border-radius: 50%;
            font-weight: bold;
        }

        .member-icons button{
            font-size: 18px;
            height: 30px;
            width: 30px;
            border: none;
            background: #ddd;
            cursor: pointer;
            border-radius: 5px;
        }

        .works_together button{
            font-size: 18px;
            height: 30px;
            width: 30px;
            border: none;
            background: #ddd;
            cursor: pointer;
            border-radius: 5px;
        }

        #description_display {
            background-color: #314d67eb;
            color: #e3ded4;
            outline: none;
            font-size: 15px;
            min-height: 82px;
            padding: 8px;
            border: 1px solid darkgray;
            border-radius: 4px;
            resize: none;
        }

        #description_textarea{
            background-color: #fafafa;
            font-family: Arial, sans-serif;
            outline: none;
            font-size: 15px;
            width: 100%;
            min-height: 150px;
            padding: 8px;
            border: 1px solid #0de3cb;
            border-radius: 3px;
            resize: none;
        }

        /* Tools Task */
        #tools_task {
            flex: 1;
            margin: 22px 0px 0px 20px;
            display: flex;
            flex-direction: column;
            align-items: center;
            border-radius: 5px;
        }
        #tools_task button {
            padding-left: 25px;
            width: 100%;
            height: 35px;
            margin-bottom: 15px;
            background: #0079bf;
            color: white;
            font-weight: bold;
            border: none;
            display: flex;
            align-items: center;
            gap: 10px;
            cursor: pointer;
            border-radius: 5px;
        }

        #tools_task button:hover {
            background: #005f8a;
        }

        /* Đưa navigation_task và tools_task trên cùng một hàng */
        #content_task {
            display: flex;
            flex-direction: row;
            gap: 10px;
        }

        .due-date span{
            color: white;
            justify-content: center;
            text-align: center;
            align-items: center;
            display: flex;
            border-radius: 4px;
            align-content: center;
            background-color: #A2A2A2;
            width: 105px;
            height: 30px;
        }

        .works_together span{
            color: white;
            justify-content: center;
            display: flex;
            border-radius: 4px;
            background-color: #138254;
            width: 134px;
            height: 30px;
        }


        #tools_task button i {
            color: white; /* Đảm bảo icon màu trắng */
        }


        .comment_task {
            margin-top: 30px;
            display: flex;
        }


        .comment_task input{
            color: white;
            background-color: #314d67eb;
            margin-left: 5px;
            border: 1px solid darkgray;
            padding-left: 10px;
            height: 30px;
            border-radius: 4px;
            width: 100%;
            outline: none;
        }

        .description_task {
            margin-top: 55px;
        }


        .hidden{
            display: none;
        }

        .buttons_description{
            margin-top: 10px;
        }

        .save_description_button{
            cursor: pointer;
            border-radius: 3px;
            border: none;
            outline: none;
            background-color: #1cb2e3;
            height: 28px;
            width: 70px;
            color: white;
        }

        .cancel_description_button{
            cursor: pointer;
            border-radius: 3px;
            border: none;
            outline: none;
            background-color: #a6a4a4;
            height: 28px;
            width: 70px;
            color: white;
        }


        .save_description_button,
        .cancel_description_button {
            border: none;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .save_description_button:hover::before {
            content: "\f0c7"; /* FontAwesome icon for save */
            font-family: "Font Awesome 6 Free";
            font-weight: 900;
        }

        .cancel_description_button:hover::before {
            content: "\f2ed"; /* FontAwesome icon for trash */
            font-family: "Font Awesome 6 Free";
            font-weight: 900;
        }

        .save_description_button:hover{
            color: white;
            background: #007bff;
            margin-left: 3px;
        }

        .cancel_description_button:hover{
            color: white;
            background: #d71010;
        }

        .comment_task {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .comment_task i {
            color: #c0c5cc;
            font-weight: bold;


        }

        .comment_input_container {
            position: relative;
            width: 100%;
            display: flex;
            align-items: center;
        }


        .comment_input_container input:focus {
            border-color: #007bff;
        }

        .send_comment_button {
            position: absolute;
            right: 3px;
            background: none;
            border: none;
            cursor: pointer;
            color: #007bff;
            font-size: 18px;
            transition: color 0.3s ease;
        }
    </style>
</head>
<body>

<!-- Button trigger modal -->
<p   onclick="openTaskModal({ title: 'Tiêu đề Task', status: 'To Do', description: 'Mô tả task', dueDate: '2025-03-15' })">
    Launch Task Modal
</p>

<!-- Task Modal -->
<div id="taskModal">
    <div class="modal-content" >
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
                <section style="background-color: #0079bf; width: 100%; height: 30px; border-radius: 5px;" class="date-picker-section">
                    <button id="open_calendar"><i class="fas fa-calendar-alt"></i> Ngày</button>
                    <input type="date" id="date_picker">
                </section>
            </div>
        </div>
    </div>
</div>

<script>
    function openTaskModal(task) {
        document.getElementById("modalTaskTitle").value = task.title;
        document.querySelector(".status").textContent = task.status || "To Do";
        document.getElementById("description_display").textContent = task.description || "Thêm mô tả chi tiết...";
        document.getElementById("selected_date").textContent = task.dueDate || "Chưa có ngày hết hạn";

        document.getElementById("taskModal").style.display = "flex"; // Hiển thị modal với flexbox để căn giữa
    }

    // Đóng modal
    function closeTaskModal() {
        document.getElementById("taskModal").style.display = "none";
    }


    // // Hiển thị phần chỉnh sửa mô tả
    // function editDescription() {
    //     document.getElementById("description_display").classList.add("hidden");
    //     document.getElementById("description_edit").classList.remove("hidden");
    // }
    //
    // // Lưu mô tả
    // function saveDescription() {
    //     let descText = document.getElementById("description_textarea").value;
    //     document.getElementById("description_display").textContent = descText || "Thêm mô tả chi tiết...";
    //     document.getElementById("description_display").classList.remove("hidden");
    //     document.getElementById("description_edit").classList.add("hidden");
    // }
    //
    // // Hủy chỉnh sửa mô tả
    // function cancelDescription() {
    //     document.getElementById("description_display").classList.remove("hidden");
    //     document.getElementById("description_edit").classList.add("hidden");
    // }
</script>

</body>
</html>
