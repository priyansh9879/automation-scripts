#!/usr/bin/bash

echo =========================================================================
echo "Welcome to Automatic Jenkins Deployment Wizard. This Script works both 
with Red Hat Enterprise Linux Server release 7.5 (Maipo) and Red Hat 
Enterprise Linux Release 8.0 (Ootpa)"; sleep 2s
echo =========================================================================
echo Fetching Red Hat Linux Version; sleep 2s
sudo cat /etc/redhat-release; sleep 2s
echo =========================================================================
echo
echo =========================================================================
echo             Install Java jdk-8u171-linux-x64.rpm Package
echo =========================================================================
sleep 2s
if sudo rpm -qa | grep jdk1.8-1.8.0_171-fcs.x86_64
then
	echo =========================================================================
	echo   jdk version 8u171 is Already Installed or Exists. Proceeding Further:
	echo =========================================================================
else
	sudo yum install https://mirrors.huaweicloud.com/java/jdk/8u171-b11/jdk-8u171-linux-x64.rpm -y
	echo =========================================================================
	echo         Package Installed Successfully. Proceeding Further:
	echo =========================================================================
fi

sleep 2s
echo =========================================================================
echo                    Checking jdk path in the file:
echo =========================================================================
sleep 2s
if sudo cat /root/.bashrc | grep JAVA_HOME; sudo cat /root/.bashrc | grep PATH
then
	echo =========================================================================
	echo           Path Already Present. Proceeding Further:
	echo =========================================================================
else
	sudo echo export JAVA_HOME=/usr/java/jdk1.8.0_171-amd64/ >> /root/.bashrc
	sudo echo export PATH=/usr/java/jdk1.8.0_171-amd64/bin:$PATH >> /root/.bashrc
	echo =========================================================================
        echo      Path Successfully Specified in the file. Proceeding further:
	echo =========================================================================
fi

sleep 2s
echo =========================================================================
echo                       Checking the wget Services
echo =========================================================================
sleep 2s
if sudo rpm -qa | grep wget
then
	echo =========================================================================
	echo          wget Service Already Exisits. Proceeding Further:
	echo =========================================================================
else
	echo =========================================================================
	echo          Services Unavailable. Installing the wget Services:
	echo =========================================================================
	sudo yum install wget -y
fi

sleep 2s
echo =========================================================================
echo       Creating the Jenkins Repository for Installing Jenkins:
echo =========================================================================
sleep 2s
if sudo ls /etc/yum.repos.d/ | grep jenkins.repo
then
	echo =========================================================================
	echo            Repository Already Exists. Checking the repo:
	echo =========================================================================
	sudo yum clean all; sudo yum repolist
else
	sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
	sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
	echo =========================================================================
	echo Repostory for jenkins created successfully. Checking the repo:
	echo =========================================================================
	sudo yum repolist
fi

sleep 2s
echo =========================================================================
echo          Installing Jenkins with the most Stable Version:
echo =========================================================================
sleep 2s
if sudo cat /etc/redhat-release | grep 'Red Hat Enterprise Linux release 8.0 (Ootpa)'
then
	if sudo rpm -qa | grep jenkins
	then
		echo =========================================================================
		echo =========================================================================
		echo      Jenkins is Already Installed or Exists: Procedding Further:
		echo =========================================================================
	else
		sudo yum install jenkins --nobest -y
		echo =========================================================================
		echo          Jenkins installed Successfully. Proceeding Further:
		echo =========================================================================
	fi
else
	sudo cat /etc/redhat-release
	echo =========================================================================
	if sudo rpm -qa | grep jenkins
        then
                echo =========================================================================
                echo      Jenkins is Already Installed or Exists: Procedding Further:
                echo =========================================================================
        else
                sudo yum install jenkins -y
                echo =========================================================================
                echo          Jenkins installed Successfully. Proceeding Further:
                echo =========================================================================
	fi
fi

sleep 2s
echo =========================================================================
echo                 Allowing port 8080 in Firewall Rules:
echo =========================================================================
sleep 2s
if sudo firewall-cmd --list-all | grep 8080/tcp
then
	echo =========================================================================
	echo      Port Already Enabled in Firewall Rules. Proceeding Further:
	echo =========================================================================
else
	sudo firewall-cmd --zone=public --add-port=8080/tcp --permanent
	sudo firewall-cmd --reload
	echo =========================================================================
	echo    Port Specified Successfully in Firewall Rules. Proceeding Further:
	echo =========================================================================
fi

sleep 2s
echo =========================================================================
echo                Assigning Sudo Powers to user jenkins:
echo =========================================================================
sleep 2s
if sudo cat /etc/sudoers | grep jenkins
then
	echo =========================================================================
	echo         jenkins already has Sudo Powers. Proceeding Further:
	echo =========================================================================
else
	sudo echo "jenkins ALL=(ALL)       NOPASSWD:ALL" >> /etc/sudoers
	echo =========================================================================
	echo  Successfully Assigned Sudo Powers to user jenkins: Proceeding Further:
	echo =========================================================================
fi

sleep 2s
echo =========================================================================
echo                    Checking the Jenkins Serivces:
echo =========================================================================
sleep 2s
if sudo systemctl status jenkins | grep enabled; sudo systemctl status jenkins | grep running
then
	echo =========================================================================
	echo        Services Already Up and Persistant. Proceeding Further:
	echo =========================================================================
else
        sudo systemctl restart jenkins; sudo systemctl enable jenkins
	echo =========================================================================
	echo        Services are now Up and Persistant. Proceeding Further:
	echo =========================================================================
fi

sleep 2s
echo =========================================================================
echo Congratulations, Jenkins Automatic Deployment Successfully in
cat /etc/redhat-release
echo Jenkins portal is Accessible at http://$(sudo ip -4 addr show enp0s3 | grep -oP '(?<=inet\s)\d+(\.\d+){3}'):8080
echo =========================================================================
echo Happy Learning.
echo =========================================================================

