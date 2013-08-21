#!/bin/bash

#############################################
#
# 	Quickstart Agent Installer
#	Author: Stephen Hynes
#	Version: 1.0
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

REGISTER_CMD="le register"

follow_folder() {
	for filepath in $1*;do echo le follow $filepath ;done; 
}

printf "Welcome to the Logentries Install Script for "; hostname;
printf "We will now register your machine.\n"
printf "\n"
$REGISTER_CMD
printf "\n"
printf "This script will guide you through following your first set of logs. \n"
printf "I have automatically followed these files of interest for you.\n"

if [ -f /var/log/auth.log ];  then 
printf "/var/log/auth.log - Authenication logs.\n"
le follow /var/log/auth.log
fi
printf "\n"
if [ -f /var/log/cron.log ]; then
printf "/var/log/cron.log - Crond logs (cron job).\n"
le follow /var/log/cron.log
fi
printf "\n"
if [ -f /var/log/mysqld.log ]; then
printf "/var/log/mysqld.log - MySQL database server log file.\n"
le follow /var/log/mysqld.log
fi
printf "\n"
if [ -f /var/log/nginx/error.log ]; then
printf "/var/log/nginx/error.log - Nginx error log.\n"
le follow /var/log/nginx/error.log
fi
printf "\n"
if [ -f /var/log/nginx/access.log ]; then
printf "/var/log/nginx/access.log - Nginx access log.\n"
le follow /var/log/nginx/access.log
fi
printf "\n"

printf "Now let's add a log of your choice. Please choose one of the following. \n"
printf "Press 1 to follow a single log file.\n"
printf "Press 2 to follow all log files in a folder.\n"
read RESP
echo $RESP
if [ "$RESP" = "1" ]; then
	printf "Enter the location of your log file you wish to follow.\n"
	read LOCFile
	le follow $LOCFILE
else
	printf "Enter the location of your folder you wish to follow.\n"
	read LOCFOLDER
	printf "Attempting to follow all files located in " $LOCFOLDER
	follow_folder $LOCFOLDER
fi

printf "Restarting the Logentries service"
sudo service logentries restart
printf "Install Complete!\n\n"
printf "If you would like to monitor more files, simply run this command as root 'le follow filepath', e.g. 'le follow /var/log/auth.log'\n\n"
printf "And be sure to restart the agent service for new files to take effect, you can do this with 'sudo service logentries restart'\n"

exit 0

