#!/usr/bin/bash

#git installation in Red Hat Enterprise Linux release 8.0 (Ootpa)
echo ============================================================================
echo "Welcome to Automatic Git-lfs Deployment Wizard. This Script works both with 
Red Hat Enterprise Linux Server release 7.5 (Maipo) and Red Hat Enterprise Linux 
Release 8.0 (Ootpa)"
echo ============================================================================
sleep 2s
echo ============================================================================
echo "Fetching Red Hat Linux Version";sleep 2s
if sudo cat /etc/redhat-release | grep 'Red Hat Enterprise Linux release 8.0 (Ootpa)'
then
	echo ============================================================================
	sleep 2s
	echo ============================================================================
	echo                    Configuring Git-lfs Repository
	echo ============================================================================
	sleep 2s
	if sudo ls /etc/yum.repos.d | grep github_git-lfs.repo
	then
		echo ============================================================================
		echo       Git-lfs Repository Already Exists. Checking Repository in Yum:
		echo ============================================================================
		yum clean all
		yum repolist
	else
		curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.rpm.sh | sudo bash
		echo ============================================================================
		echo           Configuration Successfull. Checking Repository in Yum:
		echo ============================================================================
		yum repolist
	fi

	sleep 2s
	echo ============================================================================
	echo                   Installing Git-lfs Version 2.11.0-1
	echo ============================================================================
	sleep 2s
	if sudo rpm -qa | grep git-lfs-2.11.0-1.el8.x86_64
	then
		echo ============================================================================
		echo      Git-lfs Version 2.11.0-1 Already Exists. Proceeding Further:
		echo ============================================================================
	else
		yum install git-lfs -y
		echo ============================================================================
                echo                        Installation successfull
                echo ============================================================================
        fi

else
	# git installation in Red Hat Enterprise Linux Server release 7.5 (Maipo)
	echo ============================================================================
	sudo cat /etc/redhat-release
	echo ============================================================================
	sleep 2s
	echo ============================================================================
	echo                      Configuring Git-lfs Repository
	echo ============================================================================
	sleep 2s
	if sudo ls /etc/yum.repos.d | grep github_git-lfs.repo
	then
        	echo ============================================================================
        	echo       Git-lfs Repository Already Exists. Checking Repository in Yum:
        	echo ============================================================================       
		yum clean all
		yum repolist
	else
        	sudo curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.rpm.sh | sudo bash
        	echo ============================================================================
        	echo           Configuration Successfull. Checking Repository in Yum:
        	echo ============================================================================
		yum repolist
	fi

	sleep 2s
	echo ============================================================================
	echo                   Installing Git-lfs Version 2.11.0-1
	echo ============================================================================
	sleep 2s
	if sudo rpm -qa | grep git-lfs-2.11.0-1.el7.x86_64
	then
        	echo ============================================================================
        	echo        Git-lfs Version 2.11.0-1 Already Exists. Proceeding Further:
        	echo ============================================================================
	else
        	sudo yum install git-lfs --nogpgcheck -y
		echo ============================================================================
		echo                         Installation Successfull
		echo ============================================================================
	fi
fi

sleep 2s
echo ============================================================================
echo "Congratulations, you have Successfully Deployed Git-lfs in your"
cat /etc/redhat-release
echo You can now Initialize any git workspace with git lfs install command
echo ============================================================================
echo Happy Learning.
echo ============================================================================
