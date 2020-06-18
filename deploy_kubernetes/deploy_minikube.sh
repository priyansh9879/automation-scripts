#!/usr/bin/bash

#selinux
echo =========================================================================
echo "Welcome to the Automatic Kubernetes Deployment Wizard.This Script works 
both with Red Hat Enterprise Linux Server release 7.5 (Maipo) and Red Hat 
Enterprise Linux Release 8.0 (Ootpa)"; sleep 2s
echo =========================================================================
echo Configuring Initial Requirements before Deploying Kubernetes Cluster
echo =========================================================================
sleep 2s
echo Creating SeLinux Policy
echo =========================================================================
sleep 2s
if getenforce | grep enforcing
then
	echo =========================================================================
	echo      SeLinux is Already set to Permissive Mode. Proceeding Further:
	echo =========================================================================
	sleep 3s
else
	setenforce 0
	sed -i --follow-symlinks 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/sysconfig/selinux
	echo =========================================================================
	echo              SeLinux Policy Created. Proceeding Further:
	echo =========================================================================
fi



# conntrack-tools package
sleep 2s
echo =========================================================================
echo                    Installing conntrack Package
echo =========================================================================
sleep 2s
if cat /etc/redhat-release | grep 'Red Hat Enterprise Linux release 8.0 (Ootpa)'
then
	if rpm -qa | grep conntrack-tools-1.4.4-9.el8.x86_64
	then
		echo =========================================================================
		echo              Package Already Exists. Proceeding Further:
		echo =========================================================================
		sleep 3s
	else
		yum install conntrack-tools -y
		echo =========================================================================
		echo            Installation Successfull. Proceeding Further:
		echo =========================================================================
	fi
else
	if rpm -qa | grep conntrack-tools-1.4.4-3.el7.x86_64
	then
                echo =========================================================================
                echo              Package Already Exists. Proceeding Further:
                echo =========================================================================
                sleep 3s
        else
                yum install conntrack-tools -y
                echo =========================================================================
                echo            Installation Successfull. Proceeding Further:
                echo =========================================================================
	fi
fi


# docker installation
echo ============================================================================
echo "Welcome to Automatic Docker-ce Deployment Wizard. This Script works both 
with Red Hat Enterprise Linux Server release 7.5 (Maipo) and Red Hat Enterprise 
Linux Release 8.0 (Ootpa)"
echo ============================================================================
# Red Hat Enterprise Linux Server release 7.5 (Maipo)
sleep 2s
echo ============================================================================
echo "Fetching Red Hat Linux Version";sleep 2s
if cat /etc/redhat-release | grep 'Red Hat Enterprise Linux Server release 7.5 (Maipo)'
then
	echo ============================================================================
	sleep 2s
	echo
        echo =========================================================================
        echo          Installing docker-ce-18.06.1.ce-3.el7.x86_64.rpm
        echo =========================================================================
        sleep 2s
        if rpm -qa | grep -E '(^|\s)docker-ce-18.06.1.ce-3.el7.x86_64($|\s)'
        then
                echo =========================================================================
                echo docker-ce-18.06.1.ce-3.el7.x86_64 Already Installed. Proceeding Further:
                echo =========================================================================
        else
                yum install https://download.docker.com/linux/centos/7/x86_64/stable/Packages/docker-ce-18.06.1.ce-3.el7.x86_64.rpm -y
                echo =========================================================================
                echo           Installation Successfull. Proceeding Further:
                echo =========================================================================
        fi

        sleep 2s
        echo =========================================================================
        echo      Allowing masquerade, port 80 and port 443 in Firewall Rules
        echo =========================================================================
        sleep 2s
        if firewall-cmd --list-all | grep ports: | grep 80/tcp | grep 443/tcp; firewall-cmd --list-all | grep masquerade: | grep yes
        then
                echo =========================================================================
                echo   Requirements Already Satisfied in Firewall Rules. Proceeding Further:
                echo =========================================================================
        else
                firewall-cmd --zone=public --add-masquerade --permanent
                firewall-cmd --zone=public --add-port=80/tcp --permanent
                firewall-cmd --zone=public --add-port=443/tcp --permanent
                firewall-cmd --reload
                echo =========================================================================
                echo    Requirements now Specified in Firewall Rules. Proceeding Further:
                echo =========================================================================
        fi

        sleep 2s
        echo =========================================================================
        echo                       Checking Docker Services
        echo =========================================================================
        sleep 2s
        if systemctl status docker | grep enabled; systemctl status docker | grep running
        then
                sleep 2s
                echo =========================================================================
                echo  Docker Services are Already Active and Persistant. Proceeding Further:
                echo =========================================================================
		rm -rf docker-ce-18.06.1.ce-3.el7.x86_64.rpm
        else
                systemctl restart docker; systemctl enable docker
                echo =========================================================================
                echo      Docker Services up and are persistant now. Proceeding Further:
                echo =========================================================================
		rm -rf docker-ce-18.06.1.ce-3.el7.x86_64.rpm

        fi

else
	# Statement for Red Hat Enterprise Linux Release 8.0 (Ootpa)
	echo ============================================================================
	cat /etc/redhat-release
	echo ============================================================================
	sleep 2s
	echo
	echo =========================================================================
	echo             Creating Repository with the name docker.repo:
	echo =========================================================================
	sleep 2s 
	if ls /etc/yum.repos.d/ | grep docker.repo
	then
		echo =========================================================================
		echo         Repository Already Exists. Checking Repository in yum:
		echo =========================================================================
		yum clean all; yum repolist
	else
		touch /etc/yum.repos.d/docker.repo
		echo "[Docker-ce]" >> /etc/yum.repos.d/docker.repo
		echo "name=Softwares from Docker" >> /etc/yum.repos.d/docker.repo
		echo "baseurl=https://download.docker.com/linux/centos/7/x86_64/stable/" >> /etc/yum.repos.d/docker.repo
		echo "gpgcheck=0" >> /etc/yum.repos.d/docker.repo
		echo =========================================================================
		echo            Repository Created. Checking Repository in yum:
		echo =========================================================================	
		sleep 2s
		yum clean all; yum repolist
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
	if rpm -qa | grep docker-ce-18.09.1-3.el7.x86_64; rpm -qa | grep docker-ce-cli-19.03.11-3.el7.x86_64
	then
		echo =========================================================================
		echo  Docker 18.09.9-3.el7.x86_64 is already installed. Proceeding Further:
		echo =========================================================================
	else
		yum install docker-ce-18.09.1-3.el7 -y
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
        if firewall-cmd --list-all | grep ports: | grep 80/tcp | grep 443/tcp; firewall-cmd --list-all | grep masquerade: | grep yes
        then
                echo =========================================================================
                echo   Requirements Already Satisfied in Firewall Rules. Proceeding Further:
                echo =========================================================================
        else
                firewall-cmd --zone=public --add-masquerade --permanent
                firewall-cmd --zone=public --add-port=80/tcp --permanent
                firewall-cmd --zone=public --add-port=443/tcp --permanent
                firewall-cmd --reload
                echo =========================================================================
                echo         Requirements Enabled Successfully. Proceeding Further:
                echo =========================================================================
        fi
		
	sleep 2s
	echo =========================================================================
	echo                       Checking Docker Services
	echo =========================================================================
	sleep 2s
	if systemctl status docker | grep enabled; systemctl status docker | grep running
	then
		sleep 2s
		echo =========================================================================
		echo  Docker Services are Already Active and Persistant. Proceeding Further:
		echo =========================================================================
	else
		systemctl restart docker; systemctl enable docker
		echo =========================================================================
		echo       Services are up and persistant now. Proceeding Further:
		echo =========================================================================
	
	fi
fi

sleep 2s
echo =========================================================================
echo "Congratulation, you have Successfully installed Docker"
cat /etc/redhat-release
echo For verification, check the Following output:
echo =========================================================================
sleep 2s
docker version
sleep 2s
echo =========================================================================
echo              Enjoy with the Containers. Happy Learning
echo =========================================================================
echo
echo =========================================================================
echo           Docker Deployed Successfully. Proceeding further:
echo =========================================================================



#firewall rules for minikube and kubectl
echo =========================================================================
echo            Adding Firewall Rules for minikube and kubectl
echo =========================================================================
sleep 3s
if firewall-cmd --list-all | grep ports: | grep 8443 | grep 10250
then
	echo =========================================================================
	echo           Firewall Rules Already Exists: Proceeding Further:
	echo =========================================================================
	sleep 3s
else
	firewall-cmd --zone=public --add-port=8443/tcp --permanent
	firewall-cmd --zone=public --add-port=10250/tcp --permanent
	firewall-cmd --reload
	echo =========================================================================
	echo              Rules Added to Firewall. Proceeding Further:
	echo =========================================================================
	sleep 3s
fi


#Kubectl Installation
echo =========================================================================
echo                 Downloading kubectl from kubernetes.io
echo =========================================================================
sleep 3s
if ls | grep -E '(^|\s)kubectl($|\s)'
then
	echo =========================================================================
	echo            Requirement Already Exists. Proceeding Further:
	echo =========================================================================
	sleep 3s
else
	curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl
fi

echo =========================================================================
echo                    Changing Permissions for kubectl
echo =========================================================================
sleep 3s
if ls -l | grep rwx | grep -E '(^|\s)kubectl($|\s)'
then
	echo =========================================================================
	echo         Permissions Already Satisfied. Proceeding Further:
	echo =========================================================================
	sleep 3s
else
	chmod +x ./kubectl
	echo =========================================================================
	echo              Permissions Changed. Proceeding Further:
	echo =========================================================================
	sleep 3s
fi

echo =========================================================================
echo       Copying kubectl to the Default Directory /usr/local/bin
echo =========================================================================
sleep 3s
if ls /usr/local/bin | grep -E '(^|\s)kubectl($|\s)'
then
	echo =========================================================================
	echo       kubectl Already Present in the Path. Proceeding Further:
	echo =========================================================================
	sleep 3s
else
	cp ./kubectl /usr/local/bin/kubectl
	echo =========================================================================
	echo                      Success. Proceeding Further.
	echo =========================================================================
	sleep 3s
fi



#Minikube Installation
echo =========================================================================
echo                    Downloading minikube in rhel8
echo =========================================================================
sleep 3s
if ls | grep -E '(^|\s)minikube($|\s)'
then
	echo =========================================================================
	echo          Requirement Already Exists. Proceeding Further:
	echo =========================================================================
	sleep 3s
else
	curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
fi

echo =========================================================================
echo                   Changing Permissions for minikube
echo =========================================================================
sleep 3s
if ls -l | grep rwx | grep -E '(^|\s)minikube($|\s)'
then
	echo =========================================================================
	echo         Permissions Already Satisfied. Proceeding Further:
	echo =========================================================================
	sleep 3s
else
	chmod +x minikube
	echo =========================================================================
	echo               Permissions Changed. Proceeding Further:
	echo =========================================================================
	sleep 3s
fi

echo =========================================================================
echo                   Modifying Directory for minikube:
echo =========================================================================
sleep 3s
mkdir -p /usr/local/bin/

echo =========================================================================
echo      Installing minikube to the Default Directory /usr/local/bin
echo =========================================================================
sleep 3s
if ls /usr/local/bin | grep -E '(^|\s)minikube($|\s)'
then
	echo =========================================================================
	echo  minikube Already Installed and Exists in Directory. Proceeding Further:
	echo =========================================================================
	sleep 3s
else
	install minikube /usr/local/bin/
	echo =========================================================================
	echo                     Success. Proceeding Further.
	echo =========================================================================
	sleep 3s
fi




#start minikube
echo =========================================================================
echo              Startinng the Minikube Kubernetes Cluster
echo =========================================================================
sleep 3s
if minikube status | grep host: | grep Stopped
then
	echo =========================================================================
	echo            minikube is Already Running in the Background.
	echo =========================================================================
	sleep 3s
else
	minikube start --driver=none
fi



#confirming ports
echo =========================================================================
echo                         Checking Active ports:
echo =========================================================================
sleep 3s
firewall-cmd --list-all | grep ports:



#check kubectl
echo =========================================================================
echo                Checking the kubectl status for clients
echo =========================================================================
sleep 3s
kubectl version --client -o json



#check Minikube
echo =========================================================================
echo                      Checking the minikube status
echo =========================================================================
sleep 3s
minikube status
echo
sleep 3s
echo =========================================================================
echo   Congratulations, Kubernetes Cluster by minikube Deployed Succesfully. 
echo            Enjoy and Play with Kubernetes. Happy Learning.
echo =========================================================================
rm -rf minikube
rm -rf kubectl
