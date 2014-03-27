fn million_prefix(num : u64) -> ~str {
    match num {
        1000000          => ~"m",
        1000000000       => ~"b",
        1000000000000    => ~"tr",
        1000000000000000 => ~"quadr",

        // ...
        _    => ~"gaz"
    }
}

fn power_of_ten(num : u64) -> ~str {
    if num == 1000 {
        ~"thousand"
    } else {
        million_prefix(num) + "illion"
    }
}

pub fn number_to_english(num : u64) -> ~str {

    // hundreds
    let h  = num/100;
    let hm = num%100;

    if h > 0 && h < 10 {
        let mut partial = number_to_english(h) + " hundred";
        if hm != 0 {
            partial = partial + " and " + number_to_english(hm);
        }
        return partial;
    }

    // thousands + *illions
    let mut threshold = 1000;

    while threshold <= num {
        let d = num/threshold;
        let m = num%threshold;

        if d > 0 && d < 1000 {
            let mut partial = number_to_english(d) + " " + power_of_ten(threshold);
            if m != 0 {
                if m < 100 {
                    partial = partial + " and";
                }
                partial = partial + " " + number_to_english(m);
            }
            return partial;
        }

        threshold *= 1000;
    }

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

        21..99 => number_to_english((num/10)*10) + "-" + number_to_english(num%10),

        _  => ~"TODO"
    }
}
