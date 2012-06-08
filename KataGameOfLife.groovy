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
    def cols
    def lines

    Generation(int gn, List b) {
       this.genNum = gn
       this.board = b

       this.lines = b.size()
       this.cols = (lines == 0) ? 0 : b[0].length()
    }

    private getNbNeighbours(int i, int j) {
        def n = 0
        
        for (int x = i-1; x <= i+1; x++) {
            for (int y = j-1; y <= j-1; y++) {
                if ((x == i) && (y == j))
                    continue

                if (this.board[x] == null)
                    continue

                n += (this.board[x][y] && this.board[x][y] == "*") ? 1 : 0
            }
        }
        n
    }

    Generation nextGen() {

        def newBoard = []
        def line
        def cell

        for (int i=0; i<this.lines; i++) {
            
            line = ""
            for (int j=0; j<this.cols; j++) {
            
                cell = "."

                def nb = this.getNbNeighbours(i, j)

                if (((this.board[i][j] == ".") && (nb == 3)) \
                    || ((this.board[i][j] == "*") && ((nb == 2) || (nb == 3)))) {
                    cell = "*"
                }

                line += cell
            }
            
            newBoard.push(line)
        }

        new Generation(this.genNum+1, newBoard)
    }

    String toString() {
         "Generation ${this.genNum}:\n" \
        +"${this.lines} ${this.cols}\n" \
        +"${this.board.join("\n")}"
    }
}

