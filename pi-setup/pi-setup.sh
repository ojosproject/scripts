#!/bin/bash
#
# pi-setup.sh
# Ojos Project
# 
# This is a setup script for the Raspberry Pi that will be used for the Ojos
# Project.
# 
# To run this script, please run this command in the terminal:
# bash pi-setup.sh
printf "READ THE FOLLOWING IMPORTANT INFORMATION CAREFULLY.

This script was designed for Raspberry Pis that are used for the Ojos Project
at the University of California, Irvine.

This script will:
    1. Overwrite settings
    2. Create a new user
    3. Delete the current user (keeping home directory)

We recommend that you do not use this on a personal device. YOU HAVE BEEN WARNED.

"

# TODO: Add firewall, our public SSH keys, require sudo passwords, etc.

function run() {
    echo "Asking for sudo permissions..."
    sudo -v

    echo "Thank you for your permission, $USERNAME."

    echo "Updating software..."
    sudo apt update && sudo apt upgrade -y

    echo "Setting hostname..."
    sudo raspi-config nonint do_hostname pi4ojos

    echo "Setting option 'Boot to console, requiring login'"
    sudo raspi-config nonint do_boot_behaviour B2

    echo "Setting option 'Boot without waiting for network connection'"
    sudo raspi-config nonint do_boot_wait 0

    echo "Setting option 'Enable splash screen'"
    sudo raspi-config nonint do_boot_splash 0

    echo "Enabling SSH..."
    sudo raspi-config nonint do_ssh 0

    echo "Setting localisation options..."
    sudo raspi-config nonint do_change_locale "en_US.UTF-8 UTF-8"
    sudo raspi-config nonint do_change_timezone America/Los_Angeles
    sudo raspi-config nonint do_configure_keyboard us
    sudo raspi-config nonint do_wifi_country US

    echo "Logins for the Raspberry Pi are going to be STANDARDIZED."
    echo "Enter your first name: "
    read -r new_username

    echo "Adding user $new_username..."
    sudo adduser "$new_username"

    echo "WARNING: You will be given sudo permissions. Please use with care."
    sudo usermod -aG sudo "$new_username"

    echo "Deleting current user $USERNAME..."
    echo "Note: Your home directory will be preserved."
    sudo deluser "$USERNAME"

    echo "Please log in with your new username '$new_username'."

}

echo -n "Proceed? [y/N]: "
read -rn 1 consent

if [[ $consent == "y" ]]; then
    printf "\nCONSENT PROVIDED. INITIATING SETUP...\n"
    run
fi
