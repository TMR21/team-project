#!/bin/bash
set -euo pipefail

# Arguments: first arg is the file path (from action input)
FILE_ARG="${1:-data.txt}"

# Environment variables passed by workflow:
# GITHUB_TOKEN, GITHUB_USER, GITHUB_REPOSITORY

# Ensure required env vars are present
if [ -z "${GITHUB_TOKEN:-}" ]; then
  echo "ERROR: GITHUB_TOKEN is required in environment." >&2
  exit 1
fi

if [ -z "${GITHUB_USER:-}" ]; then
  echo "ERROR: GITHUB_USER is required in environment." >&2
  exit 1
fi

if [ -z "${GITHUB_REPOSITORY:-}" ]; then
  echo "ERROR: GITHUB_REPOSITORY is required in environment." >&2
  exit 1
fi

echo "Analyzing file: $FILE_ARG"
python3 /github/workspace/github/scripts/frequency.py "/github/workspace/${FILE_ARG}" > /tmp/vowel_result.txt || {
  echo "Error running vowel count"; exit 1;
}

FREQ_RESULT="$(cat /tmp/vowel_result.txt | tr -d '\r\n')"
GITHUB_USER_READ="${GITHUB_USER}"
TIMESTAMP="$(date -u '+%Y-%m-%d %H:%M:%S UTC')"

echo "Frequency result: $FREQ_RESULT"
echo "Updating README.md..."

# Run update script (will append the data into README.md)
bash /github/workspace/github/scripts/update_readme.sh "$FREQ_RESULT" "$GITHUB_USER_READ" "$TIMESTAMP"

# Configure git to push changes using the provided token
git config --global user.name "github-actions[bot]"
git config --global user.email "github-actions[bot]@users.noreply.github.com"

# set remote url with token (use https + x-access-token)
REPO_URL="https://x-access-token:${GITHUB_TOKEN}@github.com/${GITHUB_REPOSITORY}.git"
git remote set-url origin "$REPO_URL"

# commit and push (only if README changed)
git add README.md || true
if ! git diff --cached --quiet; then
  git commit -m "Action: update README with vowel frequency by ${GITHUB_USER_READ} at ${TIMESTAMP}" || true
  git push origin HEAD:main --follow-tags
  echo "Pushed README update."
else
  echo "No changes to README; nothing to commit."
fi

echo "Action completed."
