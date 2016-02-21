#!/bin/bash -eux

HOME_DIR="${HOME_DIR:-/root}";
VBOX_VERSION=$(cat $HOME_DIR/.vbox_version)

echo "==> Installing VirtualBox guest additions"
yum -y install autoconf bison flex gcc gcc-c++ kernel-devel kernel-headers m4 patch perl
mkdir -p /tmp/vbox;
mount -o loop $HOME_DIR/VBoxGuestAdditions_$VBOX_VERSION.iso /tmp/vbox;
sh /tmp/vbox/VBoxLinuxAdditions.run \
    || echo "VBoxLinuxAdditions.run exited $? and is suppressed." \
        "For more read https://www.virtualbox.org/ticket/12479";
umount /tmp/vbox;
rm -rf /tmp/vbox;
rm -f $HOME_DIR/*.iso;