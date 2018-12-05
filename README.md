# Magento 中文本地化补丁
downloads目录下存放有 Magento2 系列的中文本地化补丁。请按照文件名所述的版本下载对应解压覆盖使用。

与源码一起封装过补丁的Magento2.3.0中文本地化版请移步
https://forum.magentochina.org/t/magento23%E4%B8%AD%E6%96%87%E7%89%88%E5%8F%91%E5%B8%83/518 下载 

本地化版本说明：
针对2.3.0 来说相对官方源代码
针对语言包不能汉化的
Magento2安装设置过程 /Setup目录 进行了硬汉化 (含Web Setup Wizard)
Magento2的更新过程 /update目录 进行了硬汉化
Magento CLI 命令提示与描述部分 进行了硬汉化
修正 https://github.com/magento/magento2/issues/14001 此处待处理Bug
加入中国省级行政区划名称

安装过程初始化调整为中文中国
默认时区 东八区 Asia/shanghai
默认货币 人民币 ￥
默认前端显示语言 中文中国
默认后台显示语言 中文中国

语言包不能翻译的 产品类型 进行了本地化 等等很多地方懒的描述了

一共修改了247个文件
10个JS
180个PHP
1个html
31个phtml
20个xml

添加了benheart制作的中文语言包https://github.com/benheart/magento2_zh_hans_cn


# magento2-cn-installer
计划制作适合中国地区所使用的Magento2环境部署一键安装。（BASH脚本、通过源安装【拒绝软件包下载编译】）未来将扩展到安装本人开发的中文本地化Magento2

请直接下载存放到用户目录 例如：/home/jiyun/

执行脚本需要root权限

例如：

Debian下 su 后输入密码

执行 ./magento-cn-installer.sh

Ubuntu下 

执行 sudo ./magento-cn-installer.sh

等我有动力再来更新 2.3.0 要添加的东西太多了

