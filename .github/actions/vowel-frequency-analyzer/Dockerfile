FROM python:3.9-slim

# Install git and certificates
RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    ca-certificates \
 && apt-get clean && rm -rf /var/lib/apt/lists/*

# Set working directory inside the container
WORKDIR /github/workspace

# Copy all action files to the container
COPY entrypoint.sh /github/workspace/entrypoint.sh
COPY github /github/workspace/github

# Ensure entrypoint and script permissions
RUN chmod +x /github/workspace/entrypoint.sh
RUN chmod +x /github/workspace/github/scripts/update_readme.sh

# Set the entrypoint
ENTRYPOINT ["/github/workspace/entrypoint.sh"]
