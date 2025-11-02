# Azure VM with Apache2 & MySQL - Complete Guide

This project demonstrates how to deploy a web server on Azure Virtual Machine with Apache2 and MySQL, both **manually** and using **Terraform**. The setup includes a sample PHP website that connects to MySQL database.

## 📋 Table of Contents

- [Overview](#overview)
- [Prerequisites](#prerequisites)
- [Project Structure](#project-structure)
- [Method 1: Terraform Deployment](#method-1-terraform-deployment)
- [Method 2: Manual Deployment](#method-2-manual-deployment)
- [Testing the Setup](#testing-the-setup)
- [Accessing the Website](#accessing-the-website)
- [Troubleshooting](#troubleshooting)
- [Cleanup](#cleanup)
- [Security Considerations](#security-considerations)

## 🎯 Overview

This project sets up:
- **Azure Virtual Machine** (Ubuntu 22.04 LTS)
- **Apache2** web server
- **MySQL** database server
- **PHP** with MySQL support
- Sample website with database connectivity test
- **Complete User Management System** with CRUD operations (Create, Read, Update, Delete)

### 🆕 New Features - User Management System

This project now includes a full-featured **CRUD application** for managing users:

- ✅ **Create**: Add new users via web form
- ✅ **Read**: View all users in a formatted table
- ✅ **Update**: Edit existing user information
- ✅ **Delete**: Remove users with confirmation dialog
- ✅ **Modern UI**: Responsive design with gradient backgrounds
- ✅ **Statistics Dashboard**: Real-time user count and database status

**New Pages:**
- `add_user.php` - Add new users
- `manage_users.php` - View and manage all users
- `edit_user.php` - Edit existing users
- `delete_user.php` - Delete users

📚 **Documentation:**
- [Complete CRUD Guide](USER_MANAGEMENT_GUIDE.md)
- [Quick Summary](USER_CRUD_SUMMARY.md)
- [Architecture Diagram](ARCHITECTURE_CRUD.md)

## 📦 Prerequisites

### For Both Methods:
- Azure account with an active subscription
- SSH key pair (will be generated if not exists)

### For Terraform:
- [Terraform](https://www.terraform.io/downloads.html) (>= 1.0)
- [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli)

### For Manual Setup:
- [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli)
- Basic knowledge of Linux commands

## 📁 Project Structure

```
AzureVM-Apache2-MYSQL/
├── terraform/
│   ├── main.tf                    # Main Terraform configuration
│   ├── variables.tf               # Variable definitions
│   ├── outputs.tf                 # Output values
│   ├── cloud-init.yaml           # Cloud-init configuration
│   └── terraform.tfvars.example  # Example variables file
├── scripts/
│   ├── create_azure_vm.sh        # Azure VM creation script (CLI)
│   ├── install_apache_mysql.sh   # Apache2 & MySQL installation
│   ├── configure_mysql.sh        # MySQL configuration
│   └── deploy_website.sh         # Website deployment
├── website/
│   ├── index.php                 # Main page
│   ├── db_test.php              # Database test page
│   └── info.php                 # PHP info page
└── README.md                     # This file
```

---

## 🚀 Method 1: Terraform Deployment

### Step 1: Prepare Terraform Configuration

1. **Navigate to the terraform directory:**
   ```bash
   cd terraform
   ```

2. **Create terraform.tfvars file:**
   ```bash
   cp terraform.tfvars.example terraform.tfvars
   ```

3. **Edit terraform.tfvars with your values:**
   ```bash
   nano terraform.tfvars
   ```

   Example content:
   ```hcl
   resource_group_name = "rg-webserver-demo"
   location            = "East US"
   prefix              = "webserver"
   environment         = "Development"
   vm_size             = "Standard_B2s"
   admin_username      = "azureuser"
   ssh_public_key_path = "~/.ssh/id_rsa.pub"
   mysql_root_password = "YourSecurePassword123!"
   ```

### Step 2: Login to Azure

```bash
az login
```

### Step 3: Initialize Terraform

```bash
terraform init
```

### Step 4: Review the Deployment Plan

```bash
terraform plan
```

### Step 5: Deploy the Infrastructure

```bash
terraform apply
```

Type `yes` when prompted to confirm.

### Step 6: Get Output Information

```bash
terraform output
```

You'll see output like:
```
public_ip_address = "20.X.X.X"
ssh_command = "ssh azureuser@20.X.X.X"
website_url = "http://20.X.X.X"
```

### Step 7: Wait for Setup to Complete

Cloud-init will automatically install and configure everything. Wait about 5-10 minutes, then check:

```bash
# SSH into the VM
ssh azureuser@<PUBLIC_IP>

# Check if services are running
sudo systemctl status apache2
sudo systemctl status mysql

# Exit the VM
exit
```

### Step 8: Access Your Website

Open your browser and navigate to:
- **Main page:** `http://<PUBLIC_IP>`
- **Database test:** `http://<PUBLIC_IP>/db_test.php`
- **PHP info:** `http://<PUBLIC_IP>/info.php`

---

## 🛠️ Method 2: Manual Deployment

### Step 1: Create Azure VM Using Azure CLI

1. **Navigate to the scripts directory:**
   ```bash
   cd scripts
   ```

2. **Make the script executable:**
   ```bash
   chmod +x create_azure_vm.sh
   ```

3. **Login to Azure:**
   ```bash
   az login
   ```

4. **Run the VM creation script:**
   ```bash
   ./create_azure_vm.sh
   ```

   This will:
   - Create a resource group
   - Set up virtual network and subnet
   - Configure network security group (NSG) with rules for SSH, HTTP, HTTPS
   - Create public IP address
   - Create and configure the VM

5. **Note the output:** Save the public IP address displayed at the end.

### Step 2: Connect to the VM

```bash
ssh azureuser@<PUBLIC_IP>
```

### Step 3: Install Apache2 and MySQL

1. **Copy the installation scripts to the VM:**
   
   From your local machine:
   ```bash
   scp install_apache_mysql.sh azureuser@<PUBLIC_IP>:~/
   scp configure_mysql.sh azureuser@<PUBLIC_IP>:~/
   scp deploy_website.sh azureuser@<PUBLIC_IP>:~/
   ```

2. **SSH into the VM:**
   ```bash
   ssh azureuser@<PUBLIC_IP>
   ```

3. **Make scripts executable:**
   ```bash
   chmod +x install_apache_mysql.sh configure_mysql.sh deploy_website.sh
   ```

4. **Run the installation script:**
   ```bash
   sudo ./install_apache_mysql.sh
   ```

   This will:
   - Update system packages
   - Install Apache2
   - Install MySQL Server
   - Install PHP and required modules
   - Enable and start services

### Step 4: Configure MySQL

```bash
sudo ./configure_mysql.sh
```

When prompted:
- Enter a secure MySQL root password
- Confirm the password

This will:
- Set MySQL root password
- Create database `webdb`
- Create user `webuser` with password `webpass123`
- Create sample `users` table with test data
- Secure MySQL installation

### Step 5: Deploy the Website

```bash
sudo ./deploy_website.sh
```

This will:
- Backup existing website files
- Deploy sample PHP website
- Set proper permissions
- Display access URLs

### Step 6: Access Your Website

Open your browser and navigate to:
- **Main page:** `http://<PUBLIC_IP>`
- **Database test:** `http://<PUBLIC_IP>/db_test.php`
- **PHP info:** `http://<PUBLIC_IP>/info.php`

---

## 🧪 Testing the Setup

### 1. Test Apache2

```bash
# Check Apache status
sudo systemctl status apache2

# Test configuration
sudo apache2ctl configtest

# Check if Apache is listening
sudo netstat -tulpn | grep :80
```

### 2. Test MySQL

```bash
# Login to MySQL
sudo mysql -u root -p

# Show databases
SHOW DATABASES;

# Use webdb
USE webdb;

# Show tables
SHOW TABLES;

# Query users
SELECT * FROM users;

# Exit MySQL
EXIT;
```

### 3. Test PHP

```bash
# Check PHP version
php -v

# Test PHP modules
php -m | grep mysql
```

### 4. Test Website Connectivity

```bash
# Test from VM
curl http://localhost

# Test from outside (from your local machine)
curl http://<PUBLIC_IP>
```

---

## 🌐 Accessing the Website

After deployment, you can access:

1. **Homepage** - `http://<PUBLIC_IP>/`
   - Displays server information
   - Shows PHP version
   - Links to test pages

2. **Database Test** - `http://<PUBLIC_IP>/db_test.php`
   - Tests MySQL connectivity
   - Displays users from database
   - Shows connection details

3. **PHP Info** - `http://<PUBLIC_IP>/info.php`
   - Complete PHP configuration
   - Loaded modules
   - System information

---

## 🔧 Troubleshooting

### Issue: Cannot access website

**Check firewall rules:**
```bash
# On Azure portal, verify NSG rules allow port 80
az network nsg rule list --resource-group rg-webserver-demo --nsg-name webserver-nsg --output table
```

**Check Apache status:**
```bash
sudo systemctl status apache2
sudo journalctl -u apache2 -n 50
```

### Issue: Database connection fails

**Check MySQL status:**
```bash
sudo systemctl status mysql
```

**Verify database and user:**
```bash
sudo mysql -u root -p
SHOW DATABASES;
SELECT user, host FROM mysql.user WHERE user='webuser';
```

**Check credentials in db_test.php:**
```bash
cat /var/www/html/db_test.php | grep -A 5 "servername"
```

### Issue: 502 Bad Gateway or PHP not working

**Verify PHP is installed:**
```bash
php -v
```

**Check Apache PHP module:**
```bash
apache2ctl -M | grep php
```

**Restart Apache:**
```bash
sudo systemctl restart apache2
```

### Issue: Permission denied errors

**Fix file permissions:**
```bash
sudo chown -R www-data:www-data /var/www/html
sudo chmod -R 755 /var/www/html
```

### Issue: SSH connection timeout

**Verify NSG rule for SSH:**
```bash
az network nsg rule show \
  --resource-group rg-webserver-demo \
  --nsg-name webserver-nsg \
  --name Allow-SSH
```

### View Logs

```bash
# Apache error logs
sudo tail -f /var/log/apache2/error.log

# Apache access logs
sudo tail -f /var/log/apache2/access.log

# MySQL logs
sudo tail -f /var/log/mysql/error.log

# System logs
sudo journalctl -xe
```

---

## 🧹 Cleanup

### For Terraform Deployment:

```bash
cd terraform
terraform destroy
```

Type `yes` when prompted.

### For Manual Deployment:

```bash
# Delete the entire resource group
az group delete --name rg-webserver-demo --yes --no-wait

# Or delete individual resources
az vm delete --resource-group rg-webserver-demo --name webserver-vm --yes
az network nic delete --resource-group rg-webserver-demo --name webserver-nic
az network public-ip delete --resource-group rg-webserver-demo --name webserver-publicip
az network nsg delete --resource-group rg-webserver-demo --name webserver-nsg
az network vnet delete --resource-group rg-webserver-demo --name webserver-vnet
```

---

## 🔐 Security Considerations

### ⚠️ Important Security Notes:

1. **MySQL Password:**
   - Change the default MySQL root password
   - Use strong passwords for database users
   - Never commit passwords to version control

2. **SSH Access:**
   - Consider restricting SSH access to your IP only
   - Use SSH keys instead of passwords
   - Disable root login via SSH

3. **Network Security:**
   - Restrict MySQL port (3306) access in production
   - Consider using Azure Private Link for database
   - Enable HTTPS (SSL/TLS) for production websites

4. **Regular Updates:**
   ```bash
   sudo apt update
   sudo apt upgrade -y
   ```

5. **Firewall Configuration:**
   ```bash
   # Enable UFW firewall
   sudo ufw allow 22/tcp
   sudo ufw allow 80/tcp
   sudo ufw allow 443/tcp
   sudo ufw enable
   ```

### Recommended Security Improvements:

1. **Use Azure Key Vault** for storing secrets
2. **Enable Azure Disk Encryption** for VM disks
3. **Configure Azure Backup** for VM
4. **Set up Azure Monitor** for logging and alerts
5. **Use Managed Identities** for Azure service authentication
6. **Implement SSL/TLS** with Let's Encrypt

---

## 📚 Additional Resources

- [Azure Virtual Machines Documentation](https://docs.microsoft.com/en-us/azure/virtual-machines/)
- [Apache2 Documentation](https://httpd.apache.org/docs/)
- [MySQL Documentation](https://dev.mysql.com/doc/)
- [Terraform Azure Provider](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs)
- [Azure CLI Reference](https://docs.microsoft.com/en-us/cli/azure/)

---

## 🛡️ Default Credentials

**MySQL Database:**
- Database: `webdb`
- Username: `webuser`
- Password: `webpass123`
- Root Password: (set during configuration)

**⚠️ Change these credentials in production!**

---

## 📝 Quick Command Reference

### Terraform Commands
```bash
terraform init          # Initialize Terraform
terraform plan          # Preview changes
terraform apply         # Apply changes
terraform destroy       # Destroy infrastructure
terraform output        # Show outputs
terraform fmt           # Format configuration files
terraform validate      # Validate configuration
```

### Azure CLI Commands
```bash
az login                                    # Login to Azure
az account list                            # List subscriptions
az account set --subscription "<NAME>"     # Set subscription
az group list                              # List resource groups
az vm list --output table                  # List VMs
az vm start --resource-group <RG> --name <VM>    # Start VM
az vm stop --resource-group <RG> --name <VM>     # Stop VM
az vm show --resource-group <RG> --name <VM>     # Show VM details
```

### Service Management Commands
```bash
sudo systemctl status apache2       # Check Apache status
sudo systemctl restart apache2      # Restart Apache
sudo systemctl status mysql         # Check MySQL status
sudo systemctl restart mysql        # Restart MySQL
```

---

## 🎓 Learning Outcomes

After completing this project, you will have learned:
- How to deploy Azure Virtual Machines using Terraform and Azure CLI
- How to configure network security groups and firewall rules
- How to install and configure Apache2 web server
- How to set up MySQL database server
- How to deploy PHP applications
- How to use cloud-init for automated configuration
- Infrastructure as Code (IaC) best practices

---

## 🤝 Contributing

Feel free to submit issues, fork the repository, and create pull requests for any improvements.

---

## 📄 License

This project is licensed under the MIT License - feel free to use it for learning and development purposes.

---

## ✨ Author

Created as a demonstration project for Azure VM deployment with Apache2 and MySQL.

---

**Happy Deploying! 🚀**
