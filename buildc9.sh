#!/bin/bash

# Update to php7.1
sudo add-apt-repository -y ppa:ondrej/php
sudo apt-get update -o Dir::Etc::sourcelist="sources.list.d/ondrej-php-trusty.list" -o Dir::Etc::sourceparts="-" -o APT::Get::List-Cleanup="0"
sudo apt install -y libapache2-mod-php7.1
sudo a2dismod php5
sudo a2enmod php7.1
sudo service apache2 restart
sudo apt install -y php7.1-dom
sudo apt install -y php7.1-mbstring
sudo apt install -y php7.1-zip
sudo apt-get install -y php7.1-mysql

# Make project
composer require "laravel/installer"
PATH=$PATH:$PWD/vendor/bin
laravel new tempLaravel
rm -rf vendor
mv tempLaravel/* tempLaravel/.* .
echo ".c9" >> .gitignore
echo "build.log.txt" >> .gitignore

# default string length bug fix
sed -i "N;N;/boot()\\n    {/a\\\t\\tSchema::defaultStringLength(191);" app/Providers/AppServiceProvider.php  
sed -i "/use Illuminate\\\Support\\\ServiceProvider;/ause Illuminate\\\Support\\\Facades\\\Schema;" app/Providers/AppServiceProvider.php

# Edit environment file
sed -i "/DB_DATABASE=/c\DB_DATABASE=c9" ~/workspace/.env
sed -i "/DB_USERNAME=/c\DB_USERNAME=$C9_USER" ~/workspace/.env
sed -i "/DB_PASSWORD=/c\DB_PASSWORD=" ~/workspace/.env

# Host from public folder only
sudo cp /etc/apache2/sites-available/001-cloud9.conf /etc/apache2/sites-available/002-laravel.conf
#change the site to be hosted from the "public" folder
sudo perl -pi -w -e 's/\/home\/ubuntu\/workspace/\/home\/ubuntu\/workspace\/public/g;' /etc/apache2/sites-available/002-laravel.conf
#set the correct sites enabled 
sudo a2dissite 000*; sudo a2dissite 001*; sudo a2ensite 002*

# Start apache server (in background)
run-apache2 &
echo "echo hosting at http://\$C9_PROJECT-\$C9_USER.c9users.io" > site
chmod 750 site
# Display site location
./site