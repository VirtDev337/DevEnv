#!/bin/bash

sudo rm /etc/sudoers.d/dont-prompt-$USER
sed -Ei "s#^alias (install|backup|configure|uninstall)=\"bash ~/.config/DevEnv/\1.sh\"##" ~/.bash_aliases
rm -rf $HOME/.config/DevEnv