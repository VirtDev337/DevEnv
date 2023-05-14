usage="Usage:       $ bash configure.sh [options]
  -a        Install Android Studio

  -c        Install VS Code

  -C        Install VS Codium (similar to VS Code but without Microsoft integration)

  -i        Install Intellij IDEA Community Edition

  -k        Keep the no password configuration for sudo commands

  -r        Create a backup now.

  -?        This Usage message."


keep=false
run=false

if ( apt list --installed | grep -E "/wget|curl|apt\-transport\-https|software-properties-commmon/" && git --version ) > /dev/null
then
    echo "Development dependencies are already installed."
else
    echo "Adding development dependencies..."
    sudo apt install -y software-properties-common apt-transport-https wget git curl > /dev/null
fi

while getopts "?acCikr" option
do
    case $option in
        a)
            if ( apt list --installed | grep android-studio ) > /dev/null
            then
                echo "Android Studio is already installed."
            else
                echo "Installing Android Studio..."
                sudo dpkg --add-architecture i386
                sudo apt install -y openjdk-14-jdk libc6:i386 libncurses5:i386 libstdc++6:i386 lib32z1 libbz2-1.0:i386 > /dev/null

                sudo add-apt-repository -y ppa:maarten-fonville/android-studio > /dev/null
                
                sudo apt install -y android-studio
            fi
        ;;
        c)
            if ( apt list --installed | grep code/stable ) > /dev/null
            then
                echo "VS Code is already installed."
            else
                echo "Installing VS Code..."
                sudo apt install -y code
            fi
        ;;
        C)
            if ( apt list --installed | grep codium ) > /dev/null
            then
                echo "VS Codium is already installed."
            else
                echo "Installing VS Codium..."
                curl -fSsL https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/master/pub.gpg | sudo gpg --dearmor | sudo tee /usr/share/keyrings/vscodium.gpg > /dev/null
                
                echo deb [signed-by=/usr/share/keyrings/vscodium.gpg] https://download.vscodium.com/debs vscodium main | sudo tee /etc/apt/sources.list.d/vscodium.list > /dev/null
                
                sudo apt update > /dev/null
                sudo apt install -y codium
            fi
        ;;
        i)
            if ( apt list --installed | grep intellij-idea-* ) > /dev/null
            then
                echo "IDEA is already installed."
            else
                echo "Installing IntelliJ IDEA Community Edition..."
                sudo add-apt-repository -y ppa:mmk2410/intellij-idea > /dev/null
                sudo apt update > /dev/null
                sudo apt install -y intellij-idea-community
            fi
        ;;
        k)
            keep=true
        ;;
        r)
            run=true
        ;;
        ?) 
            echo $usage
            echo ""
            exit
        ;;
    esac
done

if ( git --version )
then
    if [ -d ~/.config/DevEnv ]
    then
        cd ~/.config/DevEnv
    else
        echo "Downloading the necessary files..."
        cd ~/.config
        git clone https://github.com/VirtDev337/DevEnv.git > /dev/null
        cd ./DevEnv
    fi
fi

if [ $keep ]
then
    sed -Ei "s/^(sudo rm /etc/sudoers.d/dont-prompt-$USER)/#\1/" ./install.sh  > /dev/null
    sudo bash edit.sh > /dev/null
fi

if [ $run ]
then
    echo "Backing up the sources and generating installed applicrions and packages list."
    bash backup.sh
fi

if [ -f ~/.bash_aliases ]
then
    echo ".bash_aliases exists."
else
    echo "Creating .bash_aliases..."
    touch ~/.bash_aliases
fi

echo "Creating command aliases."
echo 'alias install="bash ~/.config/DevEnv/install.sh"
alias backup="bash ~/.config/DevEnv/backup.sh"
alias uninstall="bash ~/.config/DevEnv/uninstall.sh"' >> ~/.bash_aliases

exit 0
