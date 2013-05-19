(ns kata-trigrams.core
  (:use     [kata-trigrams.helpers]))

;;; -- these functions are called by cli.clj

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
          (trigrams->json trigrams))))

(defn generate
  "Generate a random text from trigrams stored in index-filename with
   words-count words in it."
  [index-filename words-count]
  (let [trigrams (json->trigrams-map (slurp index-filename))]
    (join-space (generate-words [] trigrams words-count))))

