# Commands Reference Sheet

Quick reference for common commands used in this project.

## 📋 Table of Contents
- [Azure CLI Commands](#azure-cli-commands)
- [Terraform Commands](#terraform-commands)
- [SSH & SCP Commands](#ssh--scp-commands)
- [Apache2 Commands](#apache2-commands)
- [MySQL Commands](#mysql-commands)
- [System Administration](#system-administration)
- [Network & Firewall](#network--firewall)
- [File Management](#file-management)

---

## Azure CLI Commands

### Login & Authentication
```bash
# Login to Azure
az login

# Login with specific tenant
az login --tenant <TENANT_ID>

# Show current account
az account show

# List all subscriptions
az account list --output table

# Set active subscription
az account set --subscription "<SUBSCRIPTION_NAME>"
```

### Resource Groups
```bash
# Create resource group
az group create --name <RG_NAME> --location <LOCATION>

# List resource groups
az group list --output table

# Delete resource group
az group delete --name <RG_NAME> --yes --no-wait

# Show resource group
az group show --name <RG_NAME>
```

### Virtual Machines
```bash
# Create VM
az vm create \
  --resource-group <RG_NAME> \
  --name <VM_NAME> \
  --image Ubuntu2204 \
  --size Standard_B2s \
  --admin-username azureuser \
  --generate-ssh-keys

# List VMs
az vm list --output table

# Show VM details
az vm show --resource-group <RG_NAME> --name <VM_NAME>

# Start VM
az vm start --resource-group <RG_NAME> --name <VM_NAME>

# Stop VM (deallocate)
az vm deallocate --resource-group <RG_NAME> --name <VM_NAME>

# Restart VM
az vm restart --resource-group <RG_NAME> --name <VM_NAME>

# Delete VM
az vm delete --resource-group <RG_NAME> --name <VM_NAME> --yes

# Get VM public IP
az vm show --resource-group <RG_NAME> --name <VM_NAME> \
  --show-details --query publicIps -o tsv
```

### Network Security Groups
```bash
# Create NSG
az network nsg create --resource-group <RG_NAME> --name <NSG_NAME>

# List NSG rules
az network nsg rule list --resource-group <RG_NAME> \
  --nsg-name <NSG_NAME> --output table

# Create NSG rule
az network nsg rule create \
  --resource-group <RG_NAME> \
  --nsg-name <NSG_NAME> \
  --name <RULE_NAME> \
  --priority 1000 \
  --source-address-prefixes '*' \
  --destination-port-ranges 80 \
  --access Allow \
  --protocol Tcp

# Delete NSG rule
az network nsg rule delete \
  --resource-group <RG_NAME> \
  --nsg-name <NSG_NAME> \
  --name <RULE_NAME>
```

### Public IPs
```bash
# Create public IP
az network public-ip create \
  --resource-group <RG_NAME> \
  --name <IP_NAME> \
  --allocation-method Static

# Show public IP
az network public-ip show \
  --resource-group <RG_NAME> \
  --name <IP_NAME> \
  --query ipAddress -o tsv

# List public IPs
az network public-ip list --output table
```

---

## Terraform Commands

### Basic Commands
```bash
# Initialize Terraform
terraform init

# Validate configuration
terraform validate

# Format configuration files
terraform fmt

# Show execution plan
terraform plan

# Apply changes
terraform apply

# Apply without confirmation
terraform apply -auto-approve

# Destroy infrastructure
terraform destroy

# Destroy without confirmation
terraform destroy -auto-approve
```

### State Management
```bash
# Show current state
terraform show

# List resources in state
terraform state list

# Show specific resource
terraform state show <RESOURCE_NAME>

# Remove resource from state
terraform state rm <RESOURCE_NAME>

# Refresh state
terraform refresh
```

### Workspace Management
```bash
# List workspaces
terraform workspace list

# Create workspace
terraform workspace new <WORKSPACE_NAME>

# Select workspace
terraform workspace select <WORKSPACE_NAME>

# Delete workspace
terraform workspace delete <WORKSPACE_NAME>
```

### Output Management
```bash
# Show all outputs
terraform output

# Show specific output
terraform output <OUTPUT_NAME>

# Output in JSON format
terraform output -json
```

---

## SSH & SCP Commands

### SSH Operations
```bash
# Connect to VM
ssh <USERNAME>@<PUBLIC_IP>

# Connect with specific key
ssh -i ~/.ssh/id_rsa <USERNAME>@<PUBLIC_IP>

# Connect with verbose output
ssh -v <USERNAME>@<PUBLIC_IP>

# Run command on remote server
ssh <USERNAME>@<PUBLIC_IP> "command"

# Generate SSH key pair
ssh-keygen -t rsa -b 4096 -f ~/.ssh/id_rsa
```

### SCP File Transfer
```bash
# Copy file to remote server
scp local_file.txt <USERNAME>@<PUBLIC_IP>:~/

# Copy directory to remote server
scp -r local_directory <USERNAME>@<PUBLIC_IP>:~/

# Copy file from remote server
scp <USERNAME>@<PUBLIC_IP>:~/remote_file.txt ./

# Copy with specific key
scp -i ~/.ssh/id_rsa file.txt <USERNAME>@<PUBLIC_IP>:~/

# Copy multiple files
scp file1.txt file2.txt <USERNAME>@<PUBLIC_IP>:~/
```

---

## Apache2 Commands

### Service Management
```bash
# Start Apache
sudo systemctl start apache2

# Stop Apache
sudo systemctl stop apache2

# Restart Apache
sudo systemctl restart apache2

# Reload configuration
sudo systemctl reload apache2

# Check status
sudo systemctl status apache2

# Enable auto-start
sudo systemctl enable apache2

# Disable auto-start
sudo systemctl disable apache2
```

### Configuration
```bash
# Test configuration
sudo apache2ctl configtest

# Show loaded modules
sudo apache2ctl -M

# Enable module
sudo a2enmod <MODULE_NAME>

# Disable module
sudo a2dismod <MODULE_NAME>

# Enable site
sudo a2ensite <SITE_NAME>

# Disable site
sudo a2dissite <SITE_NAME>
```

### Logs
```bash
# View error log
sudo tail -f /var/log/apache2/error.log

# View access log
sudo tail -f /var/log/apache2/access.log

# View last 100 lines
sudo tail -n 100 /var/log/apache2/error.log

# Search logs
sudo grep "error" /var/log/apache2/error.log
```

---

## MySQL Commands

### Service Management
```bash
# Start MySQL
sudo systemctl start mysql

# Stop MySQL
sudo systemctl stop mysql

# Restart MySQL
sudo systemctl restart mysql

# Check status
sudo systemctl status mysql
```

### Database Operations
```bash
# Login to MySQL
sudo mysql -u root -p

# Login as specific user
mysql -u <USERNAME> -p

# Execute SQL from command line
mysql -u root -p -e "SHOW DATABASES;"

# Execute SQL from file
mysql -u root -p < script.sql

# Dump database
mysqldump -u root -p <DATABASE> > backup.sql

# Restore database
mysql -u root -p <DATABASE> < backup.sql
```

### Common SQL Commands
```sql
-- Show databases
SHOW DATABASES;

-- Create database
CREATE DATABASE database_name;

-- Use database
USE database_name;

-- Show tables
SHOW TABLES;

-- Describe table
DESCRIBE table_name;

-- Create user
CREATE USER 'username'@'localhost' IDENTIFIED BY 'password';

-- Grant privileges
GRANT ALL PRIVILEGES ON database.* TO 'username'@'localhost';

-- Flush privileges
FLUSH PRIVILEGES;

-- Show users
SELECT user, host FROM mysql.user;

-- Show grants
SHOW GRANTS FOR 'username'@'localhost';

-- Drop database
DROP DATABASE database_name;

-- Drop user
DROP USER 'username'@'localhost';
```

---

## System Administration

### Package Management
```bash
# Update package list
sudo apt update

# Upgrade packages
sudo apt upgrade -y

# Install package
sudo apt install <PACKAGE_NAME> -y

# Remove package
sudo apt remove <PACKAGE_NAME> -y

# Search for package
apt search <PACKAGE_NAME>

# Show package info
apt show <PACKAGE_NAME>

# Auto-remove unused packages
sudo apt autoremove -y
```

### System Information
```bash
# Show OS version
cat /etc/os-release

# Show kernel version
uname -r

# Show hostname
hostname

# Show IP addresses
ip addr show

# Show disk usage
df -h

# Show memory usage
free -h

# Show CPU info
lscpu

# Show running processes
top

# Show system uptime
uptime

# Show logged in users
who
```

### File Permissions
```bash
# Change owner
sudo chown user:group file

# Change permissions
sudo chmod 755 file

# Change recursively
sudo chown -R www-data:www-data /var/www/html
sudo chmod -R 755 /var/www/html
```

---

## Network & Firewall

### Network Commands
```bash
# Show network interfaces
ip addr show

# Show routing table
ip route show

# Test connectivity
ping google.com

# Test port connectivity
telnet <IP> <PORT>

# Show open ports
sudo netstat -tulpn

# Show listening ports
sudo ss -tulpn

# DNS lookup
nslookup google.com
dig google.com

# Get public IP
curl ifconfig.me
curl ipinfo.io/ip
```

### UFW Firewall
```bash
# Enable firewall
sudo ufw enable

# Disable firewall
sudo ufw disable

# Check status
sudo ufw status

# Allow port
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp
sudo ufw allow 22/tcp

# Deny port
sudo ufw deny 3306/tcp

# Delete rule
sudo ufw delete allow 80/tcp

# Reset firewall
sudo ufw reset
```

---

## File Management

### Basic Operations
```bash
# List files
ls -lh

# List all files (including hidden)
ls -lah

# Change directory
cd /path/to/directory

# Create directory
mkdir directory_name
mkdir -p /path/to/nested/directory

# Remove file
rm file.txt

# Remove directory
rm -rf directory

# Copy file
cp source.txt destination.txt

# Copy directory
cp -r source_dir destination_dir

# Move/rename
mv old_name.txt new_name.txt

# Create empty file
touch file.txt
```

### File Content
```bash
# View file content
cat file.txt

# View with pagination
less file.txt
more file.txt

# View first 10 lines
head file.txt

# View last 10 lines
tail file.txt

# Follow file (for logs)
tail -f /var/log/syslog

# Search in file
grep "search_term" file.txt

# Search recursively
grep -r "search_term" /path/to/directory
```

### Text Editing
```bash
# Edit with nano
nano file.txt

# Edit with vim
vim file.txt

# Edit with vi
vi file.txt

# Create/overwrite file
echo "content" > file.txt

# Append to file
echo "content" >> file.txt
```

---

## Useful One-Liners

```bash
# Check if Apache is running
systemctl is-active apache2 && echo "Running" || echo "Not running"

# Get public IP and test web server
curl -I http://$(curl -s ifconfig.me)

# Show all listening ports
sudo ss -tulpn | grep LISTEN

# Find large files
find / -type f -size +100M 2>/dev/null

# Disk usage of current directory
du -sh *

# Monitor log in real-time
tail -f /var/log/apache2/error.log | grep -i error

# Kill process by name
pkill -f process_name

# Check last reboot time
who -b

# Show failed login attempts
sudo grep "Failed password" /var/log/auth.log

# Clean package cache
sudo apt clean && sudo apt autoclean

# Check which process is using a port
sudo lsof -i :80
```

---

## Emergency & Troubleshooting

```bash
# Emergency MySQL password reset
sudo service mysql stop
sudo mysqld_safe --skip-grant-tables &
mysql -u root
# Then run: UPDATE mysql.user SET authentication_string=PASSWORD('newpass') WHERE User='root';
# FLUSH PRIVILEGES;

# Fix Apache permissions
sudo chown -R www-data:www-data /var/www/html
sudo find /var/www/html -type d -exec chmod 755 {} \;
sudo find /var/www/html -type f -exec chmod 644 {} \;

# Check disk space and clean
df -h
sudo journalctl --vacuum-time=3d
sudo apt autoremove -y
sudo apt autoclean

# View system logs
sudo journalctl -xe
sudo journalctl -u apache2 -n 50
sudo journalctl -u mysql -n 50

# Force DNS flush (Linux)
sudo systemd-resolve --flush-caches

# Check listening services
sudo netstat -tulpn | grep LISTEN
```

---

**Tips:**
- Use `--help` or `man` for detailed command information
- Use `Tab` key for auto-completion
- Use `Ctrl+C` to cancel running command
- Use `Ctrl+Z` to suspend process
- Use `history` to see command history
- Use `!!` to repeat last command
- Use `sudo !!` to repeat last command with sudo

---

For more detailed information, refer to the [README.md](README.md)
