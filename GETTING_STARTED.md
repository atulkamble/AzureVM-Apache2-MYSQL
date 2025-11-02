# 🎯 Getting Started - Choose Your Path

Welcome! This guide will help you choose the best deployment method for your needs.

---

## 📊 Quick Comparison

| Feature | Terraform | Manual |
|---------|-----------|--------|
| **Time to Deploy** | ~10 minutes total | ~20 minutes total |
| **Automation Level** | Fully automated | Semi-automated |
| **Learning Curve** | Moderate | Easy |
| **Best For** | Production, IaC | Learning, Control |
| **Repeatability** | Excellent | Good |
| **Prerequisites** | Terraform + Azure CLI | Azure CLI only |
| **Cleanup** | One command | One command |

---

## 🚀 Path 1: Terraform (Recommended for Most Users)

### ✅ Choose Terraform if:
- You want the fastest deployment
- You're learning Infrastructure as Code
- You need repeatable deployments
- You want automatic setup
- You're comfortable with command line

### 📋 Prerequisites
```bash
# 1. Install Azure CLI
# macOS
brew install azure-cli

# 2. Install Terraform
brew install terraform

# 3. Verify installations
az --version
terraform --version
```

### 🎬 Quick Start (5 Steps)

**Step 1:** Login to Azure
```bash
az login
```

**Step 2:** Navigate and configure
```bash
cd /Users/atul/Downloads/AzureVM-Apache2-MYSQL/terraform
cp terraform.tfvars.example terraform.tfvars
nano terraform.tfvars  # Edit with your values
```

**Step 3:** Initialize Terraform
```bash
terraform init
```

**Step 4:** Deploy
```bash
terraform apply -auto-approve
```

**Step 5:** Get your website URL
```bash
terraform output website_url
```

**⏰ Wait:** 5-10 minutes for cloud-init to complete, then visit the URL!

---

## 🛠️ Path 2: Manual Deployment

### ✅ Choose Manual if:
- You want to learn each step
- You prefer more control
- You don't want to install Terraform
- You're studying system administration
- You want to customize each step

### 📋 Prerequisites
```bash
# 1. Install Azure CLI
# macOS
brew install azure-cli

# 2. Verify installation
az --version
```

### 🎬 Quick Start (6 Steps)

**Step 1:** Login to Azure
```bash
az login
```

**Step 2:** Create the VM
```bash
cd /Users/atul/Downloads/AzureVM-Apache2-MYSQL/scripts
./create_azure_vm.sh
# Note the PUBLIC_IP from the output
```

**Step 3:** Copy scripts to VM
```bash
scp install_apache_mysql.sh configure_mysql.sh deploy_website.sh azureuser@<PUBLIC_IP>:~/
```

**Step 4:** SSH and prepare
```bash
ssh azureuser@<PUBLIC_IP>
chmod +x *.sh
```

**Step 5:** Run installation scripts
```bash
sudo ./install_apache_mysql.sh
sudo ./configure_mysql.sh  # You'll set MySQL password
sudo ./deploy_website.sh
```

**Step 6:** Access your website
```
http://<PUBLIC_IP>
```

---

## 🧪 Testing Your Deployment

Once deployed, test these URLs:

1. **Homepage**
   ```
   http://<PUBLIC_IP>/
   ```
   Should show: Server dashboard with system info

2. **Database Test**
   ```
   http://<PUBLIC_IP>/db_test.php
   ```
   Should show: MySQL connection success + sample users

3. **PHP Info**
   ```
   http://<PUBLIC_IP>/info.php
   ```
   Should show: Complete PHP configuration

---

## 🧹 Cleanup When Done

### Terraform:
```bash
cd terraform
terraform destroy -auto-approve
```

### Manual:
```bash
az group delete --name rg-webserver-demo --yes --no-wait
```

---

## 📚 What to Read Next

After choosing your path:

1. **First Time Users:**
   - Start with [QUICKSTART.md](QUICKSTART.md)
   - Then read [README.md](README.md) for details

2. **Experienced Users:**
   - Jump to [COMMANDS.md](COMMANDS.md)
   - Use [DEPLOYMENT_CHECKLIST.md](DEPLOYMENT_CHECKLIST.md)

3. **Learning IaC:**
   - Study [ARCHITECTURE.md](ARCHITECTURE.md)
   - Review Terraform files in `terraform/`

4. **Troubleshooting:**
   - Check [README.md - Troubleshooting](README.md#troubleshooting)
   - Review [COMMANDS.md](COMMANDS.md) for diagnostic commands

---

## 💡 Pro Tips

### For Terraform Users:
```bash
# Preview changes without applying
terraform plan

# Format your .tf files
terraform fmt

# Validate configuration
terraform validate

# Show current infrastructure
terraform show
```

### For Manual Users:
```bash
# Save your public IP for easy access
export VM_IP=<PUBLIC_IP>
ssh azureuser@$VM_IP

# Monitor cloud-init progress (Terraform users too)
ssh azureuser@<PUBLIC_IP>
tail -f /var/log/cloud-init-output.log
```

### General Tips:
```bash
# Check if services are ready
ssh azureuser@<PUBLIC_IP> "systemctl is-active apache2 mysql"

# Quick health check
curl -I http://<PUBLIC_IP>

# View your Azure resources
az resource list --resource-group rg-webserver-demo --output table
```

---

## ⚠️ Important Notes

1. **Costs:** Running this will incur Azure charges (~$0.05/hour for Standard_B2s)
2. **Cleanup:** Always destroy resources when done testing
3. **Security:** Default setup is for testing only - see README for production hardening
4. **Time:** Cloud-init takes 5-10 minutes after Terraform completes
5. **Region:** Default is East US - change in variables if needed

---

## 🆘 Quick Troubleshooting

### Problem: Can't access website
```bash
# Check if VM is running
az vm list --output table

# Check NSG rules
az network nsg rule list --resource-group rg-webserver-demo \
  --nsg-name webserver-nsg --output table

# SSH and check Apache
ssh azureuser@<PUBLIC_IP>
sudo systemctl status apache2
```

### Problem: Terraform errors
```bash
# Re-initialize
terraform init -upgrade

# Check Azure login
az account show

# Validate configuration
terraform validate
```

### Problem: SSH connection fails
```bash
# Check SSH key permissions
chmod 600 ~/.ssh/id_rsa
chmod 644 ~/.ssh/id_rsa.pub

# Verify VM is running
az vm show --resource-group rg-webserver-demo \
  --name webserver-vm --query "provisioningState"
```

---

## 📞 Need Help?

1. Check [README.md](README.md) - Comprehensive documentation
2. Review [COMMANDS.md](COMMANDS.md) - Command reference
3. Use [DEPLOYMENT_CHECKLIST.md](DEPLOYMENT_CHECKLIST.md) - Step-by-step guide
4. See [ARCHITECTURE.md](ARCHITECTURE.md) - Visual diagrams

---

## 🎓 Learning Resources

- **Azure:** https://docs.microsoft.com/en-us/azure/
- **Terraform:** https://learn.hashicorp.com/terraform
- **Apache:** https://httpd.apache.org/docs/
- **MySQL:** https://dev.mysql.com/doc/
- **Ubuntu:** https://ubuntu.com/server/docs

---

## ✨ Ready to Start?

Choose your path and begin:

```bash
# Terraform Path
cd terraform
terraform init
terraform apply -auto-approve

# OR

# Manual Path
cd scripts
./create_azure_vm.sh
```

**Good luck! 🚀**

---

**Next:** After deployment, visit [PROJECT_SUMMARY.md](PROJECT_SUMMARY.md) to learn what you've built!
