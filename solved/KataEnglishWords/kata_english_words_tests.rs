use kata_english_words::number_to_english;
mod kata_english_words;

#[test]
fn test_one_digit() {
    assert!(number_to_english(0) == ~"zero");
    assert!(number_to_english(1) == ~"one");
    assert!(number_to_english(2) == ~"two");
    assert!(number_to_english(3) == ~"three");
    assert!(number_to_english(4) == ~"four");
    assert!(number_to_english(5) == ~"five");
    assert!(number_to_english(6) == ~"six");
    assert!(number_to_english(7) == ~"seven");
    assert!(number_to_english(8) == ~"eight");
    assert!(number_to_english(9) == ~"nine");
}

#[test]
fn test_tens() {
    assert!(number_to_english(10) == ~"ten");
    assert!(number_to_english(20) == ~"twenty");
    assert!(number_to_english(30) == ~"thirty");
    assert!(number_to_english(40) == ~"forty");
    assert!(number_to_english(50) == ~"fifty");
    assert!(number_to_english(60) == ~"sixty");
    assert!(number_to_english(70) == ~"seventy");
    assert!(number_to_english(80) == ~"eighty");
    assert!(number_to_english(90) == ~"ninety");
}

#[test]
fn test_two_digits() {
    assert!(number_to_english(21) == ~"twenty-one");
    assert!(number_to_english(42) == ~"forty-two");
    assert!(number_to_english(67) == ~"sixty-seven");
    assert!(number_to_english(99) == ~"ninety-nine");
}

#[test]
fn test_hundreds() {
    assert!(number_to_english(100) == ~"one hundred");
    assert!(number_to_english(300) == ~"three hundred");
    assert!(number_to_english(800) == ~"eight hundred");
}

#[test]
fn test_three_digits() {
    assert!(number_to_english(143) == ~"one hundred and forty-three");
    assert!(number_to_english(401) == ~"four hundred and one");
    assert!(number_to_english(999) == ~"nine hundred and ninety-nine");
}

#[test]
fn test_thousands() {
    assert!(number_to_english(1000) == ~"one thousand");
    assert!(number_to_english(2000) == ~"two thousand");
    assert!(number_to_english(9000) == ~"nine thousand");
}

#[test]
fn test_four_digits() {
    assert!(number_to_english(1492) == ~"one thousand four hundred and ninety-two");
    assert!(number_to_english(2014) == ~"two thousand and fourteen");
    assert!(number_to_english(9999) == ~"nine thousand nine hundred and ninety-nine");
}

#[test]
fn test_five_digits() {
    assert!(number_to_english(41186) == ~"forty-one thousand one hundred and eighty-six");
}

#[test]
fn test_six_digits() {
    assert!(number_to_english(141186) == ~"one hundred and forty-one thousand one hundred and eighty-six");
}

#[test]
fn test_seven_digits() {
    assert!(number_to_english(1000000) == ~"one million");
    assert!(number_to_english(1000001) == ~"one million and one");
}

#[test]
fn test_large_numbers() {
    assert!(number_to_english(1000000000u64) == ~"one billion");
    assert!(number_to_english(1000000000000u64) == ~"one trillion");
    assert!(number_to_english(1000000000000000u64) == ~"one quadrillion");
    assert!(number_to_english(1000000000000000000u64) == ~"one gazillion");
}
