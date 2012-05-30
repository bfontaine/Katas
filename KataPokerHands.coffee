
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
                             .replace('%2', type_to_s(p[1].type[0], p[1].type[i]))

            else if (p[1].type[i] < p[2].type[i])
                return result.replace('%1', p[2].name)
                             .replace('%2', type_to_s(p[2].type[0], p[2].type[i]))

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
            suit = {'C':'clubs','D':'diamonds','H':'hearts','S':'spades'}[@suit]
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

    values.sort((v1,v2) -> v1<v2)#.reverse()

    # Straight Flush
    if (same_suit)
        # check if all cards have consecutive values
        if ([1..4].reduce (b, i) -> b && (values[i-1] - 1 == values[i]))
            return [8].concat(values)

        # Flush
        return [5].concat(values)

    # Four of a kind
    if ((values[0] == values[1] == values[2] == values[3]) ||
    (    values[1] == values[2] == values[3] == values[4]))
        return [7].concat(values)

    # Full House
    if (((values[0] == values[1]) && (values[2] == values[3] == values[4])) ||
    ((    values[0] == values[1] == values[2]) && (values[3] == values[4])))
        return [6].concat(values)


    # TODO

    # default type : high card
    [0].concat(values)


    #hand_types = [ 'high card', 'pair', 'two pairs', 'three of a kind', 'straight',
    #'flush', 'full house', 'four of a kind', 'straight flush' ]

exports.compare_hands = compare_hands
