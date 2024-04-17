#!/bin/bash
# 
# ssh-setup.sh
# Ojos Project
# 
# This is a script that is meant to help setup ssh on Unix-like systems. That
# is, macOS or Linux. If you are a Windows user, please install the Windows
# Subsystem for Linux here:
# https://learn.microsoft.com/en-us/windows/wsl/install
# 
# Please read this document as you're using this script:
# https://docs.ojosproject.org/teams/url/ssh-setup/

printf "READ THE FOLLOWING INFORMATION CAREFULLY.

This script was designed for software developers working on the Ojos Project
at the University of California, Irvine. The goal of this script is to set up
SSH on your system.

Please make sure you are running this on a Unix-based system.

Read this document as you try to install:
https://docs.ojosproject.org/teams/url/ssh-setup/

"

function saveConfig() {
    printf "Host github.com\n" >> ~/.ssh/config
    printf "\tIdentityFile ~/.ssh/github\n" >> ~/.ssh/config

    echo "Successfully updated your config file."
}

function run() {
    printf "YOU WILL BE ASKED TO ENTER A PASSPHRASE. PLEASE DO NOT FORGET IT.\n\n"
    ssh-keygen -f ~/.ssh/github -t ed25519 -C "GitHub key for Ojos Project"
    printf "\n\nSuccessfully created the 'github' key.\n\n"


    PUBLIC=$(cat ~/.ssh/github.pub)

    saveConfig "$PUBLIC"

    echo "$PUBLIC"

    printf "
Please copy ^^^this^^^ key to your GitHub account.
    
Learn more here:
https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account\n"
}

echo -n "Continue? [y/N]: "
read -rn 1 consent

if [[ $consent == "y" ]]; then
    printf "\n\nCONSENT PROVIDED. INITIATING SETUP...\n\n"
    run
fi
