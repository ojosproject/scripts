#!/bin/bash
#
# setup.sh
# Ojos Project
# 
# This is a setup script for the Raspberry Pi that will be used for the Ojos
# Project.
# 
# To run this script, please run this command in the terminal:
# bash setup.sh
printf "READ THE FOLLOWING IMPORTANT INFORMATION CAREFULLY.

This script was designed for Raspberry Pis that are used for the Ojos Project
at the University of California, Irvine.

This script may or may not overwrite information on this device. We recommend
that you do not use this on a personal device. YOU HAVE BEEN WARNED.\n\n"

function run() {
    sudo -v
}

echo -n "Proceed? [y/N]: "
read -rn 1 consent

if [[ $consent == "y" ]]; then
    printf "\nCONSENT PROVIDED. INITIATING SETUP...\n"
    run
fi
