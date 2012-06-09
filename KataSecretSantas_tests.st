
TestCase subclass: KataSecretSantasTestCase [

    | kss |

    setUp [
        kss := KataSecretSantas new.
    ]

    testNobody [
        self assert: (kss getPersons isNil).
    ]

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

    " TODO "

]
