#! /usr/bin/perl

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
                push(get_square_name($i,$j), @moves);
            }
        }
    }

    return \@moves;
}

# check if $player can play on the square [$i,$j] on the $board.
sub can_play {
    my ($x, $y, @board, $player) = $_;

    return 0 if ($$board[$x][$y] !~ /\./);

    # TODO

    return 0;
}

# Return a square name, e.g. (0,0) -> A1, (2,3) -> B4.
sub get_square_name {
    my ($i, $j) = $_;

    return qw(A B C D E F G H)[$i] . ($j+1);
}

# return a true value
1;
