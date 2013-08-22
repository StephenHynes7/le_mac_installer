#!/bin/bash
     
    #############################################
    #
    #       Quickstart Agent Installer
    #       Author: Stephen Hynes
    #       Version: 1.0
    #
    #
    #
    #############################################
     
     
# Need root to run this script
if [ "$(id -u)" != "0" ] 
then
	echo "Please run this  script as root."
	echo "Usage: sudo bash quickstart.sh"
	exit 1
fi
     
    REGISTER_CMD="./le register"
    LE_LOCATION="https://raw.github.com/logentries/le/master/le"
    CURL="/usr/bin/curl"
    CURL_TAGS="-O"
    LOGGER_CMD="logger -t LogentriesTest Test Message Sent By LogentriesAgent"
    LE_FOLLOW="./le follow"
    LE_MONITOR="./le monitor"
     
    printf "Welcome to the Logentries Install Script for "; hostname;
    $CURL $CURL_TAGS $LE_LOCATION
    chmod a+x le
    printf "We will now register your machine.\n"
    printf "\n"
    $REGISTER_CMD
    printf "\n"
    printf "This script will guide you through following your first set of logs. \n"
    printf "I have automatically followed these files of interest for you.\n"
     
     
    if [ -f /var/log/system.log ];  then
    printf "/var/log/system.log - System logs.\n"
    $LE_FOLLOW /var/log/system.log
    fi
    printf "\n"
    if [ -f /var/log/install.log ]; then
    printf "/var/log/install.log - Install logs.\n"
    $LE_FOLLOW /var/log/install.log
    fi
    printf "\n"
    if [ -f /var/log/fsck_hfs.log ]; then
    printf "/var/log/fsck_hfs.log - FSCK log file.\n"
    $LE_FOLLOW /var/log/fsck_hfs.log
    fi
    printf "\n"
    if [ -f /var/log/opendirectoryd.log ]; then
    printf "/var/log/opendirectoryd.log - Open Directoryd log.\n"
    $LE_FOLLOW /var/log/opendirectoryd.log
    fi
    printf "\n"
    if [ -f /var/log/appfirewall.log ]; then
    printf "/var/log/appfirewall.log - App firewall log.\n"
    $LE_FOLLOW /var/log/appfirewall.log
    fi
    printf "\n"
     
    logger -p "Logentries Agent Test Event 1" >> /var/log/system.log
    logger -p "Logentries Agent Test Event 3" >> /var/log/system.log
    logger -p "Logentries Agent Test Event 4" >> /var/log/system.log
    logger -p "Logentries Agent Test Event 5" >> /var/log/system.log
    logger -p "Logentries Agent Test Event 6" >> /var/log/system.log
    logger -p "Logentries Agent Test Event 7" >> /var/log/system.log
    logger -p "Logentries Agent Test Event 8" >> /var/log/system.log
     
    printf "Install Complete!\n\n"
    printf "Will now monitor logs from terminal"
    $LE_MONITOR
     
    exit 0


