
TestCase subclass: KataSecretSantasTestCase [

    | kss |

    setUp [
        kss := KataSecretSantas new.
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
        | p1 p2 |
        
        p1 := Person new.
        p2 := Person new.

        p1 setFirstName: 'Chuck'
         ; setLastName:  'Norris'
         ; setEmail:     '<ch@ck.nr>'.

        p2 setFirstName: 'Chuck'
         ; setLastName:  'Noris'
         ; setEmail:     '<ch@ck.nr>'.

        self assert: (p1 sameFamily: p2) = false.
    ]

    testSameFamily [
        | p1 p2 |
        
        p1 := Person new.
        p2 := Person new.

        p1 setFirstName: 'Chuck'
         ; setLastName:  'Norris'
         ; setEmail:     '<ch@ck.nr>'.

        p2 setFirstName: 'FooBar'
         ; setLastName:  'Norris'
         ; setEmail:     '<foob@r.nr>'.

        self assert: (p1 sameFamily: p2) = true.
    ]

    testSamePerson [
        | p1 p2|

        p1 := Person new.
        p2 := Person new.

        p1 setFirstName: 'Chuck'
         ; setLastName:  'Norris'
         ; setEmail:     '<ch@ck.nr>'.

        p2 setFirstName: 'Chuck'
         ; setLastName:  'Norris'
         ; setEmail:     '<ch@ck.nr>'.

        self assert: (p1 = p2) = true.
    ]

    testNotSamePerson [
        | p1 p2|

        p1 := Person new.
        p2 := Person new.

        p1 setFirstName: 'Chuck'
         ; setLastName:  'Norris'
         ; setEmail:     '<ch@ck.nr>'.

        p2 setFirstName: 'FakeChuck'
         ; setLastName:  'Norris'
         ; setEmail:     '<ch@ck.nr>'.

        self assert: (p1 = p2) = false.
    ]

    " TODO "

]
