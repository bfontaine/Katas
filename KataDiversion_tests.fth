\ KataDiversion tests, in Forth
\ running tests:
\   gforth KataDiversion_tests.fth -e bye

REQUIRE KataDiversion.fth

VARIABLE ASSERT-COUNT
0 ASSERT-COUNT !

: ASSERT-EQUAL ( n1 n2 -- n1 n2 )
    2DUP <> IF 1 ABORT" AssertEqual: Fail"
            ELSE ASSERT-COUNT @ 1+ ASSERT-COUNT ! THEN ;

\ - tests -

\ ?MAX-NB
-1 ?MAX-NB  0   ASSERT-EQUAL
0 ?MAX-NB   0   ASSERT-EQUAL
1 ?MAX-NB   2   ASSERT-EQUAL
2 ?MAX-NB   4   ASSERT-EQUAL
3 ?MAX-NB   8   ASSERT-EQUAL



\ ---------

ASSERT-COUNT @ . ." assertions successfully passed." CR

