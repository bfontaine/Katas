#! /usr/bin/python3.2

class TooManyBooksException(Exception):
    def __init__(self,*args):
        super(*args)

# returns the price with as big discount as
# possible. Format: list of books, e.g. :
# [2,4,7,0,1] =  2x the first book,
#              + 4x the second one,
#              + 7x the third one,
#              + 1x the fifth one.
def calculate_price(*books):
    if (len(books) > 5):
        raise TooManyBooksException

    # keep ony non-0 elements
    books = [b for b in books if b]

    # 0 books
    if (len(books) == 0):
        return get_original_price(0)

    # some books with the same title
    if (len(books) == 1):
        return get_original_price(books[0])

    # some books, one for each different title
    if (min(books) == max(books) <= 5):
        return apply_discount(len(books)*books[0], len(books))

    #TODO
    return 0

# returns the discount for n different books, in %
# (i.e. 0 <= discount <= 25)
def get_discount(n):
    # 1 -> 0
    # 2 -> -5%
    # 3 -> -10%
    # 4 -> -20%
    # 5 -> -25%
    return (n-1)*5 if (n<4) else n*5


def apply_discount(n, n_different=None):
    if (n_different == None):
        n_different = n
    return get_original_price(n) * (1 - get_discount(n_different) / 100.0)


# returns the price for n books, without discount
def get_original_price(n):
    return 8 * n

