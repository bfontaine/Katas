#! /bin/bash

. KataRomanNumerals.sh;
. assert.sh;

# Part I
should_returns_I()      { return dec_to_roman    1; }
should_returns_VII()    { return dec_to_roman    8; }
should_returns_IX()     { return dec_to_roman    9; }
should_returns_XV()     { return dec_to_roman   15; }
should_returns_XIX()    { return dec_to_roman   19; }
should_returns_XLI()    { return dec_to_roman   41; }
should_returns_L()      { return dec_to_roman   50; }
should_returns_XCIX()   { return dec_to_roman   99; }
should_returns_C()      { return dec_to_roman  100; }
should_returns_CC()     { return dec_to_roman  200; }
should_returns_D()      { return dec_to_roman  500; }
should_returns_DXCIX()  { return dec_to_roman  599; }
should_returns_DCCXLIX(){ return dec_to_roman  749; }
should_returns_M()      { return dec_to_roman 1000; }
should_returns_MCMXC()  { return dec_to_roman 1990; }
should_returns_MMVIII() { return dec_to_roman 2008; }

# Part II
should_returns_1()    { return roman_to_dec "I"; }
should_returns_4()    { return roman_to_dec "IV"; }
should_returns_7()    { return roman_to_dec "VII"; }
should_returns_10()   { return roman_to_dec "X"; }
should_returns_50()   { return roman_to_dec "L"; }
should_returns_100()  { return roman_to_dec "C"; }
should_returns_500()  { return roman_to_dec "D"; }
should_returns_1000() { return roman_to_dec "M"; }
should_returns_1991() { return roman_to_dec "MCMXCI"; }
should_returns_2007() { return roman_to_dec "MMVII"; }

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
assert "should_returns_MMVIII" "MMVIII";

assert "should_returns_1" "1";
assert "should_returns_4" "4";
assert "should_returns_7" "7";
assert "should_returns_10" "10";
assert "should_returns_50" "50";
assert "should_returns_100" "100";
assert "should_returns_500" "500";
assert "should_returns_1000" "1000";
assert "should_returns_1991" "1991";
assert "should_returns_2007" "2007";
assert_end;
