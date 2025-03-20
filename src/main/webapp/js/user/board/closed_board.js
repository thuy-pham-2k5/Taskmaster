$('#openModalButton').click(function () {
    getClosedBoards(function (closedBoards) {
        let contentDiv = document.createElement("div");

        if (closedBoards.length > 0) {
            closedBoards.forEach(board => {
                contentDiv.appendChild(createClosedBoard(board));
            });
        } else {
            let noDataDiv = document.createElement("div");
            noDataDiv.className = "closed-board-no-data";
            noDataDiv.textContent = "Không có bảng nào đã đóng";
            contentDiv.appendChild(noDataDiv);
        }

        showClosedBoard(contentDiv);
    });
});

function getClosedBoards(callback) {
    $.ajax({
        type: "GET",
        url: "/group_home?action=getClosedBoards",
        dataType: "json",
        success: function (response) {
            callback(response); // Chỉ gọi callback khi dữ liệu đã có
        },
        error: function (xhr, status, error) {
            console.error("Lỗi khi lấy danh sách bảng đã đóng:", error);
        }
    });
}

function createClosedBoard(board) {
    let parentDiv = document.createElement("div");
    parentDiv.className = "closed-board-container";
    parentDiv.dataset.board = board.boardId;
    parentDiv.innerHTML = `
                  <div class="closed-board-info">
                      <img src="" alt="error.png" class="image-closed-board"/>
                      <div>
                          <div class="closed-board-title">
                                <a class="closed-board-title-link"></a>
                          </div>
                          <div class="closed-board-group-title"></div>
                      </div>
                  </div>
                  <div class="closed-board-action">
                      <button class="open-closed-board">Mở lại</button>
                      <button class="delete-closed-board">Xóa</button>
                  </div>
            `;
    parentDiv.querySelector(".image-closed-board").src = board.backgroundLink || "error.png";
    parentDiv.querySelector(".closed-board-group-title").textContent = board.groupName || "";
    parentDiv.querySelector(".closed-board-title-link").href = "/group_home?action=boardView&&boardId=" + board.boardId;
    parentDiv.querySelector(".closed-board-title-link").textContent = board.title || "";
    return parentDiv;
}

function showClosedBoard(contentDiv) {
    let content = $(contentDiv).html().trim();
    if (!content) {
        content = '<div class="no-closed-board">Chưa có bảng nào được đóng.</div>';
    }
    Swal.fire({
        title: 'Các bảng đã đóng',
        html: content,
        showCloseButton: true,
        showConfirmButton: false,
        showClass: {
            popup: ""
        },
        didOpen: () => {
            $('.open-closed-board').on("click", function () {
                let parentDiv = $(this).closest(".closed-board-container");
                let boardId = parentDiv.data("board");
                console.log(boardId);
                Swal.fire({
                    title: "Xác nhận",
                    text: "Bạn có chắc chắn muốn mở lại bảng?",
                    icon: "question"
                })
                    .then((result) => {
                        if (result.isConfirmed) {
                            actionClosedBoard(boardId, "open");
                        }
                    })
            })
            $('.delete-closed-board').on("click", function () {
                let parentDiv = $(this).closest(".closed-board-container");
                let boardId = parentDiv.data("board");
                console.log(boardId);
                Swal.fire({
                    title: "Bạn chắc chắn xóa bảng?",
                    text: "Tất cả danh sách, thẻ và hành động sẽ bị xóa và không thể mở lại bảng.",
                    icon: "question"
                })
                    .then((result) => {
                        if (result.isConfirmed) {
                            actionClosedBoard(boardId, "delete");
                        }
                    })
            })
        }
    });
}

function actionClosedBoard(boardId, typeAction) {
    let url = typeAction === "open" ? "/board?action=openBoard" : "/board?action=deleteBoard";
    let text = typeAction === "open" ? "Đã mở lại bảng" : "Đã xóa bảng";
    console.log(url)
    $.ajax({
        type: "POST",
        url: url,
        data: {boardId: boardId},
        success: function (response, status, xhr) {
            if (xhr.status === 200) {
                console.log("Thành công xóa/mở");
                alertShowSuccess("Thành công!", text);
            }
        },
        error: function () {
            console.log("Lỗi khi xóa / mở bảng!");
        }
    })
}