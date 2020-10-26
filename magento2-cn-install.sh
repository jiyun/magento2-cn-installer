#!/bin/sh
# auto install LAMPRV(linxu apache2 mariadb php docker elasticsearch redis varnish)
# by author jiyun
# 2020-10-26
#EOF

#变量与函数赋值区域
_NONE="                     "
btitle(){
    echo "\033[37;41m\033[01m\t\t$_NONE$1$_NONE\033[0m\t"
}
myellow(){
    echo "\033[33m ==>$1\033[0m"
}
byellow(){
    echo "\033[32m$1\033[0m" "\033[33m\033[01m[ $2 ]\033[0m"
}
bred(){
    echo "\033[31m\033[01m$1\033[0m" "\033[33m\033[01m[ $2 ]\033[0m"
}
messageyesno(){
while true
do
	read -p $1"[ Y/N ]" input
	case $input in
	    [yY][eE][sS]|[yY])
			echo "ByeBye!"
			exit 1
			;;
	    [nN][oO]|[nN])
			echo "No"
            $2
            break
            ;;
	    *)
			echo $(bred "别瞎输入，确认下咯..." Y/N)
			;;
	esac
done
}
showip=$(ip addr | awk '/^[0-9]+: / {}; /inet.*global/ {print gensub(/(.*)\/(.*)/, "\\1", "g", $2)}')
magento='sudo -u www-data php /var/www/html/241/bin/magento'
userpwd=$(pwd)
#判断系统所用软件源安装管理器
Get_Dist_Name()
{
    if grep -Eqi "CentOS" /etc/issue || grep -Eq "CentOS" /etc/*-release; then
        DISTRO='CentOS'
        PM='yum'
    elif grep -Eqi "Debian" /etc/issue || grep -Eq "Debian" /etc/*-release; then
        DISTRO='Debian'
        PM='apt'
    elif grep -Eqi "Ubuntu" /etc/issue || grep -Eq "Ubuntu" /etc/*-release; then
        DISTRO='Ubuntu'
        PM='apt'
    else
        DISTRO='未知操作系统或系统不在支持范围'
    fi
    echo "侦测到当前操作系统是 $DISTRO ，正在为你切换软件包管理器。";
}
# Magento2 2.4.1所需软件定义
APACHE_SS="apache2"
APACHE_SS_CENTOS="httpd"
MYSQL_SS="mariadb-server"
PHP_SS="php php-curl php php-bcmath php-curl php-gd php-intl php-mbstring php-soap php-zip php-xml php-mysql imagemagick"
ES_SS="elasticsearch"
DOCKER_SS="docker.io"
COMP_SS="composer"
REDIS_SS="redis-server"
I_I=" -y install"

## 添加判断WSL 
#uname -a | grep -oi "microsoft"
echo ''
#赋值区域结束

clear
#欢迎屏开始
btitle "Magento2.4.1萌新安装助手(Ver 1.0.1026)by 急云"
byellow "当前系统登录用户：" " `whoami` "
byellow "当前系统登录用户数：" " `who | wc -l` "
byellow "当前时间：" " `date +'%Y-%m-%d %H:%M:%S'` "
byellow "当前磁盘利用率：" " `df -hT | grep "/$" | awk '{print $6}'`"
byellow "当前系统共有的进程数：" " `ps | wc -l`"
byellow "当前空闲容量  " " `free | grep "Mem:" | awk '{print$4}'` "KB 
byellow "当前cpu利用率 " " `uptime | awk -F, '{print$3}' | awk '{print$3}'` " % 
byellow "显示本机IP地址 " $showip
btitle "执行本脚本需要Root权限因需要部署环境并修改目录权限或所属"
btitle "包括安装APACHE MariaDB PHP等并进行一定量的设置配置等操作"
btitle "仅支持Ubuntu 20.04版本下的默认源安装并配置非此版本请取消"
messageyesno "本命令是给Magento2的菜鸟萌新使用的，自觉是高手请绕道！"
#欢迎屏幕结束

#判定当前运行身份
if [ $(id -u) -ne 0 ]; then
    myellow "执行自动部署过程命令需要SUDO赋权执行"
    myellow '\t部署程序已退出。'
else
Get_Dist_Name
    #Ubuntu版本判定区域
    #待添加
    #Ubuntu版本判定结束
#步骤一
myellow "步骤一、更新当前系统软件源"
$PM update
echo ''

#步骤二 是否添加第三方源 php mariadb redis varnish nginx
myellow '步骤二、判断是否添加第三方源-待完善'
#sudo add-apt-repository ppa:ondrej/php
echo ''

#步骤三 LAMP安装过程
myellow "步骤三、环境部署安装"
#install mariadb
bred "数据库 MariaDB 安装" "**必要组件"
$PM $I_I $MYSQL_SS
echo ''
bred "Web 服务器 Apache2 安装" "**必要组件"
#install apache2
$PM $I_I $APACHE_SS
echo ''
bred "开源脚本语言 PHP 安装" "**必要组件"
#install php
    #if Get_Dist_Name == "UBUNTU" then 
    #    if [[ `lsb_release -r --short` !=  "20.04" ]]; then 
    #        echo "需要Ubuntu 20.04版 你的版本是`lsb_release -r --short` 不符合要求，结束执行！"
    #        exit
    #    fi
    #fi
$PM $I_I $PHP_SS
echo ''
bred "应用容器引擎 Docker 安装" "**必要组件"
#install Docker
$PM $I_I $DOCKER_SS
echo ''
echo "下面有三项非必选安装询问，选是也仅安装需自行配置。"
myellow "数据库 Composer 安装 可选组件"
while true; do
    read -p "非必选组件是否安装?" yn
    case $yn in
#install redis
        [Yy]* ) $PM $I_I $COMP_SS; break;;
        [Nn]* ) echo "跳过安装"; break;;
        * ) echo "请回答 yes 或 no 。";;
    esac
done
echo ''
myellow "数据库 Redis 安装 可选组件"
while true; do
    read -p "非必选组件是否安装?" yn
    case $yn in
#install redis
        [Yy]* ) $PM $I_I $REDIS_SS; break;;
        [Nn]* ) echo "跳过安装"; break;;
        * ) echo "请回答 yes 或 no 。";;
    esac
done
echo ''
myellow "HTTP加速器 Varnish 安装 可选组件"
while true; do
    read -p "非必选组件是否安装?" yn
    case $yn in
#install varnish
    [Yy]* ) $PM $I_I $VARNISH_SS; break;;
    [Nn]* ) echo "跳过安装"; break;;
    * ) echo "请回答 yes 或 no 。";;
    esac
done
echo ''

#步骤四 Bash环境配置
myellow "步骤四、下载Magento2.4.1并配置环境"
#进入用户目录
cd $userpwd
#download magento2.4.1
echo "\033[33m开始下载Magento2.4.1源文件\033[0m"
wget https://download.magentochina.org/magento/2/2.4.X/magento-ce-2.4.1-2020-09-25-04-17-23.tar.gz
echo ''
#创建目录并解压发布版文件
echo "\033[33m创建放置Magento2.4.1子目录\033[0m"
sudo mkdir 241
mv magento-ce-2.4.1-2020-09-25-04-17-23.tar.gz 241/
#创建硬链接
cd /var/www/html
sudo ln -Fs $userpwd/241 241
echo ''
echo "\033[33m解压Magento2源文件\033[0m"
cd $userpwd/241
tar xzf magento-ce-2.4.1-2020-09-25-04-17-23.tar.gz
echo ''
#修改目录所属与权限
echo "\033[33m修改目录所属与权限\033[0m"
sudo chmod -R 775 $userpwd/241
sudo chown -R www-data:www-data $userpwd/241
echo ''

myellow "步骤五、进行安装软件的初始化配置..."
#配置软件初始化
echo "\033[33m添加APACHE2配置内容\033[0m"
sudo sed -i '$a <Directory "/var/www/html">\n\tAllowOverride all\n</Directory>' /etc/apache2/sites-available/000-default.conf
echo ''
echo "\033[33m启用APACHE2重写模块\033[0m"
sudo a2enmod rewrite
echo ''
##配置Mysql
echo "\033[33m配置Mysql\033[0m"
sudo mysql -uroot -e "use mysql; update mysql.user set plugin='mysql_native_password' where User='root'; create database magento charset utf8; grant all on *.* to magento2@'%' identified by 'Magento' with grant option; flush privileges;"
echo ''
mysqladmin -uroot password test@123
echo ''
##配置docker下载elasticsearch
echo "\033[33mdocker下载elasticsearch\033[0m"
sudo docker pull nshou/elasticsearch-kibana
echo ''

myellow "步骤六、下载安装中文化补丁包"
## 下载 中文语言包补丁
while true; do
    read -p "需要安装下载中文本地化补丁包？[ Y/N ]" yn
    case $yn in
#install varnish
    [Yy]* )  cd $userpwd;wget  https://download.magentochina.org/magento/2/2.4.X/Magento2.4.1-chinese.location.patch.by.jiyun-20201026.tgz;sudo -u www-data tar zxf Magento2.4.1-chinese.location.patch.by.jiyun-20201026.tgz -C 241/;rm -rf Magento2.4.1-chinese.location.patch.by.jiyun-20201026.tgz; break;;
    [Nn]* ) echo ""; break;;
    * ) echo "请回答 yes 或 no 。";;
    esac
done
echo ''

myellow "步骤七、重启服务，即将完成"
echo "\033[33m开启服务apache2\033[0m"
sleep 1
sudo service apache2 restart
apache2 -v
echo "\033[33m开启服务mysql（Maria DB）\033[0m"
sleep 1
sudo service mysql restart
mysql -V
echo "\033[33m启动elasticsearch镜像\033[0m"
sleep 1
sudo docker run -d -p 9200:9200 -p 9300:9300 -p 5601:5601 --name eskibana nshou/elasticsearch-kibana
echo ''

myellow "步骤八、Magento2安装"
#进入目录后执行下列命令
echo "开始安装Magento 2.4.1"
$magento setup:install --backend-frontname="admin" \
--db-host="localhost" \
--db-name="magento" \
--db-user="magento2" \
--db-password="Magento" \
--language="zh_Hans_CN" \
--currency="CNY" \
--timezone="Asia/Shanghai" \
--use-rewrites=1 \
--base-url="http://"$showip/241/ \
--admin-user=admin \
--admin-password="password@123" \
--admin-email=admin@domain.com \
--admin-firstname=Firstname \
--admin-lastname=Lastname \
--session-save=db \
--search-engine=elasticsearch7 \
--elasticsearch-host=127.0.0.1 \
--elasticsearch-port=9200 \
--cleanup-database
myellow "执行Magento CLI 预初始化"
echo '执行CLI 关闭两步验证模块'
$magento module:disable Magento_TwoFactorAuth
echo ''
echo '执行CLI Cron install'
$magento cron:install
echo ''
echo '执行CLI Cron run'
$magento cron:run
echo ''
echo '执行CLI 强制重建静态缓存'
$magento setup:static-content:deploy -f
echo ''
btitle "Magento2.4.1萌新助手完成"
byellow "后台管理员" "admin"
byellow "管理员密码" "password@123"
byellow "前端地址" "http://$showip/241"
byellow "后台入口" "http://$showip/241/admin"
echo ''
byellow 更多安装教程访问 https://forum.magentochina.org/t/854
echo "如果安装过程中遇到网络问题报错 重新运行本安装程序即可"
echo "WSL2中安装需要 预先安装Docker Desktop具体见上面的教程"
myellow "要卸载Magento2.4.1重新来过一遍吗？"
while true; do
    read -p "执行CLI卸载命令？" yn
    case $yn in
#reload?
    [Yy]* )  $magento setup:uninstall; break;;
    [Nn]* ) echo "非常好！你没有手误。d(ﾟｰﾟ@)"; break;;
    * ) echo "请回答 yes 或 no 。";;
    esac
done
$magento list
fi
