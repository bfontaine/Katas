
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

    p[1].hand = parse_hand(p[1].hand)
    p[2].hand = parse_hand(p[2].hand)

    p[1].type = check_hand_types(p[1].hand)
    p[2].type = check_hand_types(p[2].hand)

    result = ""

    if (p[1].type == p[2].type)
        i = 0
        while ((i < 5) && (p[1].hand[4-i].value == p[2].hand[4-i].value))
            i++

        # each player has same cards
        return 'Tie.' if (i == 5)


check_hand_types = (hand) ->
    hand_types[0] # not implemented

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


exports.compare_hands = compare_hands
