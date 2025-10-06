#!/bin/bash

set -ouex pipefail

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/39/x86_64/repoview/index.html&protocol=https&redirect=1

# this installs a package from centos repos
dnf install -y \
  tmux \
  cockpit \
  sysstat \
  ansible \
  gnome-disk-utility \
  hplip \
  system-reinstall-bootc \
  tuned-ppd \
  wireguard-tools \
  xhost \
  firefox \
  iptraf-ng \
  krb5-workstation \
  libvirt-daemon \
  libvirt-daemon-driver-network \
  libvirt-daemon-driver-nodedev \
  libvirt-daemon-driver-qemu \
  libvirt-daemon-driver-storage \
  libvirt-daemon-config-network \
  libvirt-daemon-config-nwfilter \
  qemu-kvm \
  nmap \
  cockpit-image-builder \
  cockpit-machines \
  cockpit-podman \
  cockpit-storaged




# Add EPEL and install packages from it
dnf config-manager --set-enabled crb && \
  dnf install https://dl.fedoraproject.org/pub/epel/epel-release-latest-10.noarch.rpm && \
  dnf config-manager --set-disabled epel && \
  dnf -y install --enablerepo=epel \
    ripgrep \
    distrobox \
    duperemove \
    gnome-tweaks


# Install tailscale -- includes enabling the repo
dnf config-manager --add-repo https://pkgs.tailscale.com/stable/centos/10/tailscale.repo && \
  dnf -y install tailscale && \
  systemctl enable tailscaled


# RPMs to remove
dnf -y remove toolbox


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
systemctl enable cockpit.socket
systemctl enable libvirtd.socket
