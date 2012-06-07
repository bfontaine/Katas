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

is( KataReversi::get_moves, undef,
    "With no given value, get_moves returns an undef value.");

is( KataReversi::get_moves(2), undef,
    "With bad given value, get_moves returns an undef value.");

# --- bad board (not enough lines)
$test = <<EOF
........
........
........
........
........
B
EOF
;

is( KataReversi::get_moves($test), undef,
    "With bad board (not enough lines), get_moves returns an undef value.");

# --- bad board (not enough columns)
$test = <<EOF
.......
.......
.......
..BW...
..WB...
.......
.......
.......
B
EOF
;

is( KataReversi::get_moves($test), undef,
    "With bad board (not enough columns), get_moves returns an undef value.");

# --- bad board (too many lines)
$test = <<EOF
........
........
........
...BW...
...WB...
........
........
........
........
B
EOF
;

is( KataReversi::get_moves($test), undef,
    "With bad board (too many lines), get_moves returns an undef value.");

# --- bad board (too many columns)
$test = <<EOF
.........
.........
.........
....BW...
....WB...
.........
.........
.........
B
EOF
;

is( KataReversi::get_moves($test), undef,
    "With bad board (too many columns), get_moves returns an undef value.");

# --- bad player
$test = <<EOF
........
........
........
...BW...
...WB...
........
........
........
Q
EOF
;

is( KataReversi::get_moves($test), undef,
    "With bad player, get_moves returns an undef value.");

# --- bad player on the board
$test = <<EOF
........
........
........
...BZ...
...WB...
........
........
........
B
EOF
;

is( KataReversi::get_moves($test), undef,
    "With bad player on the board, get_moves returns an undef value.");

# --- empty board
$test = <<EOF
.........
.........
.........
.........
.........
.........
.........
.........
B
EOF
;

is( KataReversi::get_moves($test), undef,
    "With empty board, get_moves returns an empty array."); # = undef

# --- initial board, black player
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

@moves = qw(C5 D6 E3 F4);

isa_ok ( KataReversi::get_moves($test), 'ARRAY',
    "With good given value, get_moves(…) returns an array." );

is_deeply( KataReversi::get_moves($test), \@moves,
            "with the initial board, Black player can play in "
            . join('/', @moves));


# --- initial board, white player
$test = <<EOT
........
........
........
...BW...
...WB...
........
........
........
W
EOT
;

@moves = qw(C4 D3 E6 F5);

is_deeply( KataReversi::get_moves($test), \@moves,
            "with the initial board, White player can play in "
            . join('/', @moves));


# --- random board, white player
$test = <<EOT
........
........
...W.W..
..BBWB..
...WB...
........
........
........
W
EOT
;

@moves = qw(B3 B4 B5 E6 F5 G4);

is_deeply( KataReversi::get_moves($test), \@moves,
            "with a random board, White player can play in "
            . join('/', @moves));

