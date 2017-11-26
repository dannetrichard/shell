#!/bin/bash
echo "Do It Now!"

cd /data/wwwroot/tiger.jingyi-good.com/laravel
git init
git add .
git commit -m 'refresh'
git remote add origin git@github.com:dannetrichard/mall.git
git push -f origin master