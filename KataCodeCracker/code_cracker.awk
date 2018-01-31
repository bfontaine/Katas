#!/usr/bin/env awk -f

# Usage:
#
#  $ awk -f code_cracker.awk -v key=<decryption key> [-v debug=1 ] [<your file>]
#
# See http://codingdojo.org/kata/CodeCracker/. The key must be 26-chars long.

BEGIN {
  split("abcdefghijklmnopqrstuvwxyz", alphabet_chars, "")
  split(key, key_chars, "")

  size = length(alphabet_chars)

  for (k = 1; k<=size; k++) {
    table[key_chars[k]] = alphabet_chars[k]
  }
}

{
  split($0, line_chars, "")
  size = length(line_chars)
  for (k = 1; k<=size; k++) {
    printf("%c", table[ line_chars[k] ])
  }
  print ""
}
