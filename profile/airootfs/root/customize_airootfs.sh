#!/usr/bin/env bash
set -e

# Enable the graphical login and networking in the live environment.
systemctl enable lightdm.service
systemctl enable NetworkManager.service

# Keep the live environment clearly identified.
cat > /etc/motd <<'EOF'
Welcome to CarsonArch!

Arch-based, Carson-built, and ready to customize.
EOF
