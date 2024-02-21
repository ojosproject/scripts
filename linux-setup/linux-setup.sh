#!/bin/bash
# 
# linux-setup.sh
# Ojos Project
# 
# This is a setup script designed for people working on the Ojos Project at the
# University of California, Irvine. It installs programs that we will be using
# for the project. This script should be updated constantly.

printf "
-------------------------------------------------------------------------------
READ THE FOLLOWING INFORMATION CAREFULLY.

This script was designed for individuals working on the Ojos Project at the
University of California, Irvine working on the Ojos Project. The goal of this
script is to:

    1. Install packages needed for the project
    2. Change your Linux shell to zsh
    3. Add a .zshrc file to add more useful features to your shell

Please make sure you are running a Debian-based Linux distribution.

This script **will** rewrite your .zshrc file if you have one. YOU HAVE BEEN
WARNED.

-------------------------------------------------------------------------------
"

CDRIVE_COMMAND_INSTRUCTIONS="
-------------------------------------------------------------------------------
'cdrive' COMMAND SETUP
            
When you type 'cdrive' on the terminal, it will take you to your
Windows home directory. To do that, I will need your Windows
username. Your username can be found here: 
            
Open Powershell -> 'PS C:\\Users\[THIS IS YOUR USERNAME]>' 
-------------------------------------------------------------------------------

"

# these are the programs that will be installed using apt
APT_PACKAGES=("nodejs" "npm" "gpg" "vim" "zsh")

function checkOrInstall() {
    # checks to see if a command is available
    # if a command is not available, it will install it
    # it takes 1 argument: $1, which is the command we are looking for

    if [[ "$1" == "nodejs" ]]; then
        # node in apt is 'nodejs', but command is 'node'
        set -- "node"
    fi;

    if ! command -v "$1" &> /dev/null; then
        echo "Installing $1..."
        sudo apt install "$1" -y

        # if the command is zsh
        # it will setup .zshrc
        if [[ $1 == "zsh" ]]; then
            echo "$CDRIVE_COMMAND_INSTRUCTIONS"

            echo -n "What is your Windows username? "
            read -r username

            echo "Installing .zshrc..."
            cp -f "$PWD"/linux-setup/.zshrc ~/.zshrc

            # creates a new alias, "cdrive", to take users to their Windows
            # home directory
            echo "alias cdrive=\"cd /mnt/c/Users/$username\"" >> ~/.zshrc

            echo "Asking to switch shell..."
            chsh -s "$(which zsh)"
        fi

    else {
        echo "Found $1, moving on..."
    }
    fi
}

function run() {
    echo "Asking for sudo permissions..."
    sudo -v

    echo "Installing updates..."
    sudo apt update
    sudo apt upgrade

    echo "Installing packages..."
    for package in "${APT_PACKAGES[@]}"; do
        checkOrInstall "$package"
    done

    echo "SUCCESS. Please close this terminal. Thanks!"
}

echo -n "Continue? [y/N]: "
read -rn 1 consent

if [[ $consent == "y" ]]; then
    printf "\n\nCONSENT PROVIDED. INITIATING SETUP...\n\n"
    run
fi
