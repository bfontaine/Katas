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
    if [ ${ROMAN_N[$1]} ]; then echo ${ROMAN_N[$1]};exit 0; fi;

    # others
    d=$1; # decimal
    r=; #   roman

    # i: 3,2,1,0
    for i in {3..0..-1}; do
        dec=$(echo "10^$i" | bc); # 1000,100,10,1
        n=$(echo "$d/$dec" | bc); # number of 'dec' in $1

        # for numbers like MMM…, XX…, CCC…, CC…, …
        if [ $n -gt 0 ] && [ $n -le 3 ]; then
            for j in $(seq 1 $n); do
                r="$r${ROMAN_N[$dec]}";
            done;

            d=$(echo "$d%($n*$dec)" | bc);
        fi
    done


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
    d=0; #   decimal

    # replace CM with DCCCC
    # …       CD      CCCC
    # …       XC      LXXXX
    # …       XL      XXXX
    # …       IX      VIIII
    # …       IV      IIII
    # then convert: ((number of M * 1000) + (number of D * 500) + …)

    r=$(echo $r | sed 's/CM/DCCCC/g' | sed 's/CD/CCCC/g');
    r=$(echo $r | sed 's/XC/LXXXX/g' | sed 's/XL/XXXX/g');
    r=$(echo $r | sed 's/IX/VIIII/g' | sed 's/IV/IIII/g');

    for i in 1 10 50 100 500 1000; do
        tmp=${r//[^${ROMAN_N[$i]}]}; # all ${ROMAN_N[$i]} characters
        d=$(echo "$d+(${#tmp}*$i)" | bc);
    done

    echo $d;
    return 0;
}

