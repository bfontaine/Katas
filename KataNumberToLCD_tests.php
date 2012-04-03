<?php

require_once "KataNumberToLCD.php";

$tests = array( 0 =>      " _ \n".
                          "| |\n".
                          "|_|",

                1 =>      "   \n".
                          "  |\n".
                          "  |",

                7 =>      " _ \n".
                          "| |\n".
                          "  |",

                8 =>      " _ \n".
                          "|_|\n".
                          "|_|",

                34 =>     " _     \n".
                          " _| |_|\n".
                          " _|   |",

                89 =>     " _   _ \n".
                          "|_| |_|\n".
                          "|_|  _|",

                123789 => "     _   _   _   _   _ \n".
                          "  |  _|  _| | | |_| |_|\n".
                          "  | |_   _|   | |_|  _|",

                31415 =>  " _               _ \n".
                          " _|   | |_|   | |_ \n".
                          " _|   |   |   |  _|"
              );

$fails = 0;
foreach ($tests as $param => $expected) {
    $value = number_to_LCD($param);

    if ($value !== $expected) {
        echo("[FAIL] Expected:\n".$expected."\nGot:\n".$value."\n");
        $fails++;
    } else {
        echo("[OK]\n");
    }
}
echo(count($tests)." tests: ".(count($tests)-$fails)." ok, and $fails failed.\n");
?>
