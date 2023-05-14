#!/bin/bash

ppas=(
  "add-apt-repository ppa:maarten-fonville/android-studio" 
  "add-apt-repository 'deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main'" 
  "add-apt-repository ppa:cappelikan/ppa" 
  "add-apt-repository ppa:tuxinvader/lts-mainline" 
  "add-apt-repository -y ppa:mmk2410/intellij-idea" 
  "echo deb [signed-by=/usr/share/keyrings/vscodium.gpg] https://download.vscodium.com/debs vscodium main | sudo tee /etc/apt/sources.list.d/vscodium.list > /dev/null"
  "$@"
) 

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

for ppa in ${ppas[@]}
do
  if "add-apt-repository" in $ppa || "echo" in $ppa
  then
    echo $ppa >> install_ppas.sh
  else
    echo "add-apt-repository -y $ppa" >> install_ppas.sh
  fi
done

apt-mark showmanual > apt-installed

sudo dpkg -l | awk '/^ii/ { print $2 }' > package-list

exit 0