<%--
  Created by IntelliJ IDEA.
  User: ASUS
  Date: 2/20/2025
  Time: 1:20 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<div id="overlay" class="overlay">
    <div class="modal">
        <span id="closeModalBtn" class="close">&times;</span>
        <h2>Invite New Member</h2>
        <form action="submit_invitation.jsp" method="post">
            <label for="email">Email:</label>
            <input type="email" id="email" name="email" required>
            <br>
            <button type="submit">Send Invitation</button>
        </form>
    </div>
</div>
</body>
</html>
