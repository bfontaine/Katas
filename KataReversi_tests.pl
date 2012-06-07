#! /usr/bin/perl

use warnings;
use strict;

use Test::More 'no_plan';

require_ok 'KataReversi.pm';
require_ok 'KataReversi';
use_ok 'KataReversi';

use KataReversi;

my $test;
my @moves;

ok( defined &KataReversi::get_moves, "get_moves function is defined." );

is( KataReversi::get_moves, undef, "With no given value, get_moves returns an undef value.");
is( KataReversi::get_moves(2), undef, "With bad given value, get_moves returns an undef value.");

# --- initial board
$test = <<EOT
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

@moves = ('C5', 'D6', 'E3', 'F4');

isa_ok ( KataReversi::get_moves($test), 'ARRAY', "With good given value, get_moves(…) returns an array." );

is ( KataReversi::get_moves($test), @moves,
            "with the initial board, Black player can play in C5/D6/E3/F4");

# ---
