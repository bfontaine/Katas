
hand_types = [ 'high card', 'pair', 'two pairs', 'three of a kind', 'straight',
'flush', 'full house', 'four of a kind', 'straight flush' ]

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

    # same type
    if (p[1].type[0] == p[2].type[0])
        # check if all cards have same values
        # or apply the 'highest card' rule
        for i in [1..5]
            if (p[1].type[i] > p[2].type[i])
                return result.replace('%1', p[1].name)
                             .replace('%2', type_to_s(p[1].type[0],
                                                      p[1].type[i]))

            else if (p[1].type[i] < p[2].type[i])
                return result.replace('%1', p[2].name)
                             .replace('%2', type_to_s(p[2].type[0],
                                                      p[2].type[i]))

            return 'Tie.' if (i == 5)

    else if (p[1].type[0] > p[2].type[0])
        return result.replace('%1', p[1].name)
                     .replace('%2', type_to_s(p[1].type[0]))

    else
        return result.replace('%1', p[2].name)
                     .replace('%2', type_to_s(p[2].type[0]))



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

        value_s: () -> value_s(@value)

        to_s: () ->
            suit = {C:'clubs', D:'diamonds', H:'hearts', S:'spades'}[@suit]
            "#{value_s} of #{suit}"
    
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

# Return a string representation of the given card value
value_to_s = (value) ->
    return '' + value if (value <= 10)
    {11:'Jack',12:'Queen',13:'King',14:'Ace'}[value]

# Return a string representation of the given type, with
# a card value if the type is 0 (= high card)
type_to_s = (type, val) ->
    return hand_types[type] if (type > 0)
    hand_types[type] + ': ' + value_to_s(val)


# Return the maximal hand type found in an hand. This is a numbers Array,
# the first one is the indice of the type in `hand_types`, and the following
# ones are cards values ordered by importance.
# Example for a 'Four of a kind' of Aces : [ 7, 14, 14, 14, 14, … ]
get_hand_type = (hand) ->

    same_suit = has_unique_suit(hand)

    # hand's cards values
    values = hand.map (card) -> card.value

    values.sort((v1,v2) -> v1<v2)

    has_consecutive_values =
        ([1..4].reduce (b, i) -> b && (values[i-1] - 1 == values[i]))

    # Straight Flush
    if (same_suit)
        # check if all cards have consecutive values
        return [8].concat(values) if (has_consecutive_values)

        # Flush
        return [5].concat(values)

    # Four of a kind
    if (values[0] == values[1] == values[2] == values[3])
        return [7].concat(values)

    if (values[1] == values[2] == values[3] == values[4])
        return [7].concat(values.slice(1)).concat([values[0]])

    # Full House
    if ((values[0] == values[1]) && (values[2] == values[3] == values[4]))
        return [6].concat(values.slice(2)).concat(values.slice(0,2))
    
    if ((values[0] == values[1] == values[2]) && (values[3] == values[4]))
        return [6].concat(values.slice(0,3)).concat(values.slice(3))

    # Straight
    if (has_consecutive_values)
        return [4].concat(values)

    # Three of a kind
    if (values[0] == values[1] == values[2])
        return [3].concat(values)
    
    if (values[1] == values[2] == values[3])
        return [3].concat(values.slice(1,4)).concat([values[0], values[4]])
    
    if (values[2] == values[3] == values[4])
        return [3].concat(values.slice(2)).concat(values.slice(0,2))
    
    paires = []
    for i1 in [0..4]
        for i2 in [0..4]
            continue if (i1 == i2)
            if ((values[i1] == values[i2]) && !paires.some((e) -> e == values[i1]))
                # keep only the value
                paires.push(values[i1])

    if (paires.length > 0)

        # Two pairs
        if (paires.length == 2)
            remaining = -1
            for v in values
                remaining = v if ((v != paires[0]) && (v != paires[1]))

            [p1,p2] = [[],[]]
            
            if (paires[0] > paires[1])
                [p1,p2] = paires[0..1]
            else
                [p2,p1] = paires[0..1]

            return [2].concat([p1,p1]).concat([p2,p2]).concat(remaining)

        # One pair
        p1 = paires[0]
        remainings = []
        for v in values
            remainings.push(v) if (v != paires[0])

        remainings.sort((a,b) -> a<b)

        return [1].concat([p1,p1]).concat(remainings)


    # High card
    [0].concat(values)


    #hand_types = [ 'high card', 'pair', 'two pairs', 'three of a kind',
    #'straight','flush', 'full house', 'four of a kind', 'straight flush' ]

exports.compare_hands = compare_hands
