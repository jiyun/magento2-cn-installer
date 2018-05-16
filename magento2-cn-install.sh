#!/bin/bash
# auto install LAMPRV(linxu apache2 mariadb php redis varnish)
# by author jiyun
# 2018-05-16
#EOF
echo ''
# Magento2 2.2.x所需软件定义
APACHE_SS="apache2"
APACHE_SS_CENTOS="httpd"
MYSQL_SS="mariadb-server"
PHP_SS="php php-curl php-gd php-intl php-mbstring php-mcrypt php-mysql php-xml php-zip php-soap php-bcmath"
PHP_SS_U1804="php7.1 php7.1-curl php7.1-gd php7.1-intl php7.1-mbstring php7.1-mcrypt php7.1-mysql php7.1-xml php7.1-zip php7.1-soap php7.1-bcmath"
REDIS_SS="redis-server"
VARNISH_SS="varnish"
I_I=" -y install"


#判定当前运行身份
if [[ "$USER" != "root" ]]; then
	echo "执行自动部署过程命令需要ROOT身份"
# return 1
	EOF
	echo '部署程序已退出。'

else
	#判断系统所用软件源安装管理器
	Get_Dist_Name()
	{
	    if grep -Eqii "CentOS"  /etc/issue || grep -Eq "CentOS"  /etc/*-release; then
		DISTRO='CentOS'
		PM='yum'
	    elif grep -Eqi "Aliyun"  /etc/issue || grep -Eq "Aliyun"  /etc/*-release; then
		DISTRO='Aliyun'
		PM='yum'
	    elif grep -Eqi "Debian"  /etc/issue || grep -Eq "Debian"  /etc/*-release; then
		DISTRO='Debian'
		PM='apt'
	    elif grep -Eqi "Ubuntu"  /etc/issue || grep -Eq "Ubuntu"  /etc/*-release; then
		DISTRO='Ubuntu'
		PM='apt'
	    else
		DISTRO='未知操作系统或系统不在支持范围'
	    fi
	    echo "侦测到当前操作系统是 $DISTRO ，正在为你切换软件包管理器。";
	}

	Get_Dist_Name
	
	#步骤一
	echo "步骤一、更新当前系统软件源"
	$PM update
echo ''
	#步骤二 是否添加第三方源 php mariadb redis varnish nginx
	echo '步骤二、判断是否添加第三方源-待完善'
	$sudo add-apt-repository ppa:ondrej/php
echo ''
	#步骤三 安装过程
	echo "步骤三、环境部署安装"

	#install mariadb
	echo "数据库 MariaDB 安装"
	$PM $I_I $MYSQL_SS
echo ''
	echo 'Web 服务器 Apache2 安装'
	#install apache2
	$PM $I_I $APACHE_SS
echo ''
	echo '开源脚本语言 PHP 安装'
	#install php
	#if Get_Dist_Name == "UBUNTU" then 
	#	if grep -Eqi "18.04" cat etc/issue || grep -Eq "18.04" cat /etc/*-release; then
	#fi
	$PM $I_I $PHP_SS
echo ''
	echo '数据库 Redis 安装'
	#install redis
	$PM $I_I $REDIS_SS
echo ''
	echo 'HTTP加速器 Varnish 安装'
	#install varnish
	$PM $I_I $VARNISH_SS
echo ''
	#步骤四 Bash环境配置
	echo '步骤四、Bash环境配置-待完善'
	#设定Magento2 CLI 别名
	alias magento='sudo -u www-data:www-data php /var/www/html/bin/magento'
echo ''
	echo '步骤五、进行安装软件的初始化配置-待...'
	#配置软件初始化
echo ''

	echo '步骤六、重启服务，即将完成-待'
	echo '步骤七、选择Magento2安装方式-1.Composer 2.自行上传压缩包 3.从本程序作者处下载M2中文本地化补丁-待'
fi
