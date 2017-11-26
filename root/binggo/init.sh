#!/bin/bash

function php_version(){
    cd /root/oneinstack
    ./change_php_version.sh
    export PATH=$PATH:/usr/local/php71/bin
    cd
    return 1
}
function update_disable_function(){
    echo "update disable function"
    sed -i 's/shell_exec,proc_open,proc_get_status,/shell_exec,/g' /usr/local/php71/etc/php.ini
    return 1
}
function composer_install(){
    curl -sS https://getcomposer.org/installer | php
    sudo mv composer.phar /usr/local/bin/composer
    composer config -g repo.packagist composer https://packagist.phpcomposer.com
    return 1
}
function reset_db_password(){
    cd /root/oneinstack
    ./reset_db_root_password.sh
}

php_version
update_disable_function
composer_install
reset_db_password