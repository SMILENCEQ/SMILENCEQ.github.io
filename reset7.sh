#!/bin/bash
echo -e "\e[1;35m======================================================================================================================================\e[0m"
echo -e "\e[1;35m一键初始化\e[0m"
echo -e "\e[1;35m支持openEuler2203，centos7.9，rocky8.5，kylinV10\e[0m"
echo -e "\e[1;35m初始化内容:更新yum源，安装软件，关闭防火墙，关闭selinux，优化limits，添加别名,修改主机名颜色,历史记录增加条数和时间显示等\e[0m"
echo -e "\e[1;35m======================================================================================================================================\e[0m"



reset(){
#echo -e "\n\e[1;35m===========================================================更新YUM源==============================================================\e[0m"
#yum clean all 
#yum makecache
echo -e "\n\e[1;32m安装软件\e[0m"
echo -e "\e[1;35m======================================================================================================================================\e[0m"
software=("lrzsz"
        "sar"
        "vim"
        "tree"
        "wget"
        "tcpdump"
        "psmisc"
        "rsync"
        "mlocate"
        "bzip2"
        "zip"
        "unzip"
        "lsof"
        "telnet"
        "libpcap"
        "tar"
        "ntpdate"
        "libtalloc"
        "net-tools"
        "httpd-tools"
        "bash-completion"
        "libpcap-devel"
        "libtalloc-devel"
        "bridge-utils.x86_64"
        )
for i in ${software[@]}
do
rpm -q  $i &> /dev/null && echo -e "$i\t\e[1;32m已安装\e[0m" || { yum -y install $i &> /dev/null ; echo -e "$i\t\e[1;35m安装成功\e[0m" ; }

done




sleep 2

echo -e "\n\e[1;32m关闭firewalld\e[0m"
echo -e "\e[1;35m======================================================================================================================================\e[0m"
systemctl disable --now firewalld

[ $? -eq 0 ] && echo -e "\e[1;35m                                                            [  OK  ] \e[0m" || echo -e "\e[1;31m                false \e[0m"
sleep 2



echo -e "\n\e[1;32m添加别名\e[0m"
echo -e "\e[1;35m======================================================================================================================================\e[0m"
echo -e "\n\e[1;35m添加的别名有：cdnet='cd /etc/sysconfig/network-scripts/'，vi='vim'\e[0m"


cat >>~/.bashrc <<EOF
alias cdnet='cd /etc/sysconfig/network-scripts/'
alias vi='vim'
EOF

[ $? -eq 0 ] && echo -e "\e[1;35m                                                            [  OK  ] \e[0m" || echo -e "\e[1;31m                false \e[0m"

sleep 2

echo -e "\n\e[1;32m关闭SELINUX\e[0m"
echo -e "\e[1;35m======================================================================================================================================\e[0m"

sed -i 's/SELINUX=enforcing/SELINUX=disabled/'    /etc/selinux/config

[ $? -eq 0 ] && echo -e "\e[1;35m                                                            [  OK  ] \e[0m" || echo -e "\e[1;31m                false \e[0m"

sleep 2

echo -e "\n\e[1;32m优化limits\e[0m"
echo -e "\e[1;35m======================================================================================================================================\e[0m"

cat >> /etc/security/limits.conf << EOF
* soft nofile 65535
* hard nofile 65535
* soft noproc 65535
* hard noproc 65535
EOF

#sed -i '/fs.file-max = /c\fs.file-max = 6553600' /etc/sysctl.conf
echo "fs.file-max = 1000000" >> /etc/sysctl.conf
sysctl -p


[ $? -eq 0 ] && echo -e "\e[1;35m                                                            [  OK  ] \e[0m" || echo -e "\e[1;31m                false \e[0m"
sleep 2
echo -e "\n\e[1;32m其他修改\e[0m"
echo -e "\e[1;35m======================================================================================================================================\e[0m"
echo  "PS1='\[\e[1;34m\][\[\e[$[RANDOM%7+31]m\]\u\[\e[$[RANDOM%7+31]m\]@\[\e[$[RANDOM%7+31]m\]\h\[\e[$[RANDOM%7+31]m\] \W\[\e[34m\]]\\$\[\e[0m\]'" >> /etc/bashrc

echo  "export HISTTIMEFORMAT=\"%Y-%m-%d %H:%M:%S \"" >> /etc/bashrc
#source ~/.bashrc
#sed -i '/HISTSIZE=/c\HISTSIZE=10000' /etc/profile
sed -i 's/^HISTSIZE=.*/HISTSIZE=100000/' /etc/profile
#source /etc/profile
echo  "shopt -s histappend" >> /etc/profile

#sed -i '/HISTSIZE= /c\HISTSIZE=10000' /etc/profile
#echo export HISTTIMEFORMAT=\"%Y-%m-%d %H:%M:%S  \" >> /etc/profile
source /etc/profile
source /etc/bashrc
[ $? -eq 0 ] && echo -e "\e[1;35m                                                            [  OK  ] \e[0m" || echo -e "\e[1;31m                false \e[0m"

#echo -e "\n\e[1;35m=============================================================修改主机名===============================================================\e[0m"
#read -p "输入想要修改的主机名:" HOSTNAME

#hostnamectl set-hostname $HOSTNAME







echo -e "\n\e[1;32m时间同步\e[0m"
echo -e "\e[1;35m======================================================================================================================================\e[0m"

ntpdate ntp.aliyun.com


echo -e "\n\e[1;32m硬件配置信息\e[0m"
echo -e "\e[1;35m======================================================================================================================================\e[0m"
#CPU=`grep -c processor /proc/cpuinfo`

local INFO=`cat /proc/cpuinfo  | grep name | cut -d: -f2 |uniq -c | tr -s ' '` 
local MEM=`free -h | head -n2 |tail -n1 | awk '{print $2}'`
#local DISK=`lsblk /dev/sda | grep "^sda" | tr -s " " | cut -d " " -f4`
local DISK=`df -h | grep root | awk '{print $ 2}'`
local SYSTEM=`uname -m`
echo -e "\n\e[1;35m逻辑cpu个数 cpu型号 系统架构:$INFO $SYSTEM\e[0m"
echo -e "\n\e[1;35m内存总大小:$MEM\e[0m"
echo -e "\n\e[1;35m硬盘总大小:$DISK\e[0m"
sleep 2
echo -e "\n\e[1;32m重启生效配置\e[0m"
echo -e "\e[1;35m======================================================================================================================================\e[0m"
echo -e "\n\e[1;32m五秒后重启系统\e[0m"
for i in {5..1}
do
    echo -n "${i} "
    echo -ne "\r"
   sleep 1
done
init 6
}
reset