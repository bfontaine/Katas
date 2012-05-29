
hand_types = [ 'High Card', 'Pair', 'Two Pairs', 'Three of a Kind', 'Straight',
'Flush', 'Full House', 'Four of a kind', 'Straight Flush' ]

compare_hands = (s) ->

    regex_hand = /([A-Z]\w+): ((?:[2-9TJQKA][CDHS] ?)+)/g

    p1 = regex_hand.exec(s)
    p2 = regex_hand.exec(s)

    return null if !p1? || !p2?

    p = [null, {}, {}] # players 1 and 2

    [p[1].name, p[1].hand] = p1.slice(1)
    [p[2].name, p[2].hand] = p2.slice(1)

    for i in [1, 2]
        p[i].hand = parse_hand(p[i].hand)
        p[i].type = get_hand_type(p[i].hand)

    result = '%1 wins. - with %2'

    if (p[1].type[0] == p[2].type[0])
        # check if all cards have same values
        # TODO refactor, and set the result type (e.g. 'high card: 9')
        for i in [1..5]
            return [p[1], p[2]]
            if (p[1].type[i].value > p[2].type[i].value)
                result.replace('%1', p[1].name)
                break
            else if (p[1].type[i].value < p[2].type[i].value)
                result.replace('%1', p[2.name])
                break

            return 'Tie.' if (i == 5)




# Parse a string describing a hand ("XX XX XX XX XX") and
# return a Card Array. Each Card has two attributes: suit (C, D, H or S), and
# value (2-14)
parse_hand = (s) ->

    class Card
        constructor: (str) ->
            [value, @suit] = str
            if (/\d/.test(value))
                @value = +value
            else
                @value = 'TJQKA'.indexOf(value) + 10

        to_s: () ->
            suit = {'C':'clubs','D':'diamonds','H':'hearts','S':'spades'}[@suit]
            value = @value
            if (@value > 10)
                value = {11:'Jack',12:'Queen',13:'King',14:'Ace'}[@value]

            "#{value} of #{suit}"
    
    cards = []
    for card in s.split(' ')
        cards.push(new Card(card)) if (card != '')

    cards

# return true if all cards of the given hand are of the same suit, else false
has_unique_suit = (hand) ->
    suit = hand[0].suit

    for card in hand[1..]
        return false if card.suit != suit

    true


# Return the maximal hand type found in an hand. This is a numbers Array,
# the first one is the indice of the type in `hand_types`, and the following
# ones are cards values ordered by importance.
# Example for a 'Four of a kind' of Aces : [ 7, 14, 14, 14, 14, … ]
get_hand_type = (hand) ->

    same_suit = has_unique_suit(hand)

    # sort the hand by values
    hand.sort (a, b) -> a.value < b.value

    # hand's cards values
    values = hand.map (card) -> card.value

    # Straight Flush
    if (same_suit)
        # check if all cards have consecutive values
        if (!![1..4].reduce (b, i) -> b & (hand[i-1].value + 1 == hand[i].value))
            return [7].concat(values)

    # TODO

    # default type : high card
    [0].concat(values)


    #renamining hand_types : [ 'High Card', 'Pair', 'Two Pairs', 'Three of a Kind', 'Straight',
    #'Flush', 'Full House', 'Four of a kind' ]

exports.compare_hands = compare_hands
