#!/usr/bin/env python3
"""
Main application entry point
"""
import os
import sys
import json
from datetime import datetime
import uuid
from http.server import HTTPServer, BaseHTTPRequestHandler
import threading
import signal

# Add the parent directory to the path so we can import modules
sys.path.append(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
from main.logger import get_logger, log_function_call

# Initialize logger
logger = get_logger(__name__)

# Global server instance
server = None

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

class RequestHandler(BaseHTTPRequestHandler):
    """
    HTTP request handler for the application
    """
    def _set_headers(self, status_code=200, content_type='application/json'):
        self.send_response(status_code)
        self.send_header('Content-type', content_type)
        self.end_headers()

    def _send_json_response(self, data, status_code=200):
        self._set_headers(status_code)
        self.wfile.write(json.dumps(data).encode('utf-8'))

    def do_GET(self):
        """Handle GET requests"""
        logger.info(f"GET request received for path: {self.path}")

        if self.path == '/':
            # Home page
            self._set_headers(200, 'text/html')
            response = """
            <html>
            <head><title>CI/DevOps Project</title></head>
            <body>
                <h1>Welcome to the CI/DevOps Project</h1>
                <p>This is a sample application for CI/CD demonstration.</p>
                <p>Available endpoints:</p>
                <ul>
                    <li><a href="/health">/health</a> - Health check endpoint</li>
                    <li><a href="/api/v1/data">/api/v1/data</a> - Sample API endpoint</li>
                </ul>
            </body>
            </html>
            """
            self.wfile.write(response.encode('utf-8'))

        elif self.path == '/health':
            # Health check endpoint
            self._send_json_response(health_check())

        elif self.path == '/api/v1/data':
            # API endpoint
            self._send_json_response(get_data())

        else:
            # 404 Not Found
            self._send_json_response({"error": "Not found", "path": self.path}, 404)

    def do_POST(self):
        """Handle POST requests"""
        logger.info(f"POST request received for path: {self.path}")

        content_length = int(self.headers['Content-Length'])
        post_data = self.rfile.read(content_length)

        try:
            data = json.loads(post_data.decode('utf-8'))

            if self.path == '/api/v1/data':
                # Create data endpoint
                result = create_data(data)
                self._send_json_response(result, 201)
            else:
                # 404 Not Found
                self._send_json_response({"error": "Not found", "path": self.path}, 404)

        except json.JSONDecodeError:
            # Bad request - invalid JSON
            self._send_json_response({"error": "Invalid JSON"}, 400)

def start_server(port=8080):
    """
    Start the HTTP server
    """
    global server
    server_address = ('', port)
    server = HTTPServer(server_address, RequestHandler)
    logger.info(f"Starting HTTP server on port {port}")

    # Start the server in a separate thread
    server_thread = threading.Thread(target=server.serve_forever)
    server_thread.daemon = True
    server_thread.start()

    return server_thread

def stop_server():
    """
    Stop the HTTP server
    """
    global server
    if server:
        logger.info("Stopping HTTP server")
        server.shutdown()
        server.server_close()

def signal_handler(sig, frame):
    """
    Handle signals to gracefully shut down the server
    """
    logger.info(f"Received signal {sig}, shutting down...")
    stop_server()
    sys.exit(0)

@log_function_call(logger)
def main():
    """
    Main function that runs the application
    """
    logger.info("Starting CI/DevOps Project Application")

    # Load configuration
    env = os.environ.get("APP_ENV", "development")
    port = int(os.environ.get("PORT", 8080))
    logger.info(f"Running in {env} environment on port {port}")

    # Register signal handlers for graceful shutdown
    signal.signal(signal.SIGINT, signal_handler)
    signal.signal(signal.SIGTERM, signal_handler)

    # Start the HTTP server
    server_thread = start_server(port)
    logger.info("HTTP server started successfully")

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

    try:
        # Keep the main thread alive
        while True:
            signal.pause()
    except (KeyboardInterrupt, SystemExit):
        logger.info("Application shutdown initiated")
        stop_server()

    return 0

if __name__ == "__main__":
    try:
        exit_code = main()
        sys.exit(exit_code)
    except Exception as e:
        logger.error(f"Unhandled exception: {str(e)}", exc_info=True)
        stop_server()
        sys.exit(1)