#!/usr/bin/bash

# RHEL8 variables
# ----------------------------------------------------------------------------------------------------------------------------
DVD_PATH_RHEL8=$(sudo df -hT | grep  /run/media/ | rev | cut -d " " -f 1 | rev)

REPO_NAME_RHEL8=$({ sudo cat /etc/redhat-release | cut -c 1-3; sudo cat /etc/redhat-release | cut -c 5-7; } | paste -d " " -s | cut -c 1-3,5-7)

RHEL8_KEY=$(sudo ls /etc/pki/rpm-gpg/ | grep RPM-GPG-KEY-redhat-release)

# RHEL7 Variables
# ----------------------------------------------------------------------------------------------------------------------------

VAR1=$(sudo df -hT | grep  /run/media/ | rev | cut -d " " -f 2 | rev)
VAR2=$(sudo df -hT | grep  /run/media/ | rev | cut -d " " -f 1 | rev)

DVD_PATH_RHEL7_REPO=$(echo $VAR1'\' $VAR2)

DVD_PATH_RHEL7=$(sudo df -hT | grep  /run/media/ | rev | cut -d " " -f 1,2 | rev)

REPO_NAME_RHEL7=$({ sudo cat /etc/redhat-release | cut -c 1-3; sudo cat /etc/redhat-release | cut -c 5-7; } | paste -d " " -s | cut -c 1-3,5-7)

RHEL7_KEY=$(sudo ls /etc/pki/rpm-gpg/ | grep RPM-GPG-KEY-redhat-release)

# ----------------------------------------------------------------------------------------------------------------------------

echo ============================================================================================================
echo "Welcome to Automatic Yum Configuration Wizard. This Script works both with Red Hat Enterprise Linux Server 
release 7.5 (Maipo) and Red Hat Enterprise Linux Release 8.0 (Ootpa)"
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
	echo $DVD_PATH_RHEL8

	sleep 2s
	echo --------------------------------------------------------------------------
	echo "Checking and Creating Yum Configuration Repo file"
	echo --------------------------------------------------------------------------
	sleep 2s
	if sudo ls /etc/yum.repos.d/ | grep $REPO_NAME_RHEL8.repo
	then
		echo --------------------------------------------------------------------------
		echo "Repo File Already Exists"
		echo --------------------------------------------------------------------------
	else
		echo --------------------------------------------------------------------------
		echo "Creating AppStream Repo"
		echo --------------------------------------------------------------------------
		sleep 3s
		echo "[AppStream]" > /etc/yum.repos.d/$REPO_NAME_RHEL8.repo
		echo "name=Softwares from AppStream" >> /etc/yum.repos.d/$REPO_NAME_RHEL8.repo	
		echo "baseurl=file://$DVD_PATH_RHEL8/AppStream" >> /etc/yum.repos.d/$REPO_NAME_RHEL8.repo
		echo "enabled=1" >> /etc/yum.repos.d/$REPO_NAME_RHEL8.repo
		echo "gpgcheck=1" >> /etc/yum.repos.d/$REPO_NAME_RHEL8.repo
        	echo "gpgkey=file:///etc/pki/rpm-gpg/$RHEL8_KEY" >> /etc/yum.repos.d/$REPO_NAME_RHEL8.repo
		# For Space in the Repo file
		echo >> /etc/yum.repos.d/$REPO_NAME_RHEL8.repo
		echo
		echo --------------------------------------------------------------------------
		echo "Creating BaseOS Repo"
		echo --------------------------------------------------------------------------
		sleep 3s
	        echo "[BaseOS]" >> /etc/yum.repos.d/$REPO_NAME_RHEL8.repo
		echo "name=Softwares from BaseOS" >> /etc/yum.repos.d/$REPO_NAME_RHEL8.repo
	        echo "baseurl=file://$DVD_PATH_RHEL8/BaseOS" >> /etc/yum.repos.d/$REPO_NAME_RHEL8.repo
        	echo "enabled=1" >> /etc/yum.repos.d/$REPO_NAME_RHEL8.repo
	        echo "gpgcheck=1" >> /etc/yum.repos.d/$REPO_NAME_RHEL8.repo
        	echo "gpgkey=file:///etc/pki/rpm-gpg/$RHEL8_KEY" >>/etc/yum.repos.d/$REPO_NAME_RHEL8.repo
	fi
# -----------------------------------------------------------------------------------------------------------------------
else
# -----------------------------------------------------------------------------------------------------------------------	
# Red Hat Enterprise Linux Server release 7.5 (Maipo)
# -----------------------------------------------------------------------------------------------------------------------
	cat /etc/redhat-release
	sleep 2s
        echo --------------------------------------------------------------------------
        echo "Fetching DVD Path"
        echo --------------------------------------------------------------------------
        echo $DVD_PATH_RHEL7

        sleep 2s
        echo --------------------------------------------------------------------------
        echo "Checking and Creating Yum Configuration Repo file"
        echo --------------------------------------------------------------------------
        sleep 2s
        if sudo ls /etc/yum.repos.d/ | grep $REPO_NAME_RHEL7.repo
        then
                echo --------------------------------------------------------------------------
                echo "Repo File Already Exists"
                echo --------------------------------------------------------------------------
        else
		echo --------------------------------------------------------------------------
                echo "Creating RHEL7 Repo"
                echo --------------------------------------------------------------------------
                sleep 3s
                echo "[RHEL7]" > /etc/yum.repos.d/$REPO_NAME_RHEL7.repo
                echo "name=Softwares from RHEL7" >> /etc/yum.repos.d/$REPO_NAME_RHEL7.repo
                echo "baseurl=file://$DVD_PATH_RHEL7_REPO" >> /etc/yum.repos.d/$REPO_NAME_RHEL8.repo
                echo "enabled=1" >> /etc/yum.repos.d/$REPO_NAME_RHEL7.repo
                echo "gpgcheck=1" >> /etc/yum.repos.d/$REPO_NAME_RHEL7.repo
                echo "gpgkey=file:///etc/pki/rpm-gpg/$RHEL7_KEY" >> /etc/yum.repos.d/$REPO_NAME_RHEL7.repo
	fi
fi

echo --------------------------------------------------------------------------
echo "Confirming Repository list"
echo --------------------------------------------------------------------------
sudo yum clean all
sudo yum repolist
