FROM python:3.9-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    ca-certificates \
 && apt-get clean && rm -rf /var/lib/apt/lists/*

WORKDIR /github/workspace

COPY entrypoint.sh /entrypoint.sh
COPY github /github/workspace/github

RUN chmod +x /entrypoint.sh
RUN chmod +x /github/workspace/github/scripts/update_readme.sh

ENTRYPOINT ["/entrypoint.sh"]