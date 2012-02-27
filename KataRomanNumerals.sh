#! /bin/bash

ROMAN_N=(
            [1]=I
            [5]=V
           [10]=X
           [50]=L
          [100]=C
          [500]=D
         [1000]=M
        );

# Part I
dec_to_roman() {
    # simple cases
    if [ ${ROMAN_N[$1]} ]; then echo ${ROMAN_N[$1]}; fi;

    # others
    d=$1;
    r=;

    echo $r;
}

# Part II
roman_to_dec() {
    echo "";
}

