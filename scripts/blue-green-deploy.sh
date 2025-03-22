#!/bin/bash
# Blue-Green deployment script for CI/DevOps project

set -e

ENVIRONMENT=${1:-"production"}
echo "Performing Blue-Green deployment to $ENVIRONMENT environment"

# Check if we're in the right directory
if [ ! -d "src" ]; then
    echo "Error: src directory not found. Please run this script from the project root."
    exit 1
fi

# Create deployment directories if they don't exist
mkdir -p deploy/$ENVIRONMENT/blue
mkdir -p deploy/$ENVIRONMENT/green

# Determine which environment is currently active
if [ -f "deploy/$ENVIRONMENT/ACTIVE" ]; then
    ACTIVE=$(cat "deploy/$ENVIRONMENT/ACTIVE")
    echo "Current active environment is: $ACTIVE"
    
    if [ "$ACTIVE" == "blue" ]; then
        TARGET="green"
    else
        TARGET="blue"
    fi
else
    # Default to blue if no active environment is set
    TARGET="blue"
    echo "No active environment found. Defaulting to: $TARGET"
fi

echo "Deploying to $TARGET environment"

# Copy build artifacts to target deployment directory
if [ -d "build" ]; then
    cp -r build/* deploy/$ENVIRONMENT/$TARGET/ || {
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
    cp -r build/* deploy/$ENVIRONMENT/$TARGET/ || {
        echo "Error: Failed to copy build artifacts to deployment directory."
        exit 1
    }
fi

# Create a deployment marker file
echo "Deployed at $(date)" > deploy/$ENVIRONMENT/$TARGET/DEPLOY_MARKER

# Switch the active environment
echo "$TARGET" > "deploy/$ENVIRONMENT/ACTIVE"

echo "Blue-Green deployment completed successfully to $ENVIRONMENT environment!"
echo "Active environment is now: $TARGET"#!/bin/bash
# Blue-Green Deployment Script

set -e

ENVIRONMENT=${1:-"production"}
echo "Performing Blue-Green deployment to $ENVIRONMENT environment"

# Check if we're in the right directory
if [ ! -d "src" ]; then
    echo "Error: src directory not found. Please run this script from the project root."
    exit 1
fi

# Create deployment directories if they don't exist
mkdir -p deploy/$ENVIRONMENT/blue
mkdir -p deploy/$ENVIRONMENT/green

# Determine which environment is currently active
if [ -f "deploy/$ENVIRONMENT/ACTIVE" ]; then
    ACTIVE_ENV=$(cat "deploy/$ENVIRONMENT/ACTIVE")
else
    # Default to blue if no active environment is set
    ACTIVE_ENV="blue"
    echo "blue" > "deploy/$ENVIRONMENT/ACTIVE"
fi

# Determine target environment (opposite of active)
if [ "$ACTIVE_ENV" == "blue" ]; then
    TARGET_ENV="green"
else
    TARGET_ENV="blue"
fi

echo "Current active environment: $ACTIVE_ENV"
echo "Deploying to target environment: $TARGET_ENV"

# Deploy to the target environment
echo "Deploying application to $TARGET_ENV environment..."
cp -r build/* "deploy/$ENVIRONMENT/$TARGET_ENV/"

# Simulate traffic routing (in a real environment, this would update load balancer, DNS, etc.)
echo "Routing traffic to $TARGET_ENV environment..."
sleep 2  # Simulate the time it takes to switch traffic

# Verify deployment
echo "Verifying deployment..."
if [ -d "deploy/$ENVIRONMENT/$TARGET_ENV" ]; then
    echo "Deployment verification successful!"
    
    # Update active environment marker
    echo "$TARGET_ENV" > "deploy/$ENVIRONMENT/ACTIVE"
    echo "Successfully switched active environment to $TARGET_ENV"
else
    echo "Error: Deployment verification failed!"
    exit 1
fi

# Keep the old environment for quick rollback if needed
echo "Keeping $ACTIVE_ENV environment for potential rollback"

echo "Blue-Green deployment completed successfully to $ENVIRONMENT environment!"