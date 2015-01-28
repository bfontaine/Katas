#! /bin/bash -e

__t() {

    local PROG=kata_sort_chars.bas
    local CMD="cbmbasic $PROG"
    local ret=0

    ksc_test() {
        local input=$1
        local expected=$2
        local result="$(echo $input | $CMD | tail -n 1 | tr '\r' ' ' | xargs)"
        if [ x"$result" != x"$expected" ]; then
            echo "FAIL! input='$input'"
            echo "   expected='$expected'"
            echo "     result='$result'"
            ret=1
        fi
    }

    ksc_test "a" "a"
    ksc_test "ab" "ab"

    ksc_test "ba" "ab"
    ksc_test "abcd0" "0abcd"

    ksc_test "foobar" "abfoor"
    ksc_test "xxxxxx" "xxxxxx"

    ksc_test "hi i'm B" "bhiim"
    ksc_test ".&@%" ""

    exit $ret
}

__t $*
