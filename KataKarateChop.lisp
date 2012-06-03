;;; Kata KarateChop
;;; http://codekata.pragprog.com/2007/01/kata_two_karate.html

(cl:defpackage #:kata-karate-chop
  (:use #:common-lisp)
    (:export #:chop))

(in-package #:kata-karate-chop)

;;; Returns the indice of n in tab if it exists, else -1. l should be
;;; the length of tab.
(defun _chop (n tab l)
  (if (eq nil tab)
      (- -1 l)
      (if (eq n (car tab))
          0
          (+ 1 (_chop n (cdr tab) l)))))

;;; Returns the indice of n in tab if it exists, else -1
(defun chop (n tab) (_chop n tab (list-length tab)))
