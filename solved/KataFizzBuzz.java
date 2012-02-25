public class KataFizzBuzz {

    public static String fizzBuzz1(int i) {
        if (i%15 == 0) {
            return "FizzBuzz";
        }
        if (i%3 == 0) {
            return "Fizz";
        }
        if (i%5 == 0) {
            return "Buzz";
        }
        return ""+i;
    }

    public static String fizzBuzz2(int i) {
        String s = "";

        if ((i/10 == 3) || (i%10 == 3) || (i%3 == 0)) {
            s = "Fizz";
        }
        if ((i/10 == 5) || (i%10 == 5) || (i%5 == 0)) {
            s+= "Buzz";
        }

        if (!s.equals("")) {
            return s;
        }
        return ""+i;
    }

    public static void stage1() {
        for (int i=1; i<=100; i++) {
            System.out.println(fizzBuzz1(i));
        }
    }

    public static void stage2() {
        for (int i=1; i<=100; i++) {
            System.out.println(fizzBuzz2(i));
        }
    }

    public static void main(String[] args) {
        stage2();
    }
}
