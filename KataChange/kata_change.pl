#!/usr/bin/env gprolog --consult-file

make_some_change(0, _, []).

make_some_change(Sum, Coins, [N|Change]) :-
  Sum > 0,
  member(N, Coins),
  Sum2 is Sum-N,
  make_change(Sum2, Coins, Change).

longer_or_equal(List, Length) :-
  length(List, L),
  L >= Length.

make_change(Sum, Coins, C1) :-
  make_some_change(Sum, Coins, C1),
  length(C1, L1),
  % note this takes too much time even on simple cases
  forall(make_some_change(Sum, Coins, C2), longer_or_equal(C2, L1)).

% convenient alias
make_usa_change(Sum, Change) :-
  make_change(Sum, [25, 10, 5, 1], Change).
