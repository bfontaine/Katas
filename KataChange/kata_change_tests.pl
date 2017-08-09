#!/usr/bin/env gprolog --consult-file

init :-
  consult('kata_change.pl'),
  make_usa_change(0, []),
  make_usa_change(1, [1]),
  make_usa_change(25, [25]),
  make_usa_change(50, [25, 25]),
  make_usa_change(42, [25, 10, 5, 1, 1]),
  halt.

:- initialization(init).
