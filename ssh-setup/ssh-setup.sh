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
    printf "Host git@gitlab.com\n" >> ~/.ssh/config
    printf "\tIdentityFile ~/.ssh/GitLab\n" >> ~/.ssh/config

    echo "Successfully updated your config file."
}

function run() {
    printf "YOU WILL BE ASKED TO ENTER A PASSPHRASE. PLEASE DO NOT FORGET IT.\n\n"
    ssh-keygen -f ~/.ssh/GitLab -t ed25519 -C "GitLab key for Ojos Project"
    printf "\n\nSuccessfully created the 'GitLab' key.\n\n"


    PUBLIC=$(cat ~/.ssh/GitLab.pub)

    saveConfig "$PUBLIC"

    echo "$PUBLIC"

    printf "
    Please copy ^^^this^^^ key to your GitLab account.
    
    Learn more here:
    https://docs.gitlab.com/ee/user/ssh.html#add-an-ssh-key-to-your-gitlab-account\n"
}

echo -n "Continue? [y/N]: "
read -rn 1 consent

if [[ $consent == "y" ]]; then
    printf "\n\nCONSENT PROVIDED. INITIATING SETUP...\n\n"
    run
fi
