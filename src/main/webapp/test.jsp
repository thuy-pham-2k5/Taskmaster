<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dropdown Menu</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        ul {
            list-style: none;
            background: #3498db;
            padding: 10px;
            width: 200px;
        }

        ul li {
            position: relative;
        }

        ul li a {
            display: block;
            padding: 10px;
            color: white;
            text-decoration: none;
        }

        ul li:hover {
            background: #2980b9;
        }

        /* Dropdown menu */
        ul li ul {
            display: none;
            position: absolute;
            left: 0;
            top: 100%;
            background: #2c3e50;
            width: 200px;
        }

        ul li:hover > ul {
            display: block;
        }

        ul li ul li {
            width: 100%;
        }
    </style>
</head>
<body>
<ul>
    <li><a href="#">Menu 1</a></li>
    <li>
        <a href="#">Menu 2 ▼</a>
        <ul>
            <li><a href="#">Submenu 1</a></li>
            <li><a href="#">Submenu 2</a></li>
            <li><a href="#">Submenu 3</a></li>
        </ul>
    </li>
    <li><a href="#">Menu 3</a></li>
</ul>
</body>
</html>

</body>
</html>
