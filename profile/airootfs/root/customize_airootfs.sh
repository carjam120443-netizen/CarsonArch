#!/usr/bin/env bash
set -e

# Enable the graphical login in the live environment.
systemctl enable lightdm.service

# NetworkManager is already enabled by the releng profile.
# Do not re-enable it here, which would fail if the symlink already exists.

# Keep the live environment clearly identified.
cat > /etc/motd <<'EOF'
Welcome to CarsonArch!

Arch-based, Carson-built, and ready to customize.
EOF
