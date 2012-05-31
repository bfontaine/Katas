#! /usr/local/bin/io

# cheat
nil at := method(e, nil)

KataMinesweeper := Object clone do (

    # transform a mines list into a sequence
    listFromSequence := method (a,
    
        lines := a split("\n")

        # remove first line
        lines removeAt(0)

        lines map (asList)
    )

    # transform a sequence into a mines list
    sequenceFromList := method (s,
        if (s isNil, return "")
        s map(join) join("\n")
    )

    # add hints to a mines array
    addHints := method (a,

        for (i, 0, a size - 1,

            for (j, 0, a at(0) size - 1,

                if (a at(i) at(j) == ".",
                    n := 0
                    li := List clone with(i-1, i, i+1)
                    lj := List clone with(j-1, j, j+1)

                    li foreach(i2,
                        lj foreach(j2,
                            if (a at(i2) at(j2) == "*",
                                n = n+1
                            )
                        )
                    )
                    a at(i) atPut(j, n asString)
                ) 
            )
        )
        a
    )
)
