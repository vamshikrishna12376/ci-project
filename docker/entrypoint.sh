#!/bin/bash
# Docker container entrypoint script

set -e

echo "Starting CI/DevOps application..."

# Run the application
python main/app.py

# Keep container running if needed
# exec "$@"