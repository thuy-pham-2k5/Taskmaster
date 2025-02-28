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
</body>
</html>
