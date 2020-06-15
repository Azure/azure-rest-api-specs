#!/bin/sh

# From https://www.microsoft.com/net/download/linux-package-manager/ubuntu14-04/sdk-2.0.0

wget -q https://packages.microsoft.com/config/ubuntu/16.04/packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb
sudo apt-get install apt-transport-https -y
sudo apt-get update
sudo apt-get install dotnet-sdk-2.0.0 -y