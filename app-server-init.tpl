#!bin/bash

sudo touch /home/ubuntu/terraform-log.txt

db_username=${db_username}
db_user_password=${db_user_password}
db_name=${db_name}
db_endpoint=${db_endpoint}

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

echo 'set database config for wordpress' >> /home/ubuntu/terraform-log.txt
cd /var/www/html/wordpress
cp wp-config-sample.php wp-config.php
sed -i "s/database_name_here/$db_name/g" wp-config.php
sed -i "s/username_here/$db_username/g" wp-config.php
sed -i "s/password_here/$db_user_password/g" wp-config.php
sed -i "s/localhost/$db_endpoint/g" wp-config.php
cat <<EOF >>/var/www/html/wordpress/wp-config.php
define( 'FS_METHOD', 'direct' );
define('WP_MEMORY_LIMIT', '128M');
EOF

echo 'set chown chmod for wordpress' >> /home/ubuntu/terraform-log.txt
mkdir /var/www/html/wordpress/wp-content/uploads
chown -R www-data:www-data /var/www/html/wordpress/
chmod -R 755 /var/www/html/wordpress

echo '' >> /home/ubuntu/terraform-log.txt

echo 'complete' >> /home/ubuntu/terraform-log.txt
