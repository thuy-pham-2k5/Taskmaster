<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Chi tiết bảng</title>
    <link rel="stylesheet" href="/css/user/board/detail_board.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">

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
                                        <li class="task">
                                            <button class="open-modal">
                                                    ${task.title}
                                            </button>
                                        </li>

                                    </c:forEach>
                                </c:if>
                            </c:forEach>
                        </ol>
                        <div class="add_task">
                            <div class="btn_add_task">
                                <button >
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


    <!-- Modal hiển thị chi tiết task -->
    <div id="taskModal" class="modal">
        <div class="modal-content">
                <div id="header_task">
                    <div id="title_task_info">
                        <input id="modalTaskTitle" type="text" name="title_task" value="Tiêu đề Task"/>
                        <p>trong danh sách <span class="status">To Do</span></p>
                    </div>
                    <div id="block">
                        <span class="close">&times;</span>
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
                                    <button class="cancel_description_button" onclick="cancelDescription()">Hủy
                                    </button>
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
                        <section style="background-color: #0079bf ; width: 100%; height: 30px; border-radius: 5px;"
                                 class="date-picker-section">
                            <button id="open_calendar"><i class="fas fa-calendar-alt"></i> Ngày</button>
                            <input type="date" id="date_picker">
                        </section>
                    </div>
                </div>
        </div>
    </div>
</main>
</body>
</html>

<script>

    document.addEventListener("DOMContentLoaded", function() {
        // Lấy modal và các thành phần trong modal
        var modal = document.getElementById("taskModal");
        var modalTitle = document.getElementById("modalTaskTitle");
        var closeButton = document.querySelector(".close");

        // Lấy tất cả các button trong danh sách task
        var taskButtons = document.querySelectorAll(".open-modal");

        // Thêm sự kiện click cho từng button
        taskButtons.forEach(function(button) {
            button.addEventListener("click", function() {
                var taskTitle = this.getAttribute("data-task-title");
                modalTitle.innerText = taskTitle; // Cập nhật tiêu đề modal
                modal.style.display = "flex"; // Hiển thị modal
            });
        });

        // Khi nhấn vào nút đóng modal
        closeButton.addEventListener("click", function() {
            modal.style.display = "none";
        });

        // Khi nhấn ra ngoài modal thì đóng modal
        window.addEventListener("click", function(event) {
            if (event.target === modal) {
                modal.style.display = "none";
            }
        });
    });




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




    window.onload = function() {
        document.getElementById("description_display").addEventListener("click", editDescription);
        document.querySelector(".save_description_button").addEventListener("click", saveDescription);
        document.querySelector(".cancel_description_button").addEventListener("click", cancelDescription);
    };

    function editDescription() {
        document.getElementById("description_display").classList.add("hidden");
        document.getElementById("description_edit").classList.remove("hidden");
        document.getElementById("description_textarea").focus();
    }

    function saveDescription() {
        let textarea = document.getElementById("description_textarea");
        let newText = textarea.value.trim();
        let displayDiv = document.getElementById("description_display");

        // Nếu trống, giữ lại nội dung cũ
        displayDiv.innerHTML = newText ? newText.replace(/\n/g, "<br>") : "Thêm mô tả chi tiết...";

        cancelDescription();
    }

    function cancelDescription() {
        document.getElementById("description_display").classList.remove("hidden");
        document.getElementById("description_edit").classList.add("hidden");
    }

</script>

