# Use Python 3.9 slim as the base image
FROM python:3.9-slim

# Update apt and install apache2-utils for the 'ab' benchmarking tool
RUN apt-get update && apt-get install -y --no-install-recommends apache2-utils && \
    rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /usr/src/app

# Copy the seed files (make-data.py and generate-votes.sh)
COPY make-data.py generate-votes.sh ./

# Fix line endings for generate-votes.sh
RUN sed -i 's/\r$//' generate-votes.sh

# Execute make-data.py during the build stage
RUN python make-data.py

# Ensure generate-votes.sh is executable
RUN chmod +x generate-votes.sh

# On container start, run generate-votes.sh
CMD ["bash", "generate-votes.sh"]
