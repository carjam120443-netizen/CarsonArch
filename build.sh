#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
PROFILE="$SCRIPT_DIR/profile"
OUT="$SCRIPT_DIR/out"
WORK="$SCRIPT_DIR/work"

command -v mkarchiso >/dev/null 2>&1 || {
  echo "Error: mkarchiso is required. Install the archiso package first." >&2
  exit 1
}

sudo rm -rf "$OUT" "$WORK"
sudo mkarchiso -v -w "$WORK" -o "$OUT" "$PROFILE"
