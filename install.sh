#!/bin/bash

if [ -f edit.sh ]
then
	sudo bash edit.sh
fi

if [ -d $HOME/backups ] > /dev/null
then
	echo "Backup directory exists, changing working directory..."
	cd $HOME/backups
else
	echo "Backup directory was never made.  Nothing to restore."
	exit 0
fi

if [ -f install_ppas.sh ]
then
	echo "Installing PPAs..."
	sudo bash install_ppas.sh
	if (grep "vscode" install_ppas.sh)
	then
		wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add - > /dev/null
	elif (grep "vscodium" install_ppas.sh)
	then
		curl -fSsL https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/master/pub.gpg | sudo gpg --dearmor | sudo tee /usr/share/keyrings/vscodium.gpg > /dev/null
	fi
else
	echo "install_ppas.sh not found."
fi

sudo launchpad-getkeys

if [ -f apt-installed && -f package-list ]
then
	echo "Installing applications..."
	sudo xargs apt install -y < apt-installed 
	sudo xargs apt install -y < package-list
else
	echo "Application backup not found."
	exit 0
fi

sudo rm /etc/sudoers.d/dont-prompt-$USER

exit 0