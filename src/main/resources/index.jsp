<%--
  Created by IntelliJ IDEA.
  User: Alexey
  Date: 26.02.2022
  Time: 16:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<!DOCTYPE html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Главная</title>
    <style>
        <%@include file="/css/styles.css"%>
    </style>
</head>
<body>
<%@ include file="/WEB-INF/jsp/header.jsp" %>
<div align="center">
    <form name="index-form" class="index-form" method="POST" action="controller">
        <div class="form-message">
            <b>Добро пожаловать в игру «Быки и коровы»!</b>
            <p>
                Для начала игры войдите в свой профиль или зарегистрируйтесь в системе. Тестовая учетная запись: (Имя пользователя - user, пароль - user)
            </p>
        </div>
        <button type="submit" name="action" value="show-login" class="btn-link-ind">Вход</button>
        <br>
        <br>
        <button type="submit" name="action" value="show-register" class="btn-link-ind">Регистрация</button>
    </form>
</div>
<%@ include file="/WEB-INF/jsp/footer.jsp" %>
</body>
</html>
