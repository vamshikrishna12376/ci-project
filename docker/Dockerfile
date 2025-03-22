FROM python:3.9-slim

WORKDIR /app

# Install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Create necessary directories
RUN mkdir -p logs

# Copy application code
COPY src/ /app/

# Copy entrypoint script
COPY docker/entrypoint.sh /app/entrypoint.sh
RUN chmod +x /app/entrypoint.sh

# Expose port
EXPOSE 8080

# Set environment variables
ENV APP_ENV=production
ENV LOG_LEVEL=INFO

# Set entrypoint
ENTRYPOINT ["/app/entrypoint.sh"]