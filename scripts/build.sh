#!/bin/bash
# Build script for CI/DevOps project

set -e

echo "Building CI/DevOps project..."

# Check if we're in the right directory
if [ ! -d "src" ]; then
    echo "Error: src directory not found. Please run this script from the project root."
    exit 1
fi

# Create build directory if it doesn't exist
mkdir -p build

# Copy source files to build directory
cp -r src/* build/

echo "Build completed successfully!"