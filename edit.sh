#!/usr/bin/env bash

if (sudo grep "env_keep" /etc/sudoers)
then
    echo "env_keep exists."
else
    echo "Adding env_keep to sudoers for launchpad_getkeys to work."
    sudo sed -Ei 's/^(Defaults(.*)env_reset)/Defaults\2env_keep = \"http_proxy\"\n\1/' /etc/sudoers
fi

if [ -f /etc/sudoers.d/dont-prompt-$USER ]
then
    echo "User permissions exist."
else
    echo "Adding user permissions."
    echo "$USER ALL=(ALL:ALL) NOPASSWD: ALL" | sudo tee "/etc/sudoers.d/dont-prompt-$USER"
    sudo chmod 0440 /etc/sudoers.d/dont-prompt-$USER > /dev/null
    echo "Entry appended."
fi

echo "Verifying additions..."
sudo visudo -cq > ./sudoerErr

if [ $? == 0 ]
then 
    echo "Additions to sudoers was successful."
else
    echo "There was an issue.  Use \`sudo visudo\` to verify contents."
    echo ./sudoerErr
fi

rm ./sudoerErr
exit 0