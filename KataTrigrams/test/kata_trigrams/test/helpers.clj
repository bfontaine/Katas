(ns kata-trigrams.test.helpers
  (:use [kata-trigrams.helpers :as kt])
  (:use [clojure.test]))

;; test kt/str->trigrams
(deftest test-str->trigrams

  ;; empty string
  (is (= ()
         (kt/str->trigrams "")))
  
  ;; one word (no trigram)
  (is (= ()
         (kt/str->trigrams "one")))
  
  ;; two word (no trigram)
  (is (= ()
         (kt/str->trigrams "one two")))
  
  ;; three words -> one trigram
  (is (= '(("one" "two" "three"))
         (kt/str->trigrams "one two three")))
  
  ;; four words -> two trigrams
  (is (= '(("one" "two" "three") ("two" "three" "four"))
         (kt/str->trigrams "one two three four")))
  
  ;; punctuation
  (is (= '(("a" "b" "c."))
         (kt/str->trigrams "a b c.")))
  
  ;; hyphens in words
  (is (= '(("a" "b-b" "c"))
         (kt/str->trigrams "a b-b c"))))


;; test kt/add-trigram
(deftest test-add-trigram
  
  ;; not a trigram
  (is (= {}
         (kt/add-trigram {} '("one"))))
  (is (= {}
         (kt/add-trigram {} '("one" "two"))))

  ;; trigram with first two words not in the map
  (is (= {"a b" #{"c"}}
         (kt/add-trigram {} '("a" "b" "c"))))
  (is (= {"a b" #{"c"} "a c" #{"b"}}
         (kt/add-trigram {"a c" #{"b"}} '("a" "b" "c"))))

  ;; trigram with first two words already in the map
  (is (= {"a b" #{"c" "d"}}
         (kt/add-trigram {"a b" #{"c"}} '("a" "b" "d")))))
