#!/bin/bash
# Deployment script for CI/DevOps project

set -e

ENVIRONMENT=${1:-"development"}
echo "Deploying CI/DevOps project to $ENVIRONMENT environment..."

# Check if we're in the right directory
if [ ! -d "src" ]; then
    echo "Error: src directory not found. Please run this script from the project root."
    exit 1
fi

# Create deployment directory if it doesn't exist
mkdir -p deploy/$ENVIRONMENT

# Copy build artifacts to deployment directory
if [ -d "build" ]; then
    cp -r build/* deploy/$ENVIRONMENT/ || {
        echo "Error: Failed to copy build artifacts to deployment directory."
        exit 1
    }
else
    echo "Warning: build directory not found. Creating it and copying source files directly."
    mkdir -p build
    cp -r src/* build/ || {
        echo "Error: Failed to copy source files to build directory."
        exit 1
    }
    cp -r build/* deploy/$ENVIRONMENT/ || {
        echo "Error: Failed to copy build artifacts to deployment directory."
        exit 1
    }
fi

# Create a deployment marker file
echo "Deployed at $(date)" > deploy/$ENVIRONMENT/DEPLOY_MARKER

echo "Deployment completed successfully to $ENVIRONMENT environment!"#!/bin/bash
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