#! /usr/bin/clojure
(ns kata-trigrams.core
  (:require [clojure.data.json :as json])
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

(defn index
  "Index all trigrams from filename-in and store them in filename-out
   (JSON)."
  ;; JSON Format:
  ;;   { "word1 word2": ["word3-1", "word3-2", "word3-3", ...], ... }
  ;;
  ;; We keep punctuation, too, and treat newlines as whitespaces.
  [filename-in filename-out]
  (let [trigrams (str->trigrams (slurp filename-in))]
    (spit filename-out
          (json/write-str (reduce add-trigram {} trigrams)))))

(defn generate
  "Generate a random text from trigrams stored in index-filename with
   words-count words in it."
  [index-filename words-count]
  ;; TODO
  )
