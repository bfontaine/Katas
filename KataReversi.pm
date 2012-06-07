#! /usr/bin/perl

package KataReversi;

sub get_moves {
    my $input = shift or return undef;
    return undef if ($input !~ m/^([\.BW]{8}\n){8}[BW]\n?$/);

    return [42];
}

# return a true value
1;
