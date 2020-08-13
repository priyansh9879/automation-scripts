#!/usr/bin/bash

# RHEL8/RHEL7 variables
# ----------------------------------------------------------------------------------------------------------------------------

REPO_NAME=$({ sudo cat /etc/redhat-release | cut -c 1-3; sudo cat /etc/redhat-release | cut -c 5-7; } | paste -d " " -s | cut -c 1-3,5-7)

RHEL_KEY=$(sudo ls /etc/pki/rpm-gpg/ | grep RPM-GPG-KEY-redhat-release)

# ----------------------------------------------------------------------------------------------------------------------------

echo ============================================================================================================
echo "Welcome to Automatic Yum Configuration Wizard for CLI. This Script works both with Red Hat Enterprise Linux 
Server release 7.5 (Maipo) and Red Hat Enterprise Linux Release 8.0 (Ootpa)"
echo ============================================================================================================
# -----------------------------------------------------------------------------------------------------------------------
# Red Hat Enterprise Linux release 8.0 (Ootpa)
# -----------------------------------------------------------------------------------------------------------------------
sleep 2s
echo "                                      Fetching Red Hat Linux Version                                      ";sleep 2s
echo ============================================================================================================
if sudo cat /etc/redhat-release | grep 'Red Hat Enterprise Linux release 8.0 (Ootpa)'
then
	sleep 2s
	echo --------------------------------------------------------------------------
	echo "Fetching DVD Path"
	echo --------------------------------------------------------------------------
	if sudo df -hT | grep  /dvd | rev | cut -d " " -f 1 | rev | grep '/dvd'
	then
		echo --------------------------------------------------------------------------
		echo "Path is already set"
		echo --------------------------------------------------------------------------
	else
		echo --------------------------------------------------------------------------
		echo "Mounting [ /dev/sr0 ] to [ /dvd ] Folder"
		echo --------------------------------------------------------------------------
		mount /dev/sr0 /dvd
	fi

	sleep 2s
	echo --------------------------------------------------------------------------
	echo "Checking and Creating Yum Configuration Repo file"
	echo --------------------------------------------------------------------------
	sleep 2s
	if sudo ls /etc/yum.repos.d/ | grep $REPO_NAME.repo
	then
		echo --------------------------------------------------------------------------
		echo "Repo File Already Exists"
		echo --------------------------------------------------------------------------
	else
		echo --------------------------------------------------------------------------
		echo "Creating AppStream Repo"
		echo --------------------------------------------------------------------------
		sleep 3s
		echo "[AppStream]" > /etc/yum.repos.d/$REPO_NAME.repo
		echo "name=Softwares from AppStream" >> /etc/yum.repos.d/$REPO_NAME.repo
		echo "baseurl=file:///dvd/AppStream" >> /etc/yum.repos.d/$REPO_NAME.repo
		echo "enabled=1" >> /etc/yum.repos.d/$REPO_NAME.repo
		echo "gpgcheck=1" >> /etc/yum.repos.d/$REPO_NAME.repo
		echo "gpgkey=file:///etc/pki/rpm-gpg/$RHEL_KEY" >> /etc/yum.repos.d/$REPO_NAME.repo
		# For Space in the Repo file
		echo >> /etc/yum.repos.d/$REPO_NAME.repo
		echo
		echo --------------------------------------------------------------------------
		echo "Creating BaseOS Repo"
		echo --------------------------------------------------------------------------
		sleep 3s
		echo "[BaseOS]" >> /etc/yum.repos.d/$REPO_NAME.repo
		echo "name=Softwares from BaseOS" >> /etc/yum.repos.d/$REPO_NAME.repo
		echo "baseurl=file:///dvd/BaseOS" >> /etc/yum.repos.d/$REPO_NAME.repo
		echo "enabled=1" >> /etc/yum.repos.d/$REPO_NAME.repo
		echo "gpgcheck=1" >> /etc/yum.repos.d/$REPO_NAME.repo
		echo "gpgkey=file:///etc/pki/rpm-gpg/$RHEL_KEY" >>/etc/yum.repos.d/$REPO_NAME.repo
	fi
# -----------------------------------------------------------------------------------------------------------------------
else
# -----------------------------------------------------------------------------------------------------------------------	
# Red Hat Enterprise Linux Server release 7.5 (Maipo)
# -----------------------------------------------------------------------------------------------------------------------
	sudo cat /etc/redhat-release
	sleep 2s
        echo --------------------------------------------------------------------------
        echo "Fetching DVD Path"
        echo --------------------------------------------------------------------------
        if sudo df -hT | grep  /dvd | rev | cut -d " " -f 1 | rev | grep '/dvd'
        then
                echo --------------------------------------------------------------------------
                echo "Path is already set"
                echo --------------------------------------------------------------------------
        else
                echo --------------------------------------------------------------------------
                echo "Mounting [ /dev/sr0 ] to [ /dvd ] Folder"
                echo --------------------------------------------------------------------------
                mount /dev/sr0 /dvd
        fi

        sleep 2s
        echo --------------------------------------------------------------------------
        echo "Checking and Creating Yum Configuration Repo file"
        echo --------------------------------------------------------------------------
        sleep 2s
        if sudo ls /etc/yum.repos.d/ | grep $REPO_NAME.repo
        then
                echo --------------------------------------------------------------------------
                echo "Repo File Already Exists"
                echo --------------------------------------------------------------------------
        else
                echo --------------------------------------------------------------------------
                echo "Creating AppStream Repo"
                echo --------------------------------------------------------------------------
                sleep 3s
                echo "[Rhel7]" > /etc/yum.repos.d/$REPO_NAME.repo
                echo "name=Softwares from Rhel7" >> /etc/yum.repos.d/$REPO_NAME.repo
                echo "baseurl=file:///dvd" >> /etc/yum.repos.d/$REPO_NAME.repo
                echo "enabled=1" >> /etc/yum.repos.d/$REPO_NAME.repo
                echo "gpgcheck=1" >> /etc/yum.repos.d/$REPO_NAME.repo
                echo "gpgkey=file:///etc/pki/rpm-gpg/$RHEL_KEY" >> /etc/yum.repos.d/$REPO_NAME.repo
	fi
fi

sleep 2s
echo --------------------------------------------------------------------------
echo "Checking Persistant DVD Path Settings"
echo --------------------------------------------------------------------------
sleep 2s
if sudo cat /etc/fstab | grep '/dvd\|iso9660'
then
	echo --------------------------------------------------------------------------
	echo "[ /dvd ] is already set to persistant settings"
	echo --------------------------------------------------------------------------
else
	echo '/dev/sr0        /dvd    iso9660 defaults        0 0' >> /etc/fstab
fi

sleep 2s
echo --------------------------------------------------------------------------
echo "Checking for Filesystem Errors"
echo --------------------------------------------------------------------------
sleep 2s
VAR=$( sudo mount -a; echo $?)
if [ $VAR -eq 0 ]
then
	echo --------------------------------------------------------------------------
	echo "Everything is Ok and up-to-date"
	echo --------------------------------------------------------------------------
else
	sleep 2s
	echo --------------------------------------------------------------------------
	echo "You have some Problems in your filesystem files. Check for the error in       
[ /etc/fstab ] file and Run the script again"
	echo -------------------------------------------------------------------------
	exit 1
fi

echo --------------------------------------------------------------------------
echo "Confirming Repository list"
echo --------------------------------------------------------------------------
sudo yum clean all
sudo yum repolist
