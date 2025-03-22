#!/bin/bash
# Deployment script for CI/DevOps project

set -e

echo "Deploying CI/DevOps project..."

# Check if build directory exists
if [ ! -d "build" ]; then
    echo "Error: build directory not found. Please run build.sh first."
    exit 1
fi

# Check for deployment environment
ENVIRONMENT=${1:-"development"}
echo "Deploying to $ENVIRONMENT environment"

# Simulate deployment
echo "Copying build artifacts to deployment location..."
mkdir -p deploy/$ENVIRONMENT
cp -r build/* deploy/$ENVIRONMENT/

echo "Deployment completed successfully to $ENVIRONMENT environment!"