#! /usr/bin/perl

use warnings;
use strict;

use Test::More 'no_plan';

require_ok 'KataReversi.pm';
require_ok 'KataReversi';
use_ok 'KataReversi';

use KataReversi;

ok( defined &KataReversi::get_moves, "get_moves function is defined." );

is( KataReversi::get_moves, undef, "With no given value, get_moves returns an undef value.");

my $init_test = <<EOT
........
........
........
...BW...
...WB...
........
........
........
B
EOT
;

isa_ok ( KataReversi::get_moves($init_test), 'ARRAY', "With good given value, get_moves(…) returns an array." );

is ( KataReversi::get_moves($init_test), ('C5', 'D6', 'E3', 'F4'),
            "with the initial board, Black player can play in C5/D6/E3/F4");

