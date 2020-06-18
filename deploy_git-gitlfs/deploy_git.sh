#!/usr/bin/bash

# git installation for Red Hat Enterprise Linux Release 8.0 (Ootpa)
echo ============================================================================
echo "Welcome to Automatic Git Deployment wizard. This Script works both with 
Red Hat Enterprise Linux Server release 7.5 (Maipo) and Red Hat Enterprise 
Linux Release 8.0 (Ootpa)"
echo ============================================================================
sleep 2s
echo ============================================================================
echo "Fetching Red Hat Linux Version";sleep 2s
if sudo cat /etc/redhat-release | grep 'Red Hat Enterprise Linux release 8.0 (Ootpa)'
then
	echo ============================================================================
        sleep 2s
        echo ============================================================================
        echo                     Installing Git Version 2.18.1-3
        echo ============================================================================
        sleep 2s
        if sudo rpm -qa | grep git-2.18.1-3.el8.x86_64
        then
                echo ============================================================================
                echo         Git Version 2.18.1-3 Already Exists. Proceeding Further:
                echo ============================================================================
        else
                yum install git -y
                echo ============================================================================
                echo             Installation Successfull. Proceeding Further:
                echo ============================================================================
        fi

else	

	# git installation for Red Hat Enterprise Linux Server release 7.5 (Maipo)
	echo ============================================================================
	sudo cat /etc/redhat-release
	echo ============================================================================
	sleep 2s
	echo ============================================================================
	echo          Importing the Signing keys for Git Version 2.24.1-1
	echo ============================================================================
	sleep 2s
	if sudo ls /tmp | grep endpoint-rpmsign-7.pub
	then
        	echo ============================================================================
        	echo       keys Already exists and are verified. Proceeding Further:
        	echo ============================================================================
	else
        	sudo cd /tmp
        	sudo wget https://packages.endpoint.com/endpoint-rpmsign-7.pub
        	sudo rpm --import endpoint-rpmsign-7.pub
        	sudo rpm -qi gpg-pubkey-703df089 | gpg --with-fingerprint
        	echo ============================================================================
        	echo           Key Verification Successfull. Proceeding Further:
        	echo ============================================================================
	fi

	sleep 2s
	echo ============================================================================
	echo     Downloading End Point Yum Repository File for Git Version 2.24.1-1
	echo ============================================================================
	sleep 2s
	if sudo ls /tmp | grep endpoint-repo-1.7-1.x86_64.rpm
	then
        	echo ============================================================================
        	echo              Rpm File Already Exists. Proceeding Further:
        	echo ============================================================================
	else
        	sudo cd /tmp
        	sudo wget https://packages.endpoint.com/rhel/7/os/x86_64/endpoint-repo-1.7-1.x86_64.rpm
        	sleep 2s
        	echo ============================================================================
        	echo               Download Successfull. Proceeding Further:
        	echo ============================================================================
	fi

	sleep 2s
	echo ============================================================================
	echo     Configuring End Point Yum Repository File for Git Version 2.24.1-1
	echo ============================================================================
	sleep 2s
	if sudo ls /etc/yum.repos.d/ | grep endpoint.repo
	then
        	echo ============================================================================
        	echo       Configuration File Already Exists. Checking repository in yum:
        	echo ============================================================================
		yum clean all
		yum repolist
	else
        	sudo yum localinstall /tmp/endpoint-repo-1.7-1.x86_64.rpm -y
        	echo ============================================================================
        	echo           Configuration Successfull. Checking repository in yum:
        	echo ============================================================================
		yum repolist
	fi

	sleep 2s
	echo ============================================================================
	echo                     Installing Git Version 2.24.1-1
	echo ============================================================================
	sleep 2s
	if sudo rpm -qa | grep git-2.24.1-1.ep7.x86_64
	then
	        echo ============================================================================
	        echo            Software Already Installed. Proceeding Further:
	        echo ============================================================================
	else
	        sudo yum install git -y
	        echo ============================================================================
	        echo            Installation Successfull. Proceeding Further:
		echo ============================================================================
	fi
fi

sleep 2s
echo ============================================================================
echo "Congratulations, you have Successfully Deployed Git in your"
cat /etc/redhat-release
echo You can now Initialize any git workspace with git init Command
echo ============================================================================
echo Happy Learning.
echo ============================================================================
