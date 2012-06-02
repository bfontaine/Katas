; KataReversi

(cl:defpackage #:kata-reversi
  (:use #:common-lisp)
  (:export #:possible-moves)
)

(in-package #:kata-reversi)

(defvar *letters* (coerce "ABCDEFGH" 'list))

(defun get-square (i j)
  (format nil "~a~a" (nth i *letters*) (+ 1 j)))

(defun possible-moves(tab)
  NIL ;TODO
)
