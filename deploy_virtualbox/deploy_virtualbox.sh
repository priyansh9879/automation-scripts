#!/usr/bin/bash

echo ============================================================================================================
echo "Welcome to Automatic VirtualBox Installation Wizard. This Script works both with Red Hat Enterprise Linux
Server release 7.5 (Maipo) and Red Hat Enterprise Linux Release 8.0 (Ootpa)"
echo ============================================================================================================
# -----------------------------------------------------------------------------------------------------------------------
# Red Hat Enterprise Linux release 8.0 (Ootpa)
# -----------------------------------------------------------------------------------------------------------------------
sleep 2s
echo "                                      Fetching Red Hat Linux Version                                      ";sleep 2s
echo ============================================================================================================
sudo cat /etc/redhat-release

# pre-reqisits
sleep 2s
echo --------------------------------------------------------------------------
echo "                     Installing required packages                       "
echo --------------------------------------------------------------------------
sleep 2s
if sudo rpm -qa | grep -E 'patch|gcc|kernel-headers|kernel-devel|make|perl|wget'
then
	echo --------------------------------------------------------------------------
	echo "                      All Packages are Installed                        "
	echo --------------------------------------------------------------------------
else
	sudo yum install patch gcc kernel-headers kernel-devel make perl wget -y
fi

# for VirtualBox
sleep 2s
echo --------------------------------------------------------------------------
echo "        Getting the VirtualBox Repository fro virtualbox.org            "
echo --------------------------------------------------------------------------
sleep 2s
if sudo ls /etc/yum.repos.d | grep virtualbox.repo
then
	echo --------------------------------------------------------------------------
	echo "                     Repository Already Exists                          "
	echo --------------------------------------------------------------------------
else
	sudo wget http://download.virtualbox.org/virtualbox/rpm/el/virtualbox.repo -P /etc/yum.repos.d
fi

sleep 2s
echo --------------------------------------------------------------------------
echo "                     Installing VirtualBox Package                      "
echo --------------------------------------------------------------------------
sleep 2s
if sudo rpm -qa | grep VirtualBox
then
	echo --------------------------------------------------------------------------
	echo "                       Package Already Exists                           "
	echo --------------------------------------------------------------------------
else
	sudo yum install VirtualBox-6.0 -y
fi

sleep 2s
echo --------------------------------------------------------------------------
echo "                     Starting VirtualBox Services                       "
echo --------------------------------------------------------------------------
sleep 2s
if sudo systemctl status vboxdrv | grep -E 'active|enabled'
then
	echo --------------------------------------------------------------------------
	echo "               Serices are Already Persistant and Running               "
	echo --------------------------------------------------------------------------
else
	sudo systemctl start vboxdrv
	sudo systemctl enable vboxdrv
fi

# For Extension Pack
sleep 2s
echo --------------------------------------------------------------------------
echo "               Downloading VirtualBox Extension Packing                 "
echo --------------------------------------------------------------------------
sleep 2s
if sudo ls | grep Oracle_VM_VirtualBox_Extension_Pack-6.0.4.vbox-extpack
then
	echo --------------------------------------------------------------------------
	echo "                     Package Already Downloaded                         "
	echo --------------------------------------------------------------------------
else
	sudo wget http://download.virtualbox.org/virtualbox/6.0.4/Oracle_VM_VirtualBox_Extension_Pack-6.0.4.vbox-extpack
fi

sleep 2s
echo --------------------------------------------------------------------------
echo "                       Installing Extension Pack                        "
echo --------------------------------------------------------------------------
printf 'y' | sudo VBoxManage extpack install Oracle_VM_VirtualBox_Extension_Pack-6.0.4.vbox-extpack

sleep 2s
echo --------------------------------------------------------------------------
echo "Congratulation Virtualbox-6.0 is sucesfully installed in you Rhel VM.
Happy Learning"
echo --------------------------------------------------------------------------
