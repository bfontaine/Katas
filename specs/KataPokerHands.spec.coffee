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

    it("should be a Tie", () ->
        expect(Poker.compare_hands('Black: 2C 4C 3C 6C 5C '+
                                   ' White: 2S 4S 3S 6S 5S')).toEqual('Tie.')
    )

    # == High Card == #
    
    it("should be a Black's winning with high card (9)", () ->
        expect(Poker.compare_hands('Black: 2H 3D 5S 9C KD '+
                                   ' White: 2C 3H 4S 8C KH')).toEqual('Black wins. - with high card: 9')
    )

    it("should be a White's winning, with high card (Ace)", () ->
        expect(Poker.compare_hands('Black: 2H 3D 5S 9C KD '+
                                   ' White: 2C 3H 4S 8C AH')).toEqual('White wins. - with high card: Ace')
    )

    # == Straight == #
    
    it("should be a Black's winning, with straight (2-6)", () ->
        expect(Poker.compare_hands('Black: 2C 4C 3H 6C 5C '+
                                   ' White: 2S 8S KD QS 3S')).toEqual('Black wins. - with flush')
    )
    
    it("should be a White's winning, with straight (9-K)", () ->
        expect(Poker.compare_hands('Black: 2H 4C 3S 6C 5C '+
                                   ' White: 9C JS TD QS KS')).toEqual('White wins. - with flush')
    )
    
    # == Flush == #
    
    it("should be a White's winning, with flush (S)", () ->
        expect(Poker.compare_hands('Black: 3H 4S 4C 2D 4H '+
                                   ' White: 2S 8S AS QS 3S')).toEqual('White wins. - with flush')
    )

    it("should be a White's winning, with flush (H)", () ->
        expect(Poker.compare_hands('Black: 5H 4H 7H 2H KH '+
                                   ' White: 9H 8H AH QH 3H')).toEqual('White wins. - with flush')
    )
    
    it("should be a Black's winning, with flush (C)", () ->
        expect(Poker.compare_hands('Black: 2C 4C 8C 9C 3C '+
                                   ' White: 2S 8S AC QS 3S')).toEqual('Black wins. - with flush')
    )

    # == Full House == #
    
    it("should be a Black's winning, with full house (2,2,2,4,4)", () ->
        expect(Poker.compare_hands('Black: 2C 2S 2D 4D 4H '+
                                   ' White: 4S 8S 3C QS 5S')).toEqual('Black wins. - with full house')
    )

    # == Four Of A Kind == #
    
    it("should be a Black's winning, with four of a kind (2)", () ->
        expect(Poker.compare_hands('Black: 2C 2S 3C 2D 2H '+
                                   ' White: 4S 8S KC QS 5S')).toEqual('Black wins. - with four of a kind')
    )
    
    it("should be a White's winning, with four of a kind (4)", () ->
        expect(Poker.compare_hands('Black: 2C 2S 3C 2D 2H '+
                                   ' White: 4S 4C 4H 4D 5S')).toEqual('White wins. - with four of a kind')
    )

    # == Straight Flush == #
    
    it("should be a Black's winning, with straight flush (C)", () ->
        expect(Poker.compare_hands('Black: 2C 4C 3C 6C 5C '+
                                   ' White: 2S 8S KC QS 3S')).toEqual('Black wins. - with straight flush')
    )
    
    it("should be a White's winning, with straight flush (S)", () ->
        expect(Poker.compare_hands('Black: 2C 4C 3C 6C 5C '+
                                   ' White: 3S 5S 4S 6S 7S')).toEqual('White wins. - with straight flush')
    )
    
)
