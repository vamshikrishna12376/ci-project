#!/usr/bin/env python3
"""
Main application entry point
"""
import os
import sys
import json
from datetime import datetime
import uuid

# Add the parent directory to the path so we can import modules
sys.path.append(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
from main.logger import get_logger, log_function_call

# Initialize logger
logger = get_logger(__name__)

@log_function_call(logger)
def health_check():
    """
    Health check endpoint
    """
    logger.info("Health check requested")
    return {
        "status": "healthy",
        "timestamp": datetime.now().isoformat(),
        "version": "1.0.0"
    }

@log_function_call(logger)
def get_data():
    """
    Get sample data
    """
    logger.info("Data requested")
    return {
        "data": [
            {"id": 1, "name": "Item 1"},
            {"id": 2, "name": "Item 2"},
            {"id": 3, "name": "Item 3"}
        ],
        "count": 3,
        "timestamp": datetime.now().isoformat()
    }

@log_function_call(logger)
def create_data(data):
    """
    Create new data
    """
    logger.info(f"Creating new data: {data}")
    # In a real application, this would save to a database
    return {
        "id": str(uuid.uuid4()),
        "created": True,
        "timestamp": datetime.now().isoformat(),
        "data": data
    }

@log_function_call(logger)
def main():
    """
    Main function that runs the application
    """
    logger.info("Starting CI/DevOps Project Application")

    # Load configuration
    env = os.environ.get("APP_ENV", "development")
    logger.info(f"Running in {env} environment")

    # Simulate application startup
    logger.info("Initializing application components")

    # Simulate a health check
    health_status = health_check()
    logger.info(f"Health check status: {health_status['status']}")

    # Simulate getting data
    data = get_data()
    logger.info(f"Retrieved {data['count']} items")

    # Simulate creating data
    new_item = {"name": "New Item", "created_at": datetime.now().isoformat()}
    result = create_data(new_item)
    logger.info(f"Created new item with ID: {result['id']}")

    logger.info("Application startup completed successfully")
    return 0

if __name__ == "__main__":
    try:
        exit_code = main()
        sys.exit(exit_code)
    except Exception as e:
        logger.error(f"Unhandled exception: {str(e)}", exc_info=True)
        sys.exit(1)