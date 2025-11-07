cat > .github/actions/vowel-frequency-analyzer/entrypoint.sh <<'BASH'
#!/bin/bash
set -euo pipefail

FILE_ARG="${1:-data.txt}"

if [ -z "${GITHUB_TOKEN:-}" ]; then
  echo "ERROR: GITHUB_TOKEN missing" >&2; exit 1;
fi
if [ -z "${GITHUB_USER:-}" ]; then
  echo "ERROR: GITHUB_USER missing" >&2; exit 1;
fi
if [ -z "${GITHUB_REPOSITORY:-}" ]; then
  echo "ERROR: GITHUB_REPOSITORY missing" >&2; exit 1;
fi

echo "Analyzing file: $FILE_ARG"
python3 /github/workspace/github/scripts/frequency.py "/github/workspace/${FILE_ARG}" > /tmp/vowel_result.txt
FREQ_RESULT="$(cat /tmp/vowel_result.txt | tr -d '\r\n')"
TIMESTAMP="$(date -u '+%Y-%m-%d %H:%M:%S UTC')"

echo "Updating README..."
bash /github/workspace/github/scripts/update_readme.sh "$FREQ_RESULT" "$GITHUB_USER" "$TIMESTAMP"

git config --global user.name "github-actions[bot]"
git config --global user.email "github-actions[bot]@users.noreply.github.com"

REPO_URL="https://x-access-token:${GITHUB_TOKEN}@github.com/${GITHUB_REPOSITORY}.git"
git remote set-url origin "$REPO_URL"

git add README.md || true
if ! git diff --cached --quiet; then
  git commit -m "Action: update README with vowel frequency by ${GITHUB_USER} at ${TIMESTAMP}" || true
  git push origin HEAD:main --follow-tags
  echo "Pushed README update."
else
  echo "No changes to README; nothing to commit."
fi

echo "Action completed."
BASH
