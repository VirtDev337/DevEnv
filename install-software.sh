#!/bin/bash

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
else
	echo "install_ppas.sh not found."
fi

if [ -f apt-installed && -f package-list ]
then
	echo "Installing applications..."
	sudo xargs apt install -y < apt-installed 
	sudo xargs apt install -y < package-list
else
	echo "Application backup not found."
	exit 0
fi
