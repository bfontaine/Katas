Poker = require('../KataPokerHands')

describe('Result', () ->

    # == Null == #

    it('should be null for bad input', () ->
        expect(Poker.compare_hands('bad hands input')).toEqual(null)
    )

    it('should be null for bad card suits', () ->
        expect(Poker.compare_hands('Black: 2X 3D 5S 9C KD '+
                                   ' White: 2A 3H 5C 9S KH')).toEqual(null)
    )

    it('should be null for bad card values', () ->
        expect(Poker.compare_hands('Black: 1H 3D 5S 9C KD '+
                                   ' White: 2D 3H 5C 9S KH')).toEqual(null)
    )
    
    it('should be null if too many cards for black player', () ->
        expect(Poker.compare_hands('Black: 1H 3D 5S 9C KS KC KD '+
                                   ' White: 2D 3H 5C 9S KH')).toEqual(null)
    )
    
    it('should be null if too many cards for white player', () ->
        expect(Poker.compare_hands('Black: 1H 3D 5S 9C KD '+
                                   ' White: 2D 3H 2H 5C 9S KH')).toEqual(null)
    )

    # == Tie == #

    it('should be tie', () ->
        expect(Poker.compare_hands('Black: 2H 3D 5S 9C KD '+
                                   ' White: 2D 3H 5C 9S KH')).toEqual('Tie.')
    )

    # == High card == #
    
    it("should be a Black's winning with high card: 9", () ->
        expect(Poker.compare_hands('Black: 2H 3D 5S 9C KD '+
                                   ' White: 2C 3H 4S 8C KH')).toEqual('Black wins. - with high card: 9')
    )

    it("should be a White's winning, with high card: Ace", () ->
        expect(Poker.compare_hands('Black: 2H 3D 5S 9C KD '+
                                   ' White: 2C 3H 4S 8C AH')).toEqual('White wins. - with high card: Ace')
    )
    
    # == Flush == #
    
    it("should be a White's winning, with flush", () ->
        expect(Poker.compare_hands('Black: 2H 4S 4C 2D 4H '+
                                   ' White: 2S 8S AS QS 3S')).toEqual('White wins. - with flush')
    )

    it("should be a White's winning, with flush", () ->
        expect(Poker.compare_hands('Black: 5S 4S 7S 2S KS '+
                                   ' White: 9S 8S AS QS 3S')).toEqual('White wins. - with flush')
    )
    
    it("should be a Black's winning, with flush", () ->
        expect(Poker.compare_hands('Black: 2C 4C 8C 9C 3C '+
                                   ' White: 2S 8S AC QS 3S')).toEqual('Black wins. - with flush')
    )

    # == Straight Flush == #
    
    it("should be a Black's winning, with straight flush", () ->
        expect(Poker.compare_hands('Black: 2C 4C 3C 6C 5C '+
                                   ' White: 2S 8S KC QS 3S')).toEqual('Black wins. - with straight flush')
    )
)
