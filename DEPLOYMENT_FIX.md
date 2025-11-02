# Deployment Fix - index.php Now Included

## What Was Fixed

The issue was that `index.php` was not being deployed to `/var/www/html` during the Terraform provisioning process. The `cloud-init.yaml` file only included `info.php` and `db_test.php`, but was missing `index.php`.

## Changes Made

1. ✅ **Updated `terraform/cloud-init.yaml`**
   - Added complete `index.php` file to the `write_files` section
   - Updated `db_test.php` with the enhanced version from the `website/` folder
   - Both files now have proper styling and functionality

## How to Deploy

### Option 1: Fresh Deployment (Recommended)

If you need to recreate the VM:

```bash
cd terraform

# Destroy existing resources
terraform destroy

# Apply new configuration with updated cloud-init
terraform apply
```

### Option 2: Update Existing VM

If you want to keep the existing VM and just deploy the website files:

1. **SSH into your Azure VM:**
   ```bash
   ssh azureuser@<your-vm-public-ip>
   ```

2. **Deploy the website files manually:**
   ```bash
   # Remove default Apache index.html
   sudo rm -f /var/www/html/index.html
   
   # Option A: Use the deploy script (if copied to VM)
   sudo /path/to/deploy_website.sh
   
   # Option B: Create index.php manually
   sudo nano /var/www/html/index.php
   # Copy content from website/index.php
   
   # Set proper permissions
   sudo chown -R www-data:www-data /var/www/html
   sudo chmod -R 755 /var/www/html
   
   # Restart Apache
   sudo systemctl restart apache2
   ```

## Fix Apache2 Startup Issue

Based on your error, Apache2 is failing to start. Here's how to diagnose and fix:

### 1. Check Apache Configuration
```bash
sudo apache2ctl configtest
```

### 2. View Detailed Error Logs
```bash
sudo journalctl -xeu apache2.service
sudo tail -50 /var/log/apache2/error.log
```

### 3. Common Fixes

**If port 80 is already in use:**
```bash
sudo lsof -i :80
sudo netstat -tulpn | grep :80
```

**Fix permissions:**
```bash
sudo chown -R www-data:www-data /var/www/html
sudo chmod -R 755 /var/www/html
```

**Enable required modules:**
```bash
sudo a2enmod php
sudo a2enmod rewrite
```

**Restart Apache:**
```bash
sudo systemctl restart apache2
sudo systemctl status apache2
```

## Verify Deployment

Once Apache is running, access your website:

```bash
http://<your-vm-public-ip>/
http://<your-vm-public-ip>/info.php
http://<your-vm-public-ip>/db_test.php
```

## Files Deployed

The following files are now automatically deployed via cloud-init:

- `/var/www/html/index.php` - Main landing page with server status
- `/var/www/html/info.php` - PHP information page
- `/var/www/html/db_test.php` - MySQL database connection test

## Next Steps

1. Fix the Apache2 startup issue using the diagnostic commands above
2. Run `terraform apply` to create new VMs with the updated configuration
3. Verify all three PHP pages are accessible
4. Test MySQL connectivity via the db_test.php page

## Important Notes

- ⚠️ The MySQL root password is passed via Terraform variables
- ⚠️ Database credentials are hardcoded in the files (change in production)
- ⚠️ Security groups allow all traffic (restrict in production)
- ✅ Cloud-init now includes all necessary website files
- ✅ Apache and MySQL are configured to start on boot
