
TestCase subclass: KataSecretSantasTestCase [

    | kss chuck_norris |

    setUp [
        kss := KataSecretSantas new.

        chuck_norris := Person new.
        chuck_norris setFirstName: 'Chuck'
                   ; setLastName:  'Norris'
                   ; setEmail:     '<ch@ck.nr>'.
    ]

    testNobody [
        self assert: (kss getPersons isNil).
    ]

    " Parsing "

    testParseOneName [
        kss parseNamesList: 'Foo Bar <foobar@aol.com>'.

        self assert: (kss getPersons size) = 1.
    ]

    testParseOneNameWithLotOfSpaces [
        | p |
        
        kss parseNamesList: 'Foo     Bar      <foobar@aol.com>'.

        self assert: (kss getPersons size) = 1.

        p := kss getPersons asArray at: 1.

        self assert: (p getFirstName = 'Foo')
           ; assert: (p getLastName  = 'Bar')
           ; assert: (p getEmail     = '<foobar@aol.com>').
    ]

    testParseTwoNames [
        kss parseNamesList: 'Bar Foo <barfoo@aol.com>\nChuck Norris <ch@ck.nr>'.

        self assert: (kss getPersons size) = 2.
    ]

    " Persons "

    testNotSameFamily [
        | p |
        
        p := Person new.

        p setFirstName: 'Chuck'
        ; setLastName:  'Noris'
        ; setEmail:     '<ch@ck.nr>'.

        self assert: (chuck_norris sameFamily: p) = false.
        self assert: (p sameFamily: chuck_norris) = false.
    ]

    testSameFamily [
        | p |
        
        p := Person new.

        p setFirstName: 'FooBar'
        ; setLastName:  (chuck_norris getLastName)
        ; setEmail:     '<foob@r.nr>'.

        self assert: (p sameFamily: chuck_norris) = true.
        self assert: (chuck_norris sameFamily: p) = true.
    ]

    testSamePerson [
        | p |

        p := Person new.

        p setFirstName: (chuck_norris getFirstName)
        ; setLastName:  (chuck_norris getLastName)
        ; setEmail:     (chuck_norris getEmail).

        self assert: (p = chuck_norris) = true.
        self assert: (chuck_norris = p) = true.
        self assert: (p = p) = true.
    ]

    testNotSamePerson [
        | p |

        p := Person new.

        p setFirstName: 'FakeChuck'
        ; setLastName:  'Norris'
        ; setEmail:     '<ch@ck.nr>'.

        self assert: (p = chuck_norris) = false.
        self assert: (chuck_norris = p) = false.
    ]

    testCannotBeSantaOf [
        | p |

        p := Person new.

        p setFirstName: (chuck_norris getFirstName)
        ; setLastName:  (chuck_norris getLastName)
        ; setEmail:     (chuck_norris getEmail).

        self assert: (p canBeSantaOf: chuck_norris) = false.
        self assert: (chuck_norris canBeSantaOf: p) = false.
        self assert: (p canBeSantaOf: p) = false.

        p setFirstName: 'Foo'
        ; setEmail: '<foob@r.com>'.

        self assert: (p canBeSantaOf: chuck_norris) = false.
        self assert: (chuck_norris canBeSantaOf: p) = false.
    ]

    testCanBeSantaOf [
        | p |

        p := Person new.

        p setFirstName: 'Foo'
        ; setLastName:  'Bar'
        ; setEmail:     '<foob@r.com>'.

        self assert: (p canBeSantaOf: chuck_norris) = true.
        self assert: (chuck_norris canBeSantaOf: p) = true.
    ]

    " TODO "

]
