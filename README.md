# SMLIENCEQ.github.io

只是作为个人爱好写的一些shell脚本和go脚本



### csh.sh

```sh
#运行脚本方法
bash  csh.sh
csh.sh 脚本主要是作为linux系统功能配置和常用linux软件服务安装升级


csh v2.11.26
更新时间 2022-11-26
###################
修改centos7yum源


csh v2.11.27
更新时间 2022-11-27
###################
添加mariadb，yum安装，二进制安装

csh v2.12.07
更新时间 2022-12-07
###################
添加编译升级安装openssh，openssl

csh v2.12.27
更新时间 2022-12-07
###################
改进网卡配置流程

csh v3.1.27
更新时间 2023-1-27
###################
升级nginx，升级openssl



csh v3.2.2
更新时间 2023-2-2
###################
新增docker


csh v3.2.3
更新时间 2023-2-3
###################
新增clickhouse



csh v3.2.15
更新时间 2023-2-15
###################
新增redis



csh v3.2.17
更新时间 2023-2-17
###################
新增keepalived



csh v3.5.26
更新时间 2023-5-26
###################
新增zabbix,dns



csh v4.4.25
更新时间 2024-4-25
###################
升级openssl openssh两个版本



csh v4.7.09
更新时间 2024-7-09
###################
添加邮箱告警功能,ssh登录显示功能



csh v4.7.9
更新时间 2024-12-11
###################
#新增内容
#代码位置 选项3,选项4
#**********以下支持在centos7系列使用*************
3.升级openssl到1.1.1w版本
4.升级openssh到9.7p1版本
5 适用于从openssl1.*版本升级到openssl1.1.1w,openssh9.7p1
6 适用于从openssl1.*版本升级到openssl3.3.0,openssh9.7p1
7.适用于从openssl3.*版本升级到openssl3.3.1,openssh9.8p1
8.适用于从openssl1.*版本升级到openssl3.3.1,openssh9.8p1

#**********以下支持在centos6系列使用*************
9.适用于从openssl1.*版本升级到openssl3.3.1,openssh9.8p1

#**********以下支持在openEuler系列使用*************
10.适用于从openssl1.*版本升级到openssl3.3.1,openssh9.8p1





csh v4.8.0
更新时间 2025-02-11
###################
#代码位置  输入选项3,选项12 既可以看到kubernetes部署页面,对应选择即可
调整优化centos7.9一键部署kubernetes1.27.4版本
目前测试centos7.9可以正常部署运行


csh v4.8.5
更新时间 2025-02-25
###################
#代码位置  输入选项3,选项12 既可以看到kubernetes部署页面,对应选择即可
调整优化centos7.9一键部署kubernetes1.27.4版本


csh v4.8.6
更新时间 2025-03-12
###################
修复centos7从openssl 1.0版本升级到3.3.1版本的一些问题
函数所在处:update_sshssl4
```

### local_yum_update_sshssl

```sh
centos7.9 配置本地yum源进行升级openssl3.4.0和openssh9.9p1
```

### update_sshssl_yum.sh

```sh
centos7.9 配置本地yum源和网络源进行升级openssl3.4.0和openssh9.9p1
```







### csh.py

```py
###csh.sh 脚本重构
csh v0.0.3
更新时间 2025-02-26
################### 自学python开始重构csh.sh脚本





```



### update_sshssl_openEuler3.sh

```sh
#运行脚本方法
bash   update_sshssl_openEuler3.sh
openEuler升级到openssh9.9p1,openssl3.4.0
支持openeuler2203 LTS 

```







### commad目录

```sh
commad目录中,写这个脚本是为了显示中文linux命令帮助
```





### update_import_db.sh

```sh
#运行脚本方法
bash  update_import_db.sh

update_import_db.sh是一个可以将excel表格数据导入到mysql表,不过该脚本可能存在一些问题
```



### update_openssh_openssl.sh和update_ssh_ssl.sh

```sh
#运行脚本方法
bash  update_openssh_openssl.sh
bash  update_ssh_ssl.sh

update_openssh_openssl.sh和update_ssh_ssl.sh脚本是一键升级openssh,openssl版本的脚本
```





### mail.sh

```sh
#运行脚本方法
bash  mail.sh

mail.sh是一个linux上用的邮件告警功能脚本
```



### reset7.sh

```sh
#运行脚本方法
bash  reset7.sh

reset7.sh是一个初始化linux系统脚本
支持openEuler2203，centos7.9，rocky8.5，kylinV10
初始化内容:更新yum源，安装软件，关闭防火墙，关闭selinux，优化limits，添加别名,修改主机名颜色,历史记录增加条数和时间显示等
```





