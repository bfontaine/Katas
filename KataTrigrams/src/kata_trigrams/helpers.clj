(ns kata-trigrams.helpers
  (:require [clojure.data.json :as json])
  (:use [clojure.string :only (split)]))

(defn str->trigrams
  "Return trigrams from a string. It splits on spaces, so punctuation
   is kept."
  [s]
  (let [words (split s #"\s+")]
    (partition 3 1 words)))

(defn join-2-words
  "Join two words with a space"
  [w1 w2]
  (str w1 " " w2))

(defn add-trigram
  "Add a trigram to a map"
  ;; the map maps words pairs ("w1 w2") to sets of possible third words, e.g.:
  ;; { "foo bar" #{"baz" "quux" ... }, "bar foo" #{...}, ... }
  [m t]
  (if (not= 3 (count t))
    m ; t is not a trigram, return the original map
    (let [k (join-2-words (first t) (second t)) ; key
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
  (let [wl (m (join-2-words w1 w2))] ; words list
    (if (seq wl)
      (rand-nth wl)
      nil)))
