-module(katacheckout).
-author("Baptiste Fontaine").
-vsn(0.1).

-export([checkout/3]).

%% checkout/3 :
%%      list of goods :
%%          [ apple, banana, apple, apple, etc ]
%%          -> 3 apples and 1 banana
%%
%%      list of prices :
%%          [ {apple, 2.5}, {banana, 3}, etc ]
%%          -> apple  = $2.5 each
%%             banana = $3 each
%%      list of offers : [ {apples, 3, 7}, etc ]
%%          -> 3 apples for $7
%%
%%  -> gives the total price

checkout (_, [], _) -> 0;
checkout ([], _, _) -> 0;
checkout ([H|T], P, []) ->
    get_price(H, P) + checkout(T, P, []).

% get_price(Item, Prices_list)
% returns the price of an item or 0 if it cannot be found.
get_price(_, []) -> 0;
get_price(I, [{K, P}|_]) when I =:= K -> P;
get_price(I, [{K, _}|T]) when I =/= K ->
    get_price(I, T).

