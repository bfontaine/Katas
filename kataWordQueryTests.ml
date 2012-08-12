open OUnit ;;

let test_empty () =
  assert_equal [] (KataWordQuery.indexes [] "") ;
  assert_equal [] (KataWordQuery.indexes ["foo"] "") ;
  assert_equal [] (KataWordQuery.indexes [] "foo")
;;

let test_one_empty_string () =
  assert_equal [] (KataWordQuery.indexes [""] "foo") ;
  assert_equal [] (KataWordQuery.indexes [""] "b")
;;

let test_one_word_one_string () =
  assert_equal [0] (KataWordQuery.indexes ["foo"] "foo") ;
  assert_equal [0] (KataWordQuery.indexes ["b"] "b")
;;

let test_two_words_one_string () =
  assert_equal [0] (KataWordQuery.indexes ["foo bar"] "foo") ;
  assert_equal [0] (KataWordQuery.indexes ["bar foo"] "foo") ;
  assert_equal [0] (KataWordQuery.indexes ["b x"] "b") ;
  assert_equal [0] (KataWordQuery.indexes ["x b"] "b")
;;

let test_multiple_words_one_string () =
  assert_equal [0] (KataWordQuery.indexes ["foo bar tutu"] "foo") ;
  assert_equal [0] (KataWordQuery.indexes ["bar foo foo"] "foo") ;
  assert_equal [0] (KataWordQuery.indexes ["bar titi lala toto foo"] "foo") ;
  assert_equal [0] (KataWordQuery.indexes ["q wq toto lala, b x"] "b") ;
  assert_equal [0] (KataWordQuery.indexes ["x x x x b"] "b")
;;

let test_multiple_empty_strings () =
  assert_equal [] (KataWordQuery.indexes [""; ""] "foo") ;
  assert_equal [] (KataWordQuery.indexes [""; ""; ""] "foo") ;
  assert_equal [] (KataWordQuery.indexes [""; ""] "b")
;;

let test_multiple_one_word_strings () =
  assert_equal [0]   (KataWordQuery.indexes ["foo"; "bar"] "foo") ;
  assert_equal [1]   (KataWordQuery.indexes ["bar"; "foo"] "foo") ;
  assert_equal [0;1] (KataWordQuery.indexes ["foo"; "foo"] "foo") ;
  assert_equal [1]   (KataWordQuery.indexes ["foo"; "bar" ; "foo"] "bar") ;
  assert_equal [0;2] (KataWordQuery.indexes ["foo"; "bar" ; "foo"] "foo")
;;

let test_multiple_multiple_words_strings () =
  assert_equal [0]   (KataWordQuery.indexes ["foo bar"; "bar"] "foo") ;
  assert_equal [1]   (KataWordQuery.indexes ["bar fo o"; "2 foo bar"] "foo") ;
  assert_equal [0;1] (KataWordQuery.indexes ["f- foo"; "1 2 3 4 foo"] "foo") ;
  assert_equal [1]   (KataWordQuery.indexes ["bar1"; "bar" ; "foo"] "bar") ;
  assert_equal [0;2] (KataWordQuery.indexes ["42 foo 42"; "barfoo" ; "foo 1"] "foo")
;;

let suite =
  "suite">:::
    [
      "test_empty"                           >:: test_empty ;
      "test_one_empty_string"                >:: test_one_empty_string ;
      "test_one_word_one_string"             >:: test_one_word_one_string ;
      "test_two_words_one_string"            >:: test_two_words_one_string ;
      "test_multiple_words_one_string"       >:: test_multiple_words_one_string ;
      "test_multiple_empty_strings"          >:: test_multiple_empty_strings ;
      "test_multiple_one_word_strings"       >:: test_multiple_one_word_strings ;
      "test_multiple_multiple_words_strings" >:: test_multiple_multiple_words_strings
    ]
;;

let _ =
  run_test_tt_main suite
;;
