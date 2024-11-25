#!/bin/bash
. /etc/os-release
OpensslVersion=3.3.1
OpensslVersion1=`openssl version | awk  '{print $2}'`
OpensshVersion=9.8p1
Date=`date +%Y%m%d%H%M%S`

echo -e "\e[1;35m====================================================================\e[0m"
echo -e "\e[1;35m现在已安装的版本\e[0m"
ssh -V
echo -e "\e[1;35m本次安装的版本是openssl-${OpensslVersion}\e[0m"
echo -e "\e[1;35m本次升级的安装版本openssh-${OpensshVersion}\e[0m"
echo -e "\e[1;35m离线安装，请提前准备好对应版本的压缩包放在root目录下\e[0m"
echo -e "\e[1;35m====================================================================\e[0m"
echo -e "\e[1;35m不想安装请在五秒内终止脚本\e[0m\n"

for i in {5..1}
do
    echo -n "${i} "
    echo -ne "\r"
    sleep 1
done


echo -e "\e[1;35m==========================安装telnet=================================\e[0m"

software=(
    "telnet"
    "telnet-server"
    "xinetd"
    )
for i in ${software[@]}
do
rpm -q $i &> /dev/null && echo -e "$i\t\e[1;32m已安装\e[0m" || { yum -y install $i &> /dev/null; echo -e "$i\t\e[1;35m安装成功\e[0m" ; }
done


systemctl enable --now  xinetd.service
systemctl enable --now  telnet.socket


cat >>/etc/securetty<<EOF
pts/0 
pts/1
EOF



echo -e "\e[1;35m手动测试telnet连接是否正常\e[0m"

echo -e "\e[1;35m==========================检查系统==================================\e[0m"

if [ $ID = 'openEuler' ];then
    echo -e "\e[1;35m检测系统为openEuler,脚本支持执行\e[0m"
else
    echo -e "\e[1;33m检测系统不是openEuler,脚本不支持\e[0m"
    exit
fi


if [[ ${OpensslVersion1}  < 3 ]];then
    echo -e "\e[1;35m脚本支持升级openssl\e[0m"
else
    echo -e "\e[1;33m检测openssl版本高于3版本,脚本不支持\e[0m"
    exit
fi





echo -e "\e[1;35m==========================文件检查================================\e[0m"

if [ -e "/root/$0" ];then
    echo -e ""
else
    echo -e "\e[1;33m请将脚本文件放在root目录下执行\e[0m"
    exit
fi


if [ -e "/root/openssl-${OpensslVersion}.tar.gz" ];then
    echo -e "\e[1;35mopenssl-${OpensslVersion}文件存在\e[0m"
else
    echo -e "\e[1;33mopenssl-${OpensslVersion}文件不存在，请将文件放在root目录下\e[0m"
    exit
fi



if [[ -a "/root/openssh-${OpensshVersion}.tar.gz" ]];then
    echo -e "\e[1;35mopenssh-${OpensshVersion}文件存在\e[0m"
else
    echo -e "\e[1;33mopenssh-${OpensshVersion}文件不存在,请将文件放在root目录下\e[0m"
    exit
fi



echo -e "\e[1;35m=======================开始升级openssl==============================\e[0m"
echo -e "\e[1;35m==========================安装依赖包================================\e[0m"


#yum install  -y gcc gcc-c++ glibc make
software=(
    "gcc"
    "gcc-c++"
    "openssl-devel"
    "zlib-devel"
    "make"
    "glibc"
    "autoconf"
    "pcre-devel"
    "pam-devel"
    "pam*"
    )
for i in ${software[@]}
do
rpm -q $i &> /dev/null && echo -e "$i\t\e[1;32m已安装\e[0m" || { yum -y install $i &> /dev/null; echo -e "$i\t\e[1;35m安装成功\e[0m" ; }
done








echo -e "\e[1;35m==========================编译安装=======================================\e[0m"
tar -zxvf openssl-${OpensslVersion}.tar.gz
cd openssl-${OpensslVersion}
./config --prefix=/usr/local/openssl --openssldir=/usr/local/openssl shared zlib


make && make install

sudo mv /usr/bin/openssl /usr/bin/openssl-${Date}
sudo ln -s /usr/local/openssl/bin/openssl /usr/bin/openssl
sudo echo "/usr/local/openssl/lib" >> /etc/ld.so.conf
#echo "/usr/local/openssl/lib64" >> /etc/ld.so.conf.d/openssl.conf
echo "/usr/local/openssl/lib64" | sudo tee /etc/ld.so.conf.d/openssl-3.conf

sudo ldconfig

cd
#查看版本 是否安装成功
echo -e "\e[1;35m===============================升级后版本================================\e[0m"
ldconfig
openssl version




sleep 5



echo -e "\e[1;35m=======================开始升级openssh==================================\e[0m"

echo -e "\e[1;35m===========================解压源文件====================================\e[0m"


tar zxf /root/openssh-${OpensshVersion}.tar.gz
if [ -e /root/openssh-${OpensshVersion} ];then
    echo -e "\e[1;35mopenssh解压成功\e[0m"
else
    echo -e "\e[1;35mopenssh解压失败\e[0m"
    exit
fi




echo -e "\e[1;35m===========================编译openssh==================================\e[0m"

cd /root/openssh-${OpensshVersion}/
./configure  --with-ssl-dir=/usr/local/openssl
#./configure --with-ssl-dir=/usr/local/openssl \
#            --with-cflags="-I/usr/local/openssl/include" \
#            --with-libs="/usr/local/openssl/lib64"


make && make install


systemctl restart sshd

sleep 3
echo -e "\e[1;35m=========================更新后openssh版本================================\e[0m"
#export LD_LIBRARY_PATH=/usr/local/openssl/lib64:$LD_LIBRARY_PATH
echo 'export LD_LIBRARY_PATH=/usr/local/openssl/lib64:${LD_LIBRARY_PATH:-""}' >> /etc/profile
echo "export PATH=/usr/local/bin:$PATH"  >>/etc/profile

ldconfig
source /etc/profile
ssh -V
