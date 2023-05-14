# DevEnv
The idea is to back up all of the installed applications, their PPA sources and place the output into files for easy re-installation should it be required.

## Files
- The ***backup.sh*** creates a backups directory in the home directory.  
  - Inside backups, an ***install_ppas.sh*** is created to easily reinstall the PPA repositories that existed.  
  - An ***apt-installed*** document that lists all of the applications manually installed from the terminal.
  - A ***package-list*** document of the applications that are on your system.  There may be duplicates from the `apt-mark showmanual` command, but will not cause an issue.  Duplicate calls to install a script will cause apt to check for an update, then move on if one doesn't exist.

- The ***install.sh*** will look in the backups directory to install the PPA's, and applications listed in the two files.  It will also use the ***launchpad-getkeys*** to ensure that any PPA requiring keys, adds the keys necessary.

- The ***edit.sh*** modifies the sudoers file to include the env_keep variable in case a proxy is in use, to configure the ***lauchpad-getkeys***. It also adds a don't prompt file for the $USER that runs the script (automatically removed using the install script unless *-k* is used).

## Usage
You can use curl to clone the repo.  In the terminal type: <br>
`curl -# https://raw.githubusercontent.com/VirtDev337/DevEnv/main/configure.sh | bash` <br>  You can also run the *configure.sh* file again locally, with flags to get some of the other benefits of the scripts:
<div>
  
```
Usage:       $ bash configure.sh [options]
  -a        Install Android Studio

  -c        Install VS Code

  -C        Install VS Codium (similar to VS Code but without Microsoft integration)

  -i        Install Intellij IDEA Community Edition

  -k        Keep the no password configuration for sudo commands

  -r        Create a backup now.

  -?        This Usage message.
```
  
</div>

The configure script downloads the repo to ~/.config/DevEnv/.  It also creates or edits your .bash_aliases file to include the commands, so you don't have to remember to use *bash* or where it is located.  
- **install** to recover from backups.
- **backup** to save your sources, applications and packages for reinstallation.
- **configure** with the flags you want to add software, keep the don't prompt file or run a backup.
- **uninstall** will remove the changes made by the script and the DevEnv directory in .config.  The ~/backups directory and the files within will remain.
