```
prerequistes: VS Code, Terraform, Azure CLI

// note down tenant id 

rm terraform.tfstate
rm terraform.tfstate.backup

Get-ChildItem -Force

az login 
az account show --output table
az account list 
az account list --output table
az account set --subscription subscription-id
az login --tenant tenant-id
az account show --output table

az logout
az login --tenant tenant-id
az account set --subscription subscription-id

terraform init -reconfigure
terraform plan
terraform apply


// fork repo >> https://github.com/atulkamble/AzureVM-Apache2-MYSQL.git

git clone https://github.com/atulkamble/AzureVM-Apache2-MYSQL.git
cd AzureVM-Apache2-MYSQ
cd terraform 

terraform init 
terraform plan 
terraform apply 

ssh azureuser@172.190.223.108

sudo mysql -u webuser -p

// webpass123

>> mysql 

SHOW DATABASES;
USE wbdb;
SHOW TABLES 
SELECT *FROM table;

browser >> http://172.190.223.108/index.php

terraform destroy 



git clone https://github.com/atulkamble/WebAppDB.git
cd WebAppDB

terraform init 
terraform init -upgrade 
terraform plan 
terraform apply 

terraform apply -auto-approve 

// optional 
sudo apt install apache2
sudo systemctl start apache2
sudo systemctl enable apache2
sudo systemctl status apache2

cd /var/www/html 

// optional 

sudo apt install mysql-server 
sudo systemctl start mysql
sudo systemctl enable mysql 
sudo systemctl status mysql 


sudo mysql -u webuser -p

// enter password >> webpass123


SHOW DATABASES;
USE webdb
SHOW TABLES;
SELECT *FROM users;

INSERT INTO users (name, email, created_at) values ('Atul Kamble', 'atul_kamble@hotmail.com', '2025-11-02 03:00:31');

exit 

exit 

terraform destroy 



```
