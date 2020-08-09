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
echo "                     Downloading Terraform Packager                       "
echo ----------------------------------------------------------------------------
sleep 2s
if sudo ls | grep terraform_0.12.29_linux_amd64.zip
then
	sleep 2s
	echo ----------------------------------------------------------------------------
	echo "                      Package already downloaded                          "
	echo ----------------------------------------------------------------------------
else
	sudo wget https://releases.hashicorp.com/terraform/0.12.29/terraform_0.12.29_linux_amd64.zip
fi

sleep 2s
echo ----------------------------------------------------------------------------
echo "          Unzipping the Package at location [ /usr/local/bin ]            "
echo ----------------------------------------------------------------------------
sleep 2s
if sudo ls /usr/local/bin/ | grep -E '(^|\s)terraform($|\s)' 
then
	sleep 2s
	echo ----------------------------------------------------------------------------
	echo "                        Package Already Unzipped                          "
	echo ----------------------------------------------------------------------------
else
	sudo unzip terraform_0.12.29_linux_amd64.zip -d /usr/local/bin/
fi

sleep 2s
echo ----------------------------------------------------------------------------
echo "                    Confirming the Terraform Version                      "
echo ----------------------------------------------------------------------------
sleep 1s
terraform -v

sleep 2s
echo ----------------------------------------------------------------------------
echo "Congratulations, awscliv2 and terraform has been successfully deployed in 
your system. Happy Learning."
echo ----------------------------------------------------------------------------
