#! /usr/local/bin/io

tests := Map clone do (

    atPut("empty 0x0",
            List clone with("0 0" .. "",
                                     "")
    )

    atPut("empty 1x1",
            List clone with("1 1\n" .. ".",
                                       "0")
    )

    atPut("normal 1x1",
            List clone with("1 1\n" .. "*",
                                       "*")
    )

    atPut("normal 4x4 with 2 mines",
            List clone with("4 4\n" .. "*...\n....\n.*..\n....",
                                       "*100\n2210\n1*10\n1110")
    )
    
    atPut("normal 3x5 with 3 mines",
            List clone with("3 5\n" .. "**...\n.....\n.*...",
                                       "**100\n33200\n1*100")
    )

)

km := KataMinesweeper clone

tests foreach(k,v,
     actual := km sequenceFromList(km addHints(km listFromSequence(v at(0))))
     expected := v at(1)

     ut := UnitTest clone

     if ( actual != expected,
            ut fail(k .. ": fail! expected:\n" .. expected .. "\nactual:\n" .. actual .. "\n"),
            k .. ": ok." println
     )
)
