<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý Công Việc</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: Arial, sans-serif;
            display: flex;
            flex-direction: column;
            height: 100vh;
        }

        #header {
            width: 100%;
            height: 75px;
            background-color: #3FB5CC;
            display: flex;
            align-items: center;
        }

        .container {
            display: flex;
            flex: 1;
            flex-direction: row;
            width: 100%;
        }

        #homeRight {
            width: 20%;
            min-width: 250px;
            background-color: #93CDD8;
            height: 100%;
        }

        #homeLeft {
            flex: 1;
            width: 75%;
            background-color: #3179BA;
            height: 100%;
        }

        #headerLeft {
            width: 35%;
        }

        #headerRight {
            width: 65%;
        }

    </style>
</head>
<body>
<div id="header">
    <div id="headerLeft"></div>
    <div id="headerRight"></div>
</div>
<div class="container">
    <div id="homeRight"></div>
    <div id="homeLeft"></div>
</div>
</body>
</html>
