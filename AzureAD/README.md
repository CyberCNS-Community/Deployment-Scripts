
# Create-CyberCNSADAppRegistration.sh

Written by Tim Fournet 3/29/2021
This is a bash script, it can be run either from a Linux host, or from the Azure Cloud Shell at https://portal.azure.com.
To run from the cloud shell, use this command: 

`curl https://raw.githubusercontent.com/CyberCNS-Community/Deployment-Scripts/main/AzureAD/Create-CyberCNSADAppRegistration.sh | sh`


This will create an Azure AD App Registration with the permissions required, as outlined by the CyberCNS Documentation at 
https://cybercns.atlassian.net/wiki/spaces/CYB/pages/1079017579/Azure+AD+Audit

The script will output the information to plug into the CyberCNS UI.