#! /bin/bash

test_message() {
    local msg=$1
    local key=$2
    local expected=$3
    local got=

    got=$(echo -n "$msg" | ./code_cracker.awk -v "key=$key")
    if [[ x"$got" != x"$expected" ]]; then
        echo "Failure:"
        echo "  Message: $msg"
        echo "      Key: $key"
        echo " ---------"
        echo " Expected: $expected"
        echo "      Got: $got"
    fi
}

test_message 'abcdefghijklmnopqrstuvwxyz' \
             'abcdefghijklmnopqrstuvwxyz' \
             'abcdefghijklmnopqrstuvwxyz'

test_message '!)"(£*%&><@abcdefghijklmno' \
             '!)"(£*%&><@abcdefghijklmno' \
             'abcdefghijklmnopqrstuvwxyz'

test_message 'hillxyxuthesessxsicritoxoxox' \
             'abcdifghejklmnxpqrstuvwoyz' \
             'helloyouthisissosecretxoxoxo'
