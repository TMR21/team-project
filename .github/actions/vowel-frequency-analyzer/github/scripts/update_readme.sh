#!/bin/bash
set -euo pipefail

FREQ_RESULT="${1:-}"
GITHUB_USER="${2:-}"
TIMESTAMP="${3:-}"

if [ -z "$FREQ_RESULT" ] || [ -z "$GITHUB_USER" ] || [ -z "$TIMESTAMP" ]; then
  echo "Usage: update_readme.sh <freq_result> <github_user> <timestamp>" >&2
  exit 1
fi

echo -e "\n## Vowel frequency update" >> README.md
echo -e "- **Analyzed file:** data.txt" >> README.md
echo -e "- **Result:** ${FREQ_RESULT}" >> README.md
echo -e "- **By:** ${GITHUB_USER}" >> README.md
echo -e "- **At:** ${TIMESTAMP}" >> README.md
