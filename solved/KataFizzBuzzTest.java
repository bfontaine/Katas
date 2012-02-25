import org.junit.Test;
import static org.junit.Assert.assertEquals;

public class KataFizzBuzzTest {
    @Test
    public void stage1Test() {
        for (int i=0;i<=100;i++) {
            if ((i%3 == 0) && (i%5 == 0)) {
                assertEquals("FizzBuzz", KataFizzBuzz.fizzBuzz1(i));
            } else if ((i%3 == 0)) {
                assertEquals("Fizz", KataFizzBuzz.fizzBuzz1(i));
            } else if ((i%5 == 0)) {
                assertEquals("Buzz", KataFizzBuzz.fizzBuzz1(i));
            } else {
                assertEquals(""+i, KataFizzBuzz.fizzBuzz1(i));
            }
        }
    }

    @Test
    public void stage2Test() {
        // Fizz
        for (int i=30;i<40;i++) { // 30,31,…,39
            if (i%5 == 0) {
                assertEquals("FizzBuzz", KataFizzBuzz.fizzBuzz2(i));
            } else {
                assertEquals("Fizz", KataFizzBuzz.fizzBuzz2(i));
            }
        }
        for (int i=3; i<=100; i+=10) { // 3,13,…,93
            if (i == 53) {
                assertEquals("FizzBuzz", KataFizzBuzz.fizzBuzz2(i));
            } else {
                assertEquals("Fizz", KataFizzBuzz.fizzBuzz2(i));
            }
        }

        // Both
        for (int i=0;i<=100;i++) {
            if ((i%3 == 0) && (i%5 == 0)) { // 15,30,…,90
                assertEquals("FizzBuzz", KataFizzBuzz.fizzBuzz1(i));
            } else if ((i%3 == 0)) { // 3,6,9,…,99
                assertEquals("Fizz", KataFizzBuzz.fizzBuzz1(i));
            } else if ((i%5 == 0)) { // 5,10,…,100
                assertEquals("Buzz", KataFizzBuzz.fizzBuzz1(i));
            } else { // 1,2,4,7,8,…98
                assertEquals(""+i, KataFizzBuzz.fizzBuzz1(i));
            }
        }

        // Buzz
        for (int i=50;i<60;i++) { // 50,51,…,59
            if ((i == 53) || (i%3 == 0)) {
                assertEquals("FizzBuzz", KataFizzBuzz.fizzBuzz2(i));
            } else {
                assertEquals("Buzz", KataFizzBuzz.fizzBuzz2(i));
            }
        }
        for (int i=5; i<=100; i+=10) { // 5,15,…,95
            if ((i%3 == 0) || (i == 35)) {
                assertEquals("FizzBuzz", KataFizzBuzz.fizzBuzz2(i));
            } else {
                assertEquals("Buzz", KataFizzBuzz.fizzBuzz2(i));
            }
        }
        assertEquals("Buzz", KataFizzBuzz.fizzBuzz2(100)); // 100
    }
}
