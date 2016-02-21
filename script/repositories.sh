#!/bin/bash -eux

distro=$(sed -n 's/^distroverpkg=//p' /etc/yum.conf)
releasever=$(rpm -q --qf "%{version}" -f /etc/$distro)
basearch=$(rpm -q --qf "%{arch}" -f /etc/$distro)

wget "http://artifactory.lan.ianduffy.ie/remote-centos/RPM-GPG-KEY-CentOS-${releasever}" -O "/etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-$releasever"
rpm --import "/etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-$releasever"


wget "http://artifactory.lan.ianduffy.ie/remote-fedora/epel/RPM-GPG-KEY-EPEL-${releasever}" -O "/etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-$releasever"
rpm --import "/etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-$releasever"

rm -rf /etc/yum.repos.d/*.repo

cat <<< "
[base]
name=base
baseurl=http://artifactory.lan.ianduffy.ie/remote-centos/$releasever/os/$basearch/
priority=1
enabled=1
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-$releasever
" > /etc/yum.repos.d/base.repo

cat <<< "
[updates]
name=updates
baseurl=http://artifactory.lan.ianduffy.ie/remote-centos/$releasever/updates/$basearch/
priority=1
enabled=1
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-$releasever
" > /etc/yum.repos.d/updates.repo

cat <<< "
[extras]
name=extras
baseurl=http://artifactory.lan.ianduffy.ie/remote-centos/$releasever/extras/$basearch/
priority=1
enabled=1
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-$releasever
" > /etc/yum.repos.d/extras.repo

cat <<< "
[plus]
name=plus
baseurl=http://artifactory.lan.ianduffy.ie/remote-centos/$releasever/centosplus/$basearch/
priority=1
enabled=1
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-$releasever
" > /etc/yum.repos.d/plus.repo

cat <<< "
[epel]
name=epel
baseurl=http://artifactory.lan.ianduffy.ie/remote-fedora/epel/$releasever/$basearch/
priority=1
enabled=1
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-$releasever
" > /etc/yum.repos.d/epel.repo
