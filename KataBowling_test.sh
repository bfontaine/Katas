#! /bin/bash
#
# use:
# $ . KataBowling_test.sh
# $ tests_compile
# $ tests_exec

function tests_compile() {
    if ! [ -f KataBowling.class ]; then
        scalac KataBowling.scala
    fi
    scalac -cp .:scalatest-1.7.1.jar KataBowlingTest.scala;
}

function tests_exec() {
    scala -cp .:scalatest-1.7.1.jar org.scalatest.tools.Runner -p . \
        -o -s KataBowlingTest;
}
