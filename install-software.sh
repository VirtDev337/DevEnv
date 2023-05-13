#!/bin/bash

if [ -f install_ppas.sh ]
then
	echo "Installing PPAs..."
	sudo bash install_ppas.sh
else
	echo "install_ppas.sh not found."
fi



wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 6494C6D6997C215E
