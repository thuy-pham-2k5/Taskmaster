<%--
  Created by IntelliJ IDEA.
  User: ASUS
  Date: 2/20/2025
  Time: 1:20 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<style>

</style>

<div id="overlay" class="overlay" style="background: gray; padding: 20px; border-radius: 10px; box-shadow: 0 0 10px rgba(0, 0, 0, 0.5)">
    <div class="modal">
        <span id="closeModalBtn" class="close">&times;</span>
        <h2>Invite New Member</h2>
        <form action="/group" method="post">
            <label for="email">Email:</label>
            <input type="email" id="email" name="email" required>
            <br>
            <button type="submit">Send Invitation</button>
        </form>
    </div>
</div>

