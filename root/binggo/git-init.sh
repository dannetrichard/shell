#!/bin/bash
echo "Do It Now!"

git config --global user.email "jinjun0927@126.com"
git config --global user.name "dannetrichard"
ssh-keygen -t rsa -b 4096 -C "jinjun0927@126.com"
cat /root/.ssh/id_rsa.pub
