#!/bin/bash
echo -e "\e[1;35m======================================================================================================================================\e[0m"
echo -e "\e[1;35m一键初始化\e[0m"
echo -e "\e[1;35m支持openEuler2203，centos7.9，rocky8.5，kylinV10\e[0m"
echo -e "\e[1;35m初始化内容:更新yum源，安装软件，关闭防火墙，关闭selinux，优化limits，添加别名,修改主机名颜色,历史记录增加条数和时间显示等\e[0m"
echo -e "\e[1;35m======================================================================================================================================\e[0m"



reset(){


# 加载系统信息
#. /etc/os-release



if ! ping -c 5 114.114.114.114 > /dev/null && ! ping -c 5 8.8.8.8 > /dev/null && ! ping -c 5 www.baidu.com > /dev/null; then
    echo -e "\e[1;31m网络不通，将跳过相关网络依赖步骤。\e[0m"
    NETWORK_OK=false
else
    echo -e "\e[1;32m网络正常\e[0m"
    NETWORK_OK=true
fi

# 系统检测
#if [ "$ID" = 'centos' ]; then
#    echo -e "\e[1;35m检测系统为 CentOS\e[0m"
#    SYSTEM_OK=true
#else
#    echo -e "\e[1;31m当前系统不是 CentOS，将跳过相关系统依赖步骤。\e[0m"
#    SYSTEM_OK=false
#fi


# 检测系统版本
if [ -f /etc/os-release ]; then
    . /etc/os-release
    SYSTEM_NAME=$ID
    VERSION_ID=${VERSION_ID:-unknown}
elif [ -f /etc/redhat-release ]; then
    SYSTEM_NAME="centos"
    if grep -q "release 6" /etc/redhat-release; then
        VERSION_ID="6"
    elif grep -q "release 7" /etc/redhat-release; then
        VERSION_ID="7"
    else
        VERSION_ID="无法判断操作系统版本"
    fi
else
    SYSTEM_NAME="无法判断操作系统名称"
    VERSION_ID="无法判断操作系统版本"
fi

echo -e "\e[1;35m检测到系统为：$SYSTEM_NAME $VERSION_ID\e[0m"









#yum groupinstall "Development Tools" -y



# 备份并更换 YUM 源
if $NETWORK_OK && [ "$SYSTEM_NAME" = "centos" ] && [ "$VERSION_ID" = "7" ]; then
    echo -e "\n\e[1;35m======================================================================================================================================\e[0m"
    echo -e "\e[1;35mYUM源检测\e[0m"
    echo -e "\e[1;35m========================================================================================================================================\e[0m"
    



    [ ! -d /data/bak ] && { mkdir -p /data/bak; echo "目录 /data/bak 已创建。"; } || echo "目录 /data/bak 已存在。"

#判断文件夹是否有文件
    if [ "$(ls -A /etc/yum.repos.d/ 2>/dev/null)" ]; then
        echo -e "\e[1;35m检测到旧的 YUM 源文件，备份到 /data/bak。\e[0m"
        mv /etc/yum.repos.d/*  /data/bak || { echo "备份失败！"; exit 1; }
    else
        echo -e "\e[1;33m未检测到旧的 YUM 源文件。\e[0m"
    fi
    cat > /etc/yum.repos.d/base.repo <<'EOF'
[base]
name=CentOS
baseurl=https://mirror.tuna.tsinghua.edu.cn/centos/\$releasever/os/\$basearch/
        https://mirrors.huaweicloud.com/centos/\$releasever/os/\$basearch/
        https://mirrors.cloud.tencent.com/centos/\$releasever/os/\$basearch/
        https://mirrors.aliyun.com/centos/\$releasever/os/\$basearch/
gpgcheck=0

[extras]
name=extras
baseurl=https://mirror.tuna.tsinghua.edu.cn/centos/\$releasever/extras/\$basearch
        https://mirrors.huaweicloud.com/centos/\$releasever/extras/\$basearch
        https://mirrors.cloud.tencent.com/centos/\$releasever/extras/\$basearch
        https://mirrors.aliyun.com/centos/\$releasever/extras/\$basearch
       
gpgcheck=0
enabled=1


[epel]
name=EPEL
baseurl=https://mirror.tuna.tsinghua.edu.cn/epel/\$releasever/\$basearch
        https://mirrors.cloud.tencent.com/epel/\$releasever/\$basearch/
        https://mirrors.huaweicloud.com/epel/\$releasever/\$basearch 
        https://mirrors.cloud.tencent.com/epel/\$releasever/\$basearch
        http://mirrors.aliyun.com/epel/\$releasever/\$basearch
gpgcheck=0
enabled=1
EOF


    cat > /etc/yum.repos.d/epel.repo <<'EOF'
[epel]
name=epel
baseurl=https://mirrors.aliyun.com/epel/\$releasever/x86_64/
        https://mirrors.tuna.tsinghua.edu.cn/epel/7/x86_64/
        https://mirrors.ustc.edu.cn/epel/7/x86_64/
gpgcheck=0
EOF





    echo -e "\e[1;35mYUM 源已成功更换。\e[0m"
else
    echo -e "\e[1;33m当前系统不是 CentOS 7 或网络不通，跳过 YUM 源更换。\e[0m"
fi





if $NETWORK_OK; then

echo -e "\n\e[1;35m======================================================================================================================================\e[0m"
echo -e "\e[1;35m安装软件\e[0m"
echo -e "\n\e[1;35m======================================================================================================================================\e[0m"

yum clean all
yum makecache

software=("lrzsz"
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
        "sysstat"
        "python"
        "ntpdate"
        "pciutils-libs"
        "pciutils"
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
        if rpm -q  $i &> /dev/null;then
            echo -e "$i\t\e[1;32m已安装\e[0m" 
        else 
            if yum -y install $i &> /dev/null; then 
                echo -e "$i\t\e[1;35m安装成功\e[0m"
            else
                echo -e "$i\t\e[1;31m安装失败\e[0m"
            fi
        fi

    done

else
    echo -e "\e[1;31m"网络不通,不进行linux工具安装"\e[0m";
    
fi




#yum -y install vim lrzsz tar.x86_64 net-tools.x86_64 telnet ftp bridge-utils.x86_64 libtalloc libtalloc-devel psmisc libpcap libpcap-devel tcpdump

sleep 2
echo -e "\n\e[1;35m======================================================================================================================================\e[0m"
echo -e "\e[1;35m关闭firewalld\e[0m"
echo -e "\n\e[1;35m======================================================================================================================================\e[0m"
Firewalldstatus=`systemctl status firewalld | grep -o active`
if [[ ${Firewalldstatus} == "acticve" ]];then
    systemctl disable --now firewalld
    [ $? -eq 0 ] && echo -e "\e[1;35mfirewalld关闭成功\e[0m"|| echo -e "\e[1;31m firewalld关闭失败 \e[0m"
else
    echo -e "\e[1;35mfirewalld已经是关闭状态\e[0m"
fi
sleep 2


echo -e "\n\e[1;35m======================================================================================================================================\e[0m"
echo -e "\e[1;35m关闭openEuler的systemd-coredump.socket\e[0m"
echo -e "\e[1;35m========================================================================================================================================\e[0m"

if [ $ID = 'openEuler' ];then
    systemctl disable --now  systemd-coredump.socket
else
    echo -e "\e[1;33m不是openEuler,忽略\e[0m"
fi




echo -e "\n\e[1;35m======================================================================================================================================\e[0m"
echo -e "\e[1;35m添加别名\e[0m"
echo -e "\e[1;35m========================================================================================================================================\e[0m"

echo -e "\n\e[1;35m添加的别名有：cdnet='cd /etc/sysconfig/network-scripts/'，vi='vim'\e[0m"

if $NETWORK_OK; then
cat >>~/.bashrc <<EOF
alias cdnet='cd /etc/sysconfig/network-scripts/'
alias vi='vim'
EOF

[ $? -eq 0 ] && echo -e "\e[1;35m                                                            [  OK  ] \e[0m" || echo -e "\e[1;31m                false \e[0m"

else
    echo -e "\e[1;35m网络不通不修改别名\e[0m"
    
fi


sleep 2

echo -e "\n\e[1;35m======================================================================================================================================\e[0m"
echo -e "\e[1;35m关闭SELINUX\e[0m"
echo -e "\e[1;35m========================================================================================================================================\e[0m"

SELINUXstatus=`getenforce`
if [[ ${SELINUXstatus} == "Enforcing" ]];then
    sed -i 's/SELINUX=enforcing/SELINUX=disabled/'    /etc/selinux/config
    [ $? -eq 0 ] && echo -e "\e[1;35mselinux关闭成功\e[0m" || echo -e "\e[1;35mselinux关闭失败\e[0m"
else
    echo -e "\e[1;35mselinux已经是关闭状态\e[0m"
fi
sleep 2

echo -e "\n\e[1;35m======================================================================================================================================\e[0m"
echo -e "\e[1;35m优化limits\e[0m"
echo -e "\e[1;35m========================================================================================================================================\e[0m"


cat >> /etc/security/limits.conf << EOF
* soft nofile 65535
* hard nofile 65535
* soft noproc 65535
* hard noproc 65535
EOF

#sed -i '/fs.file-max = /c\fs.file-max = 6553600' /etc/sysctl.conf
echo "fs.file-max = 6553600" >> /etc/sysctl.conf
sysctl -p


# Systemd  
# cd /etc/systemd/
# grep -rn -F "DefaultLimitNOFILE"
#sudo sed -i '/DefaultLimitNOFILE/c DefaultLimitNOFILE=65535' /etc/systemd/*.conf
#sudo systemctl daemon-reexec



[ $? -eq 0 ] && echo -e "\e[1;35m                                                            [  OK  ] \e[0m" || echo -e "\e[1;31m                false \e[0m"
sleep 2


echo -e "\n\e[1;35m======================================================================================================================================\e[0m"
echo -e "\e[1;35m其他修改\e[0m"
echo -e "\e[1;35m========================================================================================================================================\e[0m"



echo -e "\n\e[1;32m主机名颜色\e[0m"
echo  "PS1='\[\e[1;34m\][\[\e[$[RANDOM%7+31]m\]\u\[\e[$[RANDOM%7+31]m\]@\[\e[$[RANDOM%7+31]m\]\h\[\e[$[RANDOM%7+31]m\] \W\[\e[34m\]]\\$\[\e[0m\]'" >> /etc/bashrc
#echo export HISTTIMEFORMAT=\"%Y-%m-%d %H:%M:%S  \" >> /etc/profile
echo -e "\n\e[1;35m======================================================================================================================================\e[0m"
echo -e "\n\e[1;32mhistory命令功能修改\e[0m"
#echo  "export HISTTIMEFORMAT=\"%Y-%m-%d %H:%M:%S \"" >> /etc/bashrc
#source ~/.bashrc
#sed -i '/HISTSIZE= /c\HISTSIZE=10000' /etc/profile
#sed -i '/HISTSIZE=/c\HISTSIZE=10000' /etc/profile
sed -i 's/^HISTSIZE=.*/HISTSIZE=100000/' /etc/profile
#source /etc/profile
#echo  "shopt -s histappend" >> /etc/profile

cat >> ~/.bashrc <<'EOF'
# 立即将每条命令追加到历史文件
PROMPT_COMMAND='history -a'
# 合并来自其他会话的历史记录
shopt -s histappend
history -r
export HISTTIMEFORMAT="%F %T "
EOF




source /etc/profile
source /etc/bashrc
[ $? -eq 0 ] && echo -e "\e[1;35m                                                            [  OK  ] \e[0m" || echo -e "\e[1;31m                false \e[0m"

#echo -e "\n\e[1;35m=============================================================修改主机名===============================================================\e[0m"
#read -p "输入想要修改的主机名:" HOSTNAME

#hostnamectl set-hostname $HOSTNAME






echo -e "\n\e[1;35m======================================================================================================================================\e[0m"
echo -e "\n\e[1;32m时间同步\e[0m"
echo -e "\n\e[1;35m======================================================================================================================================\e[0m"

ntpdate ntp.aliyun.com

echo -e "\n\e[1;35m======================================================================================================================================\e[0m"
echo -e "\n\e[1;32m硬件配置信息\e[0m"
echo -e "\n\e[1;35m======================================================================================================================================\e[0m"
# 查看物理 CPU 数量
PhysicalId=`grep "physical id" /proc/cpuinfo | sort -u | wc -l`

# 查看核心数（每个物理 CPU）
CoreId=`grep "core id" /proc/cpuinfo | sort -u | wc -l`

# 查看总核心数（所有物理 CPU 的核心数）
Processor=`grep "processor" /proc/cpuinfo | wc -l`

# 查看线程数（逻辑处理器数）
CpuCores=`grep "cpu cores" /proc/cpuinfo | uniq`

local INFO=`cat /proc/cpuinfo  | grep name | cut -d: -f2 |uniq -c | tr -s ' '` 
local MEM=`free -h | head -n2 |tail -n1 | awk '{print $2}'`
#DISK=${lsblk /dev/sda | grep "^sda" | tr -s " " | cut -d " " -f4}
local DISK=`df -h | grep root | awk '{print $ 2}'`
local SYSTEM=`uname -m`
echo -e "\n\e[1;33mcpu型号 系统架构:${INFO},${SYSTEM}\e[0m"
echo -e "\n\e[1;33m物理 CPU 数量:${PhysicalId}\e[0m"
echo -e "\n\e[1;33m核心数（每个物理 CPU）:${Processor}\e[0m"
echo -e "\n\e[1;33m线程数（逻辑处理器数）:${CpuCores}\e[0m"
echo -e "\n\e[1;33m内存总大小:${MEM}\e[0m"
echo -e "\n\e[1;33m硬盘总大小:${DISK}\e[0m"

echo -e "\n\e[1;32m重启生效配置\e[0m"
echo -e "\n\e[1;35m======================================================================================================================================\e[0m"
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