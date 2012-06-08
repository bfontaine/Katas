#! /usr/bin/groovy

class KataGameOfLife {
    static parse(String str) {
        def lines = str.split("\n") 
        def num = (lines.first() =~ /Generation (\d+)/)[0][1]

        //new Generation(num.toInteger(), [""])
        new Generation(num.toInteger(), lines.drop(2) as List)
    }
}

class Generation {
    def genNum
    def board

    Generation(Integer gn, List b) {
       this.genNum = gn;
       this.board = b;
    }

    Generation nextGen() {
        this;
    }

    String toString() {
         "Generation ${this.genNum}:\n" \
        +"${this.board.size()} ${this.board[0].length()}\n" \
        +"${this.board.join("\n")}"
    }
}

