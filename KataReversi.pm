#! /usr/bin/perl

use warnings;
use strict;

package KataReversi;

sub get_moves {
    my $input = shift or return undef;
    return undef if ($input !~ m/^([\.BW]{8}\n){8}[BW]\n?$/);

    my @moves;

    my @lines = split(/\n/, $input);
    my $player = pop(@lines) or return undef;
    my @board = map {split(//, $_)} @lines;

    return undef if ($player !~ /[BW]/);

    my $i;
    my $j;

    for ($i = 0 ; $i < 8; $i++) {
        for ($j = 0 ; $j < 8; $j++) {
            if (can_play($i, $j, \@board, $player)) {
                push(\@moves, get_square_name($i,$j));
            }
        }
    }

    return \@moves;
}

# simulate a 2-dimensional array
sub at {
    my ($board, $i, $j) = @_;

    # $i : column, $j : line
    $$board[$i + $j * 8];
}

# check if $player can play on the square [$i,$j] on the $board.
sub can_play {
    my ($x, $y, $board, $player) = @_;

    my $other = ($player eq "B") ? "W" : "B";

    my $square = at($board, $x, $y);

    # check if the square is empty
    return 0 if ($square !~ /\./);

    # We check, for each direction (top-left, top, top-right, left, etc) if
    # there is one or more pieces of other players followed by one
    # piece of the current player. If so, the current player can play here.
    my $i;
    my $j;
    my $s = "";
    
    # top-left
    for ($i = $x, $j = $y; $i >= 0 && $j >= 0; $i--, $j--) {
        $s .= at($board, $i, $j);
    }
    return 1 if $s =~ m/^\.$other+$player/;
    $s = "";
    
    # top
    for ($i = $x, $j = $y; $j >= 0; $j--) {
        $s .= at($board, $i, $j);
    }
    return 1 if $s =~ m/^\.$other+$player/;
    $s = "";
    
    # top-right
    for ($i = $x, $j = $y; $i < 8 && $j >= 0; $i++, $j--) {
        $s .= at($board, $i, $j);
    }
    return 1 if $s =~ m/^\.$other+$player/;
    $s = "";
    
    # left
    for ($i = $x, $j = $y; $i >= 0; $i--) {
        $s .= at($board, $i, $j);
    }
    return 1 if $s =~ m/^\.$other+$player/;
    $s = "";
    
    # right
    for ($i = $x, $j = $y; $i < 8; $i++) {
        $s .= at($board, $i, $j);
    }
    return 1 if $s =~ m/^\.$other+$player/;
    $s = "";
    
    # bottom-left
    for ($i = $x, $j = $y; $i >= 0 && $j < 8; $i--, $j++) {
        $s .= at($board, $i, $j);
    }
    return 1 if $s =~ m/^\.$other+$player/;
    $s = "";
    
    # bottom
    for ($i = $x, $j = $y; $j < 8; $j++) {
        $s .= at($board, $i, $j);
    }
    return 1 if $s =~ m/^\.$other+$player/;
    $s = "";
     
    # bottom-right
    for ($i = $x, $j = $y; $i < 8 && $j < 8; $i++, $j++) {
        $s .= at($board, $i, $j);
    }
    return 1 if $s =~ m/^\.$other+$player/;
    $s = "";

    return 0;
}

# Return a square name, e.g. (0,0) -> A1, (2,3) -> B4.
sub get_square_name {
    my ($i, $j) = @_;
    return qw(A B C D E F G H)[$i] . ($j+1);
}

# return a true value
1;
