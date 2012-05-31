; KataReversi tests

(load "lisp-unit.lisp")
(load "KataReversi.lisp")

(use-package :lisp-unit)
(use-package :kata-reversi)

(define-test :empty-board-black
  (assert-equal NIL 
                (possible-moves (concatenate 'string "........\n"
                                                    "........\n"
                                                    "........\n"
                                                    "........\n"
                                                    "........\n"
                                                    "........\n"
                                                    "........\n"
                                                    "........\n"
                                                    "B"
                                 )
                )
  )
)

(define-test :empty-board-white
  (assert-equal NIL 
                (possible-moves (concatenate 'string "........\n"
                                                     "........\n"
                                                     "........\n"
                                                     "........\n"
                                                     "........\n"
                                                     "........\n"
                                                     "........\n"
                                                     "........\n"
                                                     "W"
                                )
                )
  )
)

(define-test :initial-board-black
  (defvar pm (possible-moves (concatenate 'string "........\n"
                                                  "........\n"
                                                  "........\n"
                                                  "...BW...\n"
                                                  "...WB...\n"
                                                  "........\n"
                                                  "........\n"
                                                  "........\n"
                                                  "B"
                                    )
                   )
  )
  (assert-true (not(eq pm NIL)))
  (unordered-equal (list "C5" "D6" "E3" "F4") pm)
)

(run-tests)
