#!/bin/bash

echo "Jalankan file ini dengan user root!!"

# Update dan upgrade sistem
apt update && apt upgrade -y

# Install tools dasar dan repository PHP
apt install -y sudo zip apt-transport-https lsb-release ca-certificates wget gnupg

wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg
echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" \
    | tee /etc/apt/sources.list.d/php.list

apt update

# Install Apache, PHP 7.4, database, dan modul lengkap OwnCloud
apt install -y apache2 php7.4 mariadb-server imagemagick certbot python3-certbot-apache \
smbclient redis-server unzip rsync libapache2-mod-php7.4 \
php7.4-{intl,mysql,mbstring,imagick,igbinary,gmp,bcmath,curl,gd,zip,imap,ldap,bz2,ssh2,common,json,xml,dev,apcu,redis} \
libsmbclient-dev php-pear php-phpseclib

# Aktifkan modul Apache yang dibutuhkan OwnCloud
a2enmod dir env headers mime rewrite setenvif ssl
systemctl restart apache2

# Hint VirtualHost (tertulis tapi tidak dieksekusi)
: '

================= HINT KONFIGURASI VIRTUALHOST =================

<VirtualHost *:80>
    ServerName your-domain.com
    DocumentRoot /var/www/owncloud

    <Directory /var/www/owncloud>
        AllowOverride All
        Options FollowSymlinks MultiViews
        Require all granted
    </Directory>

    ErrorLog ${APACHE_LOG_DIR}/owncloud_error.log
    CustomLog ${APACHE_LOG_DIR}/owncloud_access.log combined
</VirtualHost>

================================================================

'

echo "=== Instalasi selesai, lanjutkan konfigurasi database dan Apache ==="

