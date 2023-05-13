#!/bin/bash

list_ppas () {
  grep -E '^deb\s' /etc/apt/sources.list /etc/apt/sources.list.d/*.list |\
    cut -f2- -d: |\
    cut -f2 -d' ' |\
    sed -re 's#http://ppa\.launchpad\.net/([^/]+)/([^/]+)(.*?)$#ppa:\1/\2#g' |\
    grep '^ppa:'
}

if [ -d $HOME/backups ] > /dev/null
then
  cd $HOME/backups
else
  mkdir $HOME/backups
  cd $HOME/backups
fi

list_ppas | xargs printf 'add-apt-repository -y %s\n' > install_ppas.sh

apt-mark showmanual > apt-installed

sudo dpkg -l | awk '/^ii/ { print $2 }' > package-list
