0100 REM KataSortChars in Commodore BASIC
0110 REM --------------------------------
0120 REM
0130 REM Goal: read a string on stdin and output its sorted chars. It should
0140 REM       ignore punctuation and map upper case to lower case.
0150 REM
0160 REM See: http://codekata.com/kata/kata11-sorting-it-out/
0170 REM
0180 T$=""
0190 T2$=""
0200 INPUT T$
0210 L% = LEN(T$)
0220 REM part 1: strip punctuation
0230 FOR I=1 TO L%
0240 CH$ = MID$(T$,I,1)
0250 C% = ASC(CH$)
0260 REM if non-alphanumeric
0270 IF (C% < 65 OR C% > 122) AND (C% < 48 OR C% > 57) THEN 310
0280 REM convert to uppercase
0290 IF C% >= 65 AND C% <= 90 THEN C% = C% + 32
0300 T2$ = T2$ + CHR$(C%)
0310 NEXT I
0320 REM part 2: sort
0330 S$ = ""
0340 L% = LEN(T2$)
0349 REM loop on alphanumeric characters
0350 FOR CI = 48 TO 122
0360 REM jump between "9" and "a"
0370 IF CI = 58 THEN CI = 97
0379 REM loop on string characters
0380 FOR I=1 TO L%
0390 CH$ = MID$(T2$,I,1)
0399 REM add a char to the output if it's in the string
0400 IF CH$ = CHR$(CI) THEN S$ = S$ + CH$
0410 NEXT I
0420 NEXT CI
0429 REM sorted string
0430 PRINT S$
