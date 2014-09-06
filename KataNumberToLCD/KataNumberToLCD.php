<?php

function number_to_LCD($nb) {

    $nbs = array (
                    0 => array(" _ ",
                               "| |",
                               "|_|"),

                    1 => array("   ",
                               "  |",
                               "  |"),

                    2 => array(" _ ",
                               " _|",
                               "|_ "),

                    3 => array(" _ ",
                               " _|",
                               " _|"),

                    4 => array("   ",
                               "|_|",
                               "  |"),

                    5 => array(" _ ",
                               "|_ ",
                               " _|"),

                    6 => array(" _ ",
                               "|_ ",
                               "|_|"),

                    7 => array(" _ ",
                               "| |",
                               "  |"),

                    8 => array(" _ ",
                               "|_|",
                               "|_|"),

                    9 => array(" _ ",
                               "|_|",
                               " _|")
                 );

    // simple cases
    if (array_key_exists($nb, $nbs)) {
        return join("\n", $nbs[$nb]);
    }

    // cases with $nb >= 10

    // returned lines
    $lines = array( '', '', '');

    $digits = str_split(''.$nb);

    foreach ($digits as $k => $digit) {
        for ($i=0;$i<3;$i++) {
            if ($lines[$i] != '') { $lines[$i] .= ' '; }

            $lines[$i] .= $nbs[(int)$digit][$i];
        }
    } 

    return join("\n", $lines);
}

?>
