package model;

import java.util.ArrayList;
import java.util.List;
import java.util.Random;

public class Logic {

    private User user;              // пользователь игры
    private String secret;          // строка загаданного числа
    private boolean guessed;        // признак того, что число угадано
    private List<Move> moves;       // список ходов игры

    public Logic() {
        startNew();
    }

    public void startNew() {
        guessed = false;
        moves = new ArrayList<Move>();
        Random random = new Random();
        int rnd;
        while (!isNumberMatch(rnd = random.nextInt(9900) + 100));
        secret = String.format("%04d", rnd);
    }

    public boolean isNumberMatch(int num) {
        String str = String.format("%04d", num);
        // если строка - только четыре неповторяющиеся цифры
        if (str.length() == 4 && str.matches("(?!.*(.).*\\1)\\d{4}")) {
            return true;
        }
        return false;
    }

    public int checkGuess(String guess) {
        int bulls = 0;
        int cows = 0;
        if (guess.length() == 4 &&
                guess.matches("(?!.*(.).*\\1)\\d{4}")) {
            for (int i = 0; i < 4; i++) {
                if (guess.charAt(i) == secret.charAt(i)) {
                    bulls++;
                } else if (secret.contains(String.valueOf(guess.charAt(i)))) {
                    cows++;
                }
            }
            if (bulls == 4) {
                guessed = true;
            }
            // Добавление хода игры в список ходов
            // для вывода последовательности на страницу
            Move move = new Move();
            move.setNumber(guess);
            move.setBulls(String.valueOf(bulls));
            move.setCows(String.valueOf(cows));
            moves.add(move);
        }
        return bulls;
    }

    public String getSecretNumber() {
        return secret;
    }

    public void setSecretNumber(String secret) {
        this.secret = secret;
    }

    public boolean isNumberGuessed() {
        return guessed;
    }

    public List<Move> getMoves() {
        return moves;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }
}
