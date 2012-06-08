import org.junit.Test
import static org.junit.Assert.assertEquals

class KataGameOfLife_tests {

    static empty_gen              = ["Generation 1:\n4 8\n........\n........\n........\n........",
                                     "Generation 2:\n4 8\n........\n........\n........\n........"]
    
    static one_cell_gen           = ["Generation 1:\n4 8\n........\n....*...\n........\n........",
                                     "Generation 2:\n4 8\n........\n........\n........\n........"]

    static topleft_corner_gen     = ["Generation 1:\n4 8\n*.......\n........\n........\n........",
                                     "Generation 2:\n4 8\n........\n........\n........\n........"]

    static bottomright_corner_gen = ["Generation 1:\n4 8\n........\n........\n........\n......**",
                                     "Generation 2:\n4 8\n........\n........\n........\n........"]

    static high_gen               = ["Generation 578:\n4 8\n........\n........\n........\n........",
                                     "Generation 579:\n4 8\n........\n........\n........\n........"]

    @Test
    void parse_unparse_empty_gen() {
        assertEquals(empty_gen[0],
                        KataGameOfLife.parse(empty_gen[0]).toString());
    }

    @Test
    void empty_next_gen() {
        assertEquals(empty_gen[1],
                        KataGameOfLife.parse(empty_gen[0]).nextGen().toString());
    }

    @Test
    void one_cell_next_gen() {
        assertEquals(one_cell_gen[1],
                        KataGameOfLife.parse(one_cell_gen[0]).nextGen().toString());
    }

    @Test
    void top_left_corner_next_gen() {
        assertEquals(topleft_corner_gen[1],
                        KataGameOfLife.parse(topleft_corner_gen[0]).nextGen().toString());
    }

    @Test
    void bottom_right_corner_next_gen() {
        assertEquals(bottomright_corner_gen[1],
                        KataGameOfLife.parse(bottomright_corner_gen[0]).nextGen().toString());
    }
}
