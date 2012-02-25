#! /usr/bin/python3.2

from KataPotter import calculate_price as cp
import unittest

class KataPotterTest(unittest.TestCase):

    def test_no_book(self):
        self.assertEqual(cp(0,0,0,0,0), 0)

    def test_one_book(self):
        self.assertEqual(cp(1,0,0,0,0), 8)
        self.assertEqual(cp(0,1,0,0,0), 8)
        self.assertEqual(cp(0,0,1,0,0), 8)
        self.assertEqual(cp(0,0,0,1,0), 8)
        self.assertEqual(cp(0,0,0,0,1), 8)

    def test_no_discount(self):
        self.assertEqual(cp(2,0,0,0,0),   2*8)
        self.assertEqual(cp(19,0,0,0,0), 19*8)
        self.assertEqual(cp(0,0,0,7,0),   7*8)
        self.assertEqual(cp(0,0,0,0,5),   5*8)

    # -5%
    def test_simple_discount_5(self):
        self.assertEqual(cp(1,1,0,0,0), 8*2*0.95)
        self.assertEqual(cp(0,1,0,0,1), 8*2*0.95)

    # -10%
    def test_simple_discount_10(self):
        self.assertEqual(cp(0,0,1,1,1), 8*3*0.9)
        self.assertEqual(cp(2,0,2,0,2), 8*6*0.9)

    # -20%
    def test_simple_discount_20(self):
        self.assertEqual(cp(1,1,0,1,1), 8* 4*0.8)
        self.assertEqual(cp(3,3,3,0,3), 8*12*0.8)

    # -25%
    def test_simple_discount_25(self):
        self.assertEqual(cp(1,1,1,1,1), 8* 5*0.75)
        self.assertEqual(cp(4,4,4,4,4), 8*20*0.75)

    def test_complex_discount(self):
        self/assertEqual(cp(2,2,2,1,1), 51.2)
        # TODO


if (__name__ == '__main__'):
    unittest.main()

