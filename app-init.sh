#!bin/bash

sudo touch /home/ubuntu/terraform-log.txt

echo 'apt update && upgrade' >> /home/ubuntu/terraform-log.txt
sudo apt update -y
sudo apt upgrade -y

echo 'apt install apache2' >> /home/ubuntu/terraform-log.txt
sudo apt install apache2 -y

echo 'apt install php php-mysql' >> /home/ubuntu/terraform-log.txt
sudo apt install php php-mysql -y

echo 'wget https://wordpress.org/latest.tar.gz' >> /home/ubuntu/terraform-log.txt
cd /tmp 
sudo wget https://wordpress.org/latest.tar.gz
echo 'tar -xvf latest.tar.gz' >> /home/ubuntu/terraform-log.txt
sudo tar -xvf latest.tar.gz
sudo cp -R wordpress /var/www/html/

echo 'set chown chmod for wordpress' >> /home/ubuntu/terraform-log.txt
sudo mkdir /var/www/html/wordpress/wp-content/uploads
sudo chown -R www-data:www-data /var/www/html/wordpress/
sudo chmod -R 755 /var/www/html/wordpress
sudo mkdir /fuck_complete

echo 'complete' >> /home/ubuntu/terraform-log.txt

