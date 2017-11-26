#!/bin/bash

function vhost(){
    cd /root/oneinstack
    ./vhost.sh
    sed -i 's/root \/data\/wwwroot\/'$1'.jingyi-good.com/root \/data\/wwwroot\/'$1'.jingyi-good.com\/laravel\/public/g' /usr/local/nginx/conf/vhost/$1.jingyi-good.com.conf
    nginx -s reload
    
}
function install_laravel(){
    cd /data/wwwroot/$1.jingyi-good.com/ 
    rm -rf laravel
    composer create-project --prefer-dist laravel/laravel
    cd laravel
    chmod -R 777 storage
    chmod -R 777 bootstrap/cache
    
    sed -i 's/DB_DATABASE=homestead/DB_DATABASE='$1'/g' .env
    sed -i 's/DB_USERNAME=homestead/DB_USERNAME=root/g' .env
    sed -i 's/DB_PASSWORD=secret/DB_PASSWORD=jinjun123/g' .env        
    sed -i 's/PUSHER_APP_SECRET=/PUSHER_APP_SECRET=\nAPP_ID=wxa02ce99b50401101\nAPP_SECRET=5c9e00d42a74132b5f153c49c8f32be6/g' .env

    sed -i 's/UTC/Asia\/Shanghai/g' config/app.php
    composer dump-autoload
}


vhost $1
install_laravel $1