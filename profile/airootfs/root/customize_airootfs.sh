#!/usr/bin/env bash
set -e

# Enable the graphical login in the live environment.
systemctl enable lightdm.service

# NetworkManager is already enabled by the releng profile.
# Do not re-enable it here, which would fail if the symlink already exists.

# Install the AUR-built yay package into the live environment.
if [[ -f /root/yay.pkg.tar.zst ]]; then
  pacman -U --noconfirm /root/yay.pkg.tar.zst
  rm -f /root/yay.pkg.tar.zst
fi

# Keep the CarsonArch Fastfetch config in the live user's skeleton.
install -d -m 0755 /etc/skel/.config/fastfetch
cp /etc/fastfetch/config.jsonc /etc/skel/.config/fastfetch/config.jsonc

# Keep the live environment clearly identified.
cat > /etc/motd <<'EOF'
Welcome to CarsonArch!

Arch-based, Carson-built, and ready to customize.
EOF
