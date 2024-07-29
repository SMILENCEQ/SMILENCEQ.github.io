#!/bin/bash
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
if [ $? -eq 0 ];then
    echo ""
else
cat >>/etc/securetty<<EOF
pts/0 
pts/1
EOF
fi
echo -e "\e[1;35m手动测试telnet连接是否正常\e[0m"
}




update_sshssl(){
local ZLIBV=1.3.1
local OPENSSHV=9.7p1
local version=1.1.1w
local OSVERSION=`awk '{print $4}' /etc/redhat-release`

echo -e "\e[1;35m========================================================================\e[0m"
echo -e "\e[1;35m现在已安装的版本\e[0m"
openssl version
ssh -V
echo -e "\n\e[1;35m本次升级的版本是openssl-${version}\e[0m"
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
if [ -e "openssl-${version}.tar.gz" ];then
    echo -e "\e[1;35mopenssl文件存在\e[0m"
else
    echo -e "\e[1;33mopenssl文件不存在\e[0m"
    exit
fi

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


tar zxf /root/openssl-${version}.tar.gz
if [ -e openssl-${version} ];then
    echo -e "\e[1;35mopenssl解压成功\e[0m\n"
else
    echo -e "\e[1;35mopenssl解压失败\e[0m"
    exit
fi


echo -e "\e[1;35m===========================编译openssl==================================\e[0m"
cd /root/openssl-${version}

./config --prefix=/usr/local/openssl -d shared
make
#执行失败的话执行make clean清除make信息
#[ $? -eq 0 ] || make clean
sleep 1
make install


echo -e "\e[1;35m============================备份旧文件===================================\e[0m"
#备份旧的
mv  /usr/bin/openssl /usr/bin/openssl.bak  
echo -e "\e[1;35m=========================对新的创建软连接================================\e[0m"
#对新的创建软连接
ln -sf /usr/local/openssl/bin/openssl /usr/bin/openssl  
echo -e "\e[1;35m==============================验证======================================\e[0m"
#将 openssl 的 lib 库写进配置中，并使配置生效
#echo "/usr/local/openssl/lib64/" >> /etc/ld.so.conf
echo "/usr/local/openssl/lib" >> /etc/ld.so.conf
#验证：ldconfig -v|grep ssl //确定链接库
ldconfig -v

[ $? -eq 0 ] && echo -e "\e[1;35m                                                            [  OK  ] \e[0m" || { echo -e "\e[1;31m                false \e[0m";exit; }


#出现报错libssl.so.1.1。。。缺少依赖库
#ln -s /usr/local/lib/libcrypto.so.1.1 /usr/lib64/libcrypto.so.1.1
#ln -s /usr/local/lib/libssl.so.1.1 /usr/lib64/libssl.so.1.1

#echo "/usr/local/lib64" >> /etc/ld.so.conf
#ldconfig -v | grep ssl


#查看版本 是否安装成功
echo -e "\e[1;35m========================升级后openssl版本================================\e[0m"

openssl version



sleep 3


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
./configure --prefix=/usr/local/openssh --with-ssl-dir=/usr/local/openssl --with-zlib=/usr/local/zlib --with-pam --without-openssl-header-check
 make && make install

[ $? -eq 0 ] && echo -e "\e[1;35m                                                           [  OK  ] \e[0m" || { echo -e "\e[1;31m                false \e[0m";exit; }
fi

echo -e "\e[1;35m======================备份旧文件，迁入新文件==============================\e[0m"                  
[ -d /data/opensshbak ] || mkdir -p /data/opensshbak/

mv /etc/ssh/sshd_config /data/opensshbak/sshd_config.bak
cp /usr/local/openssh/etc/sshd_config /etc/ssh/sshd_config

mv /usr/sbin/sshd /data/opensshbak/sshd.bak
cp /usr/local/openssh/sbin/sshd /usr/sbin/sshd

mv /usr/bin/ssh /data/opensshbak/ssh.bak
cp /usr/local/openssh/bin/ssh /usr/bin/ssh

mv /usr/bin/ssh-keygen /data/opensshbak/ssh-keygen.bak
cp /usr/local/openssh/bin/ssh-keygen /usr/bin/ssh-keygen

mv /etc/ssh/ssh_host_ecdsa_key.pub /data/opensshbak/ssh_host_ecdsa_key.pub.bak
cp /usr/local/openssh/etc/ssh_host_ecdsa_key.pub /etc/ssh/ssh_host_ecdsa_key.pub


for  i   in  $(rpm  -qa  |grep  openssh);do  rpm  -e  $i  --nodeps ;done


mv /etc/ssh/sshd_config.rpmsave /etc/ssh/sshd_config




cp /root/openssh-${OPENSSHV}/contrib/redhat/sshd.init /etc/init.d/sshd
[ $? -eq 0 ] && echo "" || echo "/etc/init.d/sshd文件拷贝失败"
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
**********           2. 升级openssl,openssh       **********
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

2)  update_sshssl
    ;;

0)  set_et
    ;;

esac
done


