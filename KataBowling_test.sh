#! /bin/bash

function tests_compile() {
    scalac KataBowling.scala
    scalac -cp .:scalatest-1.7.1.jar KataBowlingTest.scala;
}

function tests_exec() {
    scala -cp .:scalatest-1.7.1.jar org.scalatest.tools.Runner -p . \
        -o -s KataBowlingTest;
}
