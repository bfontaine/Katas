#!/usr/bin/env gprolog --consult-file

make_change(0, _, []).

% Note it finds one solution; it may not be the best one (= with the fewer
% coins).
%
% E.g.: make_change(8, [5, 4, 1], C).
%       C = [5, 1, 1, 1] ?
%
% The best solution would be [4, 4].
%
make_change(Sum, Coins, [N|Change]) :-
  Sum > 0,
  member(N, Coins),
  Sum2 is Sum-N,
  make_change(Sum2, Coins, Change).

% convenient alias
make_usa_change(Sum, Change) :-
  make_change(Sum, [25, 10, 5, 1], Change).
