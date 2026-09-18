# CarsonArch

A custom Arch Linux distribution built around a clean, reproducible ArchISO profile.

## Project status

🚧 Early development — the repository currently contains the project documentation and build scaffolding. No release ISO is claimed yet.

## Goals

- Stay close to upstream Arch Linux rather than maintaining a heavily forked base.
- Produce a reproducible x86_64 live/installable ISO with ArchISO.
- Keep Carson-specific configuration and packages separated from upstream components.
- Provide a practical desktop environment while keeping the system customizable.
- Eventually provide CarsonArch packages through a pacman-compatible repository.
- Test every release in VirtualBox before calling it release-ready.

## Planned layout

```text
.
├── README.md
├── LICENSE
├── build.sh
├── profile/
│   ├── profiledef.sh
│   ├── packages.x86_64
│   ├── pacman.conf
│   ├── airootfs/
│   └── syslinux/
├── packages/
│   └── carson-*/
├── repo/
└── tests/
```

The exact layout may change as the build system develops.

## Build approach

CarsonArch uses ArchISO rather than manually assembling an ISO. ArchISO's `mkarchiso` tool is the intended ISO builder.

Before a release is published, the ISO should be:

1. Built from a clean Arch build environment.
2. Checked for package/build errors.
3. Boot-tested as a live ISO.
4. Installed and boot-tested in VirtualBox.
5. Checked for networking, package management, users, graphics, shutdown/reboot, and basic desktop functionality.

## Package policy

CarsonArch should prefer official Arch repositories for upstream software. Carson-specific software belongs in dedicated PKGBUILDs and, eventually, a CarsonArch pacman repository.

AUR packages are not treated as official CarsonArch packages.

## Important

CarsonArch is an independent project and is not an official Arch Linux distribution.

Arch Linux and ArchISO are upstream projects. CarsonArch-specific modifications are maintained in this repository.
