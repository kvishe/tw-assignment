#!/bin/bash
dnf -y install httpd wget
dnf -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm
dnf -y install https://rpms.remirepo.net/enterprise/remi-release-8.rpm
dnf -y install dnf-utils
dnf -y module install php:remi-7.4
dnf -y install php php-mysqlnd php-gd php-xml php-mbstring php-json

systemctl enable httpd
sed -i 's/enforcing/disabled/g' /etc/selinux/config
setenforce 0
cd /opt/
wget https://releases.wikimedia.org/mediawiki/1.35/mediawiki-1.35.0.tar.gz
wget https://releases.wikimedia.org/mediawiki/1.35/mediawiki-1.35.0.tar.gz.sig
gpg --verify mediawiki-1.35.0.tar.gz.sig mediawiki-1.35.0.tar.gz

if [ ! -d /var/www/html/mediawiki ]; then
cd /var/www/html/
tar -zxf /opt/mediawiki-1.35.0.tar.gz
mv mediawiki-1.35.0 mediawiki
chown -R apache:apache mediawiki

echo "Uses /mediawiki to access Mediawiki" > index.html
systemctl start httpd
fi
