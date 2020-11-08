#!/usr/bin/bash

echo ============================================================================
echo "Welcome to Automatic Docker-ce Deployment Wizard. This Script works both 
with Red Hat Enterprise Linux Server release 7.5 (Maipo) and Red Hat Enterprise 
Linux Release 8.0 (Ootpa)"
echo ============================================================================
# Red Hat Enterprise Linux Server release 7.5 (Maipo)
sleep 2s
echo ============================================================================
echo "Fetching Red Hat Linux Version";sleep 2s
if sudo cat /etc/redhat-release | grep 'Red Hat Enterprise Linux Server release 7.5 (Maipo)'
then
	echo ============================================================================
	echo
	sleep 2s
        echo =========================================================================
        echo          Installing docker-ce-18.06.1.ce-3.el7.x86_64.rpm
        echo =========================================================================
        sleep 2s
        if sudo rpm -qa | grep -E '(^|\s)docker-ce-18.06.1.ce-3.el7.x86_64($|\s)'
        then
                echo =========================================================================
                echo docker-ce-18.06.1.ce-3.el7.x86_64 Already Installed. Proceeding Further:
                echo =========================================================================
        else
                sudo yum install https://download.docker.com/linux/centos/7/x86_64/stable/Packages/docker-ce-18.06.1.ce-3.el7.x86_64.rpm -y
                echo =========================================================================
                echo           Installation Successfull. Proceeding Further:
                echo =========================================================================
        fi

        sleep 2s
        echo =========================================================================
        echo      Allowing masquerade, port 80 and port 443 in Firewall Rules
        echo =========================================================================
        sleep 2s
        if sudo firewall-cmd --list-all | grep ports: | grep 80/tcp | grep 443/tcp; sudo firewall-cmd --list-all | grep masquerade: | grep yes
        then
                echo =========================================================================
                echo   Requirements Already Satisfied in Firewall Rules. Proceeding Further:
                echo =========================================================================
        else
                sudo firewall-cmd --zone=public --add-masquerade --permanent
                sudo firewall-cmd --zone=public --add-port=80/tcp --permanent
                sudo firewall-cmd --zone=public --add-port=443/tcp --permanent
                sudo firewall-cmd --reload
                echo =========================================================================
                echo    Requirements now Specified in Firewall Rules. Proceeding Further:
                echo =========================================================================
        fi

        sleep 2s
        echo =========================================================================
        echo                       Checking Docker Services
        echo =========================================================================
        sleep 2s
        if sudo systemctl status docker | grep enabled; sudo systemctl status docker | grep running
        then
                sleep 2s
                echo =========================================================================
                echo  Docker Services are Already Active and Persistant. Proceeding Further:
                echo =========================================================================
		rm -rf docker-ce-18.06.1.ce-3.el7.x86_64.rpm
        else
                sudo systemctl restart docker; sudo systemctl enable docker
                echo =========================================================================
                echo      Docker Services up and are persistant now. Proceeding Further:
                echo =========================================================================
		rm -rf docker-ce-18.06.1.ce-3.el7.x86_64.rpm

        fi

else
	# Statement for Red Hat Enterprise Linux Release 8.0 (Ootpa)
	echo ============================================================================
	sudo cat /etc/redhat-release
	echo ============================================================================
	sleep 2s
	echo
	echo =========================================================================
	echo             Creating Repository with the name docker.repo:
	echo =========================================================================
	sleep 2s 
	if sudo ls /etc/yum.repos.d/ | grep docker-ce.repo
	then
		echo =========================================================================
		echo         Repository Already Exists. Checking Repository in yum:
		echo =========================================================================
		sudo yum clean all; sudo yum repolist
	else
		echo '[docker-ce]' > /etc/yum.repos.d/docker-ce.repo
		echo 'baseurl=https://download.docker.com/linux/centos/7/x86_64/stable/' >> /etc/yum.repos.d/docker-ce.repo
		echo 'gpgcheck=0' >> /etc/yum.repos.d/docker-ce.repo
		echo =========================================================================
		echo            Repository Created. Checking Repository in yum:
		echo =========================================================================	
		sleep 2s
		sudo yum clean all; sudo yum repolist
		sleep 2s
		echo =========================================================================
		echo         Repository Successfuly Configured. Proceeding further:
		echo =========================================================================
	fi
	
	sleep 2s
	echo =========================================================================
	echo          Installing docker version 18.09.9-3.el7.x86_64.rpm
	echo =========================================================================
	sleep 2s
	if sudo rpm -qa | grep docker-ce-18.09.1-3.el7.x86_64; sudo rpm -qa | grep docker-ce-cli-19.03.11-3.el7.x86_64
	then
		echo =========================================================================
		echo  Docker 18.09.9-3.el7.x86_64 is already installed. Proceeding Further:
		echo =========================================================================
	else
		sudo yum install docker-ce-18.09.1-3.el7 -y
		sleep 3s
		echo =========================================================================
		echo           Installation Successfully. Proceeding Further:
		echo =========================================================================
	fi

        sleep 2s
        echo =========================================================================
        echo      Allowing masquerade, port 80 and port 443 in Firewall Rules
        echo =========================================================================
        sleep 2s
        if sudo firewall-cmd --list-all | grep ports: | grep 80/tcp | grep 443/tcp; sudo firewall-cmd --list-all | grep masquerade: | grep yes
        then
                echo =========================================================================
                echo   Requirements Already Satisfied in Firewall Rules. Proceeding Further:
                echo =========================================================================
        else
                sudo firewall-cmd --zone=public --add-masquerade --permanent
                sudo firewall-cmd --zone=public --add-port=80/tcp --permanent
                sudo firewall-cmd --zone=public --add-port=443/tcp --permanent
                sudo firewall-cmd --reload
                echo =========================================================================
                echo         Requirements Enabled Successfully. Proceeding Further:
                echo =========================================================================
        fi
		
	sleep 2s
	echo =========================================================================
	echo                       Checking Docker Services
	echo =========================================================================
	sleep 2s
	if sudo systemctl status docker | grep enabled; sudo systemctl status docker | grep running
	then
		sleep 2s
		echo =========================================================================
		echo  Docker Services are Already Active and Persistant. Proceeding Further:
		echo =========================================================================
	else
		sudo systemctl restart docker; sudo systemctl enable docker
		echo =========================================================================
		echo       Services are up and persistant now. Proceeding Further:
		echo =========================================================================
	
	fi
fi

sleep 2s
echo =========================================================================
echo "Congratulation, you have Successfully installed Docker"
sudo cat /etc/redhat-release
echo For verification, check the Following output:
echo =========================================================================
sleep 2s
sudo docker version
sleep 2s
echo =========================================================================
echo               Enjoy with the Containers. Happy Learning
echo =========================================================================
