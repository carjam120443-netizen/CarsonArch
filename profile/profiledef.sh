#!/usr/bin/env bash

iso_name="carsonarch"
iso_label="CARSONARCH"
iso_publisher="CarsonArch Project"
iso_application="CarsonArch Live/Install Media"
iso_version="$(date +%Y.%m.%d)"
install_dir="arch"

buildmodes=('iso')
bootmodes=('bios.syslinux' 'uefi.systemd-boot')
archisobasedir="$install_dir"
