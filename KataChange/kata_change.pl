#!/usr/bin/env gprolog --consult-file

make_some_change(0, _, [], _).

make_some_change(Sum, Coins, [N|Change], MaxCoins) :-
  Sum > 0,
  MaxCoins =\= 0,
  member(N, Coins),
  Sum2 is Sum-N,
  MaxCoins2 is MaxCoins-1,
  make_some_change(Sum2, Coins, Change, MaxCoins2).

longer_or_equal(List, Length) :-
  length(List, L),
  L >= Length.

better_solution(Sum, Coins, Length) :-
  Length > 1,
  ShorterLength is Length-1,
  make_some_change(Sum, Coins, _, ShorterLength).

make_change(Sum, Coins, C1) :-
  make_some_change(Sum, Coins, C1, -1),
  length(C1, L1),
  \+ better_solution(Sum, Coins, L1).

% convenient alias
make_usa_change(Sum, Change) :-
  make_change(Sum, [25, 10, 5, 1], Change).

% CLI part

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
