#!/bin/bash

###############################################################################
# Script: install_apache_mysql.sh
# Description: Install and configure Apache2 and MySQL on Ubuntu
# Usage: sudo ./install_apache_mysql.sh
###############################################################################

set -e  # Exit on any error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}========================================${NC}"
echo -e "${GREEN}Apache2 and MySQL Installation Script${NC}"
echo -e "${GREEN}========================================${NC}"

# Check if running as root
if [ "$EUID" -ne 0 ]; then 
    echo -e "${RED}Please run as root (use sudo)${NC}"
    exit 1
fi

# Update system packages
echo -e "\n${YELLOW}[1/6] Updating system packages...${NC}"
apt-get update -y
apt-get upgrade -y

# Install Apache2
echo -e "\n${YELLOW}[2/6] Installing Apache2...${NC}"
apt-get install -y apache2

# Install MySQL Server
echo -e "\n${YELLOW}[3/6] Installing MySQL Server...${NC}"
apt-get install -y mysql-server

# Install PHP and required modules
echo -e "\n${YELLOW}[4/6] Installing PHP and modules...${NC}"
apt-get install -y php libapache2-mod-php php-mysql php-cli php-curl php-gd php-mbstring php-xml php-xmlrpc

# Enable and start services
echo -e "\n${YELLOW}[5/6] Enabling and starting services...${NC}"
systemctl enable apache2
systemctl start apache2
systemctl enable mysql
systemctl start mysql

# Configure Apache2
echo -e "\n${YELLOW}[6/6] Configuring Apache2...${NC}"
a2enmod rewrite
systemctl restart apache2

# Display service status
echo -e "\n${GREEN}========================================${NC}"
echo -e "${GREEN}Installation Summary${NC}"
echo -e "${GREEN}========================================${NC}"
echo -e "Apache2 Status: $(systemctl is-active apache2)"
echo -e "MySQL Status: $(systemctl is-active mysql)"
echo -e "PHP Version: $(php -v | head -n 1)"
echo -e "${GREEN}========================================${NC}"

echo -e "\n${GREEN}✓ Installation completed successfully!${NC}"
echo -e "\n${YELLOW}Next steps:${NC}"
echo -e "1. Run: sudo ./configure_mysql.sh (to set up MySQL database)"
echo -e "2. Deploy your website files to /var/www/html/"
echo -e "3. Access your website at: http://$(curl -s ifconfig.me)\n"
