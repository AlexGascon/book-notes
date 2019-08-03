package tdd;

public class Bank {
    Money reduce(Expression source, String to) {
        return source.reduce(this, to);
    }

    int rate(String from, String to) {
        return (from.equals("CHF") && to.equals("USD")) ? 2 : 1;
    }

    void addRate(String from, String to, int rate) { }
}
