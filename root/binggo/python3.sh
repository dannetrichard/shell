#!/bin/bash
yum update -y
#安装python3.6可能使用的依赖
yum install openssl-devel bzip2-devel expat-devel gdbm-devel readline-devel sqlite-devel -y
#下载python3.6编译安装
#到python官网下载https://www.python.org
#下载最新版源码，使用make altinstall，如果使用make install，在系统中将会有两个不同版本的Python在/usr/bin/目录中。这将会导致很多问题，而且不好处理。
#wget https://www.python.org/ftp/python/3.5.4/Python-3.5.4.tgz -P /usr/local/src
cd /usr/local/src
tar -xzvf Python-3.5.4.tgz
cd  Python-3.5.4
#把Python3.6安装到 /usr/local 目录
./configure --prefix=/usr/local
make && make altinstall
#python3.5程序的执行文件：/usr/local/bin/python3.5
#python3.5应用程序目录：/usr/local/lib/python3.5
#pip3的执行文件：/usr/local/bin/pip3.5
#pyenv3的执行文件：/usr/local/bin/pyenv-3.5
#更改/usr/bin/python链接
#cd /usr/bin
#mv python python.bak
#ln -s /usr/local/bin/python3.5 /usr/bin/python
ln -s /usr/local/bin/python3.5 /usr/bin/python3
ln -s /usr/local/bin/pip3.5 /usr/bin/pip3
#更改yum脚本的python依赖
#sed -i 's/python/python2/g' /usr/bin/yum
#修改urlgrabber配置文件
#sed -i 's/python/python2/g' /usr/libexec/urlgrabber-ext-down
cd
//安装virtualenv、tensorflow
		
pip3 install virtualenv
cd /data
mkdir tf_env
cd tf_env/
cat>test.py<<EOF
#!/usr/bin/env python3
# -*- coding: utf-8 -*-
import tensorflow as tf
a = tf.add(3,5)
sess = tf.Session()
print(sess.run(a))
sess.close()
EOF

virtualenv -p /usr/bin/python3 --no-site-packages venv
source venv/bin/activate
pip3 install tf-nightly
python3 test.py
deactivate

cd