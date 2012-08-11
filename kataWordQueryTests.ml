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

let test_one_word_multiple_strings () = (* FIXME *)
  assert_equal [0]   (KataWordQuery.indexes ["foo"; "bar"] "foo") ;
  assert_equal [1]   (KataWordQuery.indexes ["bar"; "foo"] "foo") ;
  assert_equal [0;1] (KataWordQuery.indexes ["foo"; "foo"] "foo")
;;

(*
let test_every_string () =
  assert_equal [0;1] (KataWordQuery.indexes ["foo", "foo bar"])
;;*)

let suite =
  "suite">:::
    [
      "test_empty"                     >:: test_empty ;
      "test_one_empty_string"          >:: test_one_empty_string ;
      "test_one_word_one_string"       >:: test_one_word_one_string ;
      "test_two_words_one_string"      >:: test_two_words_one_string ;
      "test_multiple_words_one_string" >:: test_multiple_words_one_string ;
      "test_multiple_empty_strings"    >:: test_multiple_empty_strings ;
      "test_one_word_multiple_strings" >:: test_one_word_multiple_strings
    ]
;;

let _ =
  run_test_tt_main suite
;;
