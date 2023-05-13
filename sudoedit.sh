#!/usr/bin/env bash

if (sudo grep "/^Defaults\senv_keep\s=\s\"http_proxy\"/" /etc/sudoers)
then
    echo "env_keep exists and is correct."
else
    echo "Adding env_keep to sudoers for launchpad_getkeys to work."
    sudo sed -E '/^(%Defaults(.+)env_reset)/i "Defaults \2 env_keep = \"http_proxy\"" \1 /' /etc/sudoers
fi

if (grep -q /^"virtdev\tALL=(ALL) NOPASSWD:ALL"/ /etc/sudoers)
then
    echo "User permissions added."
else
    echo "Adding user permissions."
    sudo sed -Ei '/^root(\s)ALL=\(ALL:ALL\) ALL/a virtdev\tALL=(ALL) NOPASSWD:ALL' etc/sudoers
    echo "Entry appended."
fi

echo "Verifying additions..."
sudo visudo -cq > ./sudoerErr

if [ $? == 0 ]
then 
    echo "Additions to sudoers was successful."
else
    echo "There was an issue.  Use \`sudo visudo\` to verify contents."
    cat ./sudoerErr
fi