Import the `CyberCNS_Agent-Distributable.xml` file into your Automate instance  

This script contains some Global Variables you will need to update (in the Globals and Parameters tab in CWA):
* **cns-domain** - this will correspond to the URL of your CyberCNS Instance
* **cybercns_clientId** - Your global CyberCNS Client ID (assigned to YOUR organization) 
* **cybercns_clientSecret** - Your global CyberCNS Client Secret (assigned to YOUR organization)
To locate the above identifiers, go to CyberCNS and press the 'Probe / Agent' Download button, and choose any of the options. The Client ID comes after the `-a` switch, and Client Secret comes after `-s`. 

This script will create the following EDFs (Extra Data Fields) in a tab called "Security" (Feel free to change these to suit your preferences):
* **Client**:
  * **CyberCNS** (Click to Enable CyberCNS for the client in general)     
  * **CNS Company ID** - Use the identifier from CyberCNS for the client. You get this from the 'Probe / Agent' download, after the `-s` switch.
* **Computer**: 
  * **CyberCNS Probe** - Will install the agent in Probe mode

Further details:
* The script will automatically install as a probe if it's run on a Linux machine with the word 'perch' in the hostname.
* Running the script with the 'uninstall' parameter will uninstall the agent.
* Running with the 'force_reinstall' parameter will uninstall, and then reinstall the agent
* If you installed the agent as Lightweight (the default option) and want to convert that to Probe with this script, you'll need to reinstall

Contect me, @Tim Fournet, in the CyberCNS slack for help. 
