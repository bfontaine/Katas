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
checkout ([], _, _) -> 0.
