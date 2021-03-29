#!/bin/sh

# Written by Tim Fournet 3/29/2021
# This is a bash script, it can be run either from a Linux host, or from the Azure Cloud Shell.
# To run from the cloud shell, use this command
# curl https://raw.githubusercontent.com/CyberCNS-Community/Deployment-Scripts/main/AzureAD/Create-CyberCNSADAppRegistration.sh | sh
# This will create an Azure AD App Registration with the permissions required, as outlined by the CyberCNS Documentation at 
# https://cybercns.atlassian.net/wiki/spaces/CYB/pages/1079017579/Azure+AD+Audit

AppAccountName="RADER_CNS_AzureAD_Audit"
cns_webid="https://www.cybercns.com"
credential_lifetime_years=10

function Login_Azure () {
    if [[ ! $(which az 2>/dev/null)  ]] ; then
        echo "az command not found, attempting an install"
        if [[ -f /etc/redhat-release ]]; then
            sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
            echo -e "[azure-cli]
    name=Azure CLI
    baseurl=https://packages.microsoft.com/yumrepos/azure-cli
    enabled=1
    gpgcheck=1
    gpgkey=https://packages.microsoft.com/keys/microsoft.asc" | sudo tee /etc/yum.repos.d/azure-cli.repo
            sudo dnf -y install azure-cli 
        elif [[ $(which apt-get) ]]; then
            curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
        fi 
    fi
    if [[ ! $(which az 2>/dev/null) ]] ; then
        echo "Problem: az command could not be found or installed. Please resolve this and try again"
        exit 101 
    fi

    # Log into account if needed
    az account show || az login --allow-no-subscriptions
    tenantId=$(az account show | jq -r .tenantId)
}

function Write_Manifest () {
    json_file=$(mktemp)
    echo -e '
    [
        {
            "additionalProperties": null,
            "expiryTime": "",
            "resourceAccess": [
            {
                "additionalProperties": null,
                "id": "1638cddf-07a4-4de2-8645-69c96cacad73",
                "type": "Scope"
            },
            {
                "additionalProperties": null,
                "id": "572fea84-0151-49b2-9301-11cb16974376",
                "type": "Scope"
            },
            {
                "additionalProperties": null,
                "id": "f1493658-876a-4c87-8fa7-edb559b3476a",
                "type": "Scope"
            },
            {
                "additionalProperties": null,
                "id": "4edf5f54-4666-44af-9de9-0144fb4b6e8c",
                "type": "Scope"
            },
            {
                "additionalProperties": null,
                "id": "314874da-47d6-4978-88dc-cf0d37f0bb82",
                "type": "Scope"
            },
            {
                "additionalProperties": null,
                "id": "8696daa5-bce5-4b2e-83f9-51b6defc4e1e",
                "type": "Scope"
            },
            {
                "additionalProperties": null,
                "id": "64733abd-851e-478a-bffb-e47a14b18235",
                "type": "Scope"
            },
            {
                "additionalProperties": null,
                "id": "a154be20-db9c-4678-8ab7-66f6cc099a59",
                "type": "Scope"
            },
            {
                "additionalProperties": null,
                "id": "5f8c59db-677d-491f-a6b8-5f174b11ec1d",
                "type": "Scope"
            },
            {
                "additionalProperties": null,
                "id": "06da0dbc-49e2-44d2-8312-53f166ab848a",
                "type": "Scope"
            },
            {
                "additionalProperties": null,
                "id": "84bccea3-f856-4a8a-967b-dbe0a3d53a64",
                "type": "Scope"
            },
            {
                "additionalProperties": null,
                "id": "c79f8feb-a9db-4090-85f9-90d820caa0eb",
                "type": "Scope"
            },
            {
                "additionalProperties": null,
                "id": "b27a61ec-b99c-4d6a-b126-c4375d08ae30",
                "type": "Scope"
            },
            {
                "additionalProperties": null,
                "id": "bc024368-1153-4739-b217-4326f2e966d0",
                "type": "Scope"
            },
            {
                "additionalProperties": null,
                "id": "2f9ee017-59c1-4f1d-9472-bd5529a7b311",
                "type": "Scope"
            },
            {
                "additionalProperties": null,
                "id": "951183d1-1a61-466f-a6d1-1fde911bfd95",
                "type": "Scope"
            },
            {
                "additionalProperties": null,
                "id": "1b6ff35f-31df-4332-8571-d31ea5a4893f",
                "type": "Scope"
            },
            {
                "additionalProperties": null,
                "id": "dc377aa6-52d8-4e23-b271-2a7ae04cedf3",
                "type": "Role"
            },
            {
                "additionalProperties": null,
                "id": "7a6ee1e7-141e-4cec-ae74-d9db155731ff",
                "type": "Role"
            },
            {
                "additionalProperties": null,
                "id": "2f51be20-0bb4-4fed-bf7b-db946066c75e",
                "type": "Role"
            },
            {
                "additionalProperties": null,
                "id": "06a5fe6d-c49d-46a7-b082-56b1b14103c7",
                "type": "Role"
            },
            {
                "additionalProperties": null,
                "id": "246dd0d5-5bd0-4def-940b-0421030a5b68",
                "type": "Role"
            },
            {
                "additionalProperties": null,
                "id": "5e0edab9-c148-49d0-b423-ac253e121825",
                "type": "Role"
            },
            {
                "additionalProperties": null,
                "id": "bf394140-e372-4bf9-a898-299cfc7564e5",
                "type": "Role"
            },
            {
                "additionalProperties": null,
                "id": "b0afded3-3588-46d8-8b3d-9842eff778da",
                "type": "Role"
            },
            {
                "additionalProperties": null,
                "id": "5b567255-7703-4780-807c-7be8301ae99b",
                "type": "Role"
            },
            {
                "additionalProperties": null,
                "id": "7ab1d382-f21e-4acd-a863-ba3e13f7da61",
                "type": "Role"
            },
            {
                "additionalProperties": null,
                "id": "06b708a9-e830-4db3-a914-8e69da51d44f",
                "type": "Role"
            },
            {
                "additionalProperties": null,
                "id": "9a5d68dd-52b0-4cc2-bd40-abcf44ac3a30",
                "type": "Role"
            },
            {
                "additionalProperties": null,
                "id": "98830695-27a2-44f7-8c18-0c3ebc9698f6",
                "type": "Role"
            },
            {
                "additionalProperties": null,
                "id": "dbb9058a-0e50-45d7-ae91-66909b5d4664",
                "type": "Role"
            },
            {
                "additionalProperties": null,
                "id": "7438b122-aefc-4978-80ed-43db9fcc7715",
                "type": "Role"
            },
            {
                "additionalProperties": null,
                "id": "b86848a7-d5b1-41eb-a9b4-54a4e6306e97",
                "type": "Role"
            }
            ],
            "resourceAppId": "00000003-0000-0000-c000-000000000000"
        }
    ]' > $json_file 
}

function Create_App () {
    appResult=$(az ad app create --display-name $AppAccountName --identifier $cns_webid --required-resource-accesses @$json_file)
    appId=$(echo $appResult | jq -r .appId)
    domain=$(echo $appResult | jq -r .publisherDomain)
}

function Create_App_Credential () {
    cred=$(az ad app credential reset --id $appId --append --years $credential_lifetime_years)
    cred_name=$(echo $cred | jq -r .name)
    cred_pass=$(echo $cred | jq -r .password)
}

function Output_Details () {
    echo -e "\n\n"
    echo "Please Enter the following into CyberCNS Settings Page"
    echo "======================================================"
    echo ""
    echo "Identifier Name: (Enter your Client's Name here)"
    echo "AD Domain: $domain"
    echo "Client ID: $appId" 
    echo "Tenant ID: $tenantId" 
    echo "Client Secret: $cred_pass"
    echo -e "\n\n"
    echo "If anything has gone wrong, you can delete this app by its ID with the following command:"
    echo " #    az ad app delete --id $appId"
}


Login_Azure || exit 105
Write_Manifest || exit 106
Create_App || exit 107
Create_App_Credential || exit 108
Output_Details || exit 109




