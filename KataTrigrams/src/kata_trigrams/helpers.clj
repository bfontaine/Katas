(ns kata-trigrams.helpers
  (:use [clojure.string :only (split)]))

(defn str->trigrams
  "Return trigrams from a string. It splits on spaces, so punctuation
   is kept."
  [s]
  (let [words (split s #"\s+")]
    (partition 3 1 words)))

(defn add-trigram
  "Add a trigram to a map."
  ;; the map maps words pairs ("w1 w2") to sets of possible third words, e.g.:
  ;; { "foo bar" #{"baz" "quux" ... }, "bar foo" #{...}, ... }
  [m t]
  (if (not= 3 (count t))
    m ; t is not a trigram, return the original map
    (let [k (str (first t) " " (second t)) ; key
          v (last t)]                      ; value
      (if (m k)
        ;; if the key exists, append the value to its set
        (assoc m k (conj (m k) v))
        ;; if not, create its set
        (assoc m k #{v})))))

