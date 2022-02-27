package model;

public class Rating {

    private String userName;    // имя пользователя
    private double avgAttempts; // среднее количество попыток до угадывания числа
    private int gamesCount;     // количество сыгранных пользователем игр

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public double getAvgAttempts() {
        return avgAttempts;
    }

    public void setAvgAttempts(double avgAttempts) {
        this.avgAttempts = avgAttempts;
    }

    public int getGamesCount() {
        return gamesCount;
    }

    public void setGamesCount(int gamesCount) {
        this.gamesCount = gamesCount;
    }
}