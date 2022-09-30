#!bin/bash

sudo touch /home/ubuntu/terraform-log.txt

db_username=${db_username}
db_user_password=${db_user_password}
db_name=${db_name}
db_endpoint=${db_endpoint}
app_elastic_ip=${app_elastic_ip}
admin_user=${admin_user}
admin_pass=${admin_pass}
admin_email=${admin_email}
bucket_name=${bucket_name}
iam_user_access_key=${iam_user_access_key}
iam_user_secret_key=${iam_user_secret_key}

echo -e '\n\n\n\n\n\n\napt update && upgrade' >> /home/ubuntu/terraform-log.txt
apt update -y
apt upgrade -y

echo -e '\napt install apache2' >> /home/ubuntu/terraform-log.txt
apt install apache2 -y

echo -e '\napt install php php-mysql php-xml php-curl php-gd' >> /home/ubuntu/terraform-log.txt
apt install php php-mysql -y
apt install php-xml -y
apt install php-curl -y
apt install php-gd -y

# echo 'wget https://wordpress.org/latest.tar.gz' >> /home/ubuntu/terraform-log.txt
# cd /tmp 
# wget https://wordpress.org/latest.tar.gz
# echo 'tar -xvf latest.tar.gz' >> /home/ubuntu/terraform-log.txt
# tar -xvf latest.tar.gz
# cp -R wordpress /var/www/html/

# echo 'set database config for wordpress' >> /home/ubuntu/terraform-log.txt
# cd /var/www/html/wordpress
# cp wp-config-sample.php wp-config.php
# sed -i "s/database_name_here/$db_name/g" wp-config.php
# sed -i "s/username_here/$db_username/g" wp-config.php
# sed -i "s/password_here/$db_user_password/g" wp-config.php
# sed -i "s/localhost/$db_endpoint/g" wp-config.php
# cat <<EOF >>/var/www/html/wordpress/wp-config.php
# define( 'FS_METHOD', 'direct' );
# define('WP_MEMORY_LIMIT', '128M');
# EOF

echo -e '\ninstall wp-cli && core download' >> /home/ubuntu/terraform-log.txt
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp
touch /home/ubuntu/wp-check.txt
mkdir /var/www/html/wordpress
cd /var/www/html/wordpress
wp core download --allow-root >> /home/ubuntu/terraform-log.txt

echo -e '\nset database config for wordpress' >> /home/ubuntu/terraform-log.txt
cp wp-config-sample.php wp-config.php
sed -i "s/database_name_here/$db_name/g" wp-config.php
sed -i "s/username_here/$db_username/g" wp-config.php
sed -i "s/password_here/$db_user_password/g" wp-config.php
sed -i "s/localhost/$db_endpoint/g" wp-config.php
cat <<EOF >>/var/www/html/wordpress/wp-config.php
define( 'FS_METHOD', 'direct' );
define('WP_MEMORY_LIMIT', '128M');
EOF

echo -e "\nwait 1 min for db install to complete" >> /home/ubuntu/terraform-log.txt
sleep 60
echo -e "awake" >> /home/ubuntu/terraform-log.txt

echo -e '\ninstall wordpress core, plugin' >> /home/ubuntu/terraform-log.txt
wp core install --url=http://${app_elastic_ip}/wordpress --title=komsornTitle --admin_user=${admin_user} --admin_password=${admin_pass} --admin_email=${admin_email} --allow-root >> /home/ubuntu/terraform-log.txt
wp plugin install --activate --path=/var/www/html/wordpress amazon-s3-and-cloudfront --allow-root >> /home/ubuntu/terraform-log.txt


cd /home/ubuntu/
cat <<EOT >> credfile.txt
define( 'AS3CF_SETTINGS', serialize( array (
    'provider' => 'aws',
    'access-key-id' => '$iam_user_access_key',
    'secret-access-key' => '$iam_user_secret_key',
    'bucket' => '$bucket_name',
    'copy-to-s3' => true,
    'object-prefix' => 'wp-content/uploads/',
    'use-yearmonth-folders' => true,
    'object-versioning' => true,
    'serve-from-s3' => true,
    'remove-local-file' => false,
    'enable-delivery-domain' => false,
    'force-https' => false,

) ) );
EOT

sed -i "/define( 'WP_DEBUG', false );/r credfile.txt" /var/www/html/wordpress/wp-config.php


echo -e '\nset chown chmod for wordpress' >> /home/ubuntu/terraform-log.txt
mkdir /var/www/html/wordpress/wp-content/uploads
chown -R www-data:www-data /var/www/html/wordpress/
chmod -R 755 /var/www/html/wordpress

echo '' >> /home/ubuntu/terraform-log.txt


# wp core install --url=http://${app_elastic_ip}/wordpress --title=komsornTitle --admin_user=${admin_user} --admin_password=${admin_pass} --admin_email=${admin_email}
# wp plugin install --activate --path=/var/www/html/wordpress amazon-s3-and-cloudfront

# echo "sudo wp plugin install https://downloads.wordpress.org/plugin/amazon-s3-and-cloudfront.zip --path='/var/www/html/wordpress' --activate --allow-root" >> /home/ubuntu/tmp.sh
# chmod +x /home/ubuntu/tmp.sh
# ./tmp.sh

service apache2 restart

echo 'complete' >> /home/ubuntu/terraform-log.txt
