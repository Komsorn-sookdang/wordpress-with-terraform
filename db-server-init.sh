#!bin/bash

touch /home/ubuntu/terraform-log.txt

echo 'apt update && upgrade' >> /home/ubuntu/terraform-log.txt
apt update -y
apt upgrade -y

echo 'apt install mariadb-server mariadb-client' >> /home/ubuntu/terraform-log.txt
apt install mariadb-server mariadb-client -y

echo 'create && set up database' >> /home/ubuntu/terraform-log.txt
# sudo mysql -u root --password=  
mysql -u root -e "CREATE DATABASE wordpress_db"
mysql -u root -e "CREATE USER 'wp_user'@'%' IDENTIFIED BY 'password'"
mysql -u root -e "GRANT ALL ON wordpress_db.* TO 'wp_user'@'%' IDENTIFIED BY 'password'"
mysql -u root -e "FLUSH PRIVILEGES"

echo 'set bind-address to anywhere' >> /home/ubuntu/terraform-log.txt
sed -i 's/127.0.0.1/0.0.0.0/g' /etc/mysql/mariadb.conf.d/50-server.cnf
systemctl restart mysql

echo 'complete' >> /home/ubuntu/terraform-log.txt
