<%--
  Created by IntelliJ IDEA.
  User: Alexey
  Date: 26.02.2022
  Time: 16:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page isErrorPage="true" contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Страница не найдена</title>
    <style>
        <%@include file="/css/styles.css"%>
    </style>
</head>
<body>
<%@ include file="header.jsp" %>
<div align="center">
    <form name="error-form" class="error-form" method="POST" action="controller">
        <div class="form-message">
            <b>Запрошенная страница не найдена</b>
        </div>
        <br>
        <button type="submit" name="action" value="show-index" class="btn-link-ind">На главную</button>
    </form>
</div>
<%@ include file="footer.jsp" %>
</body>
</html>

