# Deployment Checklist

## Pre-Deployment Checklist

### Prerequisites
- [ ] Azure subscription is active
- [ ] Azure CLI is installed and updated
- [ ] Terraform is installed (for Terraform deployment)
- [ ] SSH key pair exists (`~/.ssh/id_rsa` and `~/.ssh/id_rsa.pub`)
- [ ] Logged into Azure CLI (`az login`)
- [ ] Correct subscription is selected (`az account show`)

### Configuration
- [ ] Reviewed `terraform/terraform.tfvars` (for Terraform)
- [ ] Set appropriate VM size for your needs
- [ ] Set strong MySQL root password
- [ ] Chose appropriate Azure region

## Terraform Deployment Checklist

- [ ] Navigated to `terraform/` directory
- [ ] Created `terraform.tfvars` from example
- [ ] Updated all variables in `terraform.tfvars`
- [ ] Ran `terraform init`
- [ ] Ran `terraform plan` and reviewed changes
- [ ] Ran `terraform apply`
- [ ] Noted the public IP from output
- [ ] Waited 5-10 minutes for cloud-init to complete
- [ ] Verified website is accessible
- [ ] Tested database connection page

## Manual Deployment Checklist

### VM Creation
- [ ] Made scripts executable (`chmod +x scripts/*.sh`)
- [ ] Ran `scripts/create_azure_vm.sh`
- [ ] Noted the public IP address
- [ ] Successfully connected via SSH
- [ ] Copied installation scripts to VM

### Software Installation
- [ ] Ran `install_apache_mysql.sh`
- [ ] Verified Apache2 is running
- [ ] Verified MySQL is running
- [ ] Verified PHP is installed

### Database Configuration
- [ ] Ran `configure_mysql.sh`
- [ ] Set MySQL root password
- [ ] Verified database `webdb` was created
- [ ] Verified user `webuser` was created
- [ ] Verified sample data was inserted

### Website Deployment
- [ ] Ran `deploy_website.sh`
- [ ] Verified files are in `/var/www/html/`
- [ ] Verified file permissions are correct
- [ ] Tested website access via public IP

## Post-Deployment Verification

### Connectivity Tests
- [ ] Can access homepage (`http://<PUBLIC_IP>/`)
- [ ] Can access PHP info page (`http://<PUBLIC_IP>/info.php`)
- [ ] Can access database test page (`http://<PUBLIC_IP>/db_test.php`)
- [ ] Database connection test shows sample users
- [ ] Can SSH into the VM

### Service Status Checks
```bash
# Run these commands on the VM
- [ ] `sudo systemctl status apache2` shows active (running)
- [ ] `sudo systemctl status mysql` shows active (running)
- [ ] `php -v` shows PHP version
- [ ] `curl http://localhost` returns HTML
```

### Database Verification
```bash
# Run these on the VM
- [ ] `sudo mysql -u root -p` (login works)
- [ ] `SHOW DATABASES;` (shows webdb)
- [ ] `USE webdb; SELECT * FROM users;` (shows sample data)
```

### Network Verification
- [ ] NSG rules allow port 22 (SSH)
- [ ] NSG rules allow port 80 (HTTP)
- [ ] NSG rules allow port 443 (HTTPS)
- [ ] Public IP is allocated and static
- [ ] Can ping the public IP

## Security Hardening Checklist (Recommended)

- [ ] Changed default MySQL passwords
- [ ] Updated database credentials in PHP files
- [ ] Restricted SSH access to specific IP ranges
- [ ] Enabled UFW firewall on VM
- [ ] Disabled MySQL remote access (if not needed)
- [ ] Set up SSL/TLS certificate (Let's Encrypt)
- [ ] Configured automatic security updates
- [ ] Reviewed and restricted NSG rules
- [ ] Enabled Azure Disk Encryption
- [ ] Set up Azure Backup
- [ ] Configured Azure Monitor alerts

## Maintenance Checklist

### Regular Tasks
- [ ] Update system packages (`sudo apt update && sudo apt upgrade`)
- [ ] Review Apache error logs
- [ ] Review MySQL slow query logs
- [ ] Monitor disk space usage
- [ ] Review security advisories
- [ ] Test backup restoration
- [ ] Review Azure costs

### Monthly Tasks
- [ ] Rotate database passwords
- [ ] Review NSG rules
- [ ] Check for expired SSL certificates
- [ ] Review and archive old logs
- [ ] Test disaster recovery procedures

## Cleanup Checklist

### Before Destroying Resources
- [ ] Backup any important data
- [ ] Export database if needed
- [ ] Download any important logs
- [ ] Document any custom configurations
- [ ] Notify users of downtime (if applicable)

### Terraform Cleanup
- [ ] Run `terraform plan -destroy` to review
- [ ] Run `terraform destroy`
- [ ] Verify all resources are deleted in Azure Portal
- [ ] Remove local Terraform state files if needed

### Manual Cleanup
- [ ] Delete VM
- [ ] Delete Network Interface
- [ ] Delete Public IP
- [ ] Delete NSG
- [ ] Delete Virtual Network
- [ ] Delete Resource Group
- [ ] Verify in Azure Portal all resources are gone

## Troubleshooting Checklist

### If website is not accessible:
- [ ] Verify VM is running (`az vm list --output table`)
- [ ] Check NSG rules allow port 80
- [ ] Check Apache is running (`systemctl status apache2`)
- [ ] Check Apache error logs (`/var/log/apache2/error.log`)
- [ ] Verify public IP is correct
- [ ] Check DNS resolution (if using domain)

### If database connection fails:
- [ ] Verify MySQL is running (`systemctl status mysql`)
- [ ] Check MySQL error logs (`/var/log/mysql/error.log`)
- [ ] Verify database exists (`SHOW DATABASES;`)
- [ ] Verify user exists and has permissions
- [ ] Check credentials in PHP files
- [ ] Test connection from command line

### If SSH connection fails:
- [ ] Verify NSG allows port 22
- [ ] Check VM is running
- [ ] Verify SSH key permissions (should be 600)
- [ ] Try password authentication (if enabled)
- [ ] Check Azure Serial Console
- [ ] Review Boot Diagnostics

## Documentation Checklist

- [ ] Document any custom configurations
- [ ] Save credentials securely (use password manager)
- [ ] Document the public IP address
- [ ] Save resource group name and region
- [ ] Document any deviations from standard setup
- [ ] Create runbook for recovery procedures
- [ ] Document contact information for support

---

**Notes:**
- Mark items as complete ✓ when finished
- Add custom items specific to your deployment
- Keep this checklist updated with your infrastructure changes
- Review and update security items regularly
