#!/usr/bin/bash

echo ============================================================================================================
echo "Welcome to Automatic awsvliv2 and terraform Deployment Wizard. This Script works both with Red Hat 
Enterprise Linux Server release 7.5 (Maipo) and Red Hat Enterprise Linux Release 8.0 (Ootpa)"
echo ============================================================================================================
sleep 2s
echo "                                      Fetching Red Hat Linux Version                                      ";sleep 2s
echo ============================================================================================================
sudo cat /etc/redhat-release
echo ============================================================================================================
echo

# AWS-CLI-V2 install
#--------------------------------------------------------------------------------------

sleep 2s
echo ----------------------------------------------------------------------------
echo "                  Installing AdditionalPackages package                   "
echo ----------------------------------------------------------------------------
sleep 2s
if sudo rpm -qa | grep unzip; sudo rpm -qa | grep wget
then
	echo ----------------------------------------------------------------------------
	echo "                       Package Already Installed                          "
	echo ----------------------------------------------------------------------------
else
	sudo yum install unzip wget -y
fi

sleep 2s
echo ----------------------------------------------------------------------------
echo "                    Downloading awscliv2.zip package                      "
echo ----------------------------------------------------------------------------
sleep 2s
if sudo ls | grep awscliv2.zip
then
	sleep 2s
	echo ----------------------------------------------------------------------------
	echo "                        Package already curled                            "
	echo ----------------------------------------------------------------------------
else
	sudo curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
fi

sleep 2s
echo ----------------------------------------------------------------------------
echo "                      Unzipping awscliv2.zip file                         "
echo ----------------------------------------------------------------------------

sleep 2s
if sudo ls | grep -E '(^|\s)aws($|\s)'
then
	sleep 2s
	echo ----------------------------------------------------------------------------
	echo "                       Package already unzipped                           "
	echo ----------------------------------------------------------------------------
else
	sudo unzip awscliv2.zip
fi

sleep 2s
echo ----------------------------------------------------------------------------
echo "                      Installing awscliv2 Package                         "
echo ----------------------------------------------------------------------------
sleep 2s
if sudo ls /usr/local/bin/ | grep -E 'aws|aws_completer'
then
	sleep 2s
	echo ----------------------------------------------------------------------------
	echo "                       Package already installed                          " 
	echo ----------------------------------------------------------------------------
else
	sudo ./aws/install
fi

sleep 2s
echo ----------------------------------------------------------------------------
echo "                     Confirming the awscli version                        "
echo ----------------------------------------------------------------------------
sleep 1s
aws --version


# Terraform Install
#--------------------------------------------------------------------------------------

sleep 2s
echo ----------------------------------------------------------------------------
echo "                      Installing Terraform Package                        "
echo ----------------------------------------------------------------------------

sleep 2s
echo '***************************************************'
echo "               Installing yum-utils               " 
echo '***************************************************'
sleep 2s
if sudo rpm -qa | grep dnf-utils
then
	echo '***************************************************'
	echo "               Already Installed                  "
	echo '***************************************************'
else
	sudo yum install -y yum-utils
fi

sleep 2s
echo '***************************************************'
echo " Creating Yum REpository for HarshiCorp Terraform "
echo '***************************************************'
sleep 2s
if sudo ls /etc/yum.repos.d/ | grep hashicorp.repo
then
	echo '***************************************************'
	echo "            Repository already exists             "
	echo '***************************************************'
else
	sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo
fi

sleep 2s
echo '***************************************************'
echo "                Installing Package                "
echo '***************************************************'
sleep 2s
if sudo rpm -qa | grep terraform
then
	echo '***************************************************'
	echo "            Package already Installed             "
	echo '***************************************************'
else
	sudo yum install terraform -y
fi

sleep 2s
echo ----------------------------------------------------------------------------
echo "                    Confirming the Terraform Version                      "
echo ----------------------------------------------------------------------------
sleep 1s
terraform -v

sudo rm -rf awscliv2.zip
sudo rm -rf aws

sleep 2s
echo ----------------------------------------------------------------------------
echo "Congratulations, awscliv2 and terraform has been successfully deployed in 
your system. Happy Learning."
echo ----------------------------------------------------------------------------
