;;;; KataReversi

(cl:defpackage #:kata-reversi
  (:use #:common-lisp)
  (:export #:possible-moves)
)

(in-package #:kata-reversi)

(defvar *letters* (coerce "ABCDEFGH" 'list))

;;; Returns the square {i,j}'s name
(defun get-square (i j)
  (format nil "~a~a" (nth i *letters*) (+ 1 j)))

;;; Returns the character at the given position
;;; in a list representing a Reversi board, lines are separated by
;;; one character.
(defun at (x y tab)
  (nth (+ (* (+ 1 (list-length *letters)) y) x) tab))

;;; Returns the char of the current player
(defun get-player (tab)
  (first (last tab)))

;;; Returns a list of possible moves for the current player
(defun possible-moves(s)
  (defvar tab (coerce s 'list))
  (defvar tabl (list-length *letters*))
  (defvar player (get-player tab))

  (defvar moves nil)

  (loop for i from 0 below tabl do
        (loop for j from 0 below tabl)) ; TODO

  moves
)
