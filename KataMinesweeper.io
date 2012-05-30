#! /usr/local/bin/io

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
        s map(join) join("\n")
    )

    # add hints to a mines array
    addHints := method (a,
        a #TODO
    )
)
