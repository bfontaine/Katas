<?php

function number_to_LCD($nb) {

    $nbs = array (
                    0 => " _ \n".
                         "| |\n".
                         "|_|",

                    1 => "   \n".
                         "  |\n".
                         "  |"
                 );

    if (in_array($nb, $nbs)) {
        return $nbs[$nb];
    }

}

?>
