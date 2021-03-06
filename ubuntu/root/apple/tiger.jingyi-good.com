server {
        listen 80;
        server_name tiger.jingyi-good.com;
        root /data/www/tiger.jingyi-good.com/laravel/public;
        index index.php;

        location / {
            try_files $uri $uri/ /index.php?$query_string;
        }   

        location ~ \.php$ {
            fastcgi_pass unix:/run/php/php7.1-fpm.sock;
            include snippets/fastcgi-php.conf;
            fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
        }

        location ~ /\.ht {
                deny all;
        }
}