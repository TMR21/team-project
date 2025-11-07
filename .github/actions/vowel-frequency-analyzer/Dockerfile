FROM python:3.9-slim

# Install git and certificates
RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    ca-certificates \
 && apt-get clean && rm -rf /var/lib/apt/lists/*

# Copy action files to a location that won't be overwritten by volume mounts
COPY entrypoint.sh /action/entrypoint.sh
COPY github /action/github

# Set permissions
RUN chmod +x /action/entrypoint.sh
RUN chmod +x /action/github/scripts/update_readme.sh
RUN chmod +x /action/github/scripts/frequency.py

# Set working directory (will be mounted by GitHub Actions)
WORKDIR /github/workspace

# Correct ENTRYPOINT path
ENTRYPOINT ["/action/entrypoint.sh"]
