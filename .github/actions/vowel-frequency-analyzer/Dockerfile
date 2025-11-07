FROM python:3.9-slim

# Install git and certificates
RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    ca-certificates \
 && apt-get clean && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /github/workspace

# Copy action files into container
COPY entrypoint.sh /github/workspace/entrypoint.sh
COPY github /github/workspace/github

# Set permissions
RUN chmod +x /github/workspace/entrypoint.sh
RUN chmod +x /github/workspace/github/scripts/update_readme.sh

# Run the entrypoint
ENTRYPOINT ["/github/workspace/entrypoint.sh"]
