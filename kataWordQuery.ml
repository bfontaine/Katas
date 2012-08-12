(*
  This is a modified version of RubyQuiz #54,
    (http://rubyquiz.com/quiz54.html)
  it doesn't use bits indexes.
*)

(* split a string into words *)
let split = Str.split (Str.regexp_string " ") ;;

(* test if the word w is in the wordlist l *)
let rec is_in_l w l = match l with
  | []    -> false
  | a::l2 -> if a = w then true else (is_in_l w l2)
;;

(* test if the word w is in the string s *)
let is_in_s w s = is_in_l w (split s) ;;

(* return a list l2 of indexes of 'true' values in l *)
let rec true_indexes_acc l acc = match l with
  | [] -> []
  | true::l2 -> acc :: (true_indexes_acc l2 (acc + 1))
  | _::l2    ->        (true_indexes_acc l2 (acc + 1))
;;
let true_indexes l = true_indexes_acc l 0 ;;

(* return a list where L[i] is true if strs[i] contains w *)
let rec indexes2 strs w = match strs,w with
  | [],_    -> []
  | _,""    -> []
  | s::l2,_ -> (is_in_s w s)::(indexes2 l2 w)
;;
(* return a list of indexes of strings in strs which contain w *)
let indexes strs w = true_indexes (indexes2 strs w) ;;


