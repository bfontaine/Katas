
pub fn number_to_english(num : int) -> ~str {
    match num {
        // simple numbers
         0 => ~"zero",
         1 => ~"one",
         2 => ~"two",
         3 => ~"three",
         4 => ~"four",
         5 => ~"five",
         6 => ~"six",
         7 => ~"seven",
         8 => ~"eight",
         9 => ~"nine",
        10 => ~"ten",
        11 => ~"eleven",
        12 => ~"twelve",
        13 => ~"thirteen",
        15 => ~"fifteen",
        18 => ~"eighteen",

        14 | 16 | 17 | 19 =>
            number_to_english(num-10) + "teen",

        20 => ~"twenty",
        30 => ~"thirty",
        40 => ~"forty",
        50 => ~"fifty",
        80 => ~"eighty",

        60 | 70 | 90 =>
            number_to_english(num/10) + "ty",

        _  => ~"TODO"
    }
}
