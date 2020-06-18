#!/usr/bin/bash

echo ============================================================================
echo "Welcome to Automatic Deployment for git and git-lfs. This Masterscript will
install all the necessary requirements and packages for using git or git-lfs in 
your system."
echo ============================================================================
echo
echo ============================================================================
echo "What you want to Deploy in your $(cat /etc/redhat-release)
System"
echo "	-->  Git Version 2.18.1-3"
echo "	-->  Git-lfs Version 2.11.0-1"
echo ============================================================================
echo    "Give your input as git or git-lfs. Input Other than this won't work"
echo ============================================================================
read input
First_keyword=git
Second_keyword=git-lfs
if [ $input == $First_keyword ]
then
	echo ============================================================================
	echo              Invoking deploy_git.sh Script to Deploy git
	echo ============================================================================
	sleep 3s
	./deploy_git.sh
elif [ $input == $Second_keyword ]
then
	echo ============================================================================
	echo           Invoking deploy_git-lfs.sh Script to Deploy git-lfs
	echo ============================================================================
	sleep 3s
	./deploy_git-lfs.sh
else
	echo ============================================================================
	echo           You have entered the Wrong keyword. Try Again
	echo ============================================================================
	sleep 2s
fi
