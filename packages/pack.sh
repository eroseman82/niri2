#!/usr/bin/env bash

set -e

if [ -z "$1" ]; then
  echo "Usage: $0 <desired_pkglist>"
  exit 1
fi

desired="$1"
current=$(mktemp)
desired_sorted=$(mktemp)

# Current installed packages
pacman -Qq | sort >"$current"

# Desired list normalized
sort "$desired" | uniq >"$desired_sorted"

echo "=== Missing packages (in desired, not installed) ==="
comm -23 "$desired_sorted" "$current"

echo ""
echo "=== Extra packages (installed, not in desired) ==="
comm -13 "$desired_sorted" "$current"

rm "$current" "$desired_sorted"
