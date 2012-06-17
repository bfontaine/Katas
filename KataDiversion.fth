\ KataDiversion in Forth

\ power
: ** ( n1 n2 -- n1_pow_n2 ) 1 SWAP ?DUP IF 0 DO OVER * LOOP THEN NIP ;

\ test if the given N has two adjacent 1 bits
: ?TWO-ADJACENT-1-BITS ( n -- bool ) ;

\ return the maximum number which can be made with N (given) bits
: ?MAX-NB ( n -- m ) DUP IF 2 SWAP ** NIP THEN ;

