-module(katacheckout).
-author("Baptiste Fontaine").
-vsn(0.1).

-export([checkout/3]).

% checkout/3 :
%      list of goods :
%          [ apple, banana, apple, apple, etc ]
%          -> 3 apples and 1 banana
%
%      list of prices :
%          [ {apple, 2.5}, {banana, 3}, etc ]
%          -> apple  = $2.5 each
%             banana = $3 each
%      list of offers : [ {apples, 3, 7}, etc ]
%          -> 3 apples for $7
%
%  -> gives the total price

checkout (A, B, C) -> checkout_count(count(A), B, C).

checkout_count (_, [], _) -> 0;
checkout_count ([], _, []) -> 0;
checkout_count([H|T], Pl, []) ->
    {I, C} = H,
    get_price(I, Pl) * C + checkout_count(T, Pl, []).

% get_price(Item, Prices_list)
% returns the price of an item or 0 if it cannot be found.
get_price(_, []) -> 0;

get_price(I, [{I, P}|_]) -> P;

get_price(I, [_|T]) ->
    get_price(I, T).

% count items
% e.g. [apple, banana, apple peach, peach]
%   -> [{apple, 2}, {banana, 1}, {peach, 2}]
count ([]) -> [];
count (L) -> count(L, []).
count ([H|T], C) -> count (T, add_one(H, C));
count ([], C) -> C.

% add one item to a count
% e.g. apple, [{apple, 3}, {peach, 1}]
%   -> [{apple, 4}, {peach, 1}]
add_one(I, []) -> [{I, 1}];
add_one(I, [{I, C}|T]) -> [{I, C+1}|T];
add_one(I, [{K, C}|T]) when K =/= I -> [{K,C}|add_one(I, T)].
