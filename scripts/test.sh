#!/bin/bash
# Test script for CI/DevOps project

set -e

echo "Running tests for CI/DevOps project..."

# Check if we're in the right directory
if [ ! -d "src" ]; then
    echo "Error: src directory not found. Please run this script from the project root."
    exit 1
fi

# Create reports directory if it doesn't exist
mkdir -p reports/test-reports
mkdir -p reports/coverage

# Run unit tests
echo "Running unit tests..."
python -m unittest discover -s src/test

# Generate a simple test report
echo "Test execution completed at $(date)" > reports/test-reports/test_summary.txt
echo "All tests passed successfully!" >> reports/test-reports/test_summary.txt

echo "Tests completed successfully!"