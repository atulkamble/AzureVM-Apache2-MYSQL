# Quick Start Guide

## 🚀 Fastest Way to Get Started

### Option 1: Terraform (Recommended) - 5 minutes

```bash
# 1. Login to Azure
az login

# 2. Navigate to terraform directory
cd terraform

# 3. Create your variables file
cp terraform.tfvars.example terraform.tfvars
# Edit terraform.tfvars with your preferred text editor

# 4. Deploy everything
terraform init
terraform apply -auto-approve

# 5. Get your website URL
terraform output website_url

# 6. Wait 5 minutes for cloud-init to complete, then visit the URL
```

### Option 2: Manual Setup - 15 minutes

```bash
# 1. Login to Azure
az login

# 2. Create the VM
cd scripts
chmod +x *.sh
./create_azure_vm.sh

# 3. Note the public IP from output, then SSH to VM
ssh azureuser@<PUBLIC_IP>

# 4. Copy scripts to VM (from your local machine)
scp install_apache_mysql.sh configure_mysql.sh deploy_website.sh azureuser@<PUBLIC_IP>:~/

# 5. On the VM, run setup scripts
chmod +x *.sh
sudo ./install_apache_mysql.sh
sudo ./configure_mysql.sh
sudo ./deploy_website.sh

# 6. Access your website
# http://<PUBLIC_IP>
```

## 🧪 Test Your Deployment

Visit these URLs in your browser:
- `http://<PUBLIC_IP>/` - Homepage
- `http://<PUBLIC_IP>/db_test.php` - Database test
- `http://<PUBLIC_IP>/info.php` - PHP info

## 🧹 Cleanup

### Terraform:
```bash
cd terraform
terraform destroy -auto-approve
```

### Manual:
```bash
az group delete --name rg-webserver-demo --yes --no-wait
```

## ⚠️ Before You Start

1. Make sure you have:
   - Azure subscription
   - Azure CLI installed
   - Terraform installed (for Terraform option)

2. Generate SSH key if you don't have one:
   ```bash
   ssh-keygen -t rsa -b 4096 -f ~/.ssh/id_rsa
   ```

3. Verify Azure CLI login:
   ```bash
   az account show
   ```

## 💡 Tips

- Default VM size is `Standard_B2s` (~$30-40/month if kept running)
- Remember to destroy resources when done testing
- Public IP is static - it won't change when VM restarts
- Cloud-init logs: `/var/log/cloud-init-output.log`

## 🆘 Quick Troubleshooting

**Can't access website?**
```bash
# Check if VM is running
az vm list --output table

# Check Apache status (on VM)
sudo systemctl status apache2
```

**Database connection fails?**
```bash
# On VM, check MySQL
sudo systemctl status mysql
sudo mysql -u webuser -p webpass123 -e "USE webdb; SELECT * FROM users;"
```

For detailed documentation, see [README.md](README.md)
