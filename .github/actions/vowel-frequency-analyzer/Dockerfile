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
COPY .github /github/workspace/.github

# Set permissions and fix line endings
RUN chmod +x /github/workspace/entrypoint.sh && \
    chmod +x /github/workspace/github/scripts/update_readme.sh && \
    sed -i 's/\r$//' /github/workspace/.github/scripts/*.sh && \
    chmod +x /github/workspace/.github/scripts/*.sh

# Correct ENTRYPOINT path
ENTRYPOINT ["/github/workspace/entrypoint.sh"]
