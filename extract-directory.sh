#!/usr/bin/env bash
set -euo pipefail

# Usage:
#   script.sh OWNER/REPO REF path/inside/repo DEST_DIR
#
# Example:
#   script.sh octocat/Hello-World main tools/bootstrap ./vendor/bootstrap

REPO="${1:?OWNER/REPO required}"
REF="${2:?REF required (branch/tag/SHA)}"
SUBDIR="${3:?SUBDIR required (path inside repo)}"
DEST="${4:?DEST required}"

ZIP_URL="https://github.com/${REPO}/archive/${REF}.zip"

tmp="$(mktemp -d)"
trap 'rm -rf "$tmp"' EXIT

zip="$tmp/repo.zip"
curl -fsSL "$ZIP_URL" -o "$zip"

# Find the top-level folder name inside the zip (e.g., REPO-<sha>/)
# Use a variable to avoid SIGPIPE from pipefail when head closes early
listing="$(zipinfo -1 "$zip")"
top="$(echo "$listing" | head -n 1 | cut -d/ -f1)"
want="${top}/${SUBDIR%/}/"

# Validate the requested directory exists in the zip
if ! echo "$listing" | grep -q "^${want}"; then
  echo "ERROR: '${SUBDIR}' not found in ${REPO}@${REF}"
  echo "Tip: verify the path; it must be relative to repo root."
  exit 2
fi

mkdir -p "$tmp/out" "$DEST"

# Extract only the requested directory
unzip -qo "$zip" "${want}*" -d "$tmp/out"

# Copy extracted dir contents into DEST (preserve structure under SUBDIR)
# If you want the SUBDIR folder itself copied into DEST, change the rsync source to "$tmp/out/$want"
rsync -a --delete "$tmp/out/$want" "$DEST"/
echo "Done: ${REPO}@${REF}:${SUBDIR} -> ${DEST}"
