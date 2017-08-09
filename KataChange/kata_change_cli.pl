#!/usr/bin/env gprolog --consult-file

int_list_format('', []).
int_list_format('~d', [_]).
int_list_format(F, [_|T]) :-
  int_list_format(FF, T),
  atom_concat(FF, ', ~d', F).

print_int_list(Prefix, L) :-
  int_list_format(F, L),
  atom_concat(F, '\n', FF),
  atom_concat(Prefix, FF, Format),
  format(Format, L).

print_usa_change(Sum) :-
  consult('kata_change.pl'),
  make_usa_change(Sum, Change),
  print_int_list('You need the following coins: ', Change).

main(2) :-
  argument_value(1, S),
  number_atom(Sum, S),
  print_usa_change(Sum),
  halt.

main(N) :-
  N =\= 2,
  argument_value(0, Exe),
  format('Usage: ~a <sum>\n', [Exe|[]]),
  halt.

init :-
  argument_counter(NArgs),
  main(NArgs).

:- initialization(init).
