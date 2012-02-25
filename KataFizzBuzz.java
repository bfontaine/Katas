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
        return "";
    }

    public static void stage1() {
        for (int i=0; i<=100; i++) {
            System.out.println(fizzBuzz1(i));
        }
    }

    public static void stage2() {
    }
}
