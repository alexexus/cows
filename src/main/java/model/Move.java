package model;

public class Move {

    private String number;  // строка введённого пользователем числа
    private String bulls;   // строка количества точно угаданных цифр ("быков")
    private String cows;    // строка количества цифр угаданых без учёта позиции ("коров")

    public String getNumber() {
        return number;
    }

    public void setNumber(String number) {
        this.number = number;
    }

    public String getBulls() {
        return bulls;
    }

    public void setBulls(String bulls) {
        this.bulls = bulls;
    }

    public String getCows() {
        return cows;
    }

    public void setCows(String cows) {
        this.cows = cows;
    }
}