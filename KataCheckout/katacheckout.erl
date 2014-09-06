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

% 'checkout' is just a wrapper for 'checkout_count'
checkout (A, B, C) -> checkout_count(count(A), B, C, 0).

% empty cases
checkout_count (_, [], _, Total) -> Total;
checkout_count ([], _, _, Total) -> Total;

% no promotions
checkout_count([H|T], Pl, [], Total) ->
    {I, C} = H,
    New_total = Total + get_price(I, Pl) * C,
    checkout_count(T, Pl, [], New_total);

checkout_count([{I, N}|T], Pl, Po, Total) ->
    checkout_count(T, Pl, Po, Total + get_price_with_promotion(I, N, Pl, Po)).

% promotions

% get_price(Item, Prices_list)
%   Item : an atom
%   Prices_list : list of tupples {item, price}
%
%   -> return prive of item, e.g.:
%       foo, [{bar, 3}, {foo, 1}]
%       -> 1
get_price (_, []) -> 0;

get_price (I, [{I, P}|_]) -> P;

get_price (I, [_|T]) ->
    get_price(I, T).

% get_price_with_promotion(Item, Nb, Prices_list, Promotions)
%   get price with promotions
get_price_with_promotion (_, 0, _, _) -> 0;
get_price_with_promotion (I, N, P, []) -> N * get_price(I, P);

% PN: promotion number, PP: promotion price
get_price_with_promotion (I, N, P, [{I, PN, _}|_]) when N < PN ->
    N * get_price(I, P);

get_price_with_promotion (I, N, P, [{I, PN, PP}|_]) ->
    (N div PN * PP) + (N rem PN) * get_price(I, P);

get_price_with_promotion (I, N, P, [_|T]) ->
    get_price_with_promotion(I, N, P, T).


% count items
% e.g. [apple, banana, apple peach, peach]
%   -> [{apple, 2}, {banana, 1}, {peach, 2}]
count ([]) -> [];
count (L) -> count(L, []).

count ([H|T], [{H, C}|T2]) ->
    count(T, [{H, C+1}|T2]);

count ([H|T], []) ->
    count(T, [{H, 1}]);

count ([], C) -> C;

count (L, [A|T2]) ->
    [A|count(L, T2)].


