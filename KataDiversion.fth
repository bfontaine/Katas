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

\ log2 (integer)
: LOG2 ( n -- log2_n ) DUP 1 < IF 1 ABORT" Log2 need a positive value."
                               ELSE DUP 1 = IF 0
                                            ELSE
                                                1 >R
                                                BEGIN ( n |R: i=1)
                                                    DUP DUP 2 I ** - 2 *
                                                    ( n n 2*[n-2**i])
                                                    R> 1 + >R ( … |R: i+1)
                                                    > ( n n>2*[n-2**i] )
                                                UNTIL
                                                R> 1 -
                                            THEN
                               THEN NIP ;

\ decimal to binary
\ e.g. : ( 11 -- 1 0 1 1 )
\ FIXME n DEC2BIN seems to give the binary value of n-1
: DEC2BIN ( n -- n1 n2 n3 … ) DUP 0 <> IF
                                        LOG2 2 SWAP ** >R ( n |R: X=2 ** n.log2 )
                                        BEGIN
                                            DUP I - 0 > IF 1 SWAP I - ( 1 n-X )
                                                        ELSE 0 SWAP   ( 0 n )
                                                        THEN
                                            I 1 =
                                            R> 2 / >R ( … | X/2 )
                                        UNTIL
                                        R> 2DROP
                                   THEN
                                ;

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
