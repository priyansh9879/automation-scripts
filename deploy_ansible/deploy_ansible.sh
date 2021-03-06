#!/usr/bin/bash

echo ============================================================================================================
echo "Welcome to Automatic Ansible Deployment Wizard. This Script works both with Red Hat Enterprise Linux 
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
	echo ------------------------------------------------------------------------------------------------------------	
	echo "                           Configuring epel-release-8-8.el8.noarch Repository                             "
	echo ------------------------------------------------------------------------------------------------------------
	sleep 2s
	if sudo rpm -qa | grep epel-release
	then
		echo ------------------------------------------------------------------------------------------------------------
		echo "                                     Repository Already Exists                                            "
		echo ------------------------------------------------------------------------------------------------------------
	else
		sudo yum install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm -y
	fi

	sleep 2s
	echo ------------------------------------------------------------------------------------------------------------
	echo "                                         Installing Ansible                                               "
	echo ------------------------------------------------------------------------------------------------------------ 
	sleep 2s
	if sudo rpm -qa | grep ansible
	then
		echo ------------------------------------------------------------------------------------------------------------
		echo "              Package Already Installed in $(cat /etc/redhat-release)                                     "
		echo ------------------------------------------------------------------------------------------------------------
	else
		sudo yum --enablerepo=epel install ansible -y
	fi
	
	sleep 2s
	echo ------------------------------------------------------------------------------------------------------------
	echo "                                      Installing sshpass Package                                          "
	echo ------------------------------------------------------------------------------------------------------------
	sleep 2s
	if sudo rpm -qa | grep sshpass
	then
		echo ------------------------------------------------------------------------------------------------------------
		echo "                                        Package already exists                                            "
		echo ------------------------------------------------------------------------------------------------------------
	else
		sudo yum --enablerepo=epel install sshpass -y
	fi
# -----------------------------------------------------------------------------------------------------------------------
else
# -----------------------------------------------------------------------------------------------------------------------	
# Red Hat Enterprise Linux Server release 7.5 (Maipo)
# -----------------------------------------------------------------------------------------------------------------------
	sudo cat /etc/redhat-release
	echo ------------------------------------------------------------------------------------------------------------
	echo "                             Configuring epel-release-7-12.noarch Repository                              "
	echo ------------------------------------------------------------------------------------------------------------
        sleep 2s
        if sudo rpm -qa | grep epel-release
        then
		echo ------------------------------------------------------------------------------------------------------------
		echo "                                     Repository Already Exists                                            "
		echo ------------------------------------------------------------------------------------------------------------
	else
		sudo yum install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm -y
	fi
	
	sleep 2s
	echo ------------------------------------------------------------------------------------------------------------
	echo "                                          Installing Ansible                                              "
	echo ------------------------------------------------------------------------------------------------------------
	sleep 2s
	if sudo rpm -qa | grep ansible
	then
		echo ------------------------------------------------------------------------------------------------------------
		echo "              Package Already Installed in $(cat /etc/redhat-release)                                     "
		echo ------------------------------------------------------------------------------------------------------------
	else
		sudo yum --enablerepo=epel install ansible -y
	fi

	sleep 2s
	echo ------------------------------------------------------------------------------------------------------------
	echo "                                      Installing sshpass Package                                          "
	echo ------------------------------------------------------------------------------------------------------------
	sleep 2s
	if sudo rpm -qa | grep sshpass
	then
		echo ------------------------------------------------------------------------------------------------------------
		echo "                                        Package already exists                                            "
		echo ------------------------------------------------------------------------------------------------------------
	else
		sudo yum --enablerepo=epel install sshpass -y
	fi
fi
# -----------------------------------------------------------------------------------------------------------------------

sleep 1s
echo ============================================================================================================
echo Congratulations, Ansible is Properly Installed in Your $(cat /etc/redhat-release)
echo ------------------------------------------------------------------------------------------------------------
sleep 1s
echo 'You will get the Configuration file for Ansible at {/etc/ansible/ansible.cfg}'
echo ------------------------------------------------------------------------------------------------------------
sleep 1s
echo 'You will find the Inventory file for Ansible at {/etc/ansible/hosts}'
echo ------------------------------------------------------------------------------------------------------------
sleep 1s
echo 'You will find the Roles Folder for Ansible at {/etc/ansible/roles}'
echo ============================================================================================================
