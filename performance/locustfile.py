"""
Performance testing script using Locust
"""
import time
from locust import HttpUser, task, between

class WebsiteUser(HttpUser):
    """
    Simulated user behavior for performance testing
    """
    wait_time = between(1, 5)  # Wait between 1 and 5 seconds between tasks
    
    @task(1)
    def index_page(self):
        """Test the index page"""
        self.client.get("/")
    
    @task(2)
    def health_check(self):
        """Test the health check endpoint"""
        self.client.get("/health")
    
    @task(3)
    def api_endpoint(self):
        """Test a sample API endpoint"""
        self.client.get("/api/v1/data")
    
    @task(1)
    def post_data(self):
        """Test posting data to an API endpoint"""
        self.client.post("/api/v1/data", 
                         json={"key": "value", "timestamp": time.time()})