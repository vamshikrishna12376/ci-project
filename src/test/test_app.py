"""
Unit tests for the application
"""
import json
import unittest
from unittest.mock import patch
import sys
import os

# Add the parent directory to the path so we can import modules
sys.path.append(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
from main.app import health_check, get_data, create_data

class TestApp(unittest.TestCase):
    """
    Test cases for the application
    """
    def test_health_check(self):
        """Test the health check function"""
        result = health_check()
        self.assertEqual(result['status'], 'healthy')
        self.assertIn('timestamp', result)
        self.assertEqual(result['version'], '1.0.0')
    
    def test_get_data(self):
        """Test the get_data function"""
        result = get_data()
        self.assertIn('data', result)
        self.assertEqual(len(result['data']), 3)
        self.assertEqual(result['count'], 3)
        self.assertIn('timestamp', result)
    
    def test_create_data(self):
        """Test the create_data function"""
        test_data = {'name': 'Test Item', 'value': 42}
        result = create_data(test_data)
        self.assertIn('id', result)
        self.assertTrue(result['created'])
        self.assertIn('timestamp', result)
        self.assertEqual(result['data'], test_data)

if __name__ == '__main__':
    unittest.main()