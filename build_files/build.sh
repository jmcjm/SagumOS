#!/bin/bash

set -ouex pipefail

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/39/x86_64/repoview/index.html&protocol=https&redirect=1

# this installs a package from fedora repos
dnf5 install -y tmux

# Use a COPR Example:
#
# dnf5 -y copr enable ublue-os/staging
# dnf5 -y install package
# Disable COPRs so they don't end up enabled on the final image:
# dnf5 -y copr disable ublue-os/staging

### Adding MS repo for Defender for Endpoints
# Detecting Fedora version from the image
FEDORA_VERSION=$(rpm -E %fedora)

cat << EOF > /etc/yum.repos.d/microsoft-prod.repo
[microsoft-prod]
name=Microsoft Prod repo
baseurl=https://packages.microsoft.com/config/fedora/${FEDORA_VERSION}/prod.repo
enabled=1
gpgcheck=1
gpgkey=https://packages.microsoft.com/keys/microsoft.asc
EOF

# Importing the key
rpm --import https://packages.microsoft.com/keys/microsoft.asc

# Installing
dnf5 install -y mdatp

### Adding Google Chrome repo
cat << 'EOF' > /etc/yum.repos.d/google-chrome.repo
[google-chrome]
name=Google Chrome Repo
baseurl=https://dl.google.com/linux/chrome/rpm/stable/x86_64
enabled=1
gpgcheck=1
gpgkey=https://dl.google.com/linux/linux_signing_key.pub
EOF

# Installing
dnf5 install -y google-chrome-stable

### Installing Nerd Fonts (SourceCodePro)
mkdir -p /usr/share/fonts/nerd-fonts
curl -L -o /tmp/SourceCodePro.zip https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/SourceCodePro.zip
unzip -o /tmp/SourceCodePro.zip -d /usr/share/fonts/nerd-fonts
rm /tmp/SourceCodePro.zip

# Rebuild font cache
fc-cache -f

### Misc
dnf5 install -y ripgrep
dnf5 install -y sl

# Git utilities
dnf5 install -y git-delta  # lepszy diff viewer
dnf5 install -y lazygit    # TUI dla gita

# Build tools
dnf5 install -y clang clang-tools-extra

# Database clients
dnf5 install -y postgresql

# Network tools
dnf5 install -y httpie
dnf5 install -y jq
dnf5 install -y yq

# Better shell tools
dnf5 install -y zoxide
dnf5 install -y bat
dnf5 install -y eza
dnf5 install -y fd-find

dnf5 install -y btop
dnf5 install -y iotop

dnf5 clean all

#### Example for enabling a System Unit File

systemctl enable podman.socket
