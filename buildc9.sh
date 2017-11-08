#!/bin/bash
#Update to php7.1
sudo add-apt-repository -y ppa:ondrej/php
sudo apt-get update -o Dir::Etc::sourcelist="sources.list.d/ondrej-php-trusty.list" -o Dir::Etc::sourceparts="-" -o APT::Get::List-Cleanup="0"
sudo apt install -y libapache2-mod-php7.1
sudo a2dismod php5
sudo a2enmod php7.1
sudo service apache2 restart
sudo apt install -y php7.1-dom
sudo apt install -y php7.1-mbstring
sudo apt install -y php7.1-zip

composer require "laravel/installer"
PATH=$PATH:$PWD/vendor/bin
laravel new tempLaravel
rm -rf vendor
mv tempLaravel/* tempLaravel/.* .


#Host from public folder only
#copy site .conf file
sudo cp /etc/apache2/sites-available/001-cloud9.conf /etc/apache2/sites-available/002-laravel.conf
#change the site to be hosted from the "public" folder
sudo perl -pi -w -e 's/\/home\/ubuntu\/workspace/\/home\/ubuntu\/workspace\/public/g;' /etc/apache2/sites-available/002-laravel.conf
#set the correct sites enabled 
sudo a2dissite 000*; sudo a2dissite 001*; sudo a2ensite 002*

#Start apache server (in background)
run-apache2 &
echo "echo hosting at http://\$C9_PROJECT-\$C9_USER.c9users.io" > site
chmod 750 site
./site