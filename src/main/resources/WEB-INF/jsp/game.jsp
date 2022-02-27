<%--
  Created by IntelliJ IDEA.
  User: Alexey
  Date: 26.02.2022
  Time: 16:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Logic" %>
<%@ page import="model.Move" %>
<%@ page import="model.Rating" %>
<%@ page import="model.User" %>
<jsp:useBean id="dbBean" scope="application" class="model.Database"/>
<%
    request.setCharacterEncoding("UTF-8");
    // игра из сессии
    Logic game = (Logic) session.getAttribute("game");
    String uname = "Игрок";
    if (game != null) {
        User user = game.getUser();
        if (user != null) {
            uname = user.getUserName();
        }
    }
    // вид из запроса
    String view = (String) request.getAttribute("view");
    String title = "Игра";
    if (view != null) {
        if (view.equals("rating")) {
            title = "Рейтинг";
        } else if (view.equals("rules")) {
            title = "Правила";
        }
    }
%>
<!DOCTYPE html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title><%=title%></title>
    <style>
        <%@include file="/css/styles.css"%>
    </style>
</head>
<body>
<%@ include file="header.jsp" %>
<p align="center">
<form name="game-form" class="game-form" method="POST" action="controller">
    <div class="game-message">
        <b><%=uname%></b>, добро пожаловать в игру!&nbsp;
        <button type="submit" name="action" value="logout" class="btn-link" formnovalidate>Выйти</button>
    </div>
    <br>
    <div class="tab">
        <button type="submit" name="action" value="show-game" class="tablink" formnovalidate>Игра</button>
        <button type="submit" name="action" value="show-rating" class="tablink" formnovalidate>Рейтинг</button>
        <button type="submit" name="action" value="show-rules" class="tablink" formnovalidate>Правила</button>
    </div>
    <%
        if (view == null && game != null) {
            String msg = "Угадайте загаданное компьютером число";
            String btnState = "";
            if (game.isNumberGuessed()) {
                String secret = game.getSecretNumber();
                msg = "Поздравляем, вы угадали число " + secret + "!";
                btnState = "disabled";
            }
    %>
    <div id="game-tab" class="tabcontent">
        <p class="game-message"><%=msg%></p>
        <table class="game-table">
            <tr>
                <td width="305">
                    <table class="game-moves">
                        <caption class="game-label">Предыдущие попытки</caption>
                        <thead>
                        <tr>
                            <th>№</th>
                            <th>Число</th>
                            <th>Быков</th>
                            <th>Коров</th>
                        </tr>
                        </thead>
                        <tbody>
                        <%
                            List<Move> moves = game.getMoves();
                            for (int i = 0; i < moves.size(); i++) {
                                String move = String.valueOf(i + 1);
                                String number = moves.get(i).getNumber();
                                String bulls = moves.get(i).getBulls();
                                String cows = moves.get(i).getCows();
                        %>
                        <tr>
                            <td><%=move%></td>
                            <td><%=number%></td>
                            <td><%=bulls%></td>
                            <td><%=cows%></td>
                        </tr>
                        <%
                            }
                        %>
                        </tbody>
                    </table>
                </td>
                <td width="180">
                    <table class="game-controls">
                        <caption class="game-label">Введите число</caption>
                        <tr>
                            <td colspan="5">
                                <input type="text" id="guess-text" name="guess-text" class="guess-text" maxlength="4"
                                       required onkeydown="keyDown(event)" onkeypress="keyPress(event)">
                            </td>
                        </tr>
                        <tr>
                            <td colspan="5"></td>
                        </tr>
                        <tr>
                            <td><button type="button" class="table-button" onclick="btnClick('0')">0</button></td>
                            <td><button type="button" class="table-button" onclick="btnClick('1')">1</button></td>
                            <td><button type="button" class="table-button" onclick="btnClick('2')">2</button></td>
                            <td><button type="button" class="table-button" onclick="btnClick('3')">3</button></td>
                            <td><button type="button" class="table-button" onclick="btnClick('4')">4</button></td>
                        </tr>
                        <tr>
                            <td><button type="button" class="table-button" onclick="btnClick('5')">5</button></td>
                            <td><button type="button" class="table-button" onclick="btnClick('6')">6</button></td>
                            <td><button type="button" class="table-button" onclick="btnClick('7')">7</button></td>
                            <td><button type="button" class="table-button" onclick="btnClick('8')">8</button></td>
                            <td><button type="button" class="table-button" onclick="btnClick('9')">9</button></td>
                        </tr>
                        <tr>
                            <td colspan="5">&nbsp;</td>
                        </tr>
                        <tr>
                            <td colspan="5">
                                <button type="submit" name="action" value="check-number" class="table-button" <%=btnState%>>Угадать</button>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="5">&nbsp;</td>
                        </tr>
                        <tr>
                            <td colspan="5">
                                <button type="submit" name="action" value="new-game" class="table-button" formnovalidate>Новая игра</button>
                            </td>
                        </tr>
                    </table>
                </td>
            <tr>
        </table>
    </div>
    <%
    } else if (view.equals("rating")) {
    %>
    <div id="rating-tab" class="tabcontent">
        <p class="game-message">Рейтинг игроков на основе среднего количества попыток до угадывания числа</p>
        <table class="game-rating">
            <thead>
            <tr>
                <th width="60">Место</th>
                <th width="165">Игрок</th>
                <th width="100">Количество попыток</th>
                <th width="100">Всего игр сыграно</th>
            </tr>
            </thead>
            <tbody>
            <%
                List<Rating> rating = dbBean.getRating();
                for (int i = 0; i < rating.size(); i++) {
                    String place = String.valueOf(i + 1);
                    String name = rating.get(i).getUserName();
                    String avg = String.format("%.1f", rating.get(i).getAvgAttempts());
                    String cnt = String.valueOf(rating.get(i).getGamesCount());
            %>
            <tr>
                <td width="60"><%=place%></td>
                <td width="165"><%=name%></td>
                <td width="100"><%=avg%></td>
                <td width="100"><%=cnt%></td>
            </tr>
            <%
                }
            %>
            </tbody>
        </table>
    </div>
    <%
    } else if (view.equals("rules")) {
    %>
    <div id="rules-tab" class="tabcontent">
        <div class="form-message">
            В классическом варианте игра рассчитана на двух игроков.
            Каждый из игроков задумывает и записывает тайное 4-значное число с неповторяющимися цифрами.
            Игрок, который начинает игру по жребию, делает первую попытку отгадать число. Попытка — это 4-значное число с неповторяющимися цифрами, сообщаемое противнику.
            Противник сообщает в ответ, сколько цифр угадано без совпадения с их позициями в тайном числе (то есть количество коров) и сколько угадано вплоть до позиции в тайном числе (то есть количество быков).
            Например:
            Задумано тайное число «3219».
            Попытка: «2310».
            Результат: две «коровы» (две цифры: «2» и «3» — угаданы на неверных позициях) и один «бык» (одна цифра «1» угадана вплоть до позиции).
            При игре против компьютера игрок вводит комбинации одну за другой, пока не отгадает всю последовательность.
        </div>
    </div>
    <%
        }
    %>
</form>
</div>
<%@ include file="footer.jsp" %>
<script type="text/javascript">
    <%@include file="/js/scripts.js"%>
</script>
</body>
</html>