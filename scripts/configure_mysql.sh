#!/bin/bash

###############################################################################
# Script: configure_mysql.sh
# Description: Configure MySQL with secure installation and create database
# Usage: sudo ./configure_mysql.sh
###############################################################################

set -e  # Exit on any error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${GREEN}========================================${NC}"
echo -e "${GREEN}MySQL Configuration Script${NC}"
echo -e "${GREEN}========================================${NC}"

# Check if running as root
if [ "$EUID" -ne 0 ]; then 
    echo -e "${RED}Please run as root (use sudo)${NC}"
    exit 1
fi

# Prompt for MySQL root password
echo -e "\n${BLUE}Enter MySQL root password:${NC}"
read -s MYSQL_ROOT_PASSWORD
echo -e "${BLUE}Confirm MySQL root password:${NC}"
read -s MYSQL_ROOT_PASSWORD_CONFIRM

if [ "$MYSQL_ROOT_PASSWORD" != "$MYSQL_ROOT_PASSWORD_CONFIRM" ]; then
    echo -e "${RED}Passwords do not match!${NC}"
    exit 1
fi

# Set MySQL root password
echo -e "\n${YELLOW}[1/4] Setting MySQL root password...${NC}"
mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '$MYSQL_ROOT_PASSWORD';"
mysql -e "FLUSH PRIVILEGES;"

# Create database and user
echo -e "\n${YELLOW}[2/4] Creating database and user...${NC}"
mysql -u root -p"$MYSQL_ROOT_PASSWORD" <<EOF
-- Create database
CREATE DATABASE IF NOT EXISTS webdb;

-- Create user for web application
CREATE USER IF NOT EXISTS 'webuser'@'localhost' IDENTIFIED BY 'webpass123';

-- Grant privileges
GRANT ALL PRIVILEGES ON webdb.* TO 'webuser'@'localhost';
FLUSH PRIVILEGES;

-- Use the database
USE webdb;

-- Create sample table
CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insert sample data
INSERT INTO users (name, email) VALUES 
    ('John Doe', 'john@example.com'),
    ('Jane Smith', 'jane@example.com'),
    ('Bob Johnson', 'bob@example.com');

EOF

# Secure MySQL installation
echo -e "\n${YELLOW}[3/4] Securing MySQL installation...${NC}"
mysql -u root -p"$MYSQL_ROOT_PASSWORD" <<EOF
-- Remove anonymous users
DELETE FROM mysql.user WHERE User='';

-- Disallow root login remotely
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');

-- Remove test database
DROP DATABASE IF EXISTS test;
DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';

-- Reload privilege tables
FLUSH PRIVILEGES;
EOF

# Display configuration summary
echo -e "\n${YELLOW}[4/4] Displaying configuration summary...${NC}"
mysql -u root -p"$MYSQL_ROOT_PASSWORD" -e "SHOW DATABASES;" 2>/dev/null

echo -e "\n${GREEN}========================================${NC}"
echo -e "${GREEN}MySQL Configuration Summary${NC}"
echo -e "${GREEN}========================================${NC}"
echo -e "Database Name: ${BLUE}webdb${NC}"
echo -e "Database User: ${BLUE}webuser${NC}"
echo -e "Database Password: ${BLUE}webpass123${NC}"
echo -e "Sample Table: ${BLUE}users${NC}"
echo -e "${GREEN}========================================${NC}"

echo -e "\n${GREEN}✓ MySQL configuration completed successfully!${NC}"
echo -e "\n${YELLOW}Important: Save these credentials securely!${NC}"
echo -e "You can now use these credentials in your PHP applications.\n"
