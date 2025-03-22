#!/bin/bash
# Setup script for CI/DevOps project

set -e

echo "Setting up CI/DevOps project..."

# Create necessary directories
mkdir -p reports/test-reports
mkdir -p reports/coverage
mkdir -p reports/smoke-tests
mkdir -p logs
mkdir -p build
mkdir -p deploy/staging
mkdir -p deploy/production/blue
mkdir -p deploy/production/green

# Set permissions for scripts
if [ -d "scripts" ]; then
    chmod +x scripts/*.sh 2>/dev/null || echo "Warning: Could not set execute permissions on scripts."
else
    echo "Warning: scripts directory not found."
fi

echo "Project setup completed successfully!"