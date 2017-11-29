#!/bin/bash
function install_laravel(){
    cd /data/www/
    mkdir $1.jingyi-good.com 
    cd $1.jingyi-good.com
    rm -rf laravel
    composer create-project --prefer-dist laravel/laravel
    cd laravel
    chmod -R 777 storage
    chmod -R 777 bootstrap/cache
    
    sed -i 's/utf8mb4/utf8/g' config/database.php

    sed -i 's/DB_DATABASE=homestead/DB_DATABASE='$1'/g' .env
    sed -i 's/DB_USERNAME=homestead/DB_USERNAME=root/g' .env
    sed -i 's/DB_PASSWORD=secret/DB_PASSWORD=jinjun123/g' .env        
    sed -i 's/PUSHER_APP_SECRET=/PUSHER_APP_SECRET=\nAPP_ID=wxa02ce99b50401101\nAPP_SECRET=5c9e00d42a74132b5f153c49c8f32be6/g' .env

    sed -i 's/UTC/Asia\/Shanghai/g' config/app.php
    composer dump-autoload
    cd
}

mkdir /data
cd /data
mkdir www
cd

sudo apt-get update -y
#pip3
sudo apt-get install python3-pip -y
pip3 install -U pip
#scrapy
pip3 install scrapy
pip3 install tf-nightly
#nodejs npm
curl -sL https://deb.nodesource.com/setup_9.x | sudo -E bash -
sudo apt-get install -y nodejs
#mysql
sudo apt-get install mysql-server -y
#php
sudo apt-get install software-properties-common -y
sudo add-apt-repository ppa:ondrej/php
sudo apt-get update -y
sudo apt-get install php7.1 php7.1-cli php7.1-common php7.1-json php7.1-opcache php7.1-mysql php7.1-mbstring php7.1-mcrypt php7.1-zip php7.1-fpm -y
sed -i 's/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g' /etc/php/7.1/cli/php.ini
sudo systemctl restart php7.1-fpm

#composer
curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer
composer config -g repo.packagist composer https://packagist.phpcomposer.com

#laravel
install_laravel tiger

#nginx
sudo apt-get install nginx -y
cat >/etc/nginx/sites-available/tiger.jingyi-good.com <<EOF
server {
        listen 80;
        server_name tiger.jingyi-good.com;
        root /data/www/tiger.jingyi-good.com/laravel;
        index index.php;

        location / {
                try_files $uri $uri/ =404;
        }

        location ~ \.php$ {
            fastcgi_pass unix:/run/php/php7.1-fpm.sock;
            include snippets/fastcgi-php.conf;
            fastcgi_param SCRIPT_FILENAME \$document_root\$fastcgi_script_name;
        }

        location ~ /\.ht {
                deny all;
        }
}
EOF
sudo ln -s /etc/nginx/sites-available/tiger.jingyi-good.com /etc/nginx/sites-enabled/tiger.jingyi-good.com
sudo nginx -t
sudo systemctl restart nginx