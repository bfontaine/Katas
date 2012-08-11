open OUnit ;;

let test_empty () =
  assert_equal [] (Index_query.index_query [] "") ;;

let suite =
  "suite">:::
    ["test_empty">:: test_empty]
;;

let _ =
  run_test_tt_main suite
;;
