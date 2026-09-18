#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
PROFILE="$SCRIPT_DIR/profile"
OUT="$SCRIPT_DIR/out"
WORK="$SCRIPT_DIR/work"
STAGE="$WORK/profile"

command -v mkarchiso >/dev/null 2>&1 || {
  echo "Error: mkarchiso is required. Install the archiso package first." >&2
  exit 1
}

ARCHISO_RELENG="/usr/share/archiso/configs/releng"
if [[ ! -d "$ARCHISO_RELENG" ]]; then
  echo "Error: the installed archiso package does not provide the releng profile at:" >&2
  echo "  $ARCHISO_RELENG" >&2
  exit 1
fi

if [[ $EUID -ne 0 ]]; then
  exec sudo "$SCRIPT_DIR/build.sh" "$@"
fi

rm -rf "$OUT" "$WORK"
mkdir -p "$STAGE"

cp -a "$ARCHISO_RELENG"/. "$STAGE"/
cp -a "$PROFILE"/. "$STAGE"/

mkarchiso -v -r -w "$WORK/work" -o "$OUT" "$STAGE"
