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
}
