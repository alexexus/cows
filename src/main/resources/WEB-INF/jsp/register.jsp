<%--
  Created by IntelliJ IDEA.
  User: Alexey
  Date: 26.02.2022
  Time: 16:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Регистрация</title>
    <style>
        <%@include file="/css/styles.css"%>
    </style>
</head>
<body>
<%@ include file="header.jsp" %>
<div align="center">
    <form name="register-form" class="register-form" method="POST" action="controller">
        <label for="firstname" class="label-ed">Имя</label>
        <input type="text" id="firstname" name="firstname" maxlength="32" required>
        <br>
        <label for="lastname" class="label-ed">Фамилия</label>
        <input type="text" id="lastname" name="lastname" maxlength="32" required>
        <br>
        <label for="username" class="label-ed">Логин</label>
        <input type="text" id="username" name="username" maxlength="32" required>
        <br>
        <label for="password" class="label-ed">Пароль</label>
        <input type="password" id="password" name="password" maxlength="32" required>
        <div class="error-message">
            <%
                String msg = (String) request.getAttribute("registerMessage");
                if (msg == null || msg.trim().isEmpty()) msg = "<br>";
            %>
            <%= msg %>
        </div>
        <button type="submit" name="action" value="register" class="btn">Зарегистрироваться</button>
        <br>
        <button type="submit" name="action" value="show-login" class="btn-link" formnovalidate>Войти</button>
        <br>
    </form>
</div>
<%@ include file="footer.jsp" %>
</body>
</html>