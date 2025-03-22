#!/bin/bash
# Docker container entrypoint script

set -e

echo "Starting CI/DevOps application..."

# Create necessary directories
mkdir -p logs

# Set environment variables if not already set
export PORT=${PORT:-8080}
export APP_ENV=${APP_ENV:-production}
export LOG_LEVEL=${LOG_LEVEL:-INFO}

echo "Running in $APP_ENV environment on port $PORT with log level $LOG_LEVEL"

# Run the application
python main/app.py

# Keep container running if needed
# exec "$@"