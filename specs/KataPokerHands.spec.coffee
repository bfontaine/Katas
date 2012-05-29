Poker = require('../KataPokerHands')

describe('should be tie', () ->
    expect(Poker.compare_hands('Black: 2H 3D 5S 9C KD '
                              +' White: 2D 3H 5C 9S KH')).toEqual('Tie.')
)

describe('White should win with high card: Ace', () ->
    expect(Poker.compare_hands('Black: 2H 3D 5S 9C KD '
                              +' White: 2C 3H 4S 8C AH')).toEqual('White wins. - with high card: Ace')
)

describe('White should win with flask', () ->
    expect(Poker.compare_hands('Black: 2H 4S 4C 2D 4H '
                              +' White: 2S 8S AS QS 3S')).toEqual('White wins. - with flash')
)

describe('Black should win with high card: 9', () ->
    expect(Poker.compare_hands('Black: 2H 3D 5S 9C KD '
                              +' White: 2C 3H 4S 8C KH')).toEqual('Black wins. - with high card: 9')
)
