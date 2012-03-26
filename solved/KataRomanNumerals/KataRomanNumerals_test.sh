#! /bin/bash

. KataRomanNumerals.sh;
. assert.sh;

# Part I
should_returns_I()      { echo $(dec_to_roman    1); }
should_returns_VII()    { echo $(dec_to_roman    7); }
should_returns_IX()     { echo $(dec_to_roman    9); }
should_returns_XV()     { echo $(dec_to_roman   15); }
should_returns_XIX()    { echo $(dec_to_roman   19); }
should_returns_XLI()    { echo $(dec_to_roman   41); }
should_returns_L()      { echo $(dec_to_roman   50); }
should_returns_XCIX()   { echo $(dec_to_roman   99); }
should_returns_C()      { echo $(dec_to_roman  100); }
should_returns_CC()     { echo $(dec_to_roman  200); }
should_returns_D()      { echo $(dec_to_roman  500); }
should_returns_DXCIX()  { echo $(dec_to_roman  599); }
should_returns_DCCXLIX(){ echo $(dec_to_roman  749); }
should_returns_M()      { echo $(dec_to_roman 1000); }
should_returns_MCMXC()  { echo $(dec_to_roman 1990); }
should_returns_MMCC()   { echo $(dec_to_roman 2200); }
should_returns_MMVIII() { echo $(dec_to_roman 2008); }

# Part II
should_returns_1()    { echo $(roman_to_dec "I"); }
should_returns_4()    { echo $(roman_to_dec "IV"); }
should_returns_7()    { echo $(roman_to_dec "VII"); }
should_returns_10()   { echo $(roman_to_dec "X"); }
should_returns_50()   { echo $(roman_to_dec "L"); }
should_returns_100()  { echo $(roman_to_dec "C"); }
should_returns_500()  { echo $(roman_to_dec "D"); }
should_returns_501()  { echo $(roman_to_dec "DI"); }
should_returns_1000() { echo $(roman_to_dec "M"); }
should_returns_1991() { echo $(roman_to_dec "MCMXCI"); }
should_returns_2007() { echo $(roman_to_dec "MMVII"); }

# -- tests ---------

assert "should_returns_I" "I";
assert "should_returns_VII" "VII";
assert "should_returns_IX" "IX";
assert "should_returns_XV" "XV";
assert "should_returns_XIX" "XIX";
assert "should_returns_XLI" "XLI";
assert "should_returns_L" "L";
assert "should_returns_XCIX" "XCIX";
assert "should_returns_C" "C";
assert "should_returns_CC" "CC";
assert "should_returns_D" "D";
assert "should_returns_DXCIX" "DXCIX";
assert "should_returns_DCCXLIX" "DCCXLIX";
assert "should_returns_M" "M";
assert "should_returns_MCMXC" "MCMXC";
assert "should_returns_MMCC" "MMCC";
assert "should_returns_MMVIII" "MMVIII";

assert "should_returns_1" "1";
assert "should_returns_4" "4";
assert "should_returns_7" "7";
assert "should_returns_10" "10";
assert "should_returns_50" "50";
assert "should_returns_100" "100";
assert "should_returns_500" "500";
assert "should_returns_501" "501";
assert "should_returns_1000" "1000";
assert "should_returns_1991" "1991";
assert "should_returns_2007" "2007";

assert_end KataRomanNumerals;
