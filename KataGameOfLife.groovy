#! /usr/bin/groovy

class KataGameOfLife {

    static parse(String str) {
        def lines = str.split("\n") 
        def num = (lines.first() =~ /Generation (\d+)/)[0][1]

        //new Generation(num.toInteger(), [""])
        new Generation(num.toInteger(), lines.drop(2) as List)
    }

    static unparse(Generation g) { g.toString() }

    // just for tests
    static void main(String[] args) {

        def g = "Generation 1:\n4 8\n........\n........\n........\n........"

        println(parse(g));
        println unparse(parse(g))
        println unparse(parse(g).nextGen())
    
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

    }

    String toString() {
         "Generation ${this.genNum}:\n" \
        +"${this.board.size()} ${this.board[0].length()}\n" \
        +"${this.board.join("\n")}"
    }
}

