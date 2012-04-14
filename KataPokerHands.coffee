
compare_hands = (s) ->

    regex_hand = /([A-Z]\w+): ((?:[2-9TJQKA][CDHS] ?)+)/g

    [p1_name, p1_hand] = regex_hand.exec(s).slice(1)
    [p2_name, p2_hand] = regex_hand.exec(s).slice(1)

    p1_hand = parse_hand(p1_hand)
    p2_hand = parse_hand(p2_hand)

    "not implemented"



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
