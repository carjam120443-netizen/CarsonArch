#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
PROFILE="$SCRIPT_DIR/profile"
OUT="$SCRIPT_DIR/out"
WORK="$SCRIPT_DIR/work"
STAGE="$WORK/profile"
YAY_BUILD="$WORK/yay-build"

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

# yay is an AUR package, so it cannot be listed in packages.x86_64.
# Build the current AUR package during the ISO build and install the
# resulting package into the live environment.
pacman -Syu --noconfirm git base-devel go
mkdir -p "$YAY_BUILD"
useradd --create-home --shell /bin/bash carson-yay
chown -R carson-yay:carson-yay "$YAY_BUILD"
runuser -u carson-yay -- git clone --depth 1 https://aur.archlinux.org/yay.git "$YAY_BUILD/yay"
runuser -u carson-yay -- bash -c "cd '$YAY_BUILD/yay' && makepkg --noconfirm --nodeps"
YAY_PACKAGE="$(find "$YAY_BUILD/yay" -maxdepth 1 -type f -name 'yay-*.pkg.tar.zst' -print -quit)"
if [[ -z "$YAY_PACKAGE" ]]; then
  echo "Error: yay package was not produced by makepkg." >&2
  exit 1
fi
cp "$YAY_PACKAGE" "$STAGE/airootfs/root/yay.pkg.tar.zst"
rm -rf "$YAY_BUILD"
userdel --remove carson-yay || true

mkarchiso -v -r -w "$WORK/work" -o "$OUT" "$STAGE"
