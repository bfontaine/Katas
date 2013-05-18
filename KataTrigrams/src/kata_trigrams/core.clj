#! /usr/bin/clojure
(ns kata-trigrams.core)

(defn index
  "Index all trigrams from filename-in and store them in filename-out."
  [filename-in filename-out]
  ;; TODO
  )

(defn generate
  "Generate a random text from trigrams stored in index-filename with
   words-count words in it."
  [index-filename words-count]
  ;; TODO
  )

(if (not= 3 (count *command-line-args*))
  (do
    (println "Usage:\n\t"
             "kata-trigrams index f1 f2   ; index trigrams of file <f1>"
             "and store them in <f2>.\n\t"
             "kata-trigrams generate f1 n ; generate a text of <n> words,"
             "with trigrams from file <f1>.")
    (System/exit 1))
  (let [[action arg1 arg2] *command-line-args*]
    (if (= "index" action)
      (index arg1 arg2)
      (if (= "generate" action)
        (generate arg1 arg2)
        (do
          (println (str "Unknown action: '" action "'."))
          (System/exit 1))))))
      
