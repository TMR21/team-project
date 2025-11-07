FROM python:3.9-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    ca-certificates \
 && apt-get clean && rm -rf /var/lib/apt/lists/*

# Copy action files to /action directory
COPY entrypoint.sh /entrypoint.sh
COPY github /github

RUN chmod +x /entrypoint.sh
RUN chmod +x /github/scripts/update_readme.sh

ENTRYPOINT ["/entrypoint.sh"]