Import the CyberCNS_Agent_Install.xml file into your Automate instance  


This script will create the following EDFs (Extra Data Fields):
* **Client**:
  * **CyberCNS** (Click to Enable CyberCNS for the client in general)     
  * **CNS Company ID** (use the identifier from CyberCNS for the client)
* **Location**:   
  * **CyberCNS Location Identifier** (Use the identifier from CyberCNS for the site)
  * **Deploy CyberCNS Lightweight Agent** (Click to enable LW Agent install to all computers on this site)


You will need to change the Global Variable for **cns-domain** in this script to match your CyberCNS Deployment.

Here is what the script should look like:

<img src="https://github.com/CyberCNS-Community/Deployment-Scripts/blob/main/ConnectWise_Automate/Screenshot%20from%202021-01-22%2013-24-35.png">
<img src="https://github.com/CyberCNS-Community/Deployment-Scripts/blob/main/ConnectWise_Automate/Screenshot%20from%202021-01-22%2013-26-00.png">
