# 🔗 Quick Reference - All URLs & Endpoints

## 📍 Application URLs

Replace `<your-vm-ip>` with your Azure VM's public IP address.

### Main Pages

| Page | URL | Description | HTTP Method |
|------|-----|-------------|-------------|
| **Home** | `http://<your-vm-ip>/` | Main dashboard | GET |
| **PHP Info** | `http://<your-vm-ip>/info.php` | PHP configuration | GET |
| **DB Test** | `http://<your-vm-ip>/db_test.php` | Database connection test | GET |

### User Management (CRUD)

| Operation | URL | Description | HTTP Method |
|-----------|-----|-------------|-------------|
| **List Users** | `http://<your-vm-ip>/manage_users.php` | View all users | GET |
| **Add User** | `http://<your-vm-ip>/add_user.php` | Create new user | GET/POST |
| **Edit User** | `http://<your-vm-ip>/edit_user.php?id={id}` | Update user | GET/POST |
| **Delete User** | `http://<your-vm-ip>/delete_user.php?id={id}` | Remove user | GET |

## 🗃️ Database Information

```
Database Server: localhost
Database Name: webdb
Table: users
Username: webuser
Password: webpass123
Port: 3306 (default)
```

## 📊 Table Structure

```sql
Table: users
├── id (INT, AUTO_INCREMENT, PRIMARY KEY)
├── name (VARCHAR(100), NOT NULL)
├── email (VARCHAR(100), NOT NULL)
└── created_at (TIMESTAMP, DEFAULT CURRENT_TIMESTAMP)
```

## 🔧 SSH Access

```bash
# Connect to VM
ssh azureuser@<your-vm-ip>

# Use SSH key
ssh -i ~/.ssh/id_rsa azureuser@<your-vm-ip>
```

## 🛠️ Useful Commands on VM

### Apache2 Management
```bash
# Status
sudo systemctl status apache2

# Start
sudo systemctl start apache2

# Stop
sudo systemctl stop apache2

# Restart
sudo systemctl restart apache2

# Check configuration
sudo apache2ctl configtest

# View error logs
sudo tail -f /var/log/apache2/error.log

# View access logs
sudo tail -f /var/log/apache2/access.log
```

### MySQL Management
```bash
# Status
sudo systemctl status mysql

# Connect to MySQL
sudo mysql -u root -p

# Connect as webuser
mysql -u webuser -p webdb

# View databases
sudo mysql -u root -p -e "SHOW DATABASES;"

# View users table
mysql -u webuser -pwebpass123 -D webdb -e "SELECT * FROM users;"

# Count users
mysql -u webuser -pwebpass123 -D webdb -e "SELECT COUNT(*) FROM users;"
```

### File Management
```bash
# View website files
ls -la /var/www/html/

# Edit a file
sudo nano /var/www/html/index.php

# Check permissions
ls -l /var/www/html/

# Set correct permissions
sudo chown -R www-data:www-data /var/www/html
sudo chmod -R 755 /var/www/html
```

## 📱 Testing Endpoints

### Test with cURL

```bash
# Test home page
curl http://<your-vm-ip>/

# Test database connection
curl http://<your-vm-ip>/db_test.php

# Test manage users page
curl http://<your-vm-ip>/manage_users.php

# Add user (POST request)
curl -X POST http://<your-vm-ip>/add_user.php \
  -d "name=Test User" \
  -d "email=test@example.com"

# Delete user
curl http://<your-vm-ip>/delete_user.php?id=5
```

### Test with wget

```bash
# Download home page
wget http://<your-vm-ip>/

# Download user list
wget http://<your-vm-ip>/manage_users.php
```

## 🔐 Security Settings

### Network Security Group Ports

| Port | Protocol | Purpose | Status |
|------|----------|---------|--------|
| 22 | TCP | SSH | Open |
| 80 | TCP | HTTP | Open |
| 443 | TCP | HTTPS | Open |
| 3306 | TCP | MySQL | Open (⚠️ Restrict in production) |

## 📊 SQL Queries Reference

### Basic Operations

```sql
-- List all users
SELECT * FROM users;

-- Count users
SELECT COUNT(*) FROM users;

-- Find user by ID
SELECT * FROM users WHERE id = 1;

-- Find user by email
SELECT * FROM users WHERE email LIKE '%example.com';

-- Add new user
INSERT INTO users (name, email) VALUES ('John Doe', 'john@example.com');

-- Update user
UPDATE users SET name = 'Jane Doe', email = 'jane@example.com' WHERE id = 1;

-- Delete user
DELETE FROM users WHERE id = 1;

-- Delete all users (⚠️ Dangerous!)
DELETE FROM users;

-- Show table structure
DESCRIBE users;

-- Show table creation SQL
SHOW CREATE TABLE users;
```

## 🎯 Common Tasks

### Add a New User via Command Line
```bash
mysql -u webuser -pwebpass123 -D webdb -e \
  "INSERT INTO users (name, email) VALUES ('Alice', 'alice@example.com');"
```

### View All Users via Command Line
```bash
mysql -u webuser -pwebpass123 -D webdb -e "SELECT * FROM users;"
```

### Backup Database
```bash
mysqldump -u webuser -pwebpass123 webdb > backup.sql
```

### Restore Database
```bash
mysql -u webuser -pwebpass123 webdb < backup.sql
```

### Export Users to CSV
```bash
mysql -u webuser -pwebpass123 -D webdb -e \
  "SELECT * FROM users INTO OUTFILE '/tmp/users.csv' 
   FIELDS TERMINATED BY ',' 
   ENCLOSED BY '\"' 
   LINES TERMINATED BY '\n';"
```

## 🌐 Azure Portal Links

```
Azure Portal: https://portal.azure.com
Virtual Machines: https://portal.azure.com/#blade/HubsExtension/BrowseResource/resourceType/Microsoft.Compute%2FVirtualMachines
Network Security Groups: https://portal.azure.com/#blade/HubsExtension/BrowseResource/resourceType/Microsoft.Network%2FNetworkSecurityGroups
```

## 📞 Quick Diagnostics

### Check if Apache is running
```bash
sudo systemctl is-active apache2
```

### Check if MySQL is running
```bash
sudo systemctl is-active mysql
```

### Check disk space
```bash
df -h
```

### Check memory usage
```bash
free -h
```

### Check open ports
```bash
sudo netstat -tulpn
```

### Test database connection
```bash
mysql -u webuser -pwebpass123 -e "SELECT 1;"
```

## 🎨 Page Features Summary

| Page | Create | Read | Update | Delete | Form | Table |
|------|--------|------|--------|--------|------|-------|
| index.php | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ |
| db_test.php | ❌ | ✅ | ❌ | ❌ | ❌ | ✅ |
| manage_users.php | ❌ | ✅ | ❌ | ❌ | ❌ | ✅ |
| add_user.php | ✅ | ❌ | ❌ | ❌ | ✅ | ❌ |
| edit_user.php | ❌ | ✅ | ✅ | ❌ | ✅ | ❌ |
| delete_user.php | ❌ | ✅ | ❌ | ✅ | ❌ | ❌ |

## 🔄 Deployment Options

### Terraform
```bash
cd terraform
terraform init
terraform plan
terraform apply
```

### Manual Script
```bash
sudo ./scripts/deploy_website.sh
```

### Cloud-Init (Automatic)
Already configured in `terraform/cloud-init.yaml`

## 📚 Documentation Files

| File | Description |
|------|-------------|
| `README.md` | Main documentation |
| `USER_MANAGEMENT_GUIDE.md` | Complete CRUD guide |
| `USER_CRUD_SUMMARY.md` | Quick summary |
| `ARCHITECTURE_CRUD.md` | System architecture |
| `DEPLOYMENT_FIX.md` | Deployment instructions |
| `QUICK_REFERENCE.md` | This file |

## 🎯 Bookmarks

Save these URLs for quick access (replace IP):

```
http://<your-vm-ip>/                    # Home
http://<your-vm-ip>/manage_users.php    # Users
http://<your-vm-ip>/add_user.php        # Add
http://<your-vm-ip>/db_test.php         # Test
http://<your-vm-ip>/info.php            # Info
```

---

**Last Updated:** 2025-11-02  
**Version:** 1.0  
**Status:** Complete
