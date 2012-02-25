#! /usr/bin/python3.2

# returns the price with as big discount as
# possible. Format: list of books, e.g. :
# [2,4,7,0,1] =  2x the first book,
#              + 4x the second one,
#              + 7x the third one,
#              + 1x the fifth one.
def calculate_price(*books):
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

# price in euros, discount in %
def apply_discount(price, discount):
    return price * (1 - discount / 100.0)


# returns the price for n books, without discount
def get_original_price(n):
    return 8 * n

