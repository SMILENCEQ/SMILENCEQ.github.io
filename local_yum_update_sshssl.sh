#!/bin/bash
local_yum_update_sshssl=v1.0
echo  "==============================================================================================================="
echo -e "\e[1;$[RANDOM%7+31]m

 ██████╗███████╗███╗   ██╗████████╗ ██████╗ ███████╗
██╔════╝██╔════╝████╗  ██║╚══██╔══╝██╔═══██╗██╔════╝
██║     █████╗  ██╔██╗ ██║   ██║   ██║   ██║███████╗
██║     ██╔══╝  ██║╚██╗██║   ██║   ██║   ██║╚════██║
╚██████╗███████╗██║ ╚████║   ██║   ╚██████╔╝███████║
 ╚═════╝╚══════╝╚═╝  ╚═══╝   ╚═╝    ╚═════╝ ╚══════╝
    \e[0m"
echo -e "--- update-openssh-openssl-centos - openssh-openssl升级脚本"
echo -e "--- version: $local_yum_update_sshssl"
echo -e "--- https://github.com/SMILENCEQ/SMILENCEQ.github.io"
echo "==============================================================================================================="
. /etc/os-release
OpensslVersion=3.4.0
SudoVersion=1.9.16p2
ZlibVersion=1.3.1
OpensslVersion1=`openssl version | awk  '{print $2}'`
OpensshVersion=9.9p1
Date=`date +%Y%m%d%H%M%S`
TARGET_HOST=`hostname -I`
TARGET_PORT="22"

echo -e "\e[1;35m===============================================================================================================\e[0m"
echo -e "\e[1;35m现在已安装的版本\e[0m"
ssh -V
echo -e "\e[1;32m仅支持centos7\e[0m"
echo -e "\e[1;35m本次安装的版本是sudo-${SudoVersion}\e[0m"
echo -e "\e[1;35m本次安装的版本是openssl-${OpensslVersion}\e[0m"
echo -e "\e[1;35m本次升级的安装版本openssh-${OpensshVersion}\e[0m"
echo -e "\e[1;35m本次升级的安装版本zlib-${ZlibVersion}\e[0m"
echo -e "\e[1;35m支持在线下载,如果已经下载好安装包了请将对应版本的压缩包放在root目录下\e[0m"
echo -e "\e[1;33m适用于centos7.9从openssl1.*版本升级到openssl3.4.0,openssh9.9p1\e[0m"
echo -e "\e[1;35m===============================================================================================================\e[0m"
echo -e "\e[1;35m不想安装请在五秒内终止脚本\e[0m\n"

for i in {5..1}
do
    echo -n "${i} "
    echo -ne "\r"
    sleep 1
done
check_system(){

echo -e "\e[1;35m===================================================升级前系统检查===================================================\e[0m"



for i in {5..1}
do
    echo -n "${i} "
    echo -ne "\r"
    sleep 1
done


if [ $ID = "centos" ]; then
    echo -e "\e[1;32m当前系统:$NAME，版本号：$VERSION_ID 脚本支持。\e[0m"
else
    echo -e "\e[1;31m当前系统:$NAME，版本号：$VERSION_ID 脚本不支持。\e[0m"
    exit
fi

if [[ ${OpensslVersion}  = 3.4.0 ]];then
    echo -e "\e[1;32m当前版本此脚本支持升级\e[0m"
else
    echo -e "\e[1;33m此脚本只支持升级openssl-${OpensslVersion}版本,其他版本不支持\e[0m"
    exit
fi

if [ -e "/root/$0" ];then
    echo -e "ok"
else
    echo -e "\e[1;33m请将脚本文件放在root目录下执行\e[0m"
    exit
fi


echo -e "\e[1;35m===================================================升级前文件检查===================================================\e[0m"

declare -A files=(
    ["/root/openssl-${OpensslVersion}.tar.gz"]="https://github.com/openssl/openssl/releases/download/openssl-${OpensslVersion}/openssl-${OpensslVersion}.tar.gz"
    ["/root/openssh-${OpensshVersion}.tar.gz"]="https://mirrors.aliyun.com/pub/OpenBSD/OpenSSH/portable/openssh-${OpensshVersion}.tar.gz"
    ["/root/sudo-${SudoVersion}.tar.gz"]="https://www.sudo.ws/dist/sudo-${SudoVersion}.tar.gz"
    ["/root/zlib-${ZlibVersion}.tar.gz"]="https://www.zlib.net/fossils/zlib-${ZlibVersion}.tar.gz"
)
# 检查并下载文件
for file in "${!files[@]}"; do
    if [ ! -e "$file" ]; then
        echo -e "\e[1;33m文件 $file 不存在，执行下载。\e[0m"
        wget -O "$file" "${files[$file]}"
        if [ $? -ne 0 ]; then
            echo -e "\e[1;31m文件 $file 下载失败，请手动去下载放置在 /root 目录。\e[0m"
            exit 1
        fi
    fi
done

echo -e "\e[1;32m所有必要文件均已存在。\e[0m"
}






set_local_yum(){
echo -e "\e[1;35m===================================================开始配置本地YUM===================================================\e[0m"
# 定义ISO查找和挂载函数
find_and_mount_iso(){
    echo -e "\n\e[1;35m查找可用iso文件....\e[0m"
    for path in "/dev" "/tmp" "/opt" "/data"; do
        iso_file=$(find "$path" -maxdepth 1 -type f -name "*.iso" 2>/dev/null | head -n 1)
        if [ -n "$iso_file" ]; then
            echo -e "\e[1;32m找到ISO文件: $iso_file\e[0m"
            echo -e "\e[1;32m挂载 "$iso_file" 到 /mnt/cdrom\e[0m"
            if sudo mount -o loop "$iso_file" /mnt/cdrom 2>/dev/null; then
                echo -e "\e[1;32mISO挂载成功\e[0m"
                echo "$(readlink -f "$iso_file")  /mnt/iso  iso9660  loop,ro,auto  0  0" | sudo tee -a /etc/fstab
                return 0
            else
                echo -e "\e[1;31m挂载失败: $iso_file\e[0m"
            fi
        fi
    done
        echo -e "\e[1;33m没有找到可用iso文件,请手动上传iso文件到"/dev" "/tmp" "/opt"目录\e[0m"
        exit
}

# 检查并挂载 /dev/sr0
[ -d /mnt/cdrom ] || mkdir -p /mnt/cdrom
if [ -b /dev/sr0 ];then
    echo -e "\n\e[1;35m检测到光驱设备:/dev/sr0\e[0m"
    echo -e "\e[1;35m挂载/dev/sr0到/mnt/cdrom\e[0m"
    if sudo mount /dev/sr0 /mnt/cdrom;then
        echo -e "\e[1;32m光驱挂载成功\e[0m"
        echo  "/dev/sr0    /mnt/cdrom    iso9660    defaults    0 0"
    else
        echo -e "\n\e[1;31m光驱挂载失败，尝试查找ISO文件...\e[0m"
        find_and_mount_iso || exit
    fi
else
    echo -e "\n\e[1;33m没有检测到光驱设备:/dev/sr0\e[0m"
    find_and_mount_iso || exit
fi




# 验证挂载是否成功
if ! mountpoint -q /mnt/cdrom; then
    echo -e "\n\e[1;31m严重错误：最终挂载验证失败\e[0m"
    exit 1
fi

echo -e "\n\e[1;32m挂载验证通过\e[0m"
echo -e "\e[1;35m挂载内容:\e[0m"
ls -l /mnt/cdrom | head -n 10




#判断文件夹是否有文件
[ ! -d /data/bak ] && mkdir -p /data/bak


if [ "`ls -A /etc/yum.repos.d/`" != "" ];then
    mv /etc/yum.repos.d/*  /data/bak/
else
    echo " \n"
fi
cat > /etc/yum.repos.d/base.repo <<'EOF'
[base]
name=Local YUM Repository
baseurl=file:///mnt/cdrom
enabled=1
gpgcheck=0
EOF




# 重建YUM缓存
echo -e "\n\e[1;35m重建YUM缓存...\e[0m"
yum clean all
yum makecache
yum repolist

}



update_sshssl7(){



echo -e "\e[1;35m===================================================升级前软件安装===================================================\e[0m"
software=(
    "tar"
    "gcc"
    "pam*"
    "make"
    "glibc"
    "telnet"
    "xinetd"
    "gcc-c++"
    "autoconf"
    "zlib-devel"
    "pcre-devel"
    "pam-devel"
    "perl-CPAN"
    "perl-IPC-Cmd"
    "telnet-server"
    "openssl-devel"
    )
for i in ${software[@]}
do
#rpm -q $i &> /dev/null && echo -e "$i\t\e[1;32m已安装\e[0m" || { yum -y install $i &> /dev/null; echo -e "$i\t\e[1;35m安装成功\e[0m" ; }
        if rpm -q  $i &> /dev/null;then
            echo -e "$i\t\e[1;32m已安装\e[0m" 
        else 
            if yum -y install $i &> /dev/null; then 
                echo -e "$i\t\e[1;35m安装成功\e[0m"
            else
                echo -e "$i\t\e[1;31m安装失败\e[0m"
                exit
            fi
        fi
done



echo -e "\e[1;35m================================================升级前telnet安装启动测试===================================================\e[0m"
systemctl enable --now  xinetd.service
systemctl enable --now  telnet.socket


cat >>/etc/securetty<<EOF
pts/0 
pts/1
pts/2 
pts/3
pts/4
pts/5
pts/6
pts/7
pts/8
pts/9
pts/10
EOF
# 捕获 telnet 输出
result=$(echo -e "\n" | telnet $TARGET_HOST $TARGET_PORT 2>/dev/null | grep "Connected")

if [[ -n "$result" ]]; then
    echo -e "\e[1;35mtelnet 测试成功：可以连接到 $TARGET_HOST:$TARGET_PORT\e[0m"
else
    echo -e "\e[1;31mtelnet 测试失败：无法连接到 $TARGET_HOST:$TARGET_PORT\e[0m"
    exit 1
fi


echo -e "\e[1;35m=================================================升级安装zlib==========================================================\e[0m"

for i in {5..1}
do
    echo -n "${i} "
    echo -ne "\r"
    sleep 1
done

echo -e "\e[1;35m===================================================编译zlib============================================================\e[0m"

#wget https://www.zlib.net/fossils/zlib-1.3.1.tar.gz
tar zxf /root/zlib-${ZlibVersion}.tar.gz 
cd /root/zlib-${ZlibVersion}
./configure --prefix=/usr/local/zlib
make -j$(nproc) && make install
ldconfig -v
/sbin/ldconfig

cd /root/
#wget https://github.com/openssl/openssl/releases/download/openssl-3.4.0/openssl-3.4.0.tar.gz
#yum install  -y gcc gcc-c++ glibc make





echo -e "\e[1;35m==============================================升级安装openssl版本======================================================\e[0m"

for i in {5..1}
do
    echo -n "${i} "
    echo -ne "\r"
    sleep 1
done

tar -zxvf /root/openssl-${OpensslVersion}.tar.gz
if [ -e /root/openssl-${OpensslVersion} ];then
    echo -e "\e[1;35mopenssl解压成功\e[0m"
else
    echo -e "\e[1;35mopenssl解压失败\e[0m"
    exit
fi
cd /root/openssl-${OpensslVersion}
./config --prefix=/usr/local/openssl --openssldir=/usr/local/openssl shared zlib


make -j$(nproc) && make install  || { echo -e "\e[1;31m编译或安装失败,执行make clean 重新编译\e[0m"; exit 1; }                                             

mv /usr/bin/openssl /usr/bin/openssl-${Current_Date}
ln -sf /usr/local/openssl/bin/openssl /usr/bin/openssl

echo "/usr/local/openssl/lib64" >> /etc/ld.so.conf.d/openssl.conf


echo 'export LD_LIBRARY_PATH=/usr/local/openssl/lib64:${LD_LIBRARY_PATH:-""}' >> /etc/profile
echo 'export PKG_CONFIG_PATH=/usr/local/openssl/lib64/pkgconfig:${PKG_CONFIG_PATH:-""}' >> /etc/profile


# 刷新库缓存
ldconfig
source /etc/profile

#查看版本 是否安装成功
echo -e "\e[1;35m==============================================升级后openssl版本========================================================\e[0m"
openssl version
PKG=`pkg-config --modversion openssl`

if [ "$PKG" != "$OpensslVersion" ]; then
    echo -e "\e[1;31m错误: OpenSSL 版本不匹配! 期望版本: $OpensslVersion, 实际版本: $OpensslVersion1\e[0m"
    exit 1  # 停止脚本执行
else
    echo -e "\e[1;32mOpenSSL 版本正确: $PKG\e[0m"
fi

for i in {5..1}
do
    echo -n "${i} "
    echo -ne "\r"
    sleep 1
done




echo -e "\e[1;35m==================================================升级安装sudo========================================================\e[0m"
for i in {5..1}
do
    echo -n "${i} "
    echo -ne "\r"
    sleep 1
done

cd /root/

#wget https://www.sudo.ws/dist/sudo-1.9.16p2.tar.gz
tar -xvf /root/sudo-${SudoVersion}.tar.gz -C /root/

cd /root/sudo-${SudoVersion}

CFLAGS="-I/usr/local/openssl/include" \
LDFLAGS="-L/usr/local/openssl/lib64" \
./configure --prefix=/usr/local/sudo \
            --with-openssl=/usr/local/openssl \
            --with-openssl-includes=/usr/local/openssl/include \
            --with-openssl-libs=/usr/local/openssl/lib64


# 检查是否出现 OpenSSL 警告
if grep -q "WARNING: OpenSSL dev libraries not found" configure.log; then
    echo -e "\e[1;31m编译失败,执行make clean 清理,请检查参数\e[0m"
    make clean
    exit 1
fi


make -j$(nproc) && make install

# 检查编译是否成功
if [ $? -eq 0 ]; then
    echo -e "\e[1;32m编译成功\e[0m"
else
    echo -e "\e[1;31m编译或安装失败,将make clean,请检查参数\e[0m"
    make clean
    exit 1
fi


mv /usr/bin/sudo /usr/bin/sudo-${Current_Date}
ln -s /usr/local/sudo/bin/sudo /usr/bin/sudo

#查看版本
echo -e "\e[1;35m==================================================升级后sudo版本========================================================\e[0m"
sudo --version



for i in {5..1}
do
    echo -n "${i} "
    echo -ne "\r"
    sleep 1
done





echo -e "\e[1;35m===================================================升级安装openssh======================================================\e[0m"
for i in {5..1}
do
    echo -n "${i} "
    echo -ne "\r"
    sleep 1
done
cd /root/
#wget https://mirrors.aliyun.com/pub/OpenBSD/OpenSSH/portable/openssh-9.9p1.tar.gz
tar zxf /root/openssh-${OpensshVersion}.tar.gz 
if [ -e /root/openssh-${OpensshVersion} ];then
    echo -e "\e[1;35mopenssh解压成功\e[0m"
else
    echo -e "\e[1;35mopenssh解压失败\e[0m"
    exit
fi






cd /root/openssh-${OpensshVersion}/
CFLAGS="-I/usr/local/openssl/include" \
LDFLAGS="-L/usr/local/openssl/lib64" \
./configure  --prefix=/usr/local/openssh --with-openssl-dir=/usr/local/openssl --with-zlib=/usr/local/zlib/ --with-ssl-engine



make -j$(nproc) && make install && echo -e "\e[1;35m编译完成\e[0m" || { echo -e "\e[1;31m编译或安装失败,执行make clean 重新编译\e[0m"; exit 1; }   

echo -e "\e[1;35m==============================================备份旧版本文件，更新新版本文件================================================\e[0m"                  
[ -d /data/opensshbak ] || mkdir -p /data/opensshbak/

mv /etc/ssh/sshd_config /data/opensshbak/sshd_config-${Current_Date}
cp /usr/local/openssh/etc/sshd_config /etc/ssh/sshd_config

mv /usr/sbin/sshd /data/opensshbak/sshd-${Current_Date}
cp /usr/local/openssh/sbin/sshd /usr/sbin/sshd

mv /usr/bin/ssh /data/opensshbak/ssh-${Current_Date}
cp /usr/local/openssh/bin/ssh /usr/bin/ssh

mv /usr/bin/ssh-keygen /data/opensshbak/ssh-keygen-${Current_Date}
cp /usr/local/openssh/bin/ssh-keygen /usr/bin/ssh-keygen

mv /etc/ssh/ssh_host_ecdsa_key.pub /data/opensshbak/ssh_host_ecdsa_key.pub-${Current_Date}
cp /usr/local/openssh/etc/ssh_host_ecdsa_key.pub /etc/ssh/ssh_host_ecdsa_key.pub


for  i   in  $(rpm  -qa  |grep  openssh);do  rpm  -e  $i  --nodeps ;done
mv /etc/ssh/sshd_config.rpmsave /etc/ssh/sshd_config


sudo cp  -a /root/openssh-9.9p1/contrib/redhat/sshd.init /etc/init.d/sshd
chmod u+x /etc/init.d/sshd

cp /etc/init.d/sshd /data/opensshbak/sshdnewbk-${Current_Date}
sed -i '/SSHD=/c\SSHD=\/usr\/local\/openssh\/sbin\/sshd'  /etc/init.d/sshd
sed -i '/\/usr\/bin\/ssh-keygen/c\         \/usr\/local\/openssh\/bin\/ssh-keygen -A'  /etc/init.d/sshd
sed -i '/ssh_host_rsa_key.pub/i\                \/sbin\/restorecon \/etc\/ssh\/ssh_host_key.pub'  /etc/init.d/sshd  
sed -i '/$SSHD $OPTIONS && success || failure/i\       \ OPTIONS="-f /etc/ssh/sshd_config"' /etc/rc.d/init.d/sshd




echo -e "\n\e[1;35m==============================================修改sshd_config配置文件=======================================================\e[0m"

sed -i '/PasswordAuthentication/c\PasswordAuthentication yes' /etc/ssh/sshd_config
sed -i '/X11Forwarding/c\X11Forwarding yes' /etc/ssh/sshd_config
sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

cp -arp /usr/local/openssh/bin/* /usr/bin/






#添加开机启动
chkconfig --add sshd
chkconfig --level 2345 sshd on
chkconfig --list
systemctl restart sshd
sleep 3
echo -e "\e[1;35m===================================================更新后openssh版本==========================================================\e[0m"

ssh -V
exec openssl version &>/dev/null



}


main() {
    check_system
    set_local_yum
    update_sshssl7
}

main "$@"
