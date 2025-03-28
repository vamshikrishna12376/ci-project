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

# Run unit tests with pytest and generate coverage report
echo "Running unit tests with coverage..."
# Install pytest and pytest-cov if not already installed
pip install pytest pytest-cov || true
python -m pytest src/test -v --cov=src/main --cov-report=xml:reports/coverage/coverage.xml --cov-report=html:reports/coverage/html --junitxml=reports/test-reports/junit.xml || {
    echo "Tests failed with exit code $?"
    echo "Test execution failed at $(date)" > reports/test-reports/test_summary.txt
    echo "Some tests failed. Check the logs for details." >> reports/test-reports/test_summary.txt
    exit 1
}

# Generate a test summary
echo "Test execution completed at $(date)" > reports/test-reports/test_summary.txt
echo "All tests passed successfully!" >> reports/test-reports/test_summary.txt
echo "Coverage report available in reports/coverage/" >> reports/test-reports/test_summary.txt

echo "Tests completed successfully!"