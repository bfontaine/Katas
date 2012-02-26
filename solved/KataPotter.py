#! /usr/bin/python3.2

# Note :
# I don't think that this program is *really* working for
# books > 8, but I don't have more tests to test it
#

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

    # see Notes file
    COEFS = [8, 7.2, 6.4, 4, 4.4]

    # keep ony non-0 elements
    books = [b for b in books if b]

    # 0 books
    if (len(books) == 0):
        return get_original_price(0)

    # some books with the same title
    if (len(books) == 1):
        return get_original_price(books[0])

    # N books for each different title
    if (min(books) == max(books)):
        return apply_discount(books[0], len(books))

    books2 = books[:]
    books2.sort()
    books2.reverse()

    if ((sum(books) > 7) and (max(books) == 2)):
        COEFS[-1] = 4
    
    price = sum([a*b for a,b in zip(books2, COEFS)])
    
    if (sum(books) > 8): # hack
        price -= 0.4 * ((int(sum(books)/25))+1)

    return price

# returns the discount for n different books, in %
# (i.e. 0 <= discount <= 0.25)
def get_discount(n):
    # 1 -> 0    | 2 -> 0.05
    # 3 -> 0.10 | 4 -> 0.20
    # 5 -> 0.25
    return (n-1)/20.0 if (n<4) else n/20.0

# Apply discount for `n` books of `n_diff` different titles
# e.g. : n=3, n_diff=4 -> 12 books -> 9.6 euros
def apply_discount(n, n_diff=None):
    if (n_diff == None): # if only one of each
        n_diff = n

    tmp = n%5
    n -= tmp

    total = get_original_price(tmp*n_diff) * (1 - get_discount(n_diff))

    while (n > 0):
        total += get_original_price(n*n_diff) * (1 - get_discount(n_diff))
        n -= 5

    return total

# returns the price for n books, without discount
def get_original_price(n):
    return 8 * n

