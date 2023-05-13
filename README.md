# DevEnv
The idea is to back up all of the installed applications, their PPA sources and place the output into files for easy re-installation should it be required.

## Files
- The *backup-software.sh* creates a backups directory in the home directory.  
-- Inside backups, an install_ppas.sh is created to easily reinstall the PPA repositories that existed.  
-- An apt-installed document that lists all of the applications manually installed from the terminal.
-- A package-list document of the applications that are on your system.  There may be duplicates from the `apt-mark showmanual` command, but will not cause an issue.  Duplicate calls to install a script will cause apt to check for an update, then move on if one doesn't exist.

- The *install-software.sh* will look in the backups directory to install the PPA's, and applications listed in the two files.  It will also use the *launchpad-getkeys* to ensure that any PPA requiring keys, adds the keys necessary.

- The *sudoedit.sh* modifies the sudoers file to include the env_keep variable in case a proxy is in use, to configure the *lauchpad-getkeys*.
