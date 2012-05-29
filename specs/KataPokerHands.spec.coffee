Poker = require('../KataPokerHands')

describe('Result', () ->

    it('should be null', () ->
        # bad input
        expect(Poker.compare_hands('bad hands input')).toEqual(null)
        # bad cards
        expect(Poker.compare_hands('Black: 2X 3D 5S 9C KD '+
                                   ' White: 2A 3H 5C 9S KH')).toEqual(null)
        expect(Poker.compare_hands('Black: 1H 3D 5S 9C KD '+
                                   ' White: 2D 3H 5C 9S KH')).toEqual(null)
    )

    it('should be tie', () ->
        expect(Poker.compare_hands('Black: 2H 3D 5S 9C KD '+
                                   ' White: 2D 3H 5C 9S KH')).toEqual('Tie.')
    )

    it("should be a White's winning, with high card: Ace", () ->
        expect(Poker.compare_hands('Black: 2H 3D 5S 9C KD '+
                                   ' White: 2C 3H 4S 8C AH')).toEqual('White wins. - with high card: Ace')
    )
    
    it("should be a White's winning, with flask", () ->
        expect(Poker.compare_hands('Black: 2H 4S 4C 2D 4H '+
                                   ' White: 2S 8S AS QS 3S')).toEqual('White wins. - with flash')
    )
    
    it("should be a Black's winning with high card: 9", () ->
        expect(Poker.compare_hands('Black: 2H 3D 5S 9C KD '+
                                   ' White: 2C 3H 4S 8C KH')).toEqual('Black wins. - with high card: 9')
    )

)
