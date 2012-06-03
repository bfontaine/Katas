(load "lisp-unit.lisp")
(load "KataKarateChop.lisp")
(use-package :lisp-unit)
(use-package :kata-karate-chop)

(define-test :t1
	(assert-equal -1 (chop 3 '())))

(define-test :t2
	(assert-equal -1 (chop 3 '(1))))

(define-test :t3
	(assert-equal 0 (chop 1 '(1))))

(define-test :t4
	(assert-equal 0 (chop 1 '(1 3 5))))

(define-test :t5
	(assert-equal 1 (chop 3 '(1 3 5))))

(define-test :t6
	(assert-equal 2 (chop 5 '(1 3 5))))

(define-test :t7
	(assert-equal -1 (chop 0 '(1 3 5))))

(define-test :t8
	(assert-equal -1 (chop 2 '(1 3 5))))

(define-test :t9
	(assert-equal -1 (chop 4 '(1 3 5))))

(define-test :t10
	(assert-equal -1 (chop 6 '(1 3 5))))

(define-test :t11
	(assert-equal 0 (chop 1 '(1 3 5 7))))

(define-test :t12
	(assert-equal 1 (chop 3 '(1 3 5 7))))

(define-test :t13
	(assert-equal 2 (chop 5 '(1 3 5 7))))

(define-test :t14
	(assert-equal 3 (chop 7 '(1 3 5 7))))

(define-test :t15
	(assert-equal -1 (chop 0 '(1 3 5 7))))

(define-test :t16
	(assert-equal -1 (chop 2 '(1 3 5 7))))

(define-test :t17
	(assert-equal -1 (chop 4 '(1 3 5 7))))

(define-test :t18
	(assert-equal -1 (chop 6 '(1 3 5 7))))

(define-test :t19
	(assert-equal -1 (chop 8 '(1 3 5 7))))

(run-tests)
