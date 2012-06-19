\ KataDiversion in Forth

\ -- utils

\ empty the stack
: EMPTY
    DEPTH 0 <> IF BEGIN
                    DROP DEPTH 0 =
                  UNTIL
               THEN ;

\ power
: ** ( n1 n2 -- n1_pow_n2 ) 1 SWAP ?DUP IF 0 DO OVER * LOOP THEN NIP ;

\ test if the top is a negative number
: ?NEG ( n -- bool ) DUP 0= IF -1 ELSE DUP ABS <> THEN ;

\ -- kata

\ test if the given N has two adjacent 1 bits
\ e.g. : 1011 -> -1
\        1001 -> 0
: ?TWO-ADJACENT-1-BITS ( n -- bool ) ( TODO ) ;

\ return the maximum number which can be made with N (given number) bits
: ?MAX-NB ( n -- m ) DUP ?NEG IF DROP 0 ( 0 )
                              ELSE 
                                  DUP IF DUP 2 SWAP ** NIP ( 2**n )
                                  THEN
                              THEN ;


\ return the number of numbers which can be made with N (given number) bits
\ or less, and which have not two adjacent 1 bits.
\ see http://www.codekata.com/2007/01/code_kata_fifte.html
: ?HOW-MANY-NB-NOT-TWO-ADJACENT-1-BITS ( n -- m ) ( TODO ) ;
