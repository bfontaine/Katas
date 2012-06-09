
TestCase subclass: KataSecretSantasTestCase [

    | kss |

    setUp [
        kss := KataSecretSantas new
    ]

    testNobody [
        self assert: (kss getPersons isNil)
    ]

    testParseOneName [
        kss parseNamesList: 'Foo Bar <foobar@aol.com>'.

        self assert: (kss getPersons size) = 1
    ]

    " TODO "

]
