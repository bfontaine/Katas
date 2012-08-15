-module(katacheckout_tests).
-include_lib("eunit/include/eunit.hrl").

empty_test () ->
    ?assertEqual(0, katacheckout:checkout([], [], [])),
    ?assertEqual(0, katacheckout:checkout([], [{apple, 2}], [])).

free_test () ->
    ?assertEqual(0,
        katacheckout:checkout([apple, apple], [], [])),
    ?assertEqual(0,
        katacheckout:checkout([apple, apple], [{apple, 0}], [])),
    ?assertEqual(0,
        katacheckout:checkout([apple, apple, banana], [{banana, 0}], [])),
    ?assertEqual(0,
        katacheckout:checkout([apple, banana, apple, peach],
            [{banana, 0}, {apple, 0}, {peach, 0}], [])).

no_promotion_test () ->
    (?assertEqual(42,
        katacheckout:checkout([apple, apple], [{apple, 21}], []))),
    (?assertEqual(42,
        katacheckout:checkout([apple, apple], [{banana, 2}, {apple, 21}], []))),
    (?assertEqual(17,
        katacheckout:checkout([apple, banana, apple],
            [{banana, 7}, {apple, 5}], []))),
    (?assertEqual(3.5,
        katacheckout:checkout([apple, banana, peach],
            [{banana, 1}, {apple, 1}, {peach, 1.5}], []))),
    (?assertEqual(1,
        katacheckout:checkout([apple], [{apple, 1}], [{apple, 3, 5}]))).
