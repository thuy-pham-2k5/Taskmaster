$(document).on("change", "#mySelect", function() {
    console.log("Changed to: " + $(this).val());
    const selectedValue = $(this).val();
    $.get(`/group_home?action=sortType&option=` + selectedValue, function(responseJson) {
        const listBoards = $("#listBoards");
        listBoards.empty();
        $.each(responseJson, function(index, board) {
            createListBoard(board);
        });
    });
});

// ✅ Lưu danh sách sản phẩm vào JavaScript

function filterBoards() {
    let input = document.getElementById("keyword").value.toLowerCase();
    let listBoards = document.getElementById("listBoards");
    listBoards.innerHTML = "";

    // ✅ Lọc danh sách sản phẩm theo tên
    let filteredBoards = boards.filter(board => board.title.toLowerCase().includes(input));

    // ✅ Tạo danh sách mới và thêm vào MODAL
    filteredBoards.forEach(board => {
        createListBoard(board);
    });
}

function createListBoard (board) {
    let boardDiv = document.createElement("div");
    boardDiv.className = "workspaceTable";
    boardDiv.style.backgroundImage = "url('" + board.backgroundLink + "')"

    let a = document.createElement("a");
    a.className = "workspaceTableLink";
    a.href = "/group_home?action=boardView&boardId=" + board.boardId;

    let button = document.createElement("button");
    button.className = "titleBoardWorkspace";
    button.textContent = board.title;

    a.appendChild(button);
    boardDiv.appendChild(a);
    listBoards.appendChild(boardDiv);
}
