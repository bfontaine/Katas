use kata_english_words::kata_english_words::number_to_english;
mod kata_english_words;

#[test]
fn test_zero() {
    assert!(number_to_english(0) == ~"zero");
}

