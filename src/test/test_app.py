#!/usr/bin/env python3
"""
Test module for the main application
"""
import sys
import os
import unittest

# Add the parent directory to the path so we can import the main module
sys.path.append(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
from main.app import main

class TestApp(unittest.TestCase):
    """
    Test cases for the main application
    """
    def test_main_returns_zero(self):
        """
        Test that the main function returns 0
        """
        self.assertEqual(main(), 0)

if __name__ == "__main__":
    unittest.main()