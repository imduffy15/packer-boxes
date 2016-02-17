#!/bin/bash -eux

SSH_USER=${SSH_USERNAME:-root}
SSH_USER_HOME=${SSH_USER_HOME:-/${SSH_USER}}

echo "==> Installing Parallels tools"
mount -o loop $SSH_USER_HOME/prl-tools-lin.iso /mnt
sh /mnt/install --install-unattended-with-deps
umount /mnt
rm -rf $SSH_USER_HOME/prl-tools-lin.iso
rm -f $SSH_USER_HOME/.prlctl_version

echo "==> Removing packages needed for building guest tools"
yum -y remove gcc cpp libmpc mpfr kernel-devel kernel-headers perl
