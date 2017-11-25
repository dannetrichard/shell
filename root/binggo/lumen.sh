#!/bin/bash

function vhost(){
    cd /root/oneinstack
    ./vhost.sh
    sed -i 's/root \/data\/wwwroot\/'$1'.jingyi-good.com/root \/data\/wwwroot\/'$1'.jingyi-good.com\/lumen\/public/g' /usr/local/nginx/conf/vhost/$1.jingyi-good.com.conf
    nginx -s reload
    
}
function install_lumen(){
    cd /data/wwwroot/$1.jingyi-good.com/ 
    rm -rf lumen
    composer create-project --prefer-dist laravel/lumen
    cd lumen
    chmod -R 777 storage
    sed -i 's/UTC/Asia\/Shanghai\nAPP_ID=wxa02ce99b50401101\nAPP_SECRET=5c9e00d42a74132b5f153c49c8f32be6/g' .env
    
    sed -i 's/DB_DATABASE=homestead/DB_DATABASE=tiger/g' .env
    sed -i 's/DB_USERNAME=homestead/DB_USERNAME=root/g' .env
    sed -i 's/DB_PASSWORD=secret/DB_PASSWORD=KeYpZrZx/g' .env 
 
    composer dump-autoload
}


vhost $1
install_lumen $1