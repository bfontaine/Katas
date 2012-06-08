import org.junit.Test
import static org.junit.Assert.assertEquals

class KataGameOfLife_tests {

    static empty_gen = "Generation 1:\n4 8\n........\n........\n........\n........"

    @Test
    void parse_unparse_empty_gen() {
        assertEquals(empty_gen, KataGameOfLife.parse(empty_gen).toString());
    }

    @Test
    void empty_next_gen() {
        assertEquals(empty_gen, KataGameOfLife.parse(empty_gen).nextGen().toString());
    }
}
