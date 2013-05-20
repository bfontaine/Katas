(defproject kata-trigrams "1.0.0-SNAPSHOT"
  :description "Random text generator using trigrams."
  :url "https://github.com/bfontaine/Katas"
  :dependencies [[org.clojure/clojure "1.3.0"]
                 [org.clojure/data.json "0.2.2"]
                 [org.clojure/core.incubator "0.1.2"]]
  :main kata-trigrams.cli
  :repl-init kata-trigrams.core)
