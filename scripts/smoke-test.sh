#!/bin/bash
# Smoke Test Script

set -e

ENVIRONMENT=${1:-"development"}
echo "Running smoke tests against $ENVIRONMENT environment"

# Define the base URL based on the environment
case "$ENVIRONMENT" in
    "development")
        BASE_URL="http://localhost:8080"
        ;;
    "staging")
        BASE_URL="http://staging.example.com"
        ;;
    "production")
        BASE_URL="http://production.example.com"
        ;;
    *)
        echo "Error: Unknown environment '$ENVIRONMENT'"
        exit 1
        ;;
esac

echo "Using base URL: $BASE_URL"

# Create reports directory if it doesn't exist
mkdir -p reports/smoke-tests

# Function to test an endpoint
test_endpoint() {
    local endpoint=$1
    local expected_status=$2
    local description=$3
    
    echo "Testing $description..."
    
    # Make the HTTP request and capture the status code
    status=$(curl -s -o /dev/null -w "%{http_code}" "$BASE_URL$endpoint")
    
    # Check if the status matches the expected status
    if [ "$status" -eq "$expected_status" ]; then
        echo "✅ $description: Success (Status: $status)"
        return 0
    else
        echo "❌ $description: Failed (Expected: $expected_status, Got: $status)"
        return 1
    fi
}

# Run the smoke tests
echo "Starting smoke tests..."

# Initialize test results
PASSED=0
FAILED=0
TOTAL=0

# Test the home page
if test_endpoint "/" 200 "Home page"; then
    PASSED=$((PASSED+1))
else
    FAILED=$((FAILED+1))
fi
TOTAL=$((TOTAL+1))

# Test the health check endpoint
if test_endpoint "/health" 200 "Health check"; then
    PASSED=$((PASSED+1))
else
    FAILED=$((FAILED+1))
fi
TOTAL=$((TOTAL+1))

# Test the API endpoint
if test_endpoint "/api/v1/data" 200 "API endpoint"; then
    PASSED=$((PASSED+1))
else
    FAILED=$((FAILED+1))
fi
TOTAL=$((TOTAL+1))

# Test a non-existent endpoint (should return 404)
if test_endpoint "/non-existent" 404 "Non-existent page"; then
    PASSED=$((PASSED+1))
else
    FAILED=$((FAILED+1))
fi
TOTAL=$((TOTAL+1))

# Generate a report
echo "Generating smoke test report..."
REPORT_FILE="reports/smoke-tests/smoke-test-report-$ENVIRONMENT.txt"

cat > "$REPORT_FILE" << EOF
Smoke Test Report for $ENVIRONMENT
=================================
Date: $(date)
Base URL: $BASE_URL

Summary:
--------
Total Tests: $TOTAL
Passed: $PASSED
Failed: $FAILED
Success Rate: $(( (PASSED * 100) / TOTAL ))%

EOF

# Check if all tests passed
if [ "$FAILED" -eq 0 ]; then
    echo "🎉 All smoke tests passed!"
    echo "All tests passed successfully!" >> "$REPORT_FILE"
    exit 0
else
    echo "❌ Some smoke tests failed. Check the report for details."
    echo "Some tests failed. Please check the application logs." >> "$REPORT_FILE"
    exit 1
fi