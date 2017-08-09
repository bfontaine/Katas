#!/usr/bin/env gprolog --consult-file

make_some_change(0, _, [], _).

make_some_change(Sum, Coins, [N|Change], MaxCoins) :-
  Sum > 0,
  MaxCoins =\= 0,
  member(N, Coins),
  Sum2 is Sum-N,
  MaxCoins2 is MaxCoins-1,
  make_some_change(Sum2, Coins, Change, MaxCoins2).

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
