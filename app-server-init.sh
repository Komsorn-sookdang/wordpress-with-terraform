#!bin/bash

sudo touch /home/ubuntu/terraform-log.txt

echo 'apt update && upgrade' >> /home/ubuntu/terraform-log.txt
apt update -y
apt upgrade -y

echo 'apt install apache2' >> /home/ubuntu/terraform-log.txt
apt install apache2 -y

echo 'apt install php php-mysql' >> /home/ubuntu/terraform-log.txt
apt install php php-mysql -y

echo 'wget https://wordpress.org/latest.tar.gz' >> /home/ubuntu/terraform-log.txt
cd /tmp 
wget https://wordpress.org/latest.tar.gz
echo 'tar -xvf latest.tar.gz' >> /home/ubuntu/terraform-log.txt
tar -xvf latest.tar.gz
cp -R wordpress /var/www/html/

echo 'set chown chmod for wordpress' >> /home/ubuntu/terraform-log.txt
mkdir /var/www/html/wordpress/wp-content/uploads
chown -R www-data:www-data /var/www/html/wordpress/
chmod -R 755 /var/www/html/wordpress

echo 'complete' >> /home/ubuntu/terraform-log.txt
