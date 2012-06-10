
TestCase subclass: KataSecretSantasTestCase [

    | kss chuck_norris foo_bar |

    setUp [
        kss := KataSecretSantas new.

        chuck_norris := Person new.
        chuck_norris setFirstName: 'Chuck'
                   ; setLastName:  'Norris'
                   ; setEmail:     '<ch@ck.nr>'.

        foo_bar := Person new.
        foo_bar setFirstName: 'Foo'
              ; setLastName:  'Bar'
              ; setEmail:     '<foob@r.com>'.
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
        self assert: (foo_bar canBeSantaOf: chuck_norris) = true.
        self assert: (chuck_norris canBeSantaOf: foo_bar) = true.
    ]

    " make Santas "

    testOnePersonneSanta [
        | s santas |
        s := Set new.
        s add: chuck_norris.

        kss setPersons: s.

        santas := kss makeSantas.

        self assert: (santas isNil) = true.
    ]

    testTwoPersonnesSantasOk [
        | s santas |
        
        s := Set new.
        s add: chuck_norris.
        s add: foo_bar.

        kss setPersons: s.

        santas := kss makeSantas.

        self assert: (santas isNil) = false.
        self assert: (santas size) = 2.
        self assert: (santas at: chuck_norris) = foo_bar.
        self assert: (santas at: foo_bar) = chuck_norris.
    ]

    testTwoPersonnesSantasNotOk [
        | s santas |

        foo_bar setLastName: (chuck_norris getLastName).

        s := Set new.
        s add: chuck_norris.
        s add: foo_bar.

        kss setPersons: s.

        santas := kss makeSantas.

        self assert: (santas isNil) = true.
    ]

    testFourPersonnesSantasOk [
        | s santas fb2 cn2 |

        " foo_bar and fb2 are from same family "
        fb2 := foo_bar copy.
        fb2 setFirstName: 'Fooo'.

        " chuck_norris and cn2 are from same family "
        cn2 := chuck_norris copy.
        cn2 setFirstName: 'Chuckk'.

        s := Set new.
        s add: chuck_norris.
        s add: foo_bar.
        s add: cn2.
        s add: fb2.

        kss setPersons: s.

        santas := kss makeSantas.

        self assert: (santas isNil) = false.
        self assert: (santas size) = 4.
    ]

    testThreePersonnesSantasOk [
        | s santas p |

        p := Person new.
        p setFirstName: 'Mike'
        ; setLastName: 'Ymouse'
        ; setEmail: 'mm@disn.ey'.

        s := Set new.
        s add: chuck_norris.
        s add: foo_bar.
        s add: p.

        kss setPersons: s.

        santas := kss makeSantas.

        self assert: (santas isNil) = false.
        self assert: (santas size) = 3.
    ]

    testThreePersonnesSantasNotOk [
        | s santas p |

        p := Person new.
        p setFirstName: 'Mike'
        ; setLastName: (chuck_norris getLastName)
        ; setEmail: 'mm@disn.ey'.

        s := Set new.
        s add: chuck_norris.
        s add: foo_bar.
        s add: p.

        kss setPersons: s.

        santas := kss makeSantas.

        self assert: (santas isNil) = true.
    ]

    testSevenPersonsParseAndMakeSantasOk [
        | str santas |

        str := ('Luke Skywalker   <luke@theforce.net>\n',
                'Leia Skywalker   <leia@therebellion.org>\n',
                'Toula Portokalos <toula@manhunter.org>\n',
                'Gus Portokalos   <gus@weareallfruit.net>\n',
                'Bruce Wayne      <bruce@imbatman.com>\n',
                'Virgil Brigman   <virgil@rigworkersunion.org>\n',
                'Lindsey Brigman  <lindsey@iseealiens.net>').

        kss parseNamesList: str.

        santas := kss makeSantas.

        self assert: (kss getPersons size) = 7.
        self assert: (santas isNil) = false.
        self assert: (santas size) = 7.
    ]
]
