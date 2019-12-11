# Magento2 中文本地化补丁
downloads目录下存放有 Magento2 系列的中文本地化补丁。请按照文件名所述的版本下载对应解压覆盖

与源码一起封装过补丁的Magento2.3.3中文本地化版请移步
https://forum.magentochina.org/t/magento23%E4%B8%AD%E6%96%87%E7%89%88%E5%8F%91%E5%B8%83/518 下载 

本地化补丁说明：
- [x] 更新2.3.3补丁包 相对于上一版本2.3.0（居然时间间隔了一年之久）来说新增了13个文件的本地化补丁 同步2.3.3的更新变动文件44处 另有一个文件文件名变更 此外语言包没更新沿用上一版
------
- [x] 相对2.3.0 官方源代码来说，此补丁针对语言包不能汉化的部分做出修正。
- [x] Magento2安装设置过程 /Setup目录 进行了硬汉化 (含Web Setup Wizard)
- [x] Magento2的更新过程 /update目录 进行了硬汉化
- [x] Magento CLI 命令提示与描述部分 进行了硬汉化
- [x] Magento2 中内置的部分官方组件 进行了硬汉化
- [x] Magento2 用户密码强度提醒JS 进行了硬汉化
- [x] 语言包不能翻译的 产品类型 进行了本地化 等等许多地方懒的描述了
- [x] 修正 https://github.com/magento/magento2/issues/14001 此处待处理Bug
- [x] 加入中国省级行政区划名称 <数据添加>
- 
- [x] 安装过程初始化调整为中文中国
- [x] 默认时区 东八区 Asia/shanghai
- [x] 默认货币 人民币 ￥ 允许的货币为人民币、美元、欧元
- [x] 默认采用 公制单位 Kgs
- [x] 添加了 中国的税类和税率
- [x] 默认前端显示语言 中文中国
- [x] 默认后台显示语言 中文中国
- [x] 客户、订单和后台的地址选项里可以正确显示 中国各省、直辖市、特别行政区下拉项 中文名称(zh_Hans_CN)|英文名称(en_US)随UI语言变动
- 
- [x] 修改通常只针对文本字符处理本地化，和少量数据库初始的定义。仅仅少量地方对程序进行一定的修正，如类似英语时态拼接这类型。原则上不会对官方程序产生不良影响。请注意此包 Magento2中文本地化补丁包，已提交给Magento官方社区经理，作为未来Magento2本地化改进的参考。
- [x] 使用版本更新或在Magento根目录使用Composer install 或 Composer update 将恢复成文件原版会使补丁失效<即便补丁失效对系统几乎也没影响，除了地址栏里省区市下拉栏可能不会显示中文这个问题外，变成显示英文。>。

! 将来官方发布新版本修正了当前本地化存在的问题，那么此中文本地化补丁将中止更新。如还需要继续修正我将保持此项目更新。

> 一共修改了247个文件
> 10个JS
> 180个PHP
> 1个html
> 31个phtml
> 20个xml

> 添加了benheart制作的中文语言包https://github.com/benheart/magento2_zh_hans_cn

如果认为这个Magento2中文补丁包对你有所帮助，并愿意支持作者继续开发请捐助作者。
![imgges](https://github.com/jiyun/magento2-cn-installer/blob/master/donate.jpg)

# magento2-cn-installer
计划制作适合中国地区所使用的Magento2环境部署一键安装。（BASH脚本、通过源安装）未来将扩展到安装本人开发的中文本地化Magento2

请直接下载存放到用户目录 例如：/home/jiyun/

执行脚本需要root权限

例如：

Debian下 su 后输入密码

执行 ./magento-cn-installer.sh

Ubuntu下 

执行 sudo ./magento-cn-installer.sh

等我有动力再来更新 2.3.0 要添加的东西太多了

