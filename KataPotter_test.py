#! /usr/bin/python3.2

from KataPotter import calculate_price as cp
from KataPotter import TooManyBooksException
import unittest

def r2(n):
    return round(n, 2)

class KataPotterTest(unittest.TestCase):

    def test_too_many_books(self):
        with self.assertRaises(TooManyBooksException):
            cp(1,2,3,4,5,6)

    def test_no_book(self):
        self.assertEqual(r2(cp(0,0,0,0,0)), 0)

    def test_one_book(self):
        self.assertEqual(r2(cp(1,0,0,0,0)), 8)
        self.assertEqual(r2(cp(0,1,0,0,0)), 8)
        self.assertEqual(r2(cp(0,0,1,0,0)), 8)
        self.assertEqual(r2(cp(0,0,0,1,0)), 8)
        self.assertEqual(r2(cp(0,0,0,0,1)), 8)

    def test_no_discount(self):
        self.assertEqual(r2(cp(2,0,0,0,0)),   2*8)
        self.assertEqual(r2(cp(19,0,0,0,0)), 19*8)
        self.assertEqual(r2(cp(0,0,0,7,0)),   7*8)
        self.assertEqual(r2(cp(0,0,0,0,5)),   5*8)

    # -5%
    def test_simple_discount_5(self):
        self.assertEqual(r2(cp(1,1,0,0,0)), r2(8* 2*0.95))
        self.assertEqual(r2(cp(0,1,0,0,1)), r2(8* 2*0.95))
        self.assertEqual(r2(cp(6,0,0,0,6)), r2(8*12*0.95))

    # -10%
    def test_simple_discount_10(self):
        self.assertEqual(r2(cp(0,0,1,1,1)), r2(8*3*0.9))
        self.assertEqual(r2(cp(2,0,2,0,2)), r2(8*6*0.9))

    # -20%
    def test_simple_discount_20(self):
        self.assertEqual(r2(cp(1,1,0,1,1)), r2(8* 4*0.8))
        self.assertEqual(r2(cp(3,3,3,0,3)), r2(8*12*0.8))

    # -25%
    def test_simple_discount_25(self):
        self.assertEqual(r2(cp(1,1,1,1,1)), r2(8* 5*0.75))
        self.assertEqual(r2(cp(4,4,4,4,4)), r2(8*20*0.75))

    # 6 books
    def test_complex_discount_6b(self):
        self.assertEqual(r2(cp(2,1,1,1,1)), 38)

     # 7 books
    def test_complex_discount_7b(self):
        self.assertEqual(r2(cp(0,3,3,0,1)), 52)
        self.assertEqual(r2(cp(0,1,5,1,0)), 53.6)

    # 8 books
    def test_complex_discount_8b(self):
        self.assertEqual(r2(cp(2,2,2,1,1)), 51.2)

    # 73 books
    # taken from Thomas Weller's tests file
    def test_complex_discount_73b(self):
        self.assertEqual(r2(cp(12,17,15,8,21)), 468.4)

if (__name__ == '__main__'):
    unittest.main()

