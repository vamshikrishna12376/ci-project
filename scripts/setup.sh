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
chmod +x scripts/*.sh

echo "Project setup completed successfully!"