#! /usr/bin/perl

use warnings;
use strict;

use Test::More 'no_plan';

require_ok 'KataReversi.pm';
require_ok 'KataReversi';
use_ok 'KataReversi';

use KataReversi;

ok( defined &KataReversi::get_moves, "get_moves function is defined." )
