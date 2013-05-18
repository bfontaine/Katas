#! /usr/bin/clojure
(ns kata-trigrams.cli
  (:use [kata-trigrams.core]))

(defn -main
  [& args]
  (if (not= 3 (count args))
    (do
      (println "Usage:\n\t"
               "kata-trigrams index f1 f2   ; index trigrams of file <f1>"
               "and store them in <f2>.\n\t"
               "kata-trigrams generate f1 n ; generate a text of <n> words,"
               "with trigrams from file <f1>.")
      (System/exit 1))
    (let [[action arg1 arg2] args]
      (if (= "index" action)
        (index arg1 arg2)
        (if (= "generate" action)
          (generate arg1 arg2)
          (do
            (println (str "Unknown action: '" action "'."))
            (System/exit 1)))))))
        
