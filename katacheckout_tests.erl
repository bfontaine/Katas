-module(katacheckout_tests).
-include_lib("eunit/include/eunit.hrl").

empty_test () ->
    ?assertEqual(0, katacheckout:checkout([], [], [])),
    ?assertEqual(0, katacheckout:checkout([], [{apple, 2}], [])).

