
Object subclass: Person [

    | firstName lastName email |

    setFirstName: fn [ firstName := fn. ]
    getFirstName     [ ^firstName ]

    setLastName: ln [ lastName := ln. ]
    getLastName     [ ^lastName ]

    setEmail: e [ email := e. ]
    getEmail    [ ^email ]

    = other [
        (other class = Person) ifTrue: [
            (self getFirstName = other getFirstName) ifTrue: [
                (self getLastName = other getLastName) ifTrue: [
                    ^(self getEmail = other getEmail)      
                ].
            ].
        ].
        ^false.
    ]

    sameFamily: other [ ^(self getLastName = other getLastName) ]

    canBeSantaOf: other [
        (self sameFamily: other) ifFalse: [ ^(self ~= other) ].
        ^false.
    ]

    Person class >> fromString: str [
        | p arr el |

        p := Person new.

        arr := str tokenize: ' '.

        1 to: (arr size) do: [ :i |

            el := arr at: i.
        
            " for each non-empty element"
            (el ~= '') ifTrue: [
                
                " if firstName is nil, we set it"
                (p getFirstName isNil) ifTrue: [
                    p setFirstName: el.
                ]
                ifFalse: [
                    " else if lastName is nil, we set it"
                    (p getLastName isNil) ifTrue: [
                        p setLastName: el.
                    ]
                    ifFalse: [
                        " else if email is nil, we set it"
                        (p getEmail isNil) ifTrue: [
                            p setEmail: el.
                        ]
                    ]
                ]
            ]
        ].
        ^p
    ]
]

Object subclass: KataSecretSantas [

   | persons | 

   setPersons: p [ persons := p. ]
   getPersons    [ ^persons ]

   parseNamesList: str [
        | p lines |

        p := self getPersons.
        lines := str tokenize: '\\n'.

        (p isNil) ifTrue: [ p := Set new ].

        lines collect: [ :l |
            p add: (Person fromString: l).
        ].

        self setPersons: p.
   ]

   makeSantas [
        | santas |

        santas := Dictionary new.
        
        persons collect: [ :p1 |
            
            santas at: p1 put: nil.

            persons collect: [ :p2 |
                " if p2 does not already have a Santa "
                (santas values includes: p2) ifFalse: [
                    " if p1 can be Santa of p2 "
                    (p1 canBeSantaOf: p2) ifTrue: [
                        santas at: p1 put: p2.
                    ].
                ].
            ].

        ].

        " if not everybody is someone's Santa "
        (santas values includes: nil) ifTrue: [ ^nil ].

        ^santas
   ]

]
