#!/bin/bash

sudo rm /etc/sudoers.d/dont-prompt-$USER
sed -Ei "s/^alias install=|alias backup=|alias uninstall=/\n/" ~/.bash_aliases
rm -rf $HOME/.config/DevEnv