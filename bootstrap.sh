#!/bin/sh

echo "nameserver 8.8.8.8" > /etc/resolv.conf
command -v puppet > /dev/null && { echo "Puppet is installed! skipping" ; exit 0; }


#memory extension for elaticsearch
#cp -r /vagrant/conf/sysctl.conf /etc/sysctl.conf && sysctl -p

ID=$(cat /etc/os-release | awk -F= '/^ID=/{print $2}' | tr -d '"')
VERS=$(cat /etc/os-release | awk -F= '/^VERSION_ID=/{print $2}' | tr -d '"')

case "${ID}" in
  centos|rhel)
    wget https://yum.puppet.com/puppet5/puppet5-release-el-${VERS}.noarch.rpm
    rpm -Uvh puppet5-release-el-${VERS}.noarch.rpm
    yum install -y puppet-agent
    ;;
  fedora)
    rpm -Uvh https://yum.puppet.com/puppet5/puppet5-release-fedora-${VERS}.noarch.rpm
    yum install -y puppet-agent
    ;;
  debian|ubuntu)
    wget https://apt.puppetlabs.com/puppet5-release-$(lsb_release -cs).deb
    dpkg -i puppet5-release-$(lsb_release -cs).deb
    apt-get -qq update
    apt-get install -y puppet-agent
    rm puppet5-release-$(lsb_release -cs).deb
    ;;
  *)
    echo "Distro '${ID}' not supported" 2>&1
    exit 1
    ;;
esac
