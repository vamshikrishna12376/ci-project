#!/bin/bash
# Post-build actions script for Jenkins

set -e

echo "Executing post-build actions..."

# Clean up old artifacts if needed
find reports -type f -name "*.tmp" -delete

# Send notifications (example)
echo "Build completed for CI/DevOps project"
echo "Build status: $BUILD_STATUS"
echo "Build URL: $BUILD_URL"

# You would typically integrate with notification services here
# e.g., Slack, Email, etc.

echo "Post-build actions completed!"