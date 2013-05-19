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
         (kt/add-trigram {"a b" #{"c"}} '("a" "b" "d"))))

  ;; trigram already in the map
  (is (= {"a b" #{"d"}}
         (kt/add-trigram {"a b" #{"d"}} '("a" "b" "d")))))


;; test kt/join-space
(deftest test-join-space

  ;; empty strings
  (is (= " "
         (kt/join-space "" "")))

  ;; only one empty string
  (is (= "a "
         (kt/join-space "a" "")))
  (is (= " b"
         (kt/join-space "" "b")))

  ;; 'normal' strings
  (is (= "a b"
         (kt/join-space "a" "b")))
  (is (= "a b c"
         (kt/join-space "a b" "c"))))


;; test kt/trigrams->json
(deftest test-trigrams->json
  
  ;; empty list
  (is (= "{}"
         (kt/trigrams->json ())))

  ;; one trigram
  (is (= "{\"a b\":[\"c\"]}"
         (kt/trigrams->json '(("a" "b" "c")))))

  ;; two trigrams, with the same first two words
  (is (= "{\"a b\":[\"c\",\"d\"]}"
         (kt/trigrams->json '(("a" "b" "c") ("a" "b" "d"))))))


;; test kt/json->trigrams-map
(deftest test-json->trigrams-map
  
  ;; empty map
  (is (= {}
         (kt/json->trigrams-map "{}"))

  ;; one trigram
  (is (= {"a b" ["c"]}
         (kt/json->trigrams-map "{\"a b\":[\"c\"]}")))))


;; test kt/next-word
(deftest test-next-word

  ;; only one possible word
  (is (= "c"
         (kt/next-word "a" "b" {"a b" ["c"]})))

  ;; multiple possibilities
  (is (#{"c" "d"} (kt/next-word "a" "b" {"a b" ["c" "d"]})))

  ;; no possible word
  (is (nil? (kt/next-word "a" "b" {}))))


;; test kt/rand-2-words
(deftest test-rand-2-words

  ;; empty map
  (is (nil? (kt/rand-2-words {})))

  ;; one possibility
  (is (= '("a" "b")
         (kt/rand-2-words {"a b" ["c"]}))))


;; test kt/before-last
(deftest test-before-last
  (is (= 2
         (kt/before-last [2 3])))
  (is (= 2
         (kt/before-last [1 2 3]))))


;; test kt/generate-words
(deftest test-generate-words

  ;; empty vector, two words, one possibility
  (is (= ["a" "b"]
         (generate-words [] {"a b" ["c"]} 2)))

  ;; empty vector, three words, one possibility
  (is (= ["a" "b" "c"]
         (generate-words [] {"a b" ["c"]} 3)))

  ;; non-empty vector, one possibility
  (is (= ["a" "b" "c"]
         (generate-words ["a" "b"] {"a b" ["c"]} 3))))
