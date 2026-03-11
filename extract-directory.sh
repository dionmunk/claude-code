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

src="$tmp/out/$want"

# Snapshot existing items before sync
before="$tmp/before.txt"
after="$tmp/after.txt"
if [ -d "$DEST" ]; then
  (cd "$DEST" && find . -mindepth 1 -maxdepth 1 -type d | sed 's|^\./||' | sort) > "$before"
else
  touch "$before"
fi

# Snapshot incoming items
(cd "$src" && find . -mindepth 1 -maxdepth 1 -type d | sed 's|^\./||' | sort) > "$after"

# Compute added, removed, and common items
added=$(comm -13 "$before" "$after")
removed=$(comm -23 "$before" "$after")
common=$(comm -12 "$before" "$after")

# Determine which common items have changed (must diff BEFORE rsync)
updated=""
unchanged=""
if [ -n "$common" ]; then
  while IFS= read -r item; do
    if ! diff -rq "$src/$item" "$DEST/$item" > /dev/null 2>&1; then
      updated="${updated:+$updated$'\n'}$item"
    else
      unchanged="${unchanged:+$unchanged$'\n'}$item"
    fi
  done <<< "$common"
fi

# Sync contents into DEST
rsync -a --delete "$src" "$DEST"/

# Report summary
echo ""
echo "Synced ${REPO}@${REF}:${SUBDIR} -> ${DEST}"
echo ""

if [ -n "$added" ]; then
  while IFS= read -r item; do
    echo "  + added:     $item"
  done <<< "$added"
fi

if [ -n "$updated" ]; then
  while IFS= read -r item; do
    echo "  ~ updated:   $item"
  done <<< "$updated"
fi

if [ -n "$removed" ]; then
  while IFS= read -r item; do
    echo "  - removed:   $item"
  done <<< "$removed"
fi

if [ -n "$unchanged" ]; then
  while IFS= read -r item; do
    echo "    unchanged: $item"
  done <<< "$unchanged"
fi

# Count totals
count_added=$([ -n "$added" ] && echo "$added" | wc -l | tr -d ' ' || echo 0)
count_updated=$([ -n "$updated" ] && echo "$updated" | wc -l | tr -d ' ' || echo 0)
count_removed=$([ -n "$removed" ] && echo "$removed" | wc -l | tr -d ' ' || echo 0)
count_total=$(wc -l < "$after" | tr -d ' ')

echo ""
echo "Total: $count_total items ($count_added added, $count_updated updated, $count_removed removed)"
