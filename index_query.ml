
(* see `index` *)
let rec index_acc strs ind = [0] ;;

(* return the index of the strings list `strs` *)
let index strs = (index_acc strs []) ;;

(* test if the word w is in the string index i *)
let query i w = false ;;

(* 
  return the indices of strings of `strs` that contains the word `w`
  using indexes, e.g.:
    index_query [ "foo bar" ; "bar foo" ; "toto" ] "foo" ->  [ 0; 1 ]
    index_query [ "foo bar" ; "bar foo" ; "toto" ] "toto" -> [ 2 ]
*)
let index_query strs w = [] ;;
