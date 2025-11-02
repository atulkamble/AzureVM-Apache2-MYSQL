#!/bin/bash

###############################################################################
# Script: create_azure_vm.sh
# Description: Create Azure VM manually using Azure CLI
# Usage: ./create_azure_vm.sh
###############################################################################

set -e  # Exit on any error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${GREEN}========================================${NC}"
echo -e "${GREEN}Azure VM Creation Script${NC}"
echo -e "${GREEN}========================================${NC}"

# Configuration variables
RESOURCE_GROUP="rg-webserver-demo"
LOCATION="eastus"
VM_NAME="webserver-vm"
VNET_NAME="webserver-vnet"
SUBNET_NAME="webserver-subnet"
NSG_NAME="webserver-nsg"
PUBLIC_IP_NAME="webserver-publicip"
NIC_NAME="webserver-nic"
VM_SIZE="Standard_B2s"
ADMIN_USERNAME="azureuser"
IMAGE="Ubuntu2204"

# Check if Azure CLI is installed
if ! command -v az &> /dev/null; then
    echo -e "${RED}Azure CLI is not installed. Please install it first.${NC}"
    echo -e "Visit: https://docs.microsoft.com/en-us/cli/azure/install-azure-cli"
    exit 1
fi

# Check if logged in to Azure
echo -e "\n${YELLOW}Checking Azure login status...${NC}"
if ! az account show &> /dev/null; then
    echo -e "${RED}Not logged in to Azure. Please run 'az login' first.${NC}"
    exit 1
fi

# Display current subscription
SUBSCRIPTION=$(az account show --query name -o tsv)
echo -e "${GREEN}Current subscription: ${BLUE}$SUBSCRIPTION${NC}"

# Create Resource Group
echo -e "\n${YELLOW}[1/8] Creating Resource Group...${NC}"
az group create \
    --name $RESOURCE_GROUP \
    --location $LOCATION \
    --tags Environment=Development Project=WebServer

# Create Virtual Network
echo -e "\n${YELLOW}[2/8] Creating Virtual Network...${NC}"
az network vnet create \
    --resource-group $RESOURCE_GROUP \
    --name $VNET_NAME \
    --address-prefix 10.0.0.0/16 \
    --subnet-name $SUBNET_NAME \
    --subnet-prefix 10.0.1.0/24

# Create Network Security Group
echo -e "\n${YELLOW}[3/8] Creating Network Security Group...${NC}"
az network nsg create \
    --resource-group $RESOURCE_GROUP \
    --name $NSG_NAME

# Add NSG rules
echo -e "\n${YELLOW}[4/8] Adding NSG rules...${NC}"
# SSH
az network nsg rule create \
    --resource-group $RESOURCE_GROUP \
    --nsg-name $NSG_NAME \
    --name Allow-SSH \
    --priority 1001 \
    --source-address-prefixes '*' \
    --destination-port-ranges 22 \
    --access Allow \
    --protocol Tcp

# HTTP
az network nsg rule create \
    --resource-group $RESOURCE_GROUP \
    --nsg-name $NSG_NAME \
    --name Allow-HTTP \
    --priority 1002 \
    --source-address-prefixes '*' \
    --destination-port-ranges 80 \
    --access Allow \
    --protocol Tcp

# HTTPS
az network nsg rule create \
    --resource-group $RESOURCE_GROUP \
    --nsg-name $NSG_NAME \
    --name Allow-HTTPS \
    --priority 1003 \
    --source-address-prefixes '*' \
    --destination-port-ranges 443 \
    --access Allow \
    --protocol Tcp

# Create Public IP
echo -e "\n${YELLOW}[5/8] Creating Public IP...${NC}"
az network public-ip create \
    --resource-group $RESOURCE_GROUP \
    --name $PUBLIC_IP_NAME \
    --allocation-method Static \
    --sku Standard

# Create Network Interface
echo -e "\n${YELLOW}[6/8] Creating Network Interface...${NC}"
az network nic create \
    --resource-group $RESOURCE_GROUP \
    --name $NIC_NAME \
    --vnet-name $VNET_NAME \
    --subnet $SUBNET_NAME \
    --public-ip-address $PUBLIC_IP_NAME \
    --network-security-group $NSG_NAME

# Create Virtual Machine
echo -e "\n${YELLOW}[7/8] Creating Virtual Machine...${NC}"
echo -e "${BLUE}This will generate an SSH key pair if one doesn't exist...${NC}"
az vm create \
    --resource-group $RESOURCE_GROUP \
    --name $VM_NAME \
    --location $LOCATION \
    --nics $NIC_NAME \
    --image $IMAGE \
    --size $VM_SIZE \
    --admin-username $ADMIN_USERNAME \
    --generate-ssh-keys \
    --tags Environment=Development

# Get VM information
echo -e "\n${YELLOW}[8/8] Retrieving VM information...${NC}"
PUBLIC_IP=$(az network public-ip show \
    --resource-group $RESOURCE_GROUP \
    --name $PUBLIC_IP_NAME \
    --query ipAddress -o tsv)

PRIVATE_IP=$(az vm show \
    --resource-group $RESOURCE_GROUP \
    --name $VM_NAME \
    --show-details \
    --query privateIps -o tsv)

echo -e "\n${GREEN}========================================${NC}"
echo -e "${GREEN}VM Creation Summary${NC}"
echo -e "${GREEN}========================================${NC}"
echo -e "Resource Group: ${BLUE}$RESOURCE_GROUP${NC}"
echo -e "VM Name: ${BLUE}$VM_NAME${NC}"
echo -e "Location: ${BLUE}$LOCATION${NC}"
echo -e "VM Size: ${BLUE}$VM_SIZE${NC}"
echo -e "Admin Username: ${BLUE}$ADMIN_USERNAME${NC}"
echo -e "Public IP: ${BLUE}$PUBLIC_IP${NC}"
echo -e "Private IP: ${BLUE}$PRIVATE_IP${NC}"
echo -e "${GREEN}========================================${NC}"

echo -e "\n${GREEN}✓ Azure VM created successfully!${NC}"
echo -e "\n${YELLOW}Next steps:${NC}"
echo -e "1. SSH into the VM:"
echo -e "   ${BLUE}ssh $ADMIN_USERNAME@$PUBLIC_IP${NC}"
echo -e "\n2. Copy and run the installation scripts:"
echo -e "   ${BLUE}scp scripts/*.sh $ADMIN_USERNAME@$PUBLIC_IP:~/${NC}"
echo -e "   ${BLUE}ssh $ADMIN_USERNAME@$PUBLIC_IP${NC}"
echo -e "   ${BLUE}chmod +x *.sh${NC}"
echo -e "   ${BLUE}sudo ./install_apache_mysql.sh${NC}"
echo -e "   ${BLUE}sudo ./configure_mysql.sh${NC}"
echo -e "   ${BLUE}sudo ./deploy_website.sh${NC}"
echo -e "\n3. Access your website:"
echo -e "   ${BLUE}http://$PUBLIC_IP${NC}\n"
