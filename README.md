## Tạo Package tuân thủ theo

1. Các package chính
   - controller : chứa các servlet
   - database : chứa ConnectDatabase
   - model : nơi viết các Class dùng để tạo đối tượng mô tả dữ liệu
   - service : nơi viết code xử lý logic
   - view : chứa các jstl giao diện dự án
   - css : chứa các Css cho giao diện
   - js : chứa các mã javascript dùng trong giao diện

## Hướng dẫn tạo Environment Variables

Để thiết lập các biến môi trường cho dự án này, vui lòng làm theo các bước sau:

### Windows
1. Vào Edit Configurations
2. Vào phần Startup/Connection
   - Có mục Environment Variables
        - Nhấp vào dấu +
        - Nhập Name là "db_password" và Value là mật khẩu kết nối database của bạn
   - Nhấp Apply và OK
3. Chạy lại dự án
