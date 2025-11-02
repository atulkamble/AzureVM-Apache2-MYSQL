```
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
