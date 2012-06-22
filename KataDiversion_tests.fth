\ KataDiversion tests, in Forth
\ running tests:
\   gforth KataDiversion_tests.fth -e bye

REQUIRE KataDiversion.fth

VARIABLE ASSERT-COUNT

: ASSERTS-INIT ( -- )
    0 ASSERT-COUNT ! ;

: ASSERTS-RESULT ( -- )
    ASSERT-COUNT @ . ." assertions successfully passed." CR ;

\ destructive assert-equal
: ASSERT-EQUAL-D ( n1 n2 -- )
    <> IF 1 ABORT" AssertEqual: Fail"
            ELSE ASSERT-COUNT @ 1+ ASSERT-COUNT ! THEN ;

\ non-destructive assert-equal
: ASSERT-EQUAL ( n1 n2 -- n1 n2 )
    2DUP ASSERT-EQUAL-D ;

\ destructive assert-true
: ASSERT-TRUE-D ( n -- )
    0 = IF 1 ABORT" AssertTrue: Fail"
            ELSE ASSERT-COUNT @ 1+ ASSERT-COUNT ! THEN ;

\ non-destructive assert-true
: ASSERT-TRUE ( n -- n )
    DUP ASSERT-TRUE-D ;

\ destructive assert-false
: ASSERT-False-D ( n -- )
    0 <> IF 1 ABORT" AssertFalse: Fail"
            ELSE ASSERT-COUNT @ 1+ ASSERT-COUNT ! THEN ;

\ non-destructive assert-false
: ASSERT-FALSE ( n -- n )
    DUP ASSERT-FALSE-D ;

\ ---- tests ----

ASSERTS-INIT

\ ?EMPTY
EMPTY         DEPTH 0 ASSERT-EQUAL-D
EMPTY EMPTY   DEPTH 0 ASSERT-EQUAL-D
0 EMPTY       DEPTH 0 ASSERT-EQUAL-D
1 2 3 4 EMPTY DEPTH 0 ASSERT-EQUAL-D

\ ?NEGATIVE
-1 ?NEG ASSERT-TRUE-D
 0 ?NEG ASSERT-TRUE-D
 1 ?NEG ASSERT-FALSE-D

\ ?MAX-NB
-1 ?MAX-NB  0   ASSERT-EQUAL-D
 0 ?MAX-NB  0   ASSERT-EQUAL-D
 1 ?MAX-NB  2   ASSERT-EQUAL-D
 2 ?MAX-NB  4   ASSERT-EQUAL-D
 3 ?MAX-NB  8   ASSERT-EQUAL-D

\ LOG2
 1 LOG2  0 ASSERT-EQUAL-D
 2 LOG2  1 ASSERT-EQUAL-D
 3 LOG2  1 ASSERT-EQUAL-D
 4 LOG2  2 ASSERT-EQUAL-D
 5 LOG2  2 ASSERT-EQUAL-D
 8 LOG2  3 ASSERT-EQUAL-D
42 LOG2  5 ASSERT-EQUAL-D

\ DEC2BIN

 0 DEC2BIN 0 ASSERT-EQUAL-D
 1 DEC2BIN 1 ASSERT-EQUAL-D
 2 DEC2BIN 0 ASSERT-EQUAL-D ( 2 -> 10 )
           1 ASSERT-EQUAL-D
11 DEC2BIN 1 ASSERT-EQUAL-D ( 11 -> 1011 )
           1 ASSERT-EQUAL-D
           0 ASSERT-EQUAL-D
           1 ASSERT-EQUAL-D


ASSERTS-RESULT
\ ---------


