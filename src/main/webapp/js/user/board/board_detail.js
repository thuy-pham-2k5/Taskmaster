/*modal*/
$(document).ready(function () {
    // Khi click vào dấu 3 chấm
    $('.openModal').click(function (event) {
        event.preventDefault(); // Ngăn chặn load lại trang

        var boardId = $(this).data('boardid'); // Lấy ID của board

        $.sweetModal.confirm(
            'Xác nhận thao tác',
            'Bạn có chắc chắn muốn thao tác trên bảng #' + boardId + ' không?',
            function () {
                $.sweetModal('Bạn đã xác nhận thao tác!');
            },
            function () {
                $.sweetModal('Bạn đã hủy thao tác.');
            }
        );
    });
});