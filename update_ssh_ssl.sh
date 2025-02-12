#!/usr/bin/expect
telnet_install(){
echo -e "\e[1;35m==========================安装telnet=====================================\e[0m"

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
}

update_openssl(){
local version=3.3.0
local URL=https://www.openssl.org/source/old/1.1.1/openssl-1.1.1w.tar.gz
local OSVERSION=`awk '{print $4}' /etc/redhat-release`

echo -e "\e[1;35m====================================================================\e[0m"
echo -e "\e[1;35m现在已安装的版本\e[0m"
openssl version

echo -e "\e[1;35m本次安装的版本是openssl-${version}\e[0m"
echo -e "\e[1;35m====================================================================\e[0m"
echo -e "\e[1;35m不想安装请在五秒内终止脚本\e[0m\n"

for i in {5..1}
do
    echo -n "${i} "
    echo -ne "\r"
    sleep 1
done

echo -e "\e[1;35m==========================检查系统==================================\e[0m"

if [[ ${OSVERSION} > 7 ]];then
    echo -e "\e[1;35m检测系统为centos7允许执行\e[0m"
else
    echo -e "\e[1;33m检测系统不是centos7,脚本不支持\e[0m"
    exit
fi



echo -e "\e[1;35m==========================源文件检查================================\e[0m"
if [ -e "openssl-${version}.tar.gz" ];then
    echo -e "\e[1;35m文件存在\e[0m"
else
    echo -e "\e[1;33m文件不存在，开始下载\e[0m"
    wget --no-check-certificate https://www.openssl.org/source/openssl-${version}.tar.gz
fi


echo -e "\e[1;35m==========================安装依赖包================================\e[0m"


#yum install  -y gcc gcc-c++ glibc make
software=(
    "gcc"
    "perl"
    "zlib-devel"
    "make"
    "perl-CPAN"
    )
for i in ${software[@]}
do
rpm -q $i &> /dev/null && echo -e "$i\t\e[1;32m已安装\e[0m" || { yum -y install $i &> /dev/null; echo -e "$i\t\e[1;35m安装成功\e[0m" ; }
done


echo -e "\e[1;31m需要手动按回车\e[0m"
cpan IPC::Cmd




tar -zxvf openssl-${version}.tar.gz
cd openssl-${version}
./config --prefix=/usr/local/ssl --openssldir=/usr/local/ssl shared zlib


make && make install

echo "/usr/local/ssl/lib64" > /etc/ld.so.conf.d/openssl.conf
ldconfig

cp /usr/local/ssl/bin/openssl /usr/bin/openssl
ldconfig -v
cd
#查看版本 是否安装成功
echo -e "\e[1;35m===============================升级后版本================================\e[0m"

openssl version
}






update_openssh(){
local ZLIBV=1.3.1
local OPENSSHV=9.7p1
local OSVERSION=`awk '{print $4}' /etc/redhat-release`

echo -e "\e[1;35m========================================================================\e[0m"
echo -e "\e[1;35m现在已安装的版本\e[0m"
ssh -V
echo -e "\e[1;35m本次升级的安装版本openssh-${OPENSSHV}，zlib-${ZLIBV}\e[0m"
echo -e "\e[1;35m离线安装，请提前准备好对应版本的压缩包放在root目录下\e[0m"
echo -e "\e[1;35m========================================================================\e[0m"
echo -e "\e[1;35m不想安装此版本请在五秒内终止脚本\e[0m\n"

for i in {5..1}
do
    echo -n "${i} "
    echo -ne "\r"
    sleep 1
done
echo -e "\e[1;35m==========================检查系统=====================================\e[0m"

if [[ ${OSVERSION} > 7 ]];then
    echo -e "\e[1;35m检测系统为centos7允许执行\e[0m"
else
    echo -e "\e[1;33m检测系统不是centos7,脚本不支持\e[0m"
    exit
fi



echo -e "\e[1;35m==========================源文件检查=====================================\e[0m"

if [[ -a "zlib-${ZLIBV}.tar.gz" ]];then
    echo -e "\e[1;35mzlib源文件存在\e[0m"
else
    echo -e "\e[1;33mzlib源文件不存在\e[0m"
    exit
fi

if [[ -a "openssh-${OPENSSHV}.tar.gz" ]];then
    echo -e "\e[1;35mopenssh源文件存在\e[0m"
else
    echo -e "\e[1;33mopenssh源文件不存在\e[0m"
    exit
fi

echo -e "\e[1;35m==========================安装依赖包=====================================\e[0m"

software=("gcc"
    "gcc-c++"
    "glibc"
    "make"
    "autoconf"
    "openssl"
    "openssl-devel"
    "pcre-devel"
    "pam-devel"
    "pam*"
    )
for i in ${software[@]}
do
rpm -q $i &> /dev/null && echo -e "$i\t\e[1;32m已安装\e[0m" || { yum -y install $i &> /dev/null; echo -e "$i\t\e[1;35m安装成功\e[0m" ; }
done

echo -e "\e[1;35m===========================解压源文件====================================\e[0m"
tar zxf /root/zlib-${ZLIBV}.tar.gz
if [ -e /root/zlib-${ZLIBV} ];then
    echo -e "\n\e[1;35mzlib解压成功\e[0m"
else
    echo -e "\n\e[1;35mzlib解压失败\e[0m"
    exit
fi


tar zxf /root/openssh-${OPENSSHV}.tar.gz
if [ -e /root/openssh-${OPENSSHV} ];then
    echo -e "\e[1;35mopenssh解压成功\e[0m"
else
    echo -e "\e[1;35mopenssh解压失败\e[0m"
    exit
fi





echo -e "\e[1;35m=============================编译zlib===================================\e[0m"
#tar zxf /root/zlib-${ZLIBV}.tar.gz
if [ -e /usr/local/zlib ];then
    echo -e "\n\e[1;35m已存在\e[0m"
else
echo -e "\n\e[1;35m开始编译\e[0m"
cd /root/zlib-${ZLIBV}/
./configure --prefix=/usr/local/zlib
make && make install
[ $? -eq 0 ] && echo -e "\e[1;35m                                                            [  OK  ] \e[0m" || { echo -e "\e[1;31m                false \e[0m";exit; }
fi


echo -e "\e[1;35m===========================编译openssh==================================\e[0m"
#tar zxf /root/openssh-${OPENSSHV}.tar.gz
if [ -e /usr/local/openssh ];then
    echo -e "\n\e[1;35m已存在\e[0m"
else
echo -e "\n\e[1;35m开始编译\e[0m"
cd /root/openssh-${OPENSSHV}/
./configure --prefix=/usr/local/openssh --with-ssl-dir=/usr/local/ssl --with-zlib=/usr/local/zlib
 make && make install

[ $? -eq 0 ] && echo -e "\e[1;35m                                                           [  OK  ] \e[0m" || { echo -e "\e[1;31m                false \e[0m";exit; }
fi

echo -e "\e[1;35m======================备份旧文件，迁入新文件==============================\e[0m"                  
[ -d /data/opensshbak ] || mkdir -p /data/opensshbak/

if [ -a /etc/ssh/sshd_config ];then
    echo ""
else
    echo "sshd_config文件不存在"
fi

if [ -a /usr/sbin/sshd ];then
    echo ""
else
    echo "sshd文件不存在"
    exit
fi

if [ -a /usr/bin/ssh ];then
    echo ""
else
    echo "ssh文件不存在"
    exit
fi

if [ -a /usr/bin/ssh-keygen ];then
    echo ""
else
    echo "ssh-keygen文件不存在"
    exit
fi
if [ -a /etc/ssh/ssh_host_ecdsa_key.pub ];then
    echo ""
else
    echo "ssh_host_ecdsa_key.pub文件不存在"
    exit
fi

mv /etc/ssh/sshd_config /data/opensshbak/sshd_config.bak
cp /usr/local/openssh/etc/sshd_config /etc/ssh/sshd_config
[ $? -eq 0 ] && echo "" || { echo "/etc/ssh/sshd_config文件拷贝失败";exit; }
mv /usr/sbin/sshd /data/opensshbak/sshd.bak
cp /usr/local/openssh/sbin/sshd /usr/sbin/sshd
[ $? -eq 0 ] && echo "" || { echo "/usr/sbin/sshd文件拷贝失败";exit; }
mv /usr/bin/ssh /data/opensshbak/ssh.bak
cp /usr/local/openssh/bin/ssh /usr/bin/ssh
[ $? -eq 0 ] && echo "" || { echo "/usr/bin/ssh文件拷贝失败";exit; }
mv /usr/bin/ssh-keygen /data/opensshbak/ssh-keygen.bak
cp /usr/local/openssh/bin/ssh-keygen /usr/bin/ssh-keygen
[ $? -eq 0 ] && echo "" || { echo "/usr/bin/ssh-keygen文件拷贝失败";exit; }
mv /etc/ssh/ssh_host_ecdsa_key.pub /data/opensshbak/ssh_host_ecdsa_key.pub.bak
cp /usr/local/openssh/etc/ssh_host_ecdsa_key.pub /etc/ssh/ssh_host_ecdsa_key.pub

[ $? -eq 0 ] && echo "" || { echo "/etc/ssh/ssh_host_ecdsa_key.pub文件拷贝失败";exit; }


for  i   in  $(rpm  -qa  |grep  openssh);do  rpm  -e  $i  --nodeps ;done


mv /etc/ssh/sshd_config.rpmsave /etc/ssh/sshd_config




cp /root/openssh-${OPENSSHV}/contrib/redhat/sshd.init /etc/init.d/sshd
[ $? -eq 0 ] && echo "" || { echo "/etc/init.d/sshd文件拷贝失败";exit; }



if [ -a /root/openssh-${OPENSSHV}/contrib/redhat/sshd.init ];then
    echo ""
else
    echo "/root/openssh-${OPENSSHV}/contrib/redhat/sshd.init文件不存在"
    exit
fi

if [ -a /etc/init.d/sshd ];then
    echo ""
else
    echo "/etc/init.d/sshd文件不存在"
    exit
fi
chmod u+x   /etc/init.d/sshd




echo -e "\e[1;35m==========================修改sshd配置文件================================\e[0m"



cp /etc/init.d/sshd /data/opensshbak/sshdnewbk
sed -i '/SSHD=/c\SSHD=\/usr\/local\/openssh\/sbin\/sshd'  /etc/init.d/sshd
sed -i '/\/usr\/bin\/ssh-keygen/c\         \/usr\/local\/openssh\/bin\/ssh-keygen -A'  /etc/init.d/sshd
sed -i '/ssh_host_rsa_key.pub/i\                \/sbin\/restorecon \/etc\/ssh\/ssh_host_key.pub'  /etc/init.d/sshd  
sed -i '/$SSHD $OPTIONS && success || failure/i\       \ OPTIONS="-f /etc/ssh/sshd_config"' /etc/rc.d/init.d/sshd

[ $? -eq 0 ] && echo -e "\e[1;35m                                                           [  OK  ] \e[0m" || { echo -e "\e[1;31m                false \e[0m";exit; }
echo -e "\n\e[1;35m=======================修改sshd_config配置文件=============================\e[0m"

echo -e "\n\e[1;35m修改sshd_config配置文件\e[0m"

sed -i '/PasswordAuthentication/c\PasswordAuthentication yes' /etc/ssh/sshd_config
sed -i '/X11Forwarding/c\X11Forwarding yes' /etc/ssh/sshd_config
sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

cp -arp /usr/local/openssh/bin/* /usr/bin/
service sshd restart

[ $? -eq 0 ] && echo -e "\e[1;35m                                                           [  OK  ] \e[0m" || { echo -e "\e[1;31m                false \e[0m";exit; }

echo -e "\n\e[1;35m配置开机项\e[0m"

chkconfig --add sshd
chkconfig --level 2345 sshd on
chkconfig --list


echo -e "\e[1;35m=========================更新后openssh版本=================================\e[0m"

ssh -V
}

set_et(){
   echo "GoodBye!"
    exit
}



while :;do
    echo -e "\E[$[RANDOM%7+31];1m"
    cat << EOF




************************************************************
************************************************************
************************************************************
**********                                        ********** 
**********                升级                    **********    
**********                                        **********
**********                                        **********
**********           1  安装telnet                **********
**********           2. 升级openssl               **********
**********           3. 升级openssh               **********
**********                                        **********
**********           0.退出                       ********** 
**********                                        **********
************************************************************
************************************************************
************************************************************


EOF

echo -e "\E[0m"
read -p "$(echo -e '\e[1;36m请输入序号: \e[0m')" Menu

case $Menu in

1)  telnet_install
    ;;

2)  update_openssl
    ;;

3)  update_openssh
    ;;

0)  set_et
    ;;

esac
done


