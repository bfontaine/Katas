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
    d=$1; # decimal
    r=; #   roman

    echo $r;
    return 0;
}

# Part II
roman_to_dec() {
    # simple cases
    for i in ${!a[@]};
    do
        if [ ${a[$i]} == $1 ];
        then
            echo $i;
            return 0;
        fi
    done

    # others
    r=$1; # roman
    d=; #   decimal

    echo $d;
    return 0;
}

