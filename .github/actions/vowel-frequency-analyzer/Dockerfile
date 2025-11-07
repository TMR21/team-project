FROM python:3.9-slim

# Install git and certificates
RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    ca-certificates \
 && apt-get clean && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /github/workspace

# Copy all necessary files
COPY entrypoint.sh /github/workspace/entrypoint.sh
COPY github /github/workspace/github

# Verify files were copied correctly
RUN ls -la /github/workspace/entrypoint.sh || (echo "ERROR: entrypoint.sh not found!" && exit 1)
RUN ls -la /github/workspace/github/scripts/ || (echo "ERROR: github/scripts not found!" && exit 1)

# Set permissions
RUN chmod +x /github/workspace/entrypoint.sh
RUN chmod +x /github/workspace/github/scripts/update_readme.sh
RUN chmod +x /github/workspace/github/scripts/frequency.py

# Correct ENTRYPOINT path
ENTRYPOINT ["/github/workspace/entrypoint.sh"]
