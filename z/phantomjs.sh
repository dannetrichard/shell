#!/bin/bash

function python3_install(){
#安装python3.6可能使用的依赖
yum install openssl-devel bzip2-devel expat-devel gdbm-devel readline-devel sqlite-devel -y

#下载python3.6编译安装
#到python官网下载https://www.python.org
#下载最新版源码，使用make altinstall，如果使用make install，在系统中将会有两个不同版本的Python在/usr/bin/目录中。这将会导致很多问题，而且不好处理。
#wget https://www.python.org/ftp/python/3.6.3/Python-3.6.3.tgz -P /usr/local/src
cd /usr/local/src
tar -xzvf Python-3.6.3.tgz
cd  Python-3.6.3

#把Python3.6安装到 /usr/local 目录
./configure --prefix=/usr/local
make && make altinstall
#python3.6程序的执行文件：/usr/local/bin/python3.6
#python3.6应用程序目录：/usr/local/lib/python3.6
#pip3的执行文件：/usr/local/bin/pip3.6
#pyenv3的执行文件：/usr/local/bin/pyenv-3.6

#更改/usr/bin/python链接
#cd /usr/bin
#mv python python.bak
#ln -s /usr/local/bin/python3.6 /usr/bin/python
ln -s /usr/local/bin/python3.6 /usr/bin/python3
ln -s /usr/local/bin/pip3.6 /usr/bin/pip3

#更改yum脚本的python依赖
#sed -i 's/python/python2/g' /usr/bin/yum
#修改urlgrabber配置文件
#sed -i 's/python/python2/g' /usr/libexec/urlgrabber-ext-down
cd
return 1
}

function phantomjs_install(){
	#��װphantomjs
	yum -y install bzip2 wget fontconfig
	#wget https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-2.1.1-linux-x86_64.tar.bz2 -P /usr/local/src
	cd /usr/local/src
	tar -jxvf phantomjs-2.1.1-linux-x86_64.tar.bz2
	mv phantomjs-2.1.1-linux-x86_64/ /usr/local/bin/phantomjs
	ln -s /usr/local/bin/phantomjs/bin/phantomjs /usr/bin/phantomjs
	cd
	return 1
}
function virtualenv_install(){

	yum install libcurl-devel -y
	pip3 uninstall pycurl
	export PYCURL_SSL_LIBRARY=nss
	pip3 install pycurl
		
	pip3 install virtualenv
	cd /data
	mkdir pyspider_env
	cd pyspider_env
	virtualenv -p /usr/bin/python3 --no-site-packages venv
	source venv/bin/activate
	pip3 install pyspider
	deactivate
	cd
	return 1
}

yum update -y
python3_install
virtualenv_install
phantomjs_install