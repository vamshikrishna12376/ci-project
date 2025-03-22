#!/usr/bin/env python3
"""
Test module for the main application
"""
import sys
import os
import unittest
from unittest.mock import patch
import json
from datetime import datetime

# Add the parent directory to the path so we can import the main module
sys.path.append(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
from main.app import main, health_check, get_data, create_data

class TestApp(unittest.TestCase):
    """
    Test cases for the main application
    """
    def test_main_returns_zero(self):
        """
        Test that the main function returns 0
        """
        self.assertEqual(main(), 0)

    def test_health_check(self):
        """
        Test the health check function
        """
        result = health_check()
        self.assertEqual(result["status"], "healthy")
        self.assertEqual(result["version"], "1.0.0")
        # Check that timestamp is a valid ISO format
        try:
            datetime.fromisoformat(result["timestamp"])
            is_valid_timestamp = True
        except ValueError:
            is_valid_timestamp = False
        self.assertTrue(is_valid_timestamp)

    def test_get_data(self):
        """
        Test the get_data function
        """
        result = get_data()
        self.assertEqual(len(result["data"]), 3)
        self.assertEqual(result["count"], 3)
        self.assertEqual(result["data"][0]["name"], "Item 1")
        self.assertEqual(result["data"][1]["name"], "Item 2")
        self.assertEqual(result["data"][2]["name"], "Item 3")

    def test_create_data(self):
        """
        Test the create_data function
        """
        test_data = {"name": "Test Item", "value": 42}
        result = create_data(test_data)
        self.assertTrue(result["created"])
        self.assertEqual(result["data"], test_data)
        # Check that id is a valid UUID
        self.assertEqual(len(result["id"]), 36)  # UUID format check

if __name__ == "__main__":
    unittest.main()