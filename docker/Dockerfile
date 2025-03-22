FROM python:3.9-slim

WORKDIR /app

# Copy application code
COPY src/ /app/

# Install dependencies (if you have any)
# COPY requirements.txt .
# RUN pip install --no-cache-dir -r requirements.txt

# Copy entrypoint script
COPY docker/entrypoint.sh /app/entrypoint.sh
RUN chmod +x /app/entrypoint.sh

# Expose port
EXPOSE 8080

# Set entrypoint
ENTRYPOINT ["/app/entrypoint.sh"]