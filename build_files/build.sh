#!/bin/bash

set -ouex pipefail

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/39/x86_64/repoview/index.html&protocol=https&redirect=1

# this installs a package from fedora repos
dnf5 install -y \
  tmux \
  cockpit \
  sysstat
  

# Add EPEL and install packages from it
#dnf config-manager --set-enabled crb && \
#  dnf install https://dl.fedoraproject.org/pub/epel/epel-release-latest-10.noarch.rpm && \
#  dnf config-manager --set-disabled epel && \
#  dnf -y install --enablerepo=epel \
#    ripgrep \
#    distrobox \
#    tailscale

dnf5 -y install \
  ripgrep \
  distrobox \
  tailscale


# RPMs to remove
dnf5 -y remove toolbox


# Use a COPR Example:
#
# dnf5 -y copr enable ublue-os/staging
# dnf5 -y install package
# Disable COPRs so they don't end up enabled on the final image:
# dnf5 -y copr disable ublue-os/staging


#### Remove all DNF cache
dnf clean all




#### Example for enabling a System Unit File

# systemctl enable podman.socket
systemctl enable sshd.service
