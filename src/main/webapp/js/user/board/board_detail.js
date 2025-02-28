$(document).on("change", "#mySelect", function() {
    console.log("Changed to: " + $(this).val());
    const selectedValue = $(this).val();
    $.get(`/group_home?action=sortType&option=` + selectedValue, function(responseJson) {
        const $listBoards = $("#listBoards");
        $listBoards.empty();
        $.each(responseJson, function(index, board) {
            $("<div>").addClass("workspaceTable")
                .append($("<label>").addClass("titleBoard").text(board.title))
                .appendTo($listBoards);
        });
    });
});