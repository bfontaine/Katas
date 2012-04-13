KataPokerHands = require('./KataPokerHands')
assert         = require('assert')

tests = [   # [input, expected output]

            # - given tests -

            ['Black: 2H 3D 5S 9C KD  White: 2C 3H 4S 8C AH',
                'White wins. - with high card: Ace'],

            ['Black: 2H 4S 4C 2D 4H  White: 2S 8S AS QS 3S',
                'White wins. - with flash'],

            ['Black: 2H 3D 5S 9C KD  White: 2C 3H 4S 8C KH',
                'Black wins. - with high card: 9'],

            ['Black: 2H 3D 5S 9C KD  White: 2D 3H 5C 9S KH',
                'Tie.']
]

len = tests.length
fails = 0

console.log("Running #{len} tests…")

for [input,expected_output] in tests
    output = KataPokerHands.compare_hands(input)
    try
        assert.equal(output, expected_output)
    catch AssertionError
        console.log("'#{input}' -> '#{output}', expected '#{expected_output}'")
        fails++

console.log "#{len} tests done.\n#{((len-fails)/len*100)}% OK\n#{(fails/len*100)}% failed"
