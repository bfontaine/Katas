(ns kata-trigrams.helpers
  (:require [clojure.data.json :as json])
  (:use [clojure.string :only (split join)])
  (:use [clojure.core.incubator :only (-?>)]))

(defn str->trigrams
  "Return trigrams from a string. It splits on spaces, so punctuation
   is kept."
  [s]
  (let [words (split s #"\s+")]
    (partition 3 1 words)))

(defn join-space
  "Join some strings with a space"
  [& strs]
  (join " " strs))

(defn add-trigram
  "Add a trigram to a map"
  ;; the map maps words pairs ("w1 w2") to sets of possible third words, e.g.:
  ;; { "foo bar" #{"baz" "quux" ... }, "bar foo" #{...}, ... }
  [m t]
  (if (not= 3 (count t))
    m ; t is not a trigram, return the original map
    (let [k (join-space (first t) (second t)) ; key
          v (last t)]                      ; value
      (if (m k)
        ;; if the key exists, append the value to its set
        (assoc m k (conj (m k) v))
        ;; if not, create its set
        (assoc m k #{v})))))

(defn trigrams->json
  "Convert a list of trigrams into a JSON string"
  [trigrams]
  (json/write-str (reduce add-trigram {} trigrams)))

(defn json->trigrams-map
  "Convert a JSON string into a map of trigrams"
  [json-str]
  (json/read-str json-str))

(defn next-word
  "Return a possible next word for the two given ones"
  [w1 w2 m] ; word1 word2 trigrams-map
  (let [wl (m (join-space w1 w2))] ; words list
    (if (seq wl)
      (rand-nth wl))))

(defn rand-2-words
  "Return two random words from a map of trigrams, or nil if it's empty."
  [trigrams]
  (-?> trigrams keys rand-nth (split #" ")))

(defn before-last
  "return the element before the last one of a seq."
  [sq]
  (nth sq (- (count sq) 2)))

(defn generate-words
  "Given a vector of already-generated words, a trigrams map and a words count,
   add more words to the vector, based on the trigrams map, and up to the words
   count."
  [wl trigrams max-count]
  (let [wc (count wl)]
    (if (>= wc max-count)
      wl
      (if (= 0 wc)
        (generate-words
          (vec (rand-2-words trigrams))
          trigrams
          (- max-count 2))
        (generate-words
          (conj wl
                (next-word (before-last wl) (last wl) trigrams))
          trigrams
          (dec max-count))))))
