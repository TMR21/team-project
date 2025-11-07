FROM python:3.9-slim

# Install git and utilities
RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    ca-certificates \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

WORKDIR /github/workspace

# Copy the action files into the image (the runner will pass the repository into /github/workspace)
COPY . /github/workspace

# Make entrypoint executable
RUN chmod +x /github/workspace/entrypoint.sh
RUN chmod +x /github/workspace/github/scripts/update_readme.sh

RUN chmod +x /github/workspace/entrypoint.sh
