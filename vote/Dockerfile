# vote/Dockerfile
FROM python:3.11-slim

# Create a working directory
WORKDIR /usr/src/app

# Copy requirements and install them
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the app files
COPY . .

# Expose the internal port (for clarity; Compose will handle actual mapping)
EXPOSE 5000

# Optionally define a HEALTHCHECK (extended version). Example:
# HEALTHCHECK --interval=30s --timeout=5s --start-period=5s \
#   CMD curl -f http://localhost:5000/health || exit 1

CMD ["python", "app.py"]
