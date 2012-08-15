-module(katacheckout_tests).
-include_lib("eunit/include/eunit.hrl").

empty_test () ->
    ?assertEqual(0, katacheckout:checkout([], [], [])),
    ?assertEqual(0, katacheckout:checkout([], [{apple, 2}], [])).

free_test () ->
    ?assertEqual(0, katacheckout:checkout([apple, apple], [], [])),
    ?assertEqual(0, katacheckout:checkout([apple, apple], [{apple, 0}], [])),
    ?assertEqual(0, katacheckout:checkout([apple, apple, banana], [{banana, 0}], [])).

