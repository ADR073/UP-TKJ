# UP-TKJ

## SSH
ssh root@ipaddress


apt update && apt upgrade -y


## DNS
apt install bind9 -y


cd /etc/bind

cp db.127 db.192

cp db.local db.(nama)


nano db.192

nano db.(nama)

nano named.default-zones


Isi konfigurasi file dapat dilihat pada file db.192, db.andra, dan named.conf.default-zones yang ada pada github ini


systemctl restart bind9

nano /etc/resolv.conf


# owncloud.sh
Berisi bash untuk bahan dari Ujian Praktik TKJ

Silahkan jalankan kode ini dengan user root

cara menggunakan

apt install git -y

cd ~/

git clone https://github.com/ADR073/UP-TKJ.git

bash ./UP-TKJ/owncloud.sh

# Mariadb 
mariadb -u root -p

pass= 12345


create database owncloud;

create user 'owncloud'@'localhost' identified by '12345';

grant all on owncloud.* to 'owncloud'@'localhost';

flush privileges;

exit;

# Apache2
nano /etc/apache2/sites-available/owncloud.conf

Isi file tersebut dengan hint yang ada di dalam file ./UP-TKJ/owncloud.sh atau dalam file owncloud.sh

a2ensite owncloud.conf

a2dissite 000-default.conf

systemctl restart apache2

cd /var/www/

wget https://download.owncloud.com/server/stable/owncloud-complete-20251023.tar.bz2

tar -xf ./owncloud-complete-20251023.tar.bz2

chown -R www-data:www-data ./owncloud/

chmod -R 755 ./owncloud/

#  Silahkan coba akses dengan IP
