#!/bin/bash

set -ouex pipefail

RELEASE="$(rpm -E %fedora)"


### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/39/x86_64/repoview/index.html&protocol=https&redirect=1

rpm-ostree install -y virt-manager edk2-ovmf qemu htop zsh sunshine systemd-boot-unsigned sdubby vagrant vagrant-libvirt
#rpm-ostree kargs \
#--append-if-missing="kvm.ignore_msrs=1" \
#--append-if-missing="kvm.report_ignored_msrs=0"

systemctl enable libvirtd
systemctl enable sunshine-workaround

# Fix rebase-checker in ublue-system-update.py
sed -i 's/ublue-os\/bazzite/liaralabs\/bazzite/' /usr/share/ublue-os/image-info.json
