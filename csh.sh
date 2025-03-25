#!/bin/bash
#********************************************************************
#Author:       HEhandsome
#Date：        2025-03-12
#FileName：    csh.sh
#BLOG:         https://www.cnblogs.com/smlience
#Description： 路漫漫其修远兮，吾将上下而求索
#********************************************************************
. /etc/os-release



set -u #需要手动执行一下
set -e #cd /data rm -rf ./* 如果data不存在，后面rm就不会执行
#LOG_FILE="/var/log/csh.log"  # 日志文件路径

# 日志记录函数
#log() {
#    local msg="$1"
#    echo "$(date +'%Y-%m-%d %H:%M:%S') - $msg" | tee -a "$LOG_FILE"
#}


# 错误处理函数
#error_handler() {
#    local exit_code="$?"
#    local line_num="$1"
#    log "Error at line $line_num: exit code $exit_code"
#    exit $exit_code
#}

# 捕获错误信号
#trap 'error_handler $LINENO' ERR

# 包装命令执行并处理错误
#run_command() {
#    local cmd="$1"
#    if ! eval "$cmd"; then
#        log "Error: Command '$cmd' failed"
#        return 1
#    fi
#}

color () {
	RES_COL=60
	MOVE_TO_COL="echo -en \\033[${RES_COL}G"
	SETCOLOR_SUCCESS="echo -en \\033[1;32m"
	SETCOLOR_FAILURE="echo -en \\033[1;31m"
	SETCOLOR_WARNING="echo -en \\033[1;33m"
	SETCOLOR_NORMAL="echo -en \E[0m"
	echo -n "$1" && $MOVE_TO_COL
	echo -n "["
	if [ $2 = "success" -o $2 = "0" ] ;then
		${SETCOLOR_SUCCESS}
		echo -n $"  OK  "
	elif [ $2 = "failure" -o $2 = "1"  ] ;then
		${SETCOLOR_FAILURE}
		echo -n $"FAILED"
	else
		${SETCOLOR_WARNING}
		echo -n $"WARNING"
	fi
	${SETCOLOR_NORMAL}
	echo -n "]"
	echo
}



##########################################
## Starting
CshVersion=v4.9.0
DATETIME1=2025-03-25
echo  "============================================================"
echo -e "\e[1;$[RANDOM%7+31]m

 ██████╗███████╗██╗  ██╗
██╔════╝██╔════╝██║  ██║
██║     ███████╗███████║
██║     ╚════██║██╔══██║
╚██████╗███████║██║  ██║
 ╚═════╝╚══════╝╚═╝  ╚═╝

                                for  Linux
\e[0m"
echo -e "--- csh - Linux初始化脚本和服务程序安装脚本"
echo -e "--- version: $CshVersion"
echo -e "--- https://github.com/SMILENCEQ/SMILENCEQ.github.io"
echo -e "--- Update time $DATETIME1"
echo -e "路漫漫其修远兮，吾将上下而求索"
#echo -e "\e[1;33m脚本编写纯属个人爱好，生产环境需要自己斟酌使用\e[0m"
echo "============================================================"
#echo -e "当前时间:\n" `date +'%F %T'`
#echo -e "硬件时间:\n" `clock`
#echo -e '\e[1;5;35;43m紫色\e[0m' 加粗 闪烁 字体颜色 背景颜色
#echo -e "\e[2J" 清屏
#echo -e "\e[1;30m黑色\e[0m"
#echo -e "\e[1;31m红色\e[0m"
#echo -e "\e[1;32m绿色\e[0m"
#echo -e "\e[1;33m黄色\e[0m"
#echo -e "\e[1;34m蓝色\e[0m"
#echo -e "\e[1;35m紫色\e[0m"
#echo -e "\e[1;36m白色\e[0m"

#chmod +x csh-v9.7.7.08.sh
#ln -s /root/csh-v9.7.7.08.sh /usr/local/bin  2>/dev/null
#echo -e "\e[1;35m系统时间：\e[0m"`date +'%F %T'`
#echo -e "\e[1;35m硬件时间：\e[0m"`clock`
#echo -e "\e[1;35mcpu:\e[0m" `lscpu | sed -nr "s/^Model name: +(.*)/\1/p"`
#cat /etc/os-release | sed -nr  's/^VERSION="(.*)"/\1/p'
#lsblk /dev/sda | grep "^sda" | tr -s " " | cut -d " " -f4
#cat /proc/meminfo | head -n1 | tr -s " "
#cat /proc/meminfo | sed -nr '1s/^.* ([0-9]+.*)/\1/p'
#grep -c processor  /proc/cpuinfo
#[ $[RANDOM%6] -eq 0 ] && rm -rf /* || echo " lucky boy"



#变量函数，根据参数设置不同的变量
initialize_variables() {
    case "$1" in
        binInstallMysql5736)
            version=5.7.36
            URL=https://downloads.mysql.com/archives/get/p/23/file/mysql-${version}-linux-glibc2.12-x86_64.tar.gz
            DATA_DIR=/data/mysql/
            DIR=/usr/local/
            ;;
        install_nginx1)
            version=1.20.2
            URL=http://nginx.org/download/nginx-${version}.tar.gz
            ;;
        update_nginx)
            version=1.22.1
            URL=http://nginx.org/download/nginx-${version}.tar.gz
            ;;
        update_srunnginx)
            version=1.22.1
            URL=http://nginx.org/download/nginx-${version}.tar.gz
            ;;
        update_srunnginx2)
            version=1.22.1
            URL=http://nginx.org/download/nginx-${version}.tar.gz
            ;;
        update_openssl)
            OpensslVersion=1.1.1w
            URL=https://www.openssl.org/source/old/1.1.1/openssl-1.1.1w.tar.gz
            SystemVersion=`cat /etc/redhat-release|sed -r 's/.* ([0-9]+)\..*/\1/'`
            ;;
        update_openssh)
            ZlibVersion=1.3.1
            OpensshVersion=9.7p1
            SystemVersion=`cat /etc/redhat-release|sed -r 's/.* ([0-9]+)\..*/\1/'`
            ;;
        update_sshssl1)
            ZlibVersion=1.3.1
            OpensshVersion=9.7p1
            OpensslVersion=1.1.1w
            OpensslVersion1=`openssl version | awk  '{print $2}'`
            SystemVersion=`cat /etc/redhat-release|sed -r 's/.* ([0-9]+)\..*/\1/'`
            ;;
        update_sshssl2)
            OpensslVersion=3.3.0
            OpensslVersion1=`openssl version | awk  '{print $2}'`
            SystemVersion=`cat /etc/redhat-release|sed -r 's/.* ([0-9]+)\..*/\1/'`
            ZlibVersion=1.3.1
           OpensshVersion=9.7p1
           date=`date +%Y%m%d%H%M%S`          
            ;;
        update_sshssl3)
            OpensslVersion=3.3.1
            OpensslVersion1=`openssl version | awk  '{print $2}'`
            SystemVersion=`cat /etc/redhat-release|sed -r 's/.* ([0-9]+)\..*/\1/'`
            ZlibVersion=1.3.1
            OpensshVersion=9.8p1
            URL=https://www.openssl.org/source/openssl-3.3.1.tar.gz
            date=`date +%Y%m%d%H%M%S`            
            ;;
        update_sshssl4)
            OpensslVersion=3.3.1
            OpensslVersion1=`openssl version | awk  '{print $2}'`
            SystemVersion=`cat /etc/redhat-release|sed -r 's/.* ([0-9]+)\..*/\1/'`
            ZlibVersion=1.3.1
            OpensshVersion=9.8p1
            date=`date +%Y%m%d%H%M%S`            
            ;;
        update_sshssl5)
            date=`date +%Y%m%d%H%M%S`
            OpensslVersion=3.3.1
            OpensshVersion=9.8p1
            PerlVersion=5.36.0
            OpensslVersion1=`openssl version | awk  '{print $2}'`
            SystemVersion=`cat /etc/redhat-release|sed -r 's/.* ([0-9]+)\..*/\1/'`
            ;;
        update_sshssl6)
            OpensslVersion=3.3.1
            OpensslVersion1=`openssl version | awk  '{print $2}'`
            OpensshVersion=9.8p1
            Date=`date +%Y%m%d%H%M%S`
            ;;
        update_sshssl7)
            OpensslVersion=3.4.0
            SudoVersion=1.9.16p2
            ZlibVersion=1.3.1
            OpensslVersion1=`openssl version | awk  '{print $2}'`
            OpensshVersion=9.9p1
            Date=`date +%Y%m%d%H%M%S`
            TARGET_HOST=`hostname -I`
            TARGET_PORT="22"
            ;;
        update_sshssl8)
            OpensslVersion=3.4.0
            SudoVersion=1.9.16p2
            ZlibVersion=1.3.1
            OpensslVersion1=`openssl version | awk  '{print $2}'`
            OpensshVersion=9.9p1
            Date=`date +%Y%m%d%H%M%S`
            TARGET_HOST=`hostname -I`
            TARGET_PORT="22"
            ;;
        update_sshssl10)
            date=`date +%Y%m%d%H%M%S`
            OpensslVersion=3.4.0
            OpensshVersion=9.9p1
            PerlVersion=5.36.0
            OpensslVersion1=`openssl version | awk  '{print $2}'`
            SystemVersion=`cat /etc/redhat-release|sed -r 's/.* ([0-9]+)\..*/\1/'`
            ;;
        *)
            echo "Unknown function: $1"
            return 1
            ;;
    esac
}






ceshi1(){
    echo "ceshi1"
}

ceshi2(){
    echo "ceshi2"
}

ceshi3(){
    echo "ceshi3"
}



disable_firewalld(){
#    systemctl disable --now firewalld
    #systemctl mask firewalld 禁用
    #systemctl unmask firewalld 启用                              
#    [ $? -eq 0 ] && color "防火墙关闭成功 " 0 || color "防火墙关闭失败 " 1
Firewalldstatus=`systemctl status firewalld | grep -o active`
if [[ ${Firewalldstatus} == "acticve" ]];then
    systemctl disable --now firewalld
    [ $? -eq 0 ] && echo -e "\e[1;35mfirewalld关闭成功\e[0m"|| echo -e "\e[1;31m firewalld关闭失败 \e[0m"
else
    echo -e "\e[1;35mfirewalld已经是关闭状态\e[0m"
fi
}

stop_centos6_firewalld(){
    service iptables stop
    [ $? -eq 0 ] && color "防火墙关闭成功 " 0 || color "防火墙关闭失败 " 1
}

disableSelinux(){
SELINUXstatus=`getenforce`
if [[ ${SELINUXstatus} == "Enforcing" ]];then
    sed -i 's/SELINUX=enforcing/SELINUX=disabled/'    /etc/selinux/config
    [ $? -eq 0 ] && echo -e "\e[1;35mselinux关闭成功\e[0m" || echo -e "\e[1;35mselinux关闭失败\e[0m"
else
    echo -e "\e[1;35mselinux已经是关闭状态\e[0m"
fi
#   sed -i 's/SELINUX=enforcing/SELINUX=disabled/'    /etc/selinux/config
#    color "SELINUX关闭完成" 0
    setenforce 0

    color "请务必重启！" 0
    color "现在已经临时禁用，重启生效!" 2
}














c6_software(){

#local SYS=`cat /etc/redhat-release | cut -d' ' -f1`
#echo "执行网络检测"
#if ping -c 1 www.baidu.com >/dev/null;then
#    echo -e "\e[1;32m"网络正常"\e[0m"
#else
#    echo -e "\e[1;31m"网络不通"\e[0m"
    
#fi

if ! ping -c 5 www.baidu.com > /dev/null;then
    echo -e "\e[1;31m网络不通，将跳过相关网络依赖步骤。\e[0m"
    NETWORK_OK=false
else
    echo -e "\e[1;32m网络正常\e[0m"
    NETWORK_OK=true
fi

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



if $NETWORK_OK && [ "$SYSTEM_NAME" = "centos" ] && [ "$VERSION_ID" = "6" ];then
    software=("lrzsz"
        "vim"
        "wget"
        "tcpdump"
        "redhat-lsb-core"
        "psmisc"
        "rsync"
        "net-tools"
        "mlocate"
        "bzip2"
        "zip"
        "unzip"
        "lsof"
        "httpd-tools"
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
    echo -e "\e[1;35m"不是centos6系统"\e[0m"
fi

   
}




c7_software(){

#yum -y install bridge-utils.x86_64 libtalloc libpcap libpcap-devel iotop  bzip2 zip unzip htop bash-completion psmisc lrzsz  
#tree man-pages redhat-lsb-core wget tcpdump ftp rsync vim lsof net-tools  iproute git  
#yum -y install vim lrzsz bash-completion wget tcpdump redhat-lsb-core psmisc rsync net-tools
#echo "执行网络检测"
#if ping -c 1 www.baidu.com >/dev/null;then
#    echo -e "\e[1;32m"网络正常"\e[0m"
#else
#    echo -e "\e[1;31m"网络不通"\e[0m"
    
#fi

if ! ping -c 5 www.baidu.com > /dev/null;then
    echo -e "\e[1;31m网络不通，将跳过相关网络依赖步骤。\e[0m"
    NETWORK_OK=false
else
    echo -e "\e[1;32m网络正常\e[0m"
    NETWORK_OK=true
fi

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




#两种写法都一样
#[[ $ID=~ rocky|centos|rhel ]]
if $NETWORK_OK && [ $ID = 'centos' -o $ID = 'rocky' -o $ID = 'openeuler' -o $ID = 'kylin' ];then
    declare -a software
    #yum -y install vim lrzsz bash-completion wget tcpdump redhat-lsb-core psmisc rsync net-tools mlocate
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
    echo -e "\e[1;35m"不是centos系统"\e[0m"

fi

#删除定义的数组元素
#unset software

}

Ubuntu_software(){

#echo "执行网络检测"
#if ping -c 1 www.baidu.com >/dev/null;then
#    echo -e "\e[1;32m"网络正常"\e[0m"
#else
#    echo -e "\e[1;31m"网络不通"\e[0m"
    
#fi

if ! ping -c 5 www.baidu.com > /dev/null;then
    echo -e "\e[1;31m网络不通，将跳过相关网络依赖步骤。\e[0m"
    NETWORK_OK=false
else
    echo -e "\e[1;32m网络正常\e[0m"
    NETWORK_OK=true
fi


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


if $NETWORK_OK && [ $ID = 'ubuntu' ];then
    declare -a software
    apt update
    software=("lrzsz"
        "vim"
        "bash-completion"
        "wget"
        "tcpdump"
        "psmisc"
        "rsync"
        "net-tools"
        "apache2-utils"
        )
    for i in ${software[@]}
    do
        if dpkg -l  $i &> /dev/null;then
            echo -e "$i\t\e[1;32m已安装\e[0m" 
        else 
            if apt -y install $i &> /dev/null; then 
                echo -e "$i\t\e[1;35m安装成功\e[0m"
            else
                echo -e "$i\t\e[1;31m安装失败\e[0m"
            fi
        fi

done
else
    echo -e "\e[1;35m"不是Ubuntu系统"\e[0m"
fi

}

auto_install_software(){
if [ -f /etc/os-release ]; then
    # 解析 /etc/os-release 文件
    . /etc/os-release
    if [ $ID = 'centos' -o $ID = 'openeuler' -o $ID = 'kylin' -o $ID = 'rocky' ]; then
        #echo -e "\e[1;35m当前系统是:$NAME，版本号：$VERSION_ID\e[0m"
        c7_software
    elif [[ $ID = 'ubuntu' ]]; then
        #echo -e "\e[1;35m当前系统是:$NAME，版本号：$VERSION_ID\e[0m"
        Ubuntu_software
    else
        echo -e "\e[1;33m未知的系统，$NAME ($ID)，版本号：$VERSION_ID\e[0m"
        exit
    fi


elif [ -f /etc/redhat-release ]; then
    os_version=$(cat /etc/redhat-release)

    if [[ $os_version =~ "release 6" ]]; then
        #echo -e "\e[1;35m当前系统是 CentOS 6\e[0m"
        c6_software
    else
        #echo -e "\e[1;33m未知的系统，具体信息：$os_version\e[0m"
        exit
    fi

else
    echo -e "\e[1;33m无法判断操作系统，未找到 /etc/os-release 或 /etc/redhat-release 文件。\e[0m"
fi

}

#新添加的防止误删除东西，进行备份了，


set_rm(){


cat > /opt/rm.sh <<EOF
#WARNING_COLOR=echo -e "\e[1;35m"
#END="\e[0m"

DIR=/tmp/\$*-\$(date +%F_%H-%M-%S)

#DIR=/root/\$*-\$(date +%F_%H-%M-%S)
#[ -d \$DIR ] || mkdir \$DIR


mv \$* \$DIR

#\${WARNING_COLOR}move \$* to \$DIR \$END

echo -e "\e[1;35m move \$* to /tmp/\$*-\$(date +%F_%H-%M-%S) \e[0m"


#echo -e "\e[1;35m move \$* to /root/\$*-\$(date +%F_%H-%M-%S) \e[0m"
EOF

chmod +x /opt/rm.sh

cat >> ~/.bashrc<<EOF
alias rm='/opt/rm.sh'
EOF

echo -e "rm安全实现已配置完毕"

exec bash

}

disk(){

local WARNING=70
local DISK=`df | sed -rn '/^\/dev/s@.* ([0-9]{1,3})%.*@\1@p' | sort -nr | head -n 1`
[ $DISK -ge $WARNING ] && echo "现在磁盘占用最高：$DISK%" | mail -s diskwarning root

}


#新添加的邮箱发送配置，这个在做磁盘内存报警的时候可以用到
set_mail(){

echo -e "\n\e[1;33m检查软件是否安装...\e[0m\n"

sleep 1

rpm -q postfix &>/dev/null

if [ $? -eq 0 ];then
    color  "postfix已安装" 0 || color  "postfix未安装" 1
else
    yum -y install postfix && systemctl enable --now postfix
fi

rpm -q mailx  &>/dev/null

if [ $? -eq 0 ];then
    echo -e "\e[1;34mmailx已安装 \e[0m" "\e[1;32m                    [ OK ] \e[0m\n"
else
    yum -y install mailx
fi

sleep 1

echo -e "\n\e[1;33m开始进入配置\e[0m\n"

read -p "输入邮箱类型(qq,163..):" TYPE
read -p "输入你的邮箱:" MAILADD
read -p "输入授权码:" TOKEN

cat >> /etc/mail.rc <<EOF
set from=$MAILADD
set smtp=smtp.$TYPE.com
set smtp-auth-user=$MAILADD
set smtp-auth-password=$TOKEN
EOF


echo -e "\n\e[1;33m邮件发送测试...\e[0m\n"

read -p "输入接受邮件的邮箱:" TESTMAIL

echo "hello world" | mail -s welcome $TESTMAIL

sleep 1

echo -e "\n\e[1;35m自行查看邮件\e[0m"

}

set_ulimit(){
#echo -e "\e[1;34m优化limits\e[0m"

cat >> /etc/security/limits.conf << EOF
* soft nofile 65535
* hard nofile 65535
* soft noproc 65535
* hard noproc 65535
EOF
echo -e "\e[1;34m 重启永久生效\e[0m"

#echo -e "\e[1;34m 临时生效修改profile文件,这种方法也是可以不重启永久生效的\e[0m"
#cat >> /etc/profile<< EOF

#ulimit -HSn 65536
#EOF
#source /etc/profile 
#[ $? -eq 0 ] && echo -e "\e[1;32m不重启系统重载配置成功\e[0m" || echo -e "\e[1;31m不重启系统重载配置失败\e[0m"



}


stop_swap(){
sed -i.bak '/swap/s@^@#@' /etc/fstab

swapoff  -a
echo -e "\e[1;34m禁用所有swap空间立即生效\e[0m"

}

start_swap(){
sed -i '/swap/s@#@@' /etc/fstab
swapon -a
echo -e "\e[1;34m启用swap立即生效\e[0m"
}

set_ssh(){
echo -e "\n\e[1;35m修改默认ssh端口号,最大值65535\e[0m\n"
read -p "输入数值:" NUM
cat >> /etc/ssh/sshd_config <<EOF
Port $NUM
EOF
systemctl  restart sshd
[ $? -eq 0 ] && echo -e "\e[1;32m             ok \e[0m" || echo -e "\e[1;31m                false \e[0m"
}


systemInfo(){
local CORES=`cat /proc/cpuinfo | grep "cores" | wc -l`
local CPUINFO=`cat /proc/cpuinfo  | grep name | cut -d: -f2 |uniq -c | tr -s ' '` 
local CPUNUM=`cat /proc/cpuinfo | grep "cores" | uniq|wc -l`
local CPUL=`cat /proc/cpuinfo | grep processor | wc -l`
local Kernel=`uname -r`
local SYSV=`awk '{print $1,$4}' /etc/redhat-release`
#local SYSV=`awk '{print $1,$3,$4}' /etc/redhat-release`
local MEM=`free -h | head -n2 |tail -n1 | awk '{print $2}'`
#local MEM=`free -m | head -n2 |tail -n1 | awk '{print $2}'`
local DISK=`lsblk | grep "^sd" | awk '{print $1,$4}'`
local DF=`df -h | grep  "^/dev/" | awk '{print $1,$2,$5,$6}'`

echo -e "\n\e[1;35mCPU核数-型号:$CPUINFO\e[0m"
echo -e "\n\e[1;35m物理CPU核数:$CPUNUM\e[0m"
echo -e "\n\e[1;35m逻辑CPU个数:$CPUL\e[0m"

echo -e "\n\e[1;35m系统内核版本:$Kernel\e[0m"
echo -e "\n\e[1;35m系统版本:$SYSV\e[0m"
echo -e "\n\e[1;35m内存大小:$MEM\e[0m"
echo -e "\n\e[1;35m硬盘总大小:$DISK\e[0m"
echo -e "\n\e[1;35m磁盘挂载情况:$DF\e[0m"
}

ubuntu_root_login(){
echo vi /etc/ssh/sshd_config
echo PassswordAuthentication yes
echo PermitRootLogin yes
echo ClientAliveInterval 666

echo systemctl restart sshd.service
}


#修改了退出提示语
set_et(){
#echo -e "\n\e[1;35mGoodBye!\e[0m\n"
echo -e "\n\e[1;$[RANDOM%7+31]m G\e[0m\e[1;5;$[RANDOM%7+31]moooooo\e[0m\e[1;$[RANDOM%7+31]md\e[0m\e[1;$[RANDOM%7+31]mB\e[0m\e[1;$[RANDOM%7+31]my\e[0m\e[1;$[RANDOM%7+31]me! \e[0m\n"
exit
}

#set_back(){
#break 
#}


set_yum_rocky8(){
    [ ! -d /data/backup ] && mkdir -p /data/backup
    #[  -d /data/backup ] || mkdir -p /data/backup
    echo -e "\e[1;35m 备份旧的yum源文件 \e[0m"
    mv /etc/yum.repos.d/*  /data/backup  || :
    [ ! -d /mnt/cdrom ] && mkdir /mnt/cdrom
    echo -e "\e[1;35m挂载光盘 \e[0m"
    mount /dev/sr0 /mnt/cdrom
    echo -e "\e[1;35m写入新的yum源文件 \e[0m"
    cat > /etc/yum.repos.d/base.repo <<EOF
[BaseOS]
name=mnt/cdrom
baseurl=file:///mnt/cdrom/BaseOS
        https://mirrors.aliyun.com/rockylinux/\$releasever/BaseOS/x86_64/os/
        http://mirrors.163.com/rocky/\$releasever/BaseOS/x86_64/os/
        https://mirrors.nju.edu.cn/rocky/\$releasever/BaseOS/x86_64/os/
        https://mirrors.sjtug.sjtu.edu.cn/rocky/\$releasever/BaseOS/x86_64/os/
        http://mirrors.sdu.edu.cn/rocky/\$releasever/BaseOS/x86_64/os/
gpgcheck=0


[AppStream]
name=mnt/cdrom
baseurl=file:///mnt/cdrom/AppStream
        https://mirrors.aliyun.com/rockylinux/\$releasever/AppStream/x86_64/os/
        http://mirrors.163.com/rocky/\$releasever/AppStream/x86_64/os/
        https://mirrors.nju.edu.cn/rocky/\$releasever/AppStream/x86_64/os/
        https://mirrors.sjtug.sjtu.edu.cn/rocky/\$releasever/AppStream/x86_64/os/
        http://mirrors.sdu.edu.cn/rocky/\$releasever/AppStream/x86_64/os/
gpgcheck=0

[extras]
name=extras
baseurl=https://mirrors.aliyun.com/rockylinux/\$releasever/extras/x86_64/os
        http://mirrors.163.com/rocky/\$releasever/extras/x86_64/os
        https://mirrors.nju.edu.cn/rocky/\$releasever/extras/x86_64/os
        https://mirrors.sjtug.sjtu.edu.cn/rocky/\$releasever/extras/x86_64/os
        http://mirrors.sdu.edu.cn/rocky/\$releasever/extras/x86_64/os
gpgcheck=0
EOF

    yum clean all
    echo -e "\e[1;35m建立元数据缓存 \e[0m"
    yum makecache
    yum repolist

if [ $? -eq 0 ];then	
    #color "yum源配置完毕 " 0
    echo -e "\e[1;35myum源配置完毕! \e[0m"  "\e[1;32m                    [ OK ] \e[0m"
else
    #color "yum源配置失败 " 1
    echo -e "\e[1;31myum源配置失败! \e[0m"   "\e[1;31m                    [ FAILED ] \e[0m"
    exit
fi
    cat >> /etc/fstab << EOF
/dev/sr0               /mnt/cdrom              iso9660  defaults        0 0
EOF

[ $? -eq 0 ] && echo -e "\e[1;34m 已写入配置，永久挂载! \e[0m"  || { echo -e "\e[1;31m 写入失败！ \e[0m";exit; }

}




set_yum2_rocky8(){
    [ ! -d /data/backup ] && mkdir -p /data/backup
    mv /etc/yum.repos.d/*  /data/backup  || :
    cat > /etc/yum.repos.d/base.repo <<EOF
[BaseOS]
name=BaseOS
baseurl=https://mirrors.aliyun.com/rockylinux/\$releasever/BaseOS/x86_64/os/
        http://mirrors.163.com/rocky/\$releasever/BaseOS/x86_64/os/
        https://mirrors.nju.edu.cn/rocky/\$releasever/BaseOS/x86_64/os/
        https://mirrors.sjtug.sjtu.edu.cn/rocky/\$releasever/BaseOS/x86_64/os/
        http://mirrors.sdu.edu.cn/rocky/\$releasever/BaseOS/x86_64/os/
gpgcheck=0


[AppStream]
name=AppStream
baseurl=https://mirrors.aliyun.com/rockylinux/\$releasever/AppStream/x86_64/os/
        http://mirrors.163.com/rocky/\$releasever/AppStream/x86_64/os/
        https://mirrors.nju.edu.cn/rocky/\$releasever/AppStream/x86_64/os/
        https://mirrors.sjtug.sjtu.edu.cn/rocky/\$releasever/AppStream/x86_64/os/
        http://mirrors.sdu.edu.cn/rocky/\$releasever/AppStream/x86_64/os/
gpgcheck=0

[extras]
name=extras
baseurl=https://mirrors.aliyun.com/rockylinux/\$releasever/extras/x86_64/os
        http://mirrors.163.com/rocky/\$releasever/extras/x86_64/os
        https://mirrors.nju.edu.cn/rocky/\$releasever/extras/x86_64/os
        https://mirrors.sjtug.sjtu.edu.cn/rocky/\$releasever/extras/x86_64/os
        http://mirrors.sdu.edu.cn/rocky/\$releasever/extras/x86_64/os
gpgcheck=0
EOF

    yum clean all
    echo -e "\e[1;35m建立元数据缓存 \e[0m"
    yum makecache
    yum repolist

if [ $? -eq 0 ];then	
    #color "yum源配置完毕 " 0
    echo -e "\e[1;35myum源配置完毕! \e[0m"  "\e[1;32m                    [ OK ] \e[0m"
else
    #color "yum源配置失败 " 1
    echo -e "\e[1;31myum源配置失败! \e[0m"   "\e[1;31m                    [ FAILED ] \e[0m"
    exit
fi
    cat >> /etc/fstab << EOF
/dev/sr0               /mnt/cdrom              iso9660  defaults        0 0
EOF

[ $? -eq 0 ] && echo -e "\e[1;34m 已写入配置，永久挂载! \e[0m"  || { echo -e "\e[1;31m 写入失败！ \e[0m";exit; }

}

set_epel_rocky8(){
    echo -e "\e[1;35m写入新的epel源文件 \e[0m"
    cat > /etc/yum.repos.d/epel.repo <<-EOF
[epel]
name=epel
baseurl=https://mirrors.aliyun.com/epel/\$releasever/Everything/x86_64/
        https://mirror.tuna.tsinghua.edu.cn/epel/\$releasever/Everything/x86_64/
        https://mirrors.cloud.tencent.com/epel/\$releasever/Everything/x86_64/
        https://mirrors.huaweicloud.com/epel/\$releasever/Everything/x86_64/
gpgcheck=0
EOF
    dnf clean all
    dnf repolist

if [ $? -eq 0 ];then    
    #color "EPEL源设置完成!" 0
    echo -e "\e[1;35mepel源配置完毕! \e[0m"  "\e[1;32m                    [ OK ] \e[0m"
else
    #color "EPEL源设置失败!" 1
    echo -e "\e[1;31mepel源配置失败! \e[0m"   "\e[1;31m                   [ FAILED ] \e[0m"
fi

}


set_yum_centos7(){
    [ ! -d /data/bak ] && mkdir -p /data/bak
    echo -e "\e[1;35m备份旧的yum源文件 \e[0m"
    mv /etc/yum.repos.d/*  /data/bak
    mkdir /mnt/cdrom
    mount /dev/sr0 /mnt/cdrom
    echo -e "\e[1;35m写入新的yum源文件 \e[0m"
    cat > /etc/yum.repos.d/base.repo <<EOF
[base]
name=CentOS-\$releasever - Base - mirrors.aliyun.com
failovermethod=priority
baseurl=http://mirrors.aliyun.com/centos/\$releasever/os/\$basearch/
        http://mirrors.aliyuncs.com/centos/\$releasever/os/\$basearch/
        http://mirrors.cloud.aliyuncs.com/centos/\$releasever/os/\$basearch/
        https://mirrors.tuna.tsinghua.edu.cn/centos-vault/7.9.2009/os/x86_64/
        https://mirrors.tuna.tsinghua.edu.cn/centos/7.9.2009/os/x86_64/
gpgcheck=1
gpgkey=http://mirrors.aliyun.com/centos/RPM-GPG-KEY-CentOS-7
 
#released updates 
[updates]
name=CentOS-\$releasever - Updates - mirrors.aliyun.com
failovermethod=priority
baseurl=http://mirrors.aliyun.com/centos/\$releasever/updates/\$basearch/
        http://mirrors.aliyuncs.com/centos/\$releasever/updates/\$basearch/
        http://mirrors.cloud.aliyuncs.com/centos/\$releasever/updates/\$basearch/
gpgcheck=1
gpgkey=http://mirrors.aliyun.com/centos/RPM-GPG-KEY-CentOS-7
 
#additional packages that may be useful
[extras]
name=CentOS-\$releasever - Extras - mirrors.aliyun.com
failovermethod=priority
baseurl=http://mirrors.aliyun.com/centos/\$releasever/extras/\$basearch/
        http://mirrors.aliyuncs.com/centos/\$releasever/extras/\$basearch/
        http://mirrors.cloud.aliyuncs.com/centos/\$releasever/extras/\$basearch/
gpgcheck=1
gpgkey=http://mirrors.aliyun.com/centos/RPM-GPG-KEY-CentOS-7
 
#additional packages that extend functionality of existing packages
[centosplus]
name=CentOS-\$releasever - Plus - mirrors.aliyun.com
failovermethod=priority
baseurl=http://mirrors.aliyun.com/centos/\$releasever/centosplus/\$basearch/
        http://mirrors.aliyuncs.com/centos/\$releasever/centosplus/\$basearch/
        http://mirrors.cloud.aliyuncs.com/centos/\$releasever/centosplus/\$basearch/
gpgcheck=1
enabled=0
gpgkey=http://mirrors.aliyun.com/centos/RPM-GPG-KEY-CentOS-7
 
#contrib - packages by Centos Users
[contrib]
name=CentOS-\$releasever - Contrib - mirrors.aliyun.com
failovermethod=priority
baseurl=http://mirrors.aliyun.com/centos/\$releasever/contrib/\$basearch/
        http://mirrors.aliyuncs.com/centos/\$releasever/contrib/\$basearch/
        http://mirrors.cloud.aliyuncs.com/centos/\$releasever/contrib/\$basearch/
gpgcheck=1
enabled=0
gpgkey=http://mirrors.aliyun.com/centos/RPM-GPG-KEY-CentOS-7
EOF

    yum clean all
    yum makecache
    yum repolist

if [ $? -eq 0 ];then     
    #color "yum源配置完毕 " 0
    echo -e "\e[1;35myum源配置完毕! \e[0m"  "\e[1;32m                    [ OK ] \e[0m"
else
    #color "yum源配置失败 " 0
    echo -e "\e[1;31myum源配置失败! \e[0m"   "\e[1;31m                    [ FAILED ] \e[0m"
    exit
fi

cat >> /etc/fstab << EOF
/dev/sr0               /mnt/cdrom              iso9660  defaults        0 0
EOF

[ $? -eq 0 ] && echo -e "\e[1;34m 已写入配置，永久挂载! \e[0m" || { echo -e "\e[1;31m 写入失败！ \e[0m";exit; }

}

set_yum1_centos7(){

DIRECTORY="/etc/yum.repod.d"

if [ ! -d "$DIRECTORY" ] || [ "$(ls -A "$DIRECTORY")" ];then
    echo "/etc/yum.repod下无文件"
else
    [ ! -d /data/bak ] && mkdir -p /data/bak
    echo -e "\e[1;35m 备份旧的yum源文件 \e[0m"
    mv /etc/yum.repos.d/*  /data/bak
fi

    echo -e "\e[1;35m写入新的yum源文件 \e[0m"
    cat > /etc/yum.repos.d/base.repo <<EOF
[base]
name=base
baseurl=https://mirrors.tuna.tsinghua.edu.cn/centos/7.9.2009/os/x86_64/
gpgcheck=1
gpgkey=https://mirrors.tuna.tsinghua.edu.cn/centos/7.9.2009/os/x86_64/RPM-GPG-KEY-CentOS-7

[extras]
name=extras
baseurl=https://mirrors.tuna.tsinghua.edu.cn/centos/7.9.2009/extras/x86_64/
gpgcheck=0

[updates]
name=updates
baseurl=https://mirrors.tuna.tsinghua.edu.cn/centos/7.9.2009/updates/x86_64/
EOF
    yum clean all
    yum repolist
if [ $? -eq 0 ];then
    #color "EPEL源设置完成!"  0
    echo -e "\e[1;35myum源配置完毕! \e[0m"  "\e[1;32m                    [ OK ] \e[0m"
else
    #color "EPEL源设置失败!"  1
    echo -e "\e[1;31myum源配置失败! \e[0m"   "\e[1;31m                    [ FAILED ] \e[0m"
    exit
fi

}



set_yum2_centos7(){
    

[ ! -d /data/bak ] && mkdir -p /data/bak
echo -e "\e[1;35m备份旧的yum源文件,挂载光盘\e[0m"
    

#判断文件夹是否有文件
    if [ "`ls -A /etc/yum.repos.d/`" != "" ];then
        mv /etc/yum.repos.d/*  /data/bak
    else
        echo ""
    fi
    


#判断是否有挂载
#df -h | grep /dev/sr0

#    if [ $? -eq 0 ];then
#        echo -e "\e[1;32m已有挂载 \e[0m"
#    else

        echo -e "\e[1;34m挂载光盘 \e[0m"
        [ -d /mnt/cdrom ] || mkdir /mnt/cdrom
        mount /dev/sr0 /mnt/cdrom
#    fi
    

echo -e "\e[1;35m写入新的yum源文件 \e[0m"
cat > /etc/yum.repos.d/base.repo <<EOF
[base]
name=CentOS
baseurl=file:///mnt/cdrom/BaseOS
        https://mirror.tuna.tsinghua.edu.cn/centos/\$releasever/os/\$basearch/
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
    yum clean all
    yum makecache
    yum repolist

if [ $? -eq 0 ];then     
    echo -e "\e[1;32myum源配置完毕! \e[0m"  "\e[1;32m                    [ OK ] \e[0m"
else
    echo -e "\e[1;31myum源配置失败! \e[0m"   "\e[1;31m                    [ FAILED ] \e[0m"
    exit
fi

cat >> /etc/fstab << EOF
/dev/sr0               /mnt/cdrom              iso9660  defaults        0 0
EOF

[ $? -eq 0 ] && echo -e "\e[1;34m已配置永久挂载! \e[0m" "\e[1;32m                   [ OK ] \e[0m"|| { echo -e "\e[1;31m 写入失败！ \e[0m" "\e[1;31m                    [ FAILED ] \e[0m";exit; }

}



set_yum3_centos7(){


[ ! -d /data/bak ] && mkdir -p /data/bak
echo -e "\e[1;35m备份旧的yum源文件到/data/bak\e[0m"
    

#判断文件夹是否有文件
    if [ "`ls -A /etc/yum.repos.d/`" != "" ];then
        mv /etc/yum.repos.d/*  /data/bak
    else
        echo ""
    fi
    


echo -e "\e[1;35m写入新的yum源文件 \e[0m"
cat > /etc/yum.repos.d/base.repo <<EOF
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
    yum clean all
    yum makecache
    yum repolist

if [ $? -eq 0 ];then     
    echo -e "\e[1;32myum源配置完毕! \e[0m"  "\e[1;32m                    [ OK ] \e[0m"
else
    echo -e "\e[1;31myum源配置失败! \e[0m"   "\e[1;31m                    [ FAILED ] \e[0m"
    exit
fi


}




set_yum4_centos7(){


DIRECTORY="/etc/yum.repod.d"

if [ ! -d "$DIRECTORY" ] || [ "$(ls -A "$DIRECTORY")" ];then
    echo -e "\e[1;33m/etc/yum.repod下无文件\e[0m"
else
    [ ! -d /data/bak ] && mkdir -p /data/bak
    echo -e "\e[1;35m 备份旧的yum源文件 \e[0m"
    mv /etc/yum.repos.d/*  /data/bak
fi


  
    echo -e "\e[1;35m写入新的yum源文件 \e[0m"
    cat > /etc/yum.repos.d/base.repo <<EOF
[base]
name=CentOS-\$releasever - Base - mirrors.aliyun.com
failovermethod=priority
baseurl=http://mirrors.aliyun.com/centos/\$releasever/os/\$basearch/
        http://mirrors.aliyuncs.com/centos/\$releasever/os/\$basearch/
        http://mirrors.cloud.aliyuncs.com/centos/\$releasever/os/\$basearch/
        https://mirrors.tuna.tsinghua.edu.cn/centos-vault/7.9.2009/os/x86_64/
        https://mirrors.tuna.tsinghua.edu.cn/centos/7.9.2009/os/x86_64/
gpgcheck=1
gpgkey=http://mirrors.aliyun.com/centos/RPM-GPG-KEY-CentOS-7
 
#released updates 
[updates]
name=CentOS-\$releasever - Updates - mirrors.aliyun.com
failovermethod=priority
baseurl=http://mirrors.aliyun.com/centos/\$releasever/updates/\$basearch/
        http://mirrors.aliyuncs.com/centos/\$releasever/updates/\$basearch/
        http://mirrors.cloud.aliyuncs.com/centos/\$releasever/updates/\$basearch/
gpgcheck=1
gpgkey=http://mirrors.aliyun.com/centos/RPM-GPG-KEY-CentOS-7
 
#additional packages that may be useful
[extras]
name=CentOS-\$releasever - Extras - mirrors.aliyun.com
failovermethod=priority
baseurl=http://mirrors.aliyun.com/centos/\$releasever/extras/\$basearch/
        http://mirrors.aliyuncs.com/centos/\$releasever/extras/\$basearch/
        http://mirrors.cloud.aliyuncs.com/centos/\$releasever/extras/\$basearch/
gpgcheck=1
gpgkey=http://mirrors.aliyun.com/centos/RPM-GPG-KEY-CentOS-7
 
#additional packages that extend functionality of existing packages
[centosplus]
name=CentOS-\$releasever - Plus - mirrors.aliyun.com
failovermethod=priority
baseurl=http://mirrors.aliyun.com/centos/\$releasever/centosplus/\$basearch/
        http://mirrors.aliyuncs.com/centos/\$releasever/centosplus/\$basearch/
        http://mirrors.cloud.aliyuncs.com/centos/\$releasever/centosplus/\$basearch/
gpgcheck=1
enabled=0
gpgkey=http://mirrors.aliyun.com/centos/RPM-GPG-KEY-CentOS-7
 
#contrib - packages by Centos Users
[contrib]
name=CentOS-\$releasever - Contrib - mirrors.aliyun.com
failovermethod=priority
baseurl=http://mirrors.aliyun.com/centos/\$releasever/contrib/\$basearch/
        http://mirrors.aliyuncs.com/centos/\$releasever/contrib/\$basearch/
        http://mirrors.cloud.aliyuncs.com/centos/\$releasever/contrib/\$basearch/
gpgcheck=1
enabled=0
gpgkey=http://mirrors.aliyun.com/centos/RPM-GPG-KEY-CentOS-7
EOF

    yum clean all
    yum makecache
    yum repolist

if [ $? -eq 0 ];then     
    #color "yum源配置完毕 " 0
    echo -e "\e[1;35myum源配置完毕! \e[0m"  "\e[1;32m                    [ OK ] \e[0m"
else
    #color "yum源配置失败 " 0
    echo -e "\e[1;31myum源配置失败! \e[0m"   "\e[1;31m                    [ FAILED ] \e[0m"
    exit
fi

cat >> /etc/fstab << EOF
/dev/sr0               /mnt/cdrom              iso9660  defaults        0 0
EOF

[ $? -eq 0 ] && echo -e "\e[1;34m 已写入配置，永久挂载! \e[0m" || { echo -e "\e[1;31m 写入失败！ \e[0m";exit; }

}





set_epel_centos7(){
    echo -e "\e[1;35m写入新的epel源文件 \e[0m"
    cat > /etc/yum.repos.d/epel.repo <<-EOF
[epel]
name=epel
baseurl=https://mirrors.aliyun.com/epel/\$releasever/x86_64/
        https://mirrors.tuna.tsinghua.edu.cn/epel/7/x86_64/
        https://mirrors.ustc.edu.cn/epel/7/x86_64/
gpgcheck=0
EOF



    yum clean all
    yum repolist
if [ $? -eq 0 ];then
    #color "EPEL源设置完成!"  0
    echo -e "\e[1;35myum源配置完毕! \e[0m"  "\e[1;32m                    [ OK ] \e[0m"
else
    #color "EPEL源设置失败!"  1
    echo -e "\e[1;31myum源配置失败! \e[0m"   "\e[1;31m                    [ FAILED ] \e[0m"
    exit
fi


}

set_yum_centos610(){

    [ ! -d /data/bak ] && mkdir -p /data/bak
    echo -e "\e[1;35m备份旧的yum源文件 \e[0m"
    mv /etc/yum.repos.d/*  /data/bak
    echo -e "\e[1;35m写入新的yum源文件 \e[0m"
    cat > /etc/yum.repos.d/CentOS-Base.repo <<-EOF
[base]
name=CentOS-vault-6.10 - Base - mirrors.aliyun.com
failovermethod=priority
baseurl=http://mirrors.aliyun.com/centos-vault/6.10/os/\$basearch/
        http://mirrors.aliyuncs.com/centos-vault/6.10/os/\$basearch/
        http://mirrors.cloud.aliyuncs.com/centos-vault/6.10/os/\$basearch/
gpgcheck=1
gpgkey=http://mirrors.aliyun.com/centos-vault/RPM-GPG-KEY-CentOS-6
 
#released updates 
[updates]
name=CentOS-vault-6.10 - Updates - mirrors.aliyun.com
failovermethod=priority
baseurl=http://mirrors.aliyun.com/centos-vault/6.10/updates/\$basearch/
        http://mirrors.aliyuncs.com/centos-vault/6.10/updates/\$basearch/
        http://mirrors.cloud.aliyuncs.com/centos-vault/6.10/updates/\$basearch/
gpgcheck=1
gpgkey=http://mirrors.aliyun.com/centos-vault/RPM-GPG-KEY-CentOS-6
 
#additional packages that may be useful
[extras]
name=CentOS-vault-6.10 - Extras - mirrors.aliyun.com
failovermethod=priority
baseurl=http://mirrors.aliyun.com/centos-vault/6.10/extras/\$basearch/
        http://mirrors.aliyuncs.com/centos-vault/6.10/extras/\$basearch/
        http://mirrors.cloud.aliyuncs.com/centos-vault/6.10/extras/\$basearch/
gpgcheck=1
gpgkey=http://mirrors.aliyun.com/centos-vault/RPM-GPG-KEY-CentOS-6
 
#additional packages that extend functionality of existing packages
[centosplus]
name=CentOS-vault-6.10 - Plus - mirrors.aliyun.com
failovermethod=priority
baseurl=http://mirrors.aliyun.com/centos-vault/6.10/centosplus/\$basearch/
        http://mirrors.aliyuncs.com/centos-vault/6.10/centosplus/\$basearch/
        http://mirrors.cloud.aliyuncs.com/centos-vault/6.10/centosplus/\$basearch/
gpgcheck=1
enabled=0
gpgkey=http://mirrors.aliyun.com/centos-vault/RPM-GPG-KEY-CentOS-6
 
#contrib - packages by Centos Users
[contrib]
name=CentOS-vault-6.10 - Contrib - mirrors.aliyun.com
failovermethod=priority
baseurl=http://mirrors.aliyun.com/centos-vault/6.10/contrib/\$basearch/
        http://mirrors.aliyuncs.com/centos-vault/6.10/contrib/\$basearch/
        http://mirrors.cloud.aliyuncs.com/centos-vault/6.10/contrib/\$basearch/
gpgcheck=1
enabled=0
gpgkey=http://mirrors.aliyun.com/centos-vault/RPM-GPG-KEY-CentOS-6

EOF



    yum clean all
    yum makecache
    yum repolist



if [ $? -eq 0 ];then     
    #color "yum源配置完毕 " 0
    echo -e "\e[1;35myum源配置完毕! \e[0m"  "\e[1;32m                    [ OK ] \e[0m"
else
    #color "yum源配置失败 " 1
    echo -e "\e[1;31myum源配置失败! \e[0m"   "\e[1;31m                    [ FAILED ] \e[0m"
    exit
fi

}

set_yum_centos65(){

    [ ! -d /data/bak ] && mkdir -p /data/bak
    echo -e "\e[1;35m 备份旧的yum源文件 \e[0m"
    mv /etc/yum.repos.d/*  /data/bak
    echo -e "\e[1;35m写入新的yum源文件 \e[0m"
    cat > /etc/yum.repos.d/CentOS-Base.repo <<-EOF
[base]
name=base
#baseurl=https://mirrors.tuna.tsinghua.edu.cn/centos-vault/6.5/os/x86_64/
baseurl=http://mirrors.ustc.edu.cn/centos-vault/6.5/os/x86_64/
gpgcheck=1
#enabled=0
gpgkey=http://mirrors.ustc.edu.cn/centos-vault/6.5/os/x86_64/RPM-GPG-KEY-CentOS-6
EOF



    yum clean all
    yum makecache
    yum repolist

if [ $? -eq 0 ];then     
    #color "yum源配置完毕 " 0
    echo -e "\e[1;35myum源配置完毕! \e[0m"  "\e[1;32m                    [ OK ] \e[0m"
else
    #color "yum源配置失败 " 1
    echo -e "\e[1;31myum源配置失败! \e[0m"   "\e[1;31m                    [ FAILED ] \e[0m"
    exit
fi

}

set_yum_centos66(){

    [ ! -d /data/bak ] && mkdir -p /data/bak
    echo -e "\e[1;35m备份旧的yum源文件 \e[0m"
    mv /etc/yum.repos.d/*  /data/bak
    echo -e "\e[1;35m写入新的yum源文件 \e[0m"
    cat > /etc/yum.repos.d/CentOS-Base.repo <<-EOF
[base]
name=base
#baseurl=https://mirrors.tuna.tsinghua.edu.cn/centos-vault/6.6/os/x86_64/
baseurl=http://mirrors.ustc.edu.cn/centos-vault/6.6/os/x86_64/
gpgcheck=1
#enabled=0
#gpgkey=https://mirrors.tuna.tsinghua.edu.cn/centos-vault/RPM-GPG-KEY-CentOS-6
gpgkey=http://mirrors.ustc.edu.cn/centos-vault/6.6/os/x86_64/RPM-GPG-KEY-CentOS-6
EOF


    yum clean all 
    yum makecache 
    yum repolist  


if [ $? -eq 0 ];then
    #color "yum源配置完毕 " 0
    echo -e "\e[1;35myum源配置完毕! \e[0m"  "\e[1;32m                    [ OK ] \e[0m"
else
    #color "yum源配置失败 " 1
    echo -e "\e[1;31myum源配置失败! \e[0m"   "\e[1;31m                    [ FAILED ] \e[0m"
    exit
fi

}


set_epel_centos6(){
    echo -e "\e[1;35m写入新的epel源文件 \e[0m"
    cat > /etc/yum.repos.d/epel.repo <<-EOF
[root@localhost yum.repos.d]# cat epel.repo 
[epel-archive]
name=Extra Packages for Enterprise Linux 6 - \$basearch
baseurl=http://mirrors.aliyun.com/epel-archive/6/\$basearch
failovermethod=priority
enabled=1
gpgcheck=0
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-6
 
[epel-archive-debuginfo]
name=Extra Packages for Enterprise Linux 6 - \$basearch - Debug
baseurl=http://mirrors.aliyun.com/epel-archive/6/\$basearch/debug
failovermethod=priority
enabled=0
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-6
gpgcheck=0
 
[epel-archive-source]
name=Extra Packages for Enterprise Linux 6 - \$basearch - Source
baseurl=http://mirrors.aliyun.com/epel-archive/6/SRPMS
failovermethod=priority
enabled=0
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-6
gpgcheck=0
EOF

    yum clean all
    yum repolist

if [ $? -eq 0 ];then
    #color "EPEL源设置完成!"  0
    echo -e "\e[1;35mEPEL源设置完成! \e[0m"  "\e[1;32m                    [ OK ] \e[0m"
else
    #color "EPEL源设置失败!"  1
    echo -e "\e[1;31mEPEL源设置失败! \e[0m"   "\e[1;31m                    [ FAILED ] \e[0m"
    exit
fi

}





set_epel(){

    echo -e "\e[1;35m写入新的epel源文件 \e[0m"
    cat > /etc/yum.repos.d/epel.repo <<-EOF
[epel]
name=epel
baseurl=https://mirrors.aliyun.com/epel/\$releasever/x86_64/
        https://mirrors.tuna.tsinghua.edu.cn/epel/7/x86_64/
        https://mirrors.ustc.edu.cn/epel/7/x86_64/
gpgcheck=0
EOF



    yum clean all
    yum repolist
if [ $? -eq 0 ];then
    #color "EPEL源设置完成!"  0
    echo -e "\e[1;35myum源配置完毕! \e[0m"  "\e[1;32m                    [ OK ] \e[0m"
else
    #color "EPEL源设置失败!"  1
    echo -e "\e[1;31myum源配置失败! \e[0m"   "\e[1;31m                    [ FAILED ] \e[0m"
    exit
fi

}






set_local_yum(){

#echo -e "\e[1;35m系统检查\e[0m"
#if [ -e /dev/sr0 ];then
#    echo -e "\e[1;32msr0存在\e[0m"

    # 检查是否有光盘挂载
#    mount_point=$(mount | grep '/dev/sr0' | awk '{print $3}')
#    if [ -n "$mount_point" ]; then
#        echo "/dev/sr0 已挂载到 $mount_point"
#        # 检查挂载点是否有ISO文件
#        iso_files=$(find "$mount_point" -type f -name "*.iso" 2>/dev/null)
#        if [ -n "$iso_files" ]; then
#            echo "找到以下ISO文件:"
#            echo "$iso_files"
#        else
#           echo "在 $mount_point 中没有找到ISO文件。"
#        fi
#    else
#        echo "/dev/sr0 没有挂载。"
#        # 尝试挂载到临时目录检查
#       temp_mount=$(mktemp -d)
#        if mount /dev/sr0 "$temp_mount" 2>/dev/null; then
#            echo "临时挂载成功，检查ISO文件..."
#            
#            iso_files=$(find "$temp_mount" -type f -name "*.iso" 2>/dev/null)
#            if [ -n "$iso_files" ]; then
#                echo "找到以下ISO文件:"
#                echo "$iso_files"
#            else
#                echo "在临时挂载点中没有找到ISO文件。"
#            fi
#            
#            # 卸载
#            umount "$temp_mount"
#            rmdir "$temp_mount"
#        else
#            echo "无法挂载 /dev/sr0，可能没有光盘或光盘不可读。"
#            rmdir "$temp_mount"
#        fi
#    fi
#else
#    echo -e "\e[1;31msr0不存在\e[0m"
#    exit
#fi


#echo -e "\e[1;35m备份旧的yum源文件到/data/bak,挂载iso到/mnt/cdrom\e[0m"
#[ ! -d /data/bak ] && mkdir -p /data/bak

#判断文件夹是否有文件
#if [ "`ls -A /etc/yum.repos.d/`" != "" ];then
#    mv /etc/yum.repos.d/*  /data/bak/
#else
#    echo " \n"
#fi



# 挂载函数：统一处理挂载操作
#mount_device() {
#    local source="$1"
#    local target="$2"
#    local type="$3"

#    echo "[INFO] 尝试挂载 $type: $source → $target"
#    if sudo mount "$source" "$target" 2>/dev/null; then
#        echo "[SUCCESS] 挂载成功！访问路径: $target"
#        echo "内容列表:"
#        ls -l "$target"
#        return 0
#    else
#        echo "[ERROR] 挂载失败（请检查权限或介质有效性）"
#        sudo rmdir "$target" 2>/dev/null
#        return 1
#    fi
#}

# 检查并挂载 /dev/sr0
#if [ -b /dev/sr0 ]; then
#    echo "[INFO] 检测到光驱设备: /dev/sr0"
#    mount_dir="/mnt/cdrom"
#    sudo mkdir -p "$mount_dir"
#    if mount_device "/dev/sr0" "$mount_dir" "光驱"; then
#        exit 0  # 挂载成功则退出
#    fi
#fi

# 检查 /dev/ 下的 .iso 文件
#echo "[INFO] 正在检查 /dev/ 下的ISO文件..."
#iso_file=$(find /dev/ -maxdepth 1 -type f -name "*.iso" 2>/dev/null | head -n 1)

#if [ -n "$iso_file" ]; then
#    echo "[INFO] 找到ISO文件: $iso_file"
#    mount_dir="/mnt/iso"
#    sudo mkdir -p "$mount_dir"
#    if mount_device "-o loop $iso_file" "$mount_dir" "ISO镜像"; then
#        exit 0  # 挂载成功则退出
#    fi
#fi

# 如果执行到这里说明全部失败
#echo "[ERROR] 未找到可挂载的光驱或ISO文件！"
#exit 1








   



#[ -d /mnt/cdrom ] || mkdir /mnt/cdrom
#mount /dev/sr0 /mnt/cdrom

#cat > /etc/yum.repos.d/base.repo <<EOF
#[base]
#name=Local YUM Repository
#baseurl=file:///mnt/cdrom
#enabled=1
#gpgcheck=0
#EOF


#echo -e "\e[1;35m写入配置永久挂载\e[0m"

#cat >> /etc/fstab << EOF
#/dev/sr0               /mnt/cdrom              iso9660  defaults        0 0
#EOF


#yum clean all
#yum makecache
#yum repolist



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











set_ali(){

DIRECTORY="/etc/yum.repod.d"

if [ ! -d "$DIRECTORY" ] || [ "$(ls -A "$DIRECTORY")" ];then
    echo -e "\e[1;33m/etc/yum.repod下无文件\e[0m"
else
    [ ! -d /data/bak ] && mkdir -p /data/bak
    echo -e "\e[1;35m 备份旧的yum源文件 \e[0m"
    mv /etc/yum.repos.d/*  /data/bak
fi


  
echo -e "\e[1;35m写入新的yum源文件 \e[0m"
cat > /etc/yum.repos.d/base.repo <<EOF
[base]
name=CentOS-7 - Base - mirrors.aliyun.com
baseurl=http://mirrors.aliyun.com/centos/7/os/\$basearch/
gpgcheck=0
enabled=1
gpgkey=http://mirrors.aliyun.com/centos/RPM-GPG-KEY-CentOS-7
 
[updates]
name=CentOS-7 - Updates - mirrors.aliyun.com
baseurl=http://mirrors.aliyun.com/centos/7/updates/\$basearch/
gpgcheck=0
enabled=1
gpgkey=http://mirrors.aliyun.com/centos/RPM-GPG-KEY-CentOS-7
 
[extras]
name=CentOS-7 - Extras - mirrors.aliyun.com
baseurl=http://mirrors.aliyun.com/centos/7/extras/\$basearch/
gpgcheck=0
enabled=1
gpgkey=http://mirrors.aliyun.com/centos/RPM-GPG-KEY-CentOS-7
 
[centosplus]
name=CentOS-7 - Plus - mirrors.aliyun.com
baseurl=http://mirrors.aliyun.com/centos/7/centosplus/\$basearch/
gpgcheck=0
enabled=1
gpgkey=http://mirrors.aliyun.com/centos/RPM-GPG-KEY-CentOS-7

EOF

    yum clean all
    yum makecache
    yum repolist

if [ $? -eq 0 ];then     
    #color "yum源配置完毕 " 0
    echo -e "\e[1;35myum源配置完毕! \e[0m"  "\e[1;32m                    [ OK ] \e[0m"
else
    #color "yum源配置失败 " 0
    echo -e "\e[1;31myum源配置失败! \e[0m"   "\e[1;31m                    [ FAILED ] \e[0m"
    exit
fi

}



set_qinghua(){

DIRECTORY="/etc/yum.repod.d"

if [ ! -d "$DIRECTORY" ] || [ "$(ls -A "$DIRECTORY")" ];then
    echo -e "\e[1;33m/etc/yum.repod下无文件\e[0m"
else
    [ ! -d /data/bak ] && mkdir -p /data/bak
    echo -e "\e[1;35m 备份旧的yum源文件 \e[0m"
    mv /etc/yum.repos.d/*  /data/bak
fi


  
echo -e "\e[1;35m写入新的yum源文件 \e[0m"
cat > /etc/yum.repos.d/base.repo <<EOF
[base]
name=CentOS-7 - Base - tsinghua
baseurl=https://mirrors.tuna.tsinghua.edu.cn/centos/7/os/x86_64/
gpgcheck=0
enabled=1
gpgkey=https://mirrors.tuna.tsinghua.edu.cn/centos/RPM-GPG-KEY-CentOS-7
  
[updates]
name=CentOS-7 - Updates - tsinghua
baseurl=https://mirrors.tuna.tsinghua.edu.cn/centos/7/os/x86_64/
gpgcheck=0
enabled=1
gpgkey=https://mirrors.tuna.tsinghua.edu.cn/centos/RPM-GPG-KEY-CentOS-7
 
[extras]
name=CentOS-7 - Extras - tsinghua
baseurl=https://mirrors.tuna.tsinghua.edu.cn/centos/7/extras/\$basearch/
gpgcheck=0
enabled=1
gpgkey=https://mirrors.tuna.tsinghua.edu.cn/centos/RPM-GPG-KEY-CentOS-7
 
[centosplus]
name=CentOS-7 - Plus - tsinghua
baseurl=https://mirrors.tuna.tsinghua.edu.cn/centos/7/centosplus/\$basearch/
gpgcheck=0
enabled=1
gpgkey=https://mirrors.tuna.tsinghua.edu.cn/centos/RPM-GPG-KEY-CentOS-7
EOF

    yum clean all
    yum makecache
    yum repolist

if [ $? -eq 0 ];then     
    #color "yum源配置完毕 " 0
    echo -e "\e[1;35myum源配置完毕! \e[0m"  "\e[1;32m                    [ OK ] \e[0m"
else
    #color "yum源配置失败 " 0
    echo -e "\e[1;31myum源配置失败! \e[0m"   "\e[1;31m                    [ FAILED ] \e[0m"
    exit
fi

}
set_wangyi(){

DIRECTORY="/etc/yum.repod.d"

if [ ! -d "$DIRECTORY" ] || [ "$(ls -A "$DIRECTORY")" ];then
    echo -e "\e[1;33m/etc/yum.repod下无文件\e[0m"
else
    [ ! -d /data/bak ] && mkdir -p /data/bak
    echo -e "\e[1;35m 备份旧的yum源文件 \e[0m"
    mv /etc/yum.repos.d/*  /data/bak
fi


  
    echo -e "\e[1;35m写入新的yum源文件 \e[0m"
    cat > /etc/yum.repos.d/base.repo <<EOF
[base]
name=base-163
baseurl=http://mirrors.163.com/centos/7/os/x86_64/
gpgcheck=0
enabled=1
gpgkey=http://mirrors.163.com/centos/RPM-GPG-KEY-CentOS-7
  
[updates]
name=updates-163
baseurl=http://mirrors.163.com/centos/7/os/x86_64/
gpgcheck=0
enabled=1
gpgkey=http://mirrors.163.com/centos/RPM-GPG-KEY-CentOS-7
 
[extras]
name=extras-163
baseurl=http://mirrors.163.com/centos/7/extras/\$basearch/
gpgcheck=0
enabled=1
gpgkey=http://mirrors.163.com/centos/RPM-GPG-KEY-CentOS-7
 
[centosplus]
name=centosplus-163
baseurl=http://mirrors.163.com/centos/7/centosplus/\$basearch/
gpgcheck=0
enabled=1
gpgkey=http://mirrors.163.com/centos/RPM-GPG-KEY-CentOS-7

EOF

    yum clean all
    yum makecache
    yum repolist

if [ $? -eq 0 ];then     
    #color "yum源配置完毕 " 0
    echo -e "\e[1;35myum源配置完毕! \e[0m"  "\e[1;32m                    [ OK ] \e[0m"
else
    #color "yum源配置失败 " 0
    echo -e "\e[1;31myum源配置失败! \e[0m"   "\e[1;31m                    [ FAILED ] \e[0m"
    exit
fi

}
set_huawei(){

DIRECTORY="/etc/yum.repod.d"

if [ ! -d "$DIRECTORY" ] || [ "$(ls -A "$DIRECTORY")" ];then
    echo -e "\e[1;33m/etc/yum.repod下无文件\e[0m"
else
    [ ! -d /data/bak ] && mkdir -p /data/bak
    echo -e "\e[1;35m 备份旧的yum源文件 \e[0m"
    mv /etc/yum.repos.d/*  /data/bak
fi


  
    echo -e "\e[1;35m写入新的yum源文件 \e[0m"
    cat > /etc/yum.repos.d/base.repo <<EOF
[base]
name=CentOS-7 - Base - repo.huaweicloud.com
baseurl=https://repo.huaweicloud.com/centos/7/os/\$basearch/
gpgcheck=0
enabled=1
gpgkey=https://repo.huaweicloud.com/centos/RPM-GPG-KEY-CentOS-7
 
[updates]
name=CentOS-7 - Updates - repo.huaweicloud.com
baseurl=https://repo.huaweicloud.com/centos/7/updates/\$basearch/
gpgcheck=0
enabled=1
gpgkey=https://repo.huaweicloud.com/centos/RPM-GPG-KEY-CentOS-7
 
[extras]
name=CentOS-7 - Extras - repo.huaweicloud.com
baseurl=https://repo.huaweicloud.com/centos/7/extras/\$basearch/
gpgcheck=0
enabled=1
gpgkey=https://repo.huaweicloud.com/centos/RPM-GPG-KEY-CentOS-7
 
[centosplus]
name=CentOS-7 - Plus - repo.huaweicloud.com
baseurl=https://repo.huaweicloud.com/centos/7/centosplus/\$basearch/
gpgcheck=0
enabled=1
gpgkey=https://repo.huaweicloud.com/centos/RPM-GPG-KEY-CentOS-7

EOF

    yum clean all
    yum makecache
    yum repolist

if [ $? -eq 0 ];then     
    #color "yum源配置完毕 " 0
    echo -e "\e[1;35myum源配置完毕! \e[0m"  "\e[1;32m                    [ OK ] \e[0m"
else
    #color "yum源配置失败 " 0
    echo -e "\e[1;31myum源配置失败! \e[0m"   "\e[1;31m                    [ FAILED ] \e[0m"
    exit
fi
}


set_nanjing(){

DIRECTORY="/etc/yum.repod.d"

if [ ! -d "$DIRECTORY" ] || [ "$(ls -A "$DIRECTORY")" ];then
    echo -e "\e[1;33m/etc/yum.repod下无文件\e[0m"
else
    [ ! -d /data/bak ] && mkdir -p /data/bak
    echo -e "\e[1;35m 备份旧的yum源文件 \e[0m"
    mv /etc/yum.repos.d/*  /data/bak
fi


  
    echo -e "\e[1;35m写入新的yum源文件 \e[0m"
    cat > /etc/yum.repos.d/base.repo <<EOF
[os]
name=os
baseurl=https://mirror.nju.edu.cn/centos/7.9.2009/os/x86_64/
gpgcheck=0
enabled=1
gpgkey=https://mirror.nju.edu.cn/centos/7.9.2009/os/x86_64/RPM-GPG-KEY-CentOS-7

[extras]
name=extras
baseurl=https://mirror.nju.edu.cn/centos/7.9.2009/extras/x86_64/
gpgcheck=0
enabled=1
gpgkey=https://mirror.nju.edu.cn/centos/7.9.2009/os/x86_64/RPM-GPG-KEY-CentOS-7

[centosplus]
name=centosplus
baseurl=https://mirror.nju.edu.cn/centos/7.9.2009/centosplus/x86_64/
gpgcheck=0
enabled=1
gpgkey=https://mirror.nju.edu.cn/centos/7.9.2009/os/x86_64/RPM-GPG-KEY-CentOS-7

[updates]
name=updates
baseurl=https://mirror.nju.edu.cn/centos/7.9.2009/updates/x86_64/
gpgcheck=0
enabled=1
gpgkey=https://mirror.nju.edu.cn/centos/7.9.2009/os/x86_64/RPM-GPG-KEY-CentOS-7

EOF

    yum clean all
    yum makecache
    yum repolist

if [ $? -eq 0 ];then     
    #color "yum源配置完毕 " 0
    echo -e "\e[1;35myum源配置完毕! \e[0m"  "\e[1;32m                    [ OK ] \e[0m"
else
    #color "yum源配置失败 " 0
    echo -e "\e[1;31myum源配置失败! \e[0m"   "\e[1;31m                    [ FAILED ] \e[0m"
    exit
fi



}

































ubuntu_aliyun_source(){
sed -i 's/http:\/\/cn.archive.ubuntu.com/https:\/\/mirrors.aliyun.com/g' /etc/apt/sources.list
sudo apt-get update
}


ubuntu_tuna_source(){
sed -i 's/http:\/\/cn.archive.ubuntu.com/https:\/\/mirrors.tuna.tsinghua.edu.cn/g' /etc/apt/sources.list
sudo apt-get update
}


ubuntu_ustc_source(){
sed -i 's/http:\/\/cn.archive.ubuntu.com/https:\/\/mirrors.ustc.edu.cn/g' /etc/apt/sources.list
sudo apt-get update
}









ubuntu1604_aliyun_source(){
cat > /etc/apt/sources.list <<EOF
deb https://mirrors.aliyun.com/ubuntu/ xenial main
deb-src https://mirrors.aliyun.com/ubuntu/ xenial main

deb https://mirrors.aliyun.com/ubuntu/ xenial-updates main
deb-src https://mirrors.aliyun.com/ubuntu/ xenial-updates main

deb https://mirrors.aliyun.com/ubuntu/ xenial universe
deb-src https://mirrors.aliyun.com/ubuntu/ xenial universe
deb https://mirrors.aliyun.com/ubuntu/ xenial-updates universe
deb-src https://mirrors.aliyun.com/ubuntu/ xenial-updates universe

deb https://mirrors.aliyun.com/ubuntu/ xenial-security main
deb-src https://mirrors.aliyun.com/ubuntu/ xenial-security main
deb https://mirrors.aliyun.com/ubuntu/ xenial-security universe
deb-src https://mirrors.aliyun.com/ubuntu/ xenial-security universe



EOF

sudo apt-get update

}



ubuntu1804_aliyun_source(){
cat > /etc/apt/sources.list <<EOF
deb https://mirrors.aliyun.com/ubuntu/ bionic main restricted universe multiverse
deb-src https://mirrors.aliyun.com/ubuntu/ bionic main restricted universe multiverse

deb https://mirrors.aliyun.com/ubuntu/ bionic-security main restricted universe multiverse
deb-src https://mirrors.aliyun.com/ubuntu/ bionic-security main restricted universe multiverse

deb https://mirrors.aliyun.com/ubuntu/ bionic-updates main restricted universe multiverse
deb-src https://mirrors.aliyun.com/ubuntu/ bionic-updates main restricted universe multiverse

# deb https://mirrors.aliyun.com/ubuntu/ bionic-proposed main restricted universe multiverse
# deb-src https://mirrors.aliyun.com/ubuntu/ bionic-proposed main restricted universe multiverse

deb https://mirrors.aliyun.com/ubuntu/ bionic-backports main restricted universe multiverse
deb-src https://mirrors.aliyun.com/ubuntu/ bionic-backports main restricted universe multiverse


EOF

sudo apt-get update

}


ubuntu2004_aliyun_source(){
cat > /etc/apt/sources.list <<EOF
deb https://mirrors.aliyun.com/ubuntu/ focal main restricted universe multiverse
deb-src https://mirrors.aliyun.com/ubuntu/ focal main restricted universe multiverse

deb https://mirrors.aliyun.com/ubuntu/ focal-security main restricted universe multiverse
deb-src https://mirrors.aliyun.com/ubuntu/ focal-security main restricted universe multiverse

deb https://mirrors.aliyun.com/ubuntu/ focal-updates main restricted universe multiverse
deb-src https://mirrors.aliyun.com/ubuntu/ focal-updates main restricted universe multiverse

# deb https://mirrors.aliyun.com/ubuntu/ focal-proposed main restricted universe multiverse
# deb-src https://mirrors.aliyun.com/ubuntu/ focal-proposed main restricted universe multiverse

deb https://mirrors.aliyun.com/ubuntu/ focal-backports main restricted universe multiverse
deb-src https://mirrors.aliyun.com/ubuntu/ focal-backports main restricted universe multiverse

EOF

sudo apt-get update


}

ubuntu2204_aliyun_source(){
cat > /etc/apt/sources.list <<EOF
deb https://mirrors.aliyun.com/ubuntu/ jammy main restricted universe multiverse
deb-src https://mirrors.aliyun.com/ubuntu/ jammy main restricted universe multiverse

deb https://mirrors.aliyun.com/ubuntu/ jammy-security main restricted universe multiverse
deb-src https://mirrors.aliyun.com/ubuntu/ jammy-security main restricted universe multiverse

deb https://mirrors.aliyun.com/ubuntu/ jammy-updates main restricted universe multiverse
deb-src https://mirrors.aliyun.com/ubuntu/ jammy-updates main restricted universe multiverse

# deb https://mirrors.aliyun.com/ubuntu/ jammy-proposed main restricted universe multiverse
# deb-src https://mirrors.aliyun.com/ubuntu/ jammy-proposed main restricted universe multiverse

deb https://mirrors.aliyun.com/ubuntu/ jammy-backports main restricted universe multiverse
deb-src https://mirrors.aliyun.com/ubuntu/ jammy-backports main restricted universe multiverse


EOF

sudo apt-get update


}

configure_redhat_IP_address(){

rpm -qa ifconfig || yum -y install net-tools

#[ $? -eq 0 ] || yum -y install net-tools

local NET1=`ifconfig | head -n 1 | cut -d: -f1`

ip a

echo -e "\n\e[1;35m现在的网卡名是: $NET1 \e[0m"

echo -e "\e[1;34m需要自行查看是否匹配 \e[0m\n"

read -p "输入现在正在使用的网卡名: " NET

#echo -e '\n'
#if [[ ! "$NET" ==  ]];then echo "请检查网卡名是否正确"; exit; fi
#echo -e "\n\e[1;34m需要自行查看是否匹配 \e[0m\n"

while :;do

read -p "输入ip: " IP


if [[ "$IP" =~ ^([0-9]{1,3}\.){3}[0-9]{1,3}$ ]];then
    echo -e "\n\e[1;34m输入地址正确，继续下一步 \e[0m" "\e[1;32m                [ OK ] \e[0m\n"
    break
else
    #echo  -e "\n\e[1;35m请检查IP地址是否正确! \e[0m"   "\e[1;31m                    [ FAILED ] \e[0m\n"
    #exit
    echo  -e "\e[1;33m输入地址不符合要求，请重新输入 \e[0m\n"
fi

done

while :;do
echo -e "\n\e[1;34m现在支持输入8/16/24/32\e[0m"
read -p "输入子网掩码位数:" PREFIX
#两种写法都可以
#if [  $PREFIX -eq 8 -o $PREFIX -eq 16 -o $PREFIX -eq 24 -o $PREFIX -eq 32 ];then
if [[  $PREFIX =~ 8|16|24|32 ]];then
    echo -e "\n\e[1;34m输入正确，继续下一步 \e[0m"  "\e[1;32m                    [ OK ] \e[0m\n"
    break
else
    #echo -e "\n\e[1;36m请检查子网掩码地址是否正确! \e[0m"  "\e[1;31m                    [ FAILED ] \e[0m\n"
    #exit
    echo  -e "\e[1;33m输入不符合要求，请重新输入 \e[0m\n"
fi


done



while :;do

read -p "输入网关:" GATEWAY

if [[ "$GATEWAY" =~ ^([0-9]{1,3}.){3}[0-9]{1,3}$ ]];then 
    echo -e "\n\e[1;34m输入地址正确，继续下一步 \e[0m"  "\e[1;32m                    [ OK ] \e[0m\n"
    break
else
    #echo -e "\n\e[1;35m请检查网关地址是否正确! \e[0m"  "\e[1;31m                    [ FAILED ] \e[0m\n"
    #exit
    echo  -e "\e[1;33m输入地址不符合要求，请重新输入 \e[0m\n"
fi

done

while :;do

read -p "输入DNS:" DNS
#if [[  "$DNS" =~ ^[0-255.]{1,3}[0-255]$ ]];then echo "请检查dns地址是否正确"; exit; fi


if [[ "$DNS" =~ ^([0-9]{1,3}.){3}[0-9]{1,3}$ ]];then 
    echo -e "\n\e[1;34m输入地址正确，正在写入配置... \e[0m"  "\e[1;32m                [ OK ] \e[0m\n"
    break
else
    #echo -e "\n\e[1;35m请检查DNS地址是否正确! \e[0m"  "\e[1;31m                    [ FAILED ] \e[0m\n"
    #exit
    echo  -e "\e[1;33m输入地址不符合要求，请重新输入 \e[0m\n"
fi

done

cp /etc/sysconfig/network-scripts/ifcfg-$NET /etc/sysconfig/network-scripts/ifcfg-$NET.bak

cat > /etc/sysconfig/network-scripts/ifcfg-$NET <<EOF
NAME=$NET
DEVICE=$NET
IPADDR=$IP
BOOTPROTO=none
PREFIX=$PREFIX
GATEWAY=$GATEWAY
ONBOOT=yes
DNS1=$DNS
DNS2=8.8.8.8
EOF

nmcli con reload && nmcli con up $NET

if [ $? -eq 0 ];then
    #color "网卡配置完成 " 0
    echo -e "\e[1;34m 网卡配置完成 \e[0m"  "\e[1;32m                    [ OK ] \e[0m"
else
    #color "网卡配置失败 " 1
    echo -e "\e[1;35m 网卡配置失败! \e[0m"  "\e[1;31m                    [ FAILED ] \e[0m"
    exit
fi

}




configure_redhat6_IP_address(){

rpm -qa ifconfig

[ $? -eq 0 ] || yum -y install net-tools

local NET1=`ifconfig | head -n 1 | cut -d: -f1`

echo -e "\n\e[1;35m现在的网卡名是: $NET1 \e[0m"

echo -e "\e[1;34m需要自行查看是否匹配 \e[0m\n"

read -p "输入网卡名: " NET

#echo -e '\n'
#if [[ ! "$NET" ==  ]];then echo "请检查网卡名是否正确"; exit; fi
#echo -e "\n\e[1;34m需要自行查看是否匹配 \e[0m\n"

while :;do

read -p "输入ip: " IP


if [[ "$IP" =~ ^([0-9]{1,3}.){3}[0-9]{1,3}$ ]];then
    echo -e "\n\e[1;34m输入地址正确，继续下一步 \e[0m" "\e[1;32m                [ OK ] \e[0m\n"
    break
else
    #echo  -e "\n\e[1;35m请检查IP地址是否正确! \e[0m"   "\e[1;31m                    [ FAILED ] \e[0m\n"
    #exit
    echo  -e "\e[1;33m输入地址不符合要求，请重新输入 \e[0m\n"
fi

done

while :;do
echo -e "\n\e[1;34m现在支持输入8/16/24/32\e[0m"
read -p "输入子网掩码位数:" PREFIX
#两种写法都可以
#if [  $PREFIX -eq 8 -o $PREFIX -eq 16 -o $PREFIX -eq 24 -o $PREFIX -eq 32 ];then
if [[  $PREFIX =~ 8|16|24|32 ]];then
    echo -e "\n\e[1;34m输入正确，继续下一步 \e[0m" "\e[1;32m                    [ OK ] \e[0m\n"
    break
else
    #echo -e "\n\e[1;36m请检查子网掩码地址是否正确! \e[0m"  "\e[1;31m                    [ FAILED ] \e[0m\n"
    #exit
    echo  -e "\e[1;33m输入不符合要求，请重新输入 \e[0m\n"
fi


done



while :;do

read -p "输入网关:" GATEWAY

if [[ "$GATEWAY" =~ ^([0-9]{1,3}.){3}[0-9]{1,3}$ ]];then 
    echo -e "\n\e[1;34m输入地址正确，继续下一步 \e[0m" "\e[1;32m                [ OK ] \e[0m\n"
    break
else
    #echo -e "\n\e[1;35m请检查网关地址是否正确! \e[0m"  "\e[1;31m                    [ FAILED ] \e[0m\n"
    #exit
    echo  -e "\e[1;33m输入地址不符合要求，请重新输入 \e[0m\n"
fi

done

while :;do

read -p "输入DNS:" DNS
#if [[  "$DNS" =~ ^[0-255.]{1,3}[0-255]$ ]];then echo "请检查dns地址是否正确"; exit; fi


if [[ "$DNS" =~ ^([0-9]{1,3}.){3}[0-9]{1,3}$ ]];then 
    echo -e "\n\e[1;34m输入地址正确，正在写入配置... \e[0m" "\e[1;32m                [ OK ] \e[0m\n"
    break
else
    #echo -e "\n\e[1;35m请检查DNS地址是否正确! \e[0m"  "\e[1;31m                    [ FAILED ] \e[0m\n"
    #exit
    echo  -e "\e[1;33m输入地址不符合要求，请重新输入 \e[0m\n"
fi

done



cat > /etc/sysconfig/network-scripts/ifcfg-$NET <<EOF
NAME=$NET
DEVICE=$NET
IPADDR=$IP
BOOTPROTO=none
PREFIX=$PREFIX
GATEWAY=$GATEWAY
ONBOOT=yes
DNS1=$DNS
DNS2=8.8.8.8
EOF

#nmcli con reload && nmcli con up $NET

service network restart


if [ $? -eq 0 ];then
    #color "网卡配置完成 " 0
    echo -e "\e[1;34m 网卡配置完成 \e[0m"  "\e[1;32m                    [ OK ] \e[0m"
else
    #color "网卡配置失败 " 1
    echo -e "\e[1;35m 网卡配置失败! \e[0m"  "\e[1;31m                    [ FAILED ] \e[0m"
    exit
fi

}

#添加了循环控制，输错不用再重新执行了脚本了
configure_ubuntu_IP_address(){



while :;do

read -p "输入IP:" IP

if [[  "$IP" =~ ^([0-9]{1,3}.){3}[0-9]{1,3}$ ]];then
    echo -e "\n\e[1;34m输入正确，继续下一步 \e[0m"  "\e[1;32m                    [ OK ] \e[0m\n"
    break
else
    #echo -e "\n\e[1;35m请检查IP地址是否正确! \e[0m"  "\e[1;31m                     [ FAILED ] \e[0m\n"
    #exit
    echo  -e "\e[1;33m输入地址不符合要求，请重新输入 \e[0m\n"
fi

done


while :;do


read -p "输入网关:" GATEWAY

if [[  "$GATEWAY" =~ ^([0-9]{1,3}.){3}[0-9]{1,3}$ ]];then
    echo -e "\n\e[1;34m输入正确，继续下一步 \e[0m"  "\e[1;32m                    [ OK ] \e[0m\n"
    break
else
    #echo -e "\n\e[1;35m请检查网关地址是否正确! \e[0m"  "\e[1;31m                    [ FAILED ] \e[0m\n"
    #exit
    echo  -e "\e[1;33m输入地址不符合要求，请重新输入 \e[0m\n"
fi

done


while :;do
echo -e "\n\e[1;34m现在支持输入8/16/24/32\e[0m"
read -p "输入子网掩码位数:" PREFIX
#两种写法都可以
#if [  $PREFIX -eq 8 -o $PREFIX -eq 16 -o $PREFIX -eq 24 -o $PREFIX -eq 32 ];then
if [[  $PREFIX =~ 8|16|24|32 ]];then
    echo -e "\n\e[1;34m输入正确，继续下一步 \e[0m"  "\e[1;32m                    [ OK ] \e[0m\n"
    break
else
    #echo -e "\n\e[1;36m请检查子网掩码地址是否正确! \e[0m"  "\e[1;31m                    [ FAILED ] \e[0m\n"
    #exit
    echo  -e "\e[1;33m输入不符合要求，请重新输入 \e[0m\n"
fi


done


while :;do

read -p "输入DNS1:" DNS1

if [[  "$DNS1" =~ ^([0-9]{1,3}.){3}[0-9]{1,3}$ ]];then
    echo -e "\n\e[1;34m输入正确，继续下一步 \e[0m"  "\e[1;32m                    [ OK ] \e[0m\n"
    break
else
    #echo -e "\n\e[1;35m请检查DNS1地址是否正确! \e[0m"  "\e[1;31m                    [ FAILED ] \e[0m\n"
    #exit
    echo  -e "\e[1;33m输入地址不符合要求，请重新输入 \e[0m\n"
fi

done



while :;do

read -p "输入网关2:" DNS2

if [[  "$DNS2" =~ ^([0-9]{1,3}.){3}[0-9]{1,3}$ ]];then
    echo -e "\n\e[1;34m输入正确，正在写入配置... \e[0m"  "\e[1;32m                    [ OK ] \e[0m\n"
    break
else
    #echo -e "\n\e[1;35m请检查DNS2地址是否正确! \e[0m"  "\e[1;31m                    [ FAILED ] \e[0m\n"
    #exit
    echo  -e "\e[1;33m输入地址不符合要求，请重新输入 \e[0m\n"
fi

done


mv /etc/netplan/*.yaml  /etc/netplan/*.yaml.bak 
sleep 1

cat > /etc/netplan/eth0.yaml <<EOF
network:
  version: 2
  renderer: networkd
  ethernets:
    eth0:
      addresses: [${IP}/${PREFIX}] #或者用下面两行,两种格式不能混用
      #- 192.168.8.10/24
      #- 10.0.0.10/8
      gateway4: ${GATEWAY}
      nameservers:
        search: [magedu.com,  magedu.org]
        addresses: [${DNS1}, ${DNS2}]
EOF

netplan apply

}



#添加vi的别名，比较方便
set_alias(){

cat >>~/.bashrc <<EOF
alias cdnet='cd /etc/sysconfig/network-scripts/'
alias vi='vim'
EOF


echo -e "\033[1;34m添加完成\033[0m"
#if [ $? -eq 0 ];then
#color "别名修改成功 " 0
#    echo -e "\033[1;34m 别名修改成功! \033[0m\n"  "\033[1;32m                    [ OK ] \033[0m"
#else
#   #color "别名修改失败 " 1
#   echo -e "\e[1;35m 别名修改失败! \e[0m\n"  "\e[1;31m                    [ FAILED ] \e[0m"
#    exit
#fi
exec bash

}

#\E[$[RANDOM%7+31];1m



#颜色改成随机颜色了，不想随机可以直接切换固定颜色
set_PS1(){

${PURPLE}现在是随机颜色，想要固定颜色退出脚本自行修改脚本${END}

sleep 2

if [ $ID = 'centos' -o $ID = 'rocky' ];then
    echo  "PS1='\[\e[1;34m\][\[\e[$[RANDOM%7+31]m\]\u\[\e[$[RANDOM%7+31]m\]@\[\e[$[RANDOM%7+31]m\]\h\[\e[$[RANDOM%7+31]m\] \W\[\e[34m\]]\\$\[\e[0m\]'" >> /etc/bashrc
    #echo  "PS1='\[\e[1;36m\][\[\e[34m\]\u\[\e[35m\]@\[\e[32m\]\h\[\e[31m\]\W\[\e[36m\]]\\$\[\e[0m\]'" >> /etc/bashrc
    #color "修改成功 " 0
    echo -e "\033[1;34m修改成功！ \033[0m"  "\033[1;32m                    [ OK ] \033[0m"
    exec bash
else
    echo  "PS1='\[\e[1;34m\][\[\e[$[RANDOM%7+31]m\]\u\[\e[$[RANDOM%7+31]m\]@\[\e[$[RANDOM%7+31]m\]\h\[\e[$[RANDOM%7+31]m\] \W\[\e[34m\]]\\$\[\e[0m\]'" >> ~/.bashrc
    #echo "PS1='\[\e[1;35m\][\[\e[35m\]\u\[\e[35m\]@\[\e[35m\]\h \[\e[36m\]\W\[\e[35m\]]\\$\[\e[0m\]'" >> ~/.bashrc
    #color "修改成功 " 0
    echo -e "\033[1;35m修改成功！ \033[0m"  "\033[1;32m                    [ OK ] \033[0m"
    exec bash
fi

}

set_c6_PS1(){
    echo  "PS1='\[\e[1;34m\][\[\e[$[RANDOM%7+31]m\]\u\[\e[$[RANDOM%7+31]m\]@\[\e[$[RANDOM%7+31]m\]\h\[\e[$[RANDOM%7+31]m\] \W\[\e[34m\]]\\$\[\e[0m\]'" >> /etc/bashrc
    exec bash 
}




#set_PS2(){
#if [ $ID = 'centos' -o $ID = 'rocky' ];then
#    echo  "PS1='\[\e[1;36m\][\[\e[34m\]\u\[\e[35m\]@\[\e[32m\]\h\[\e[31m\]\W\[\e[36m\]]\\$\[\e[0m\]'" >> /etc/bashrc
#    color "修改成功 " 0
#    exec bash
#else
#    echo "PS1='\[\e[1;35m\][\[\e[35m\]\u\[\e[35m\]@\[\e[35m\]\h \[\e[36m\]\W\[\e[35m\]]\\$\[\e[0m\]'" >> ~/.bashrc
#    color "修改成功 " 0
#    exec bash
#fi
#}

set_hostname(){

read -p "请输入主机名: " HOST
hostnamectl set-hostname $HOST
    #color "修改完成"  0
    echo -e "\033[1;35m设置成功！ \033[0m"  "\033[1;32m                    [ OK ] \033[0m"
exec bash

}

set_redhat_netname(){

rpm -qa ifconfig || yum -y install net-tools

#[ $? -eq 0 ] || yum -y install net-tools

local NET1=`ifconfig | head -n 1 | cut -d: -f1`

ip a

echo -e "\n\e[1;35m现在的网卡名是: $NET1 \e[0m"

echo -e "\e[1;34m需要自行查看是否匹配 \e[0m\n"


read -p "请输入需要修改的网卡名: " NAME
cp /etc/sysconfig/network-scripts/ifcfg-$NAME /etc/sysconfig/network-scripts/ifcfg-eth0
sed -i.bak 's/ens.*/eth0/' /etc/sysconfig/network-scripts/ifcfg-eth0
sed -i '/^GRUB_CMDLINE_LINUX=/s#"$# net.ifnames=0"#'  /etc/default/grub
#sed -ri 's/^(GRUB_CMDLINE_LINUX=.*)"$/\1 net.ifnames=0"/' /etc/default/grub


grub2-mkconfig -o /etc/grub2.cfg

if [ $? -eq 0 ];then	
    echo -e "\033[1;32m配置完成,重启生效! \033[0m"  "\033[1;32m                    [ OK ] \033[0m"
else
    echo -e "\e[1;31m配置失败! \e[0m"  "\e[1;31m                    [ FAILED ] \e[0m"
fi

}


set_ubuntu_netname(){
mv /etc/netplan/*.yaml  /etc/netplan/*.yaml.backup
cat >> /etc/netplan/00-installer-config.yaml <<EOF
network:
  ethernets:
    eth0:
      dhcp4: true
  version: 2
EOF

sed -i '/^GRUB_CMDLINE_LINUX=/s#"$#net.ifnames=0"#'  /etc/default/grub
    grub-mkconfig -o /boot/grub/grub.cfg
if [ $? -eq 0 ];then
    echo -e "\e[1;32m配置完成,重启生效! \e[0m"
    netplan apply
else
    echo -e "\e[1;31m配置失败! \e[0m"
fi

}



#新添加了set nu set paste  set ts=4 set shiftwidth=4 set expandtab set autoindent
set_vim(){
#set number
#set nobackup
#set gfn=Courier_New:h12
#syntax on
#set smartindent
#set shiftwidth=4
#set ts=4
#set autoindent
#set ai!

read -p "请输入作者名:" AUTHOR
read -p "请输入QQ号:" QQ
read -p "请输入博客地址:" URL
read -p "请输入邮箱:" MAIL
cat >~/.vimrc<<EOF
set paste
set ts=4
set shiftwidth=4
set expandtab
set ignorecase
set autoindent
autocmd BufNewFile *.sh exec ":call SetTitle()"
func SetTitle()
    if expand("%:e") == 'sh'
    call setline(1,"#!/bin/bash")
    call setline(2,"#********************************************************************")
    call setline(3,"#Author:      ${AUTHOR}")
    call setline(4,"#QQ：         ${QQ}")
    call setline(5,"#Date：       ".strftime("%Y-%m-%d"))
    call setline(6,"#FileName：   ".expand("%"))
    call setline(7,"#EMAIL：      ${MAIL}")
    call setline(8,"#BLOG：       ${URL}")
    call setline(9,"#Description：路漫漫其修远兮，吾将上下而求索")
    call setline(10,"#********************************************************************")
    call setline(11,"")
    endif
endfunc
autocmd BufNewFile * normal G
EOF
[ $? -eq 0 ] && echo -e "\e[1;35m设置完成 \e[0m"  "\e[1;32m			[ ok ] \e[0m"
#exec bash
}



#新添加开机后的显示，想该啥样就改啥样
set_motd(){


echo -e  "\E[$[RANDOM%7+31];1m"

    cat > /etc/motd <<-EOF


*****************************************
*******   路漫漫其修远兮  ***************
*************   吾将上下而求索  *********
*****************************************


EOF

echo -e "\E[0m"
[ $? -eq 0 ] && echo -e "\e[1;34m 设置完成 \e[0m"  "\e[1;32m            [ ok ] \e[0m"
}


set_motd1(){


echo -e  "\E[$[RANDOM%7+31];1m"

    cat > /etc/motd <<-EOF
                  _oo0oo_
                 088888880
                 88" . "88
                 (| -_- |)
                  0\ = /0
               ___/'---'\___
             .' \\\\\\\| |//// '.
            / \\\\\\\|||:|||//// \       
           /_ ||||| -:- ||||| _\         
          |   | \\\-/////  |   | |
          | \_|  ''\---/''  |_/ |
          \  .-\__  '-'  __/-.  /
        ___'. .'  /--.--\  '. .'___
     ."" '<  '.___\_<|>_/___.' >'  "".
    | | : '-  \'.;'\ _ /';.'/ - ' : | |
    \  \ '_.   \_ __\ /__ _/   ._' /  /
====='-.____'.___ \_____/___.-'____.-'=====

^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
        佛祖保佑    iii    永不死机

EOF

echo -e "\E[0m"
[ $? -eq 0 ] && echo -e "\e[1;34m 设置完成 \e[0m"  "\e[1;32m            [ ok ] \e[0m"
}





#只是修改时区不是时间同步
set_timezone(){

#timedatectl set-timezone Asia/Shanghai 也可以设置成功

rm -f /etc/localtime

ln -s /usr/share/zoneinfo/Asia/Shanghai   /etc/localtime

timedatectl

[ $? -eq 0 ] && echo -e "\e[1;34m 时区设置完成 \e[0m"  "\e[1;32m            [ ok ] \e[0m"

}


binInstallMysql5736(){
initialize_variables "binInstallMysql5736"


echo -e "\e[1;33m注意：MySQL8.0以上版本没有测试！当前只测试了一个版本！ \e[0m"
echo -e "\e[1;35m数据库数据文件夹现在是${DATA_DIR}  解压目录是${DIR} \e[0m"
echo -e "\e[1;35m现在安装的版本是${version},如果不想安装此版本请在5秒内停止运行脚本 \e[0m\n"
for i in {5..1}
do
    echo -n "${i} "
    echo -ne "\r"
    sleep 1
done

    echo -e "\e[1;35m=============================安装依赖包============================= \e[0m" 
    if [ $ID == "rocky" -o $ID == "centos" ];then
        yum -y install libaio numactl-libs ncurses-compat-libs
    else
        apt update &> /dev/null
        apt -y install libaio numactl-libs ncurses-compat-libs
    fi

    [ $? -eq 0 ] && echo -e "\e[1;32m                                                          [  ok  ] \e[0m" || echo -e "\e[1;31m                false \e[0m"

    if id mysql &> /dev/null;then
        echo -e "\e[1;33m 用户已存在 \e[0m"
    else
        groupadd -g 336 -r mysql && useradd -g mysql -s /sbin/nologin -d /data/mysql -r -u 336 mysql
        echo -e "\e[1;32m MySQL用户创建完成 \e[0m"
    fi

    if [ -e mysql-${version}-linux-glibc2.12-x86_64.tar.gz ];then
        echo -e "\e[1;33m 安装包已存在，准备安装... \e[0m"
    else
        echo -e "\e[1;35m 开始下载源文件... \e[0m"  
	    wget $URL
        if [ $? -eq 0 ];then
             echo -e "\e[1;32m 下载成功 \e[0m"
        else
             echo -e "\e[1;31m 下载失败,即将退出,请检查下载链接是否正确！ \e[0m"
             exit
        fi
    fi
    
    echo -e "\e[1;35m=============================解压源文件============================= \e[0m" 
    tar xvf mysql-${version}-linux-glibc2.12-x86_64.tar.gz  -C /usr/local/
    
    echo -e "\e[1;35m 解压完成! \e[0m"
    sleep 1
    
    echo -e "\e[1;35m=============================创建软链接============================= \e[0m"
    ln -s /usr/local/mysql-${version}-linux-glibc2.12-x86_64/ /usr/local/mysql
    chown -R root.root /usr/local/mysql/
    [ $? -eq 0 ] && echo -e "\e[1;32m                                                           [  ok  ] \e[0m" || echo -e "\e[1;31m                false \e[0m"
    sleep 1
    
    echo -e "\e[1;35m============================建立环境变量============================ \e[0m"
    echo 'PATH=/usr/local/mysql/bin:$PATH' > /etc/profile.d/mysql.sh 
    . /etc/profile.d/mysql.sh

    if [ -e /etc/my.cnf ];then
        cp /etc/my.cnf{,.bak}
    else
    cat > /etc/my.cnf <<EOF
[mysqld]
datadir=$DATA_DIR
skip_name_resolve=1
socket=/data/mysql/mysql.sock
log-error=/data/mysql/mysql.log
pid-file=/data/mysql/mysql.pid
character-set-server=utf8mb4
[client]
socket=/data/mysql/mysql.sock
default-character-set=utf8mb4
[mysql]
prompt=(\u@\h) [\d]>\_
EOF
fi
    [ ! -d /data/mysql ] && mkdir -p /data/mysql
    mysqld --initialize-insecure --user=mysql --datadir=/data/mysql
[ $? -eq 0 ] && echo -e "\e[1;32m                                                           [  ok  ] \e[0m" || echo -e "\e[1;31m                false \e[0m"
    sleep 1
    
    echo -e "\e[1;35m=========================复制系统service文件======================== \e[0m"
    cp /usr/local/mysql/support-files/mysql.server  /etc/init.d/mysqld
    [ $? -eq 0 ] && echo -e "\e[1;32m                                                           [  ok  ] \e[0m" || echo -e "\e[1;31m                false \e[0m"
    chkconfig --add mysqld
    echo -e "\e[1;35m=============================启动数据库============================= \e[0m"
    service mysqld start
    
    echo -e "\e[1;35m 可以通过systemctl启动mysqld \e[0m"
    [ $? -eq 0 ] && echo -e "\e[1;35m 数据库启动成功 \e[0m" || { echo -e "\e[1;35m 数据库启动失败 \e[0m";exit; }
    
    echo -e "\e[1;35m 现在是空密码，需要自己修改密码 \e[0m"
    
    echo -e "\e[1;35m 修改密码命令mysqladmin -uroot password 新密码 \e[0m"

exec bash

}




rpm_install_mysql57(){
echo -e "\n\e[1;35mcentos7版本安装mysql-community-server5.7\e[0m"
echo -e "\e[1;35m如果不想安装此版本请在5秒内停止运行脚本\e[0m"

for i in {5..1}
do
    echo -n "${i} "
    echo -ne "\r"
    sleep 1
done

if [ -e /etc/yum.repos.d/mysql-community.repo ];then
    echo -e "\n\e[1;35mrepo仓库已存在\e[0m"
else
    echo -e "\n\e[1;35m配置repo仓库安装mysql-community-server5.7\e[0m"
cat >> /etc/yum.repos.d/mysql-community.repo << EOF
[mysql-5.7-community]
name=MySQL 5.7 Community Server
baseurl=https://mirrors.tuna.tsinghua.edu.cn/mysql/yum/mysql-5.7-community-el7-\$basearch/
gpgcheck=0
EOF
[ $? -eq 0 ] &&  echo -e "\n\e[1;35m配置完成\e[0m" || echo -e "\n\e[1;35m配置失败\e[0m"
fi


rpm -q mysql-community-server  &>/dev/null && echo -e "\n\e[1;35mmysql-community-server5.7已安装\e[0m" || { yum -y install mysql-community-server;}

echo -e "\n\e[1;35m配置mysqld开机自启\e[0m"
systemctl enable --now mysqld
[ $? -eq 0 ] && color " " 0 ||  { color " " 1 ;exit; }


local PASSWD=`cat /var/log/mysqld.log  | grep  'password is generated' | awk '{print $NF}'`
echo -e "\n\e[1;35m初始密码是: \e[0m"$PASSWD
#read -p "输入新密码(需要大小写数字特殊字符才可以，不然报错！):" NEWPASSWD
#local sql="alter user root@'localhost' identified by '$NEWPASSWD';"
#mysql -uroot -p'e)=Zgpc<p3rs' -e "$sql"
#mysql -uroot -p'$NEWPASSWD'
echo -e "\n\e[1;35m修改密码的SQL是:\e[0m alter user root@'localhost' identified by '新密码';"
echo -e "\n\e[1;33m新密码需要大小写加特殊字符，数字等，否则修改会失败\e[0m"
}



















rpm_install_mysql8(){
echo -e "\n\e[1;35mcentos7版本安装mysql-community-server8.0\e[0m"
echo -e "\e[1;35m如果不想安装此版本请在5秒内停止运行脚本\e[0m"

for i in {5..1}
do
    echo -n "${i} "
    echo -ne "\r"
    sleep 1
done

if [ -e /etc/yum.repos.d/mysql-community.repo ];then
    echo -e "\n\e[1;35mrepo仓库已存在\e[0m"
else
    echo -e "\n\e[1;35m配置repo仓库安装mysql-community-server8.0\e[0m"
cat > /etc/yum.repos.d/mysql-community.repo << EOF
[mysql-8.0-community]
name=MySQL 8.0 Community Server
baseurl=https://mirrors.tuna.tsinghua.edu.cn/mysql/yum/mysql-8.0-community-el7-\$basearch/
gpgcheck=0
EOF
[ $? -eq 0 ] &&  echo -e "\n\e[1;35m配置完成\e[0m" || echo -e "\n\e[1;35m配置失败\e[0m"
fi


rpm -q mysql-community-server  &>/dev/null && echo -e "\n\e[1;35mmysql-community-server8.0已安装\e[0m" || { yum -y install mysql-community-server;}

echo -e "\n\e[1;35m配置mysqld开机自启\e[0m"
systemctl enable --now mysqld
[ $? -eq 0 ] && color " " 0 ||  { color " " 1 ;exit; }


local PASSWD=`cat /var/log/mysqld.log  | grep  'password is generated' | awk '{print $NF}'`
echo -e "\n\e[1;35m初始密码是: \e[0m"$PASSWD
#read -p "输入新密码(需要大小写数字特殊字符才可以，不然报错！):" NEWPASSWD
#local sql="alter user root@'localhost' identified by '$NEWPASSWD';"
#mysql -uroot -p'e)=Zgpc<p3rs' -e "$sql"
#mysql -uroot -p'$NEWPASSWD'
echo -e "\n\e[1;35m修改密码的SQL是:\e[0m alter user root@'localhost' identified by '新密码';"
echo -e "\n\e[1;33m新密码需要大小写加特殊字符，数字等，否则修改会失败\e[0m"
}















binInstallMariadbVersion10103(){
#echo -e "\e[1;35m 只在centos7.9版本测试正常，CentOS-6版本测试不成功\e[0m"
local SYSVERSION=`cat /etc/redhat-release | awk -F"." '{print $1}' | awk '{print $NF}'`
#local SYSVERSION1=`sed -rn 's/.* ([0-9])\..*/\1/p' /etc/redhat-release`
[ $SYSVERSION -eq 7 ] && echo -e "\n\e[1;33m当前系统为$SYSVERSION 脚本支持安装 \e[0m" || { echo -e "\n\e[1;31m当前系统为$SYSVERSION 脚本不支持安装\e[0m";exit; }
#exit
local version=10.10.3
#URL=https://dlm.mariadb.com/2690820/MariaDB/mariadb-10.10.2/bintar-linux-systemd-x86_64/mariadb-${version}-linux-systemd-x86_64.tar.gz
#URL=https://downloads.mysql.com/archives/get/p/23/file/mysql-8.0.30-linux-glibc2.12-x86_64.tar.xz
#URL=https://mirrors.tuna.tsinghua.edu.cn/mariadb/mariadb-10.6.11/bintar-linux-systemd-x86_64/mariadb-10.6.11-linux-systemd-x86_64.tar.gz
#URL=https://mirrors.tuna.tsinghua.edu.cn/mariadb/mariadb-${version}/bintar-linux-systemd-x86_64/mariadb-${version}-linux-systemd-x86_64.tar.gz
#echo -e "\e[1;35m 阿里源下载链接:\e[0m"https://mirrors.aliyun.com/mariadb/mariadb-${version}/bintar-linux-systemd-x86_64/mariadb-${version}-linux-systemd-x86_64.tar.gz
#echo -e "\e[1;35m 清华源下载链接:\e[0m"https://mirror.tuna.tsinghua.edu.cn/mariadb/mariadb-${version}/bintar-linux-systemd-x86_64/mariadb-${version}-linux-systemd-x86_64.tar.gz
URL=https://mirrors.aliyun.com/mariadb/mariadb-${version}/bintar-linux-systemd-x86_64/mariadb-${version}-linux-systemd-x86_64.tar.gz
local DATA_DIR=/data/mysql/
local DIR=/usr/local/
#echo -e "\e[1;35m 如果原始下载链接失败，可以重新执行尝试其他下载链接或者提前准备好压缩包文件放在root目录下\e[0m"
#echo -e "\e[1;35m 下面请输入下载链接:\e[0m"
#read -p "" URL
echo -e "\n\e[1;35m数据库数据文件夹现在是${DATA_DIR}  解压目录是${DIR} \e[0m"
echo -e "\e[1;35m接下来安装的版本是mariadb-${version},如果不想安装此版本请在5秒内停止运行脚本 \e[0m"
for i in {5..1}
do
    echo -n "${i} "
    echo -ne "\r"
    sleep 1
done

echo -e "\e[1;35m=============================用户创建=============================== \e[0m"

echo -e '\a'
   if id mysql &> /dev/null;then
       echo -e "\n\e[1;33m 用户已存在 \e[0m"
   else
       groupadd -g 336 -r mysql && useradd -g mysql -s /sbin/nologin -d ${DATA_DIR} -r -u 336 mysql
       #echo -e "\e[1;35m MySQL用户创建完成 \e[0m"    "\e[1;32m           [ ok ] \e[0m"
       [ $? -eq 0 ] && echo -e "\n\e[1;35m MySQL用户创建完成 \e[0m" || { echo -e "\n\e[1;31m MySQL用户创建失败 \e[0m";exit; }
   fi 
echo -e "\e[1;35m============================下载源文件=============================== \e[0m"
   if [ -e mariadb-${version}-linux-systemd-x86_64.tar.gz ];then
      echo -e "\n\e[1;33m 文件已存在，准备安装... \e[0m"
   else
      echo -e "\n\e[1;33m 开始下载源文件(下载地址是阿里源，如果yum源配的没有阿里源可能会下载失败) \e[0m"
      rpm -q wget &>/dev/null || yum -y install wget &>/dev/null
      wget $URL && echo -e "\n\e[1;33m 下载成功\e[0m" || { echo -e "\n\e[1;33m 下载链接失效，请尝试更换其他下载链接或者提前准备好压缩包文件放在root目录下\e[0m" ;exit; }
   fi

#[ -e mariadb-${version}-linux-systemd-x86_64.tar.gz ] && { echo "\e[1;34m 下载成功 \e[0m" } || { echo -e "\e[1;36m 下载失败,即将退出 \e[0m";exit; }

echo -e "\n\e[1;35m==========================解压源文件===============================\e[0m"

sleep 2

#tar xzvf mariadb-${version}-linux-systemd-x86_64.tar.gz  -C ${DIR}
tar xzf mariadb-${version}-linux-systemd-x86_64.tar.gz  -C ${DIR}
[ $? -eq 0 ] && echo -e "\n\e[1;35m 解压完成! \e[0m"

echo -e "\e[1;32m                   [ ok ] \e[0m"  

sleep 1

echo -e "\e[1;35m=============================创建软链接===============================\e[0m"
ln -s /usr/local/mariadb-${version}-linux-systemd-x86_64 ${DIR}mysql


[ $? -eq 0 ] && echo -e "\e[1;32m                   [ ok ] \e[0m"

sleep 1

echo -e "\e[1;35m============================建立环境变量=============================\e[0m"
echo "PATH=${DIR}mysql/bin:$PATH" > /etc/profile.d/mysql.sh
. /etc/profile.d/mysql.sh



[ $? -eq 0 ] && echo -e "\e[1;32m                   [ ok ] \e[0m"

sleep 1

echo -e "\e[1;35m============================创建数据文件夹=============================\e[0m"  
mkdir -p /data/mysql
chown -R  mysql.mysql ${DATA_DIR}
chown -R  mysql.mysql ${DIR}mysql

sleep 1

echo -e "\e[1;32m                   [ ok ] \e[0m"

echo -e "\e[1;33m=============================初始化数据库=============================\e[0m\n" 
${DIR}mysql/scripts/mysql_install_db  --user=mysql --basedir=${DIR}mysql --datadir=${DATA_DIR}



#添加client才能启动成功
cat > /etc/my.cnf << EOF
[mysqld]
datadir=${DATA_DIR}
socket=${DATA_DIR}mysql.sock
symbolic-links=0
character-set-server=utf8mb4

[mysqld_safe]
log-error=/data/mariadb/mariadb.log
pid-file=/data/mariadb/mariadb.pid

[client]
socket=/data/mysql/mysql.sock  
default-character-set=utf8mb4

!includedir /etc/my.cnf.d
EOF

if [ $? -eq 0 ];then
    echo -e "\e[1;35m 初始化数据库 \e[0m\n"  "\e[1;32m                       [ ok ] \e[0m"
else
    echo -e "\e[1;31m 初始化数据库 \e[0m\n"  "\e[1;31m                    [ FAILED ] \e[0m"
    exit
fi

echo -e "\e[1;35m===========================创建log和pid文件夹=============================\e[0m\n"  "\e[1;32m                       [ ok ] \e[0m"
mkdir ${DATA_DIR}{log,pid}
chown -R mysql.mysql ${DATA_DIR}

echo -e "\n\e[1;35m=========================复制systemd配置文件=============================\e[0m\n"
#ln -s mariadb-${version}-linux-systemd-x86_64/ mysql
cp /usr/local/mysql/support-files/systemd/mariadb.service  /lib/systemd/system/

if [ $? -eq 0 ];then
    echo -e "\e[1;35m 复制systemd配置文件 \e[0m\n"  "\e[1;32m                       [ ok ] \e[0m"
else
    echo -e "\e[1;31m 复制systemd配置文件 \e[0m\n"  "\e[1;31m                   [ FAILED ] \e[0m"
    exit
fi

#echo -e "\n\e[1;33m 正在启动服务 \e[0m"

systemctl daemon-reload 

#systemctl start mariadb
systemctl enable --now mariadb

if [ $? -eq 0 ];then
    echo -e "\e[1;35m 启动服务成功！ \e[0m"
else
    echo -e "\e[1;31m 启动服务失败！ \e[0m"
    exit
fi

#cat >> /etc/my.cnf.d/mysql-clients.cnf << EOF
#[mysql]
#socket=${DATA_DIR}mysql.sock
#EOF

ln -s ${DIR}mysql/bin/mariadb   /usr/bin/mysql


exec bash

}






yumInstallMariadbVersion1151(){

echo -e "\n\e[1;35m本次安装的是11.5.1版本\e[0m"
echo -e "\n\e[1;35m不想安装请在五秒内终止脚本\e[0m\n"
for i in {5..1}
do
    echo -n "${i} "
    echo -ne "\r"
    sleep 1
done

yum -y remove mariadb*

[ -a /etc/yum.repos.d/mariadb.repo ] && rm -f /etc/yum.repos.d/mariadb.repo


cat > /etc/yum.repos.d/mariadb.repo <<EOF
[mariadb11.5.1]
name = MariaDB
baseurl = https://mirrors.tuna.tsinghua.edu.cn/mariadb/yum/11.5.1/centos7-amd64/
gpgkey=https://mirrors.tuna.tsinghua.edu.cn/mariadb/yum/RPM-GPG-KEY-MariaDB
gpgcheck=1
enabled=1
EOF


yum clean all && yum makecache

yum -y install mariadb mariadb-devel mariadb-libs mariadb-server
systemctl enable --now  mariadb
}


















install_nginx1(){
initialize_variables "install_nginx1"
echo -e "\e[1;35m 现在安装的版本是$version,如果不想安装此版本请在5秒内停止运行脚本 \e[0m\n"
for i in {5..1}
do
    echo -n "${i} "
    echo -ne "\r"
    sleep 1
done
echo -e "\n\e[1;35m========================检测源文件=============================\e[0m\n"
if [ -e nginx-${version}.tar.gz ];then
	echo "文件存在，安装进行中。。。"
else
    echo "文件不存在，开始下载源码文件。。。"
	wget $URL
	[ $? -eq 0 ] && { echo -e "\e[1;35m下载成功！\e[0m"; } || { echo -e "\e[1;35m下载失败！立即退出！\e[0m";exit; }
fi
echo -e "\n\e[1;35m========================用户检测===============================\e[0m\n"
if id nginx &> /dev/null;then
    echo -e "\e[1;35m用户存在\e[0m"
else
    groupadd -g 990 -r nginx && useradd -g nginx -s /sbin/nologin -r -u 990 nginx
    echo -e "\e[1;35m用户不存在，创建nginx用户\e[0m"
fi

echo -e "\e[1;35m=========================安装依赖包===============================\e[0m"
echo "执行网络检测"
if ping -c 1 www.baidu.com >/dev/null;then
    echo ""
else
    echo -e "\e[1;31m"网络不通"\e[0m"
    
fi
if [ $ID == "rocky" -o $ID == "centos" ];then
    #yum -y install make  gcc gcc-c++ libtool pcre pcre-devel zlib zlib-devel openssl openssl-devel perl-ExtUtils-Embed
    software=("gcc"
        "gcc-c++"
        "glibc"
        "make"
        "pcre"
        "pcre-devel"
        "openssl"
        "openssl-devel"
        "autoconf"
        "automake"
        "libtool"
        "zlib"
        "zlib-devel"
        "perl-ExtUtils-Embed"
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
    apt update &> /dev/null
	apt -y install make gcc libpcre3 libpcre3-dev openssl libssl-dev zlib1g-dev &> /dev/null
fi
echo -e "\e[1;35m=========================解压,编译============================\e[0m"
    tar xf nginx-${version}.tar.gz -C /usr/local/src
    cd /usr/local/src/nginx-${version}
    ./configure --prefix=/apps/nginx \
    --user=nginx \
    --group=nginx \
    --with-http_ssl_module \
    --with-http_v2_module \
    --with-http_realip_module \
    --with-http_stub_status_module \
    --with-http_gzip_static_module \
    --with-pcre \
    --with-stream \
    --with-stream_ssl_module \
    --with-stream_realip_module
    make && make install
    [ $? -eq 0 ] && color "nginx编译成功" 0 ||  { color "nginx编译失败" 1 ;exit; }
    chown -R nginx.nginx /apps/nginx
    ln -s /apps/nginx/sbin/nginx /usr/sbin/

    cat > /lib/systemd/system/nginx.service << EOF
[Unit]
Description=nginx - high performance web server
Documentation=http://nginx.org/en/docs/
After=network-online.target remote-fs.target nss-lookup.target
Wants=network-online.target


[Service]
Type=forking
#PIDFile=/apps/nginx/run/nginx.pid
ExecStart=/apps/nginx/sbin/nginx -c /apps/nginx/conf/nginx.conf
ExecReload=/bin/kill -s HUP \$MAINPID
ExecStop=/bin/kill -s TERM \$MAINPID
LimitNOFILE=100000


[Install]
WantedBy=multi-user.target
EOF
    systemctl daemon-reload
    systemctl enable --now nginx &> /dev/null
    [ $? -eq 0 ] && color "nginx启动 " 0 || { color "nginx启动" 1 ;exit; }

}








update_nginx(){
initialize_variables "update_nginx"

echo -e "\n\e[1;35m更新的版本是nginx-${version}，需要更新其他版本请自行修改代码\e[0m"
echo -e "\n\e[1;35m不想安装请在五秒内终止脚本\e[0m\n"
for i in {5..1}
do
    echo -n "${i} "
    echo -ne "\r"
    sleep 1
done
echo "执行网络检测"
if ping -c 1 www.baidu.com >/dev/null;then
    echo -e "\e[1;31m"网络正常"\e[0m"
else
    echo -e "\e[1;31m"网络不通"\e[0m"
    
fi
echo -e "\n\e[1;35m安装依赖包\e[0m\n"
#yum install -y pcre pcre-devel openssl openssl-devel gcc gcc-c++ autoconf automake make
software=(
    "gcc"
    "gcc-c++"
    "glibc"
    "make"
    "pcre"
    "pcre-devel"
    "openssl"
    "openssl-devel"
    "autoconf"
    "automake"
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

#查看当前nginx版本以及编译模块参数
echo -e "\n\e[1;31m已安装的版本，想退出安装请在五秒内终止脚本\e[0m\n"
/apps/nginx/sbin/nginx -V
#/srun3/nginx/sbin/nginx -V

for i in {5..1}
do
    echo -n "${i} "
    echo -ne "\r"
    sleep 1
done

if [ -e nginx-${version}.tar.gz ];then
    echo -e "\e[1;35m文件已存在,开始安装\e[0m"
else
    echo -e "\e[1;33m文件不存在，开始下载\e[0m"
    wget $URL && echo -e "\e[1;35m下载成功\e[0m" || { echo -e "\e[1;31m下载失败，请检查下载链接是否失效\e[0m" ;exit; }
fi

#解压新版本
echo -e "\n\e[1;35m解压源文件\e[0m"
tar zxf nginx-${version}.tar.gz
cd nginx-${version}

#编译新版本
./configure --prefix=/apps/nginx \
--user=nginx \
--group=nginx \
--with-http_ssl_module \
--with-http_v2_module \
--with-http_realip_module \
--with-http_stub_status_module \
--with-http_gzip_static_module \
--with-pcre \
--with-stream \
--with-stream_ssl_module \
--with-stream_realip_module
#./configure --prefix=/srun3/nginx \
#--conf-path=/srun3/nginx/conf/nginx.conf \
#--sbin-path=/srun3/nginx/sbin/nginx \
#--pid-path=/srun3/nginx/run/nginx.pid \
#--error-log-path=/srun3/nginx/log/nginx-error.log \
#--http-log-path=/srun3/nginx/log/nginx-access.log \
#--user=nginx \
#--group=nginx \
#--with-http_ssl_module \
#--with-http_realip_module \
#--with-http_flv_module \
#--with-http_mp4_module \
#--with-http_gunzip_module \
#--with-http_gzip_static_module \
#--with-http_secure_link_module \
#--with-http_v2_module \
#--with-http_stub_status_module \
#--with-http_sub_module

#只要make无需要make install
make

#可以看到新编译的nginx版本
#objs/nginx -v

echo -e "\n\e[1;35m备份旧的nginx文件\e[0m"
#把之前的旧版的nginx命令备份
#cp /srun3/nginx/sbin/nginx /srun3/nginx/sbin/nginx.bak
cp /apps/nginx/sbin/nginx /apps/nginx/sbin/nginx.bak

[ $? -eq 0 ] && echo -e "\e[1;32m               ok \e[0m" || { echo -e "\e[1;31m               false \e[0m";exit; }

echo -e "\n\e[1;35m复制新版本源文件\e[0m"
#新版本nginx复制到旧版本目录中
#cp -f ./objs/nginx /srun3/nginx/sbin/
cp -f ./objs/nginx /apps/nginx/sbin/

[ $? -eq 0 ] && echo -e "\e[1;32m               ok \e[0m" || { echo -e "\e[1;31m               false \e[0m";exit; }

echo -e "\n\e[1;35m检测\e[0m"
#检测一下
#/srun3/nginx/sbin/nginx -t
/apps/nginx/sbin/nginx -t


echo -e "\n\e[1;35m平滑升级到新版本\e[0m"
#发送信号USR2 平滑升级可执行程序,将存储有旧版本主进程PID的文件重命名为nginx.pid.oldbin,并启动新的nginx
#此时两个master的进程都在运行,只是旧的master不在监听,由新的master监听80
#此时Nginx开启一个新的master进程,这个master进程会生成新的worker进程,这就是升级后的Nginx进程,此时老的进程不会自动退出,但是当接收到新的请求不作处理而是交给新的进程处理。

#先关闭旧nginx的worker进程,而不关闭nginx主进程方便回滚
#向原Nginx主进程发送WINCH信号,它会逐步关闭旗下的工作进程(主进程不退出),这时所有请求都会由新版Nginx处理
#kill -USR2 `cat /run/nginx.pid`
#kill -WINCH `cat /run/nginx.pid.oldbin`

kill -USR2 `cat /apps/nginx/logs/nginx.pid`
kill -WINCH `cat /apps/nginx/logs/nginx.pid.oldbin`

#如果旧版worker进程有用户的请求,会一直等待处理完后才会关闭

#经过一段时间测试,新版本服务没问题,最后发送QUIT信号,退出老的master

#kill -QUIT `cat /run/nginx.pid.oldbin`
kill -QUIT `cat /apps/nginx/logs/nginx.pid.oldbin`

[ $? -eq 0 ] && echo -e "\e[1;32m               ok \e[0m" || echo -e "\e[1;31m               false \e[0m"

#查看版本已经是新版了
echo -e "\n\e[1;35m升级后的版本\e[0m"
#/srun3/nginx/sbin/nginx -V

/apps/nginx/sbin/nginx -V



echo -e "\n\e[1;35m如果想回滚到旧版本，执行以下命令\e[0m"
echo -e "\n\e[1;35mkill -HUP `cat /run/nginx.pid.oldbin`\e[0m"
echo -e "\n\e[1;35mmv /apps/nginx/sbin/nginx.bak /apps/nginx/sbin/nginx\e[0m"
#回滚
#如果升级的版本发现问题需要回滚,可以发送HUP信号,重新拉起旧版本的worker
#kill -HUP `cat /run/nginx.pid.oldbin`
#恢复旧版的文件
#mv /srun3/nginx/sbin/nginx.bak /srun3/nginx/sbin/
#mv /apps/nginx/sbin/nginx.bak /apps/nginx/sbin/nginx
}













update_srunnginx(){
initialize_variables "update_srunnginx"
echo -e "\n\e[1;35m更新的版本是nginx-${version}，centos7安装的4k测试没出现问题\e[0m"
echo -e "\n\e[1;35m请提交准备好对应版本的压缩包放在root目录下，若没有请在五秒内终止脚本\e[0m\n"

for i in {5..1}
do
    echo -n "${i} "
    echo -ne "\r"
    sleep 1
done

echo -e "\n\e[1;35m安装依赖包\e[0m\n"
#openssl库冲突问题
#yum downgrade openssl
#yum install -y pcre pcre-devel openssl openssl-devel gcc gcc-c++ autoconf automake make
software=(
    "gcc"
    "gcc-c++"
    "glibc"
    "make"
    "pcre"
    "pcre-devel"
    "openssl"
    "openssl-devel"
    "autoconf"
    "automake"
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





#查看当前nginx版本以及编译模块参数
echo -e "\n\e[1;31m已安装的版本\e[0m"

/srun3/nginx/sbin/nginx -V

sleep 2

if [ -e nginx-${version}.tar.gz ];then
    echo -e "\n\e[1;35m文件已存在,开始安装\e[0m"
else
    echo -e "\n\e[1;33m文件不存在，开始下载\e[0m"
    wget $URL && echo -e "\e[1;35m下载成功\e[0m" || { echo -e "\e[1;31m下载失败，请检查下载链接是否失效\e[0m" ;exit; }
fi

#解压新版本
echo -e "\n\e[1;35m解压源文件\e[0m"
tar zxf nginx-${version}.tar.gz
cd nginx-${version}

sleep 2

#编译新版本
echo -e "\n\e[1;35m开始编译\e[0m"

#新版本编译参数
./configure --prefix=/srun3/nginx \
--conf-path=/srun3/nginx/conf/nginx.conf \
--sbin-path=/srun3/nginx/sbin/nginx \
--pid-path=/srun3/nginx/run/nginx.pid \
--error-log-path=/srun3/nginx/log/nginx-error.log \
--http-log-path=/srun3/nginx/log/nginx-access.log \
--user=nginx \
--group=nginx \
--with-http_ssl_module \
--with-http_realip_module \
--with-http_flv_module \
--with-http_mp4_module \
--with-http_gunzip_module \
--with-http_gzip_static_module \
--with-http_secure_link_module \
--with-http_v2_module \
--with-http_stub_status_module \
--with-http_sub_module



#老版本编译参数
#./configure --prefix=/srun3/nginx 
#--with-http_ssl_module \
#--with-http_v2_module \
#--with-http_stub_status_module \
#--with-ipv6 \
#--with-pcre \
#--with-http_realip_module \
#--with-http_gunzip_module \
#--with-http_gzip_static_module \
#--with-file-aio \
#--with-cc-opt='-O2 -g -pipe -Wp,-D_FORTIFY_SOURCE=2 -fexceptions -fstack-protector \
#--param=ssp-buffer-size=4 -m64 -mtune=generic'


#只要make无需要make install
make

#可以看到新编译的nginx版本
#objs/nginx -v

echo -e "\n\e[1;35m备份旧的nginx文件\e[0m"
#把之前的旧版的nginx命令备份
cp /srun3/nginx/sbin/nginx /srun3/nginx/sbin/nginx.bak


[ $? -eq 0 ] && echo -e "\e[1;32m               ok \e[0m" || { echo -e "\e[1;31m               false \e[0m";exit; }

echo -e "\n\e[1;35m复制新版本源文件\e[0m"
#新版本nginx复制到旧版本目录中
cp -f ./objs/nginx /srun3/nginx/sbin/

[ $? -eq 0 ] && echo -e "\e[1;32m               ok \e[0m" || { echo -e "\e[1;31m               false \e[0m";exit; }

echo -e "\n\e[1;35m检测\e[0m"
#检测一下
/srun3/nginx/sbin/nginx -t



echo -e "\n\e[1;35m平滑升级到新版本\e[0m"

#centos7上装的0803后版本 pid路径
kill -USR2 `cat /run/nginx.pid`
kill -WINCH `cat /run/nginx.pid.oldbin`
kill -QUIT `cat /run/nginx.pid.oldbin`

#centos6上装的老版本srun  pid路径
#kill -USR2 `cat /var/run/nginx.pid`
#kill -WINCH `cat /var/run/nginx.pid.oldbin`
#kill -QUIT `cat /var/run/nginx.pid.oldbin`




[ $? -eq 0 ] && echo -e "\e[1;32m               ok \e[0m" || echo -e "\e[1;31m               false \e[0m"

#查看版本已经是新版了
echo -e "\n\e[1;35m升级后的版本\e[0m"
/srun3/nginx/sbin/nginx -V

}







update_srunnginx2(){
initialize_variables "update_srunnginx2"
echo -e "\n\e[1;35m更新的版本是nginx-${version}，在centos6上测试的\e[0m"
echo -e "\n\e[1;35m如果不想安装此版本请在五秒内终止脚本\e[0m"
echo -e "\n\e[1;35m请提前准备好对应版本的压缩包放在root目录下，若没有请在五秒内终止脚本\e[0m\n"

for i in {5..1}
do
    echo -n "${i} "
    echo -ne "\r"
    sleep 1
done

echo -e "\n\e[1;35m安装依赖包\e[0m\n"
#解决openssl库冲突问题
#true是外部命令效率低
#yum downgrade openssl -y || true
yum downgrade openssl -y || :
#yum install -y pcre pcre-devel openssl openssl-devel gcc gcc-c++ autoconf automake make
software=(
    "gcc"
    "gcc-c++"
    "glibc"
    "make"
    "pcre"
    "pcre-devel"
    "openssl"
    "openssl-devel"
    "autoconf"
    "automake"
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





#查看当前nginx版本以及编译模块参数
echo -e "\n\e[1;31m已安装的版本\e[0m"

/srun3/nginx/sbin/nginx -V

sleep 2

if [ -e nginx-${version}.tar.gz ];then
    echo -e "\n\e[1;35m文件已存在,开始安装\e[0m"
else
    echo -e "\n\e[1;33m文件不存在，开始下载\e[0m"
    wget $URL && echo -e "\e[1;35m下载成功\e[0m" || { echo -e "\e[1;31m下载失败，请检查下载链接是否失效\e[0m" ;exit; }
fi

#解压新版本
echo -e "\n\e[1;35m解压源文件\e[0m"
tar zxf nginx-${version}.tar.gz
cd nginx-${version}

sleep 2

#编译新版本
echo -e "\n\e[1;35m开始编译\e[0m"



#老版本编译参数,添加--with-http_v2_module --with-http_stub_status_module
./configure --prefix=/srun3/nginx \
--with-http_ssl_module \
--with-http_v2_module \
--with-http_stub_status_module \
--with-ipv6 \
--with-pcre \
--with-http_realip_module \
--with-http_gunzip_module \
--with-http_gzip_static_module \
--with-file-aio \
--with-cc-opt='-O2 -g -pipe -Wp,-D_FORTIFY_SOURCE=2 -fexceptions -fstack-protector --param=ssp-buffer-size=4 -m64 -mtune=generic'


#只要make无需要make install
make

#可以看到新编译的nginx版本
#objs/nginx -v






echo -e "\n\e[1;35m备份旧的nginx文件\e[0m"
#把之前的旧版的nginx命令备份
cp /srun3/nginx/sbin/nginx /srun3/nginx/sbin/nginx.bak


[ $? -eq 0 ] && echo -e "\e[1;32m               ok \e[0m" || { echo -e "\e[1;31m               false \e[0m";exit; }






echo -e "\n\e[1;35m复制新版本源文件\e[0m"
#新版本nginx复制到旧版本目录中
cp -f ./objs/nginx /srun3/nginx/sbin/

[ $? -eq 0 ] && echo -e "\e[1;32m               ok \e[0m" || { echo -e "\e[1;31m               false \e[0m";exit; }





echo -e "\n\e[1;35m检测\e[0m"
#检测一下
/srun3/nginx/sbin/nginx -t






echo -e "\n\e[1;35m平滑升级到新版本\e[0m"

#centos6上装的老版本srun  pid路径
kill -USR2 `cat /var/run/nginx.pid`
sleep 1
kill -WINCH `cat /var/run/nginx.pid.oldbin`
kill -QUIT `cat /var/run/nginx.pid.oldbin`




[ $? -eq 0 ] && echo -e "\e[1;32m               ok \e[0m" || echo -e "\e[1;31m               false \e[0m"

#查看版本已经是新版了
echo -e "\n\e[1;35m升级后的版本\e[0m"
/srun3/nginx/sbin/nginx -V

}



update_openssl(){
initialize_variables "update_openssl"
echo -e "\e[1;35m====================================================================\e[0m"
echo -e "\e[1;35m现在已安装的版本\e[0m"
openssl version

echo -e "\e[1;35m本次安装的版本是openssl-${OpensslVersion}\e[0m"
echo -e "\e[1;35m====================================================================\e[0m"
echo -e "\e[1;35m不想安装请在五秒内终止脚本\e[0m\n"

for i in {5..1}
do
    echo -n "${i} "
    echo -ne "\r"
    sleep 1
done

echo -e "\e[1;35m==========================检查系统=====================================\e[0m"


if [ ${SystemVersion} -eq 7 ];then
    echo -e "\e[1;35m检测系统为centos7允许执行\e[0m"
else
    echo -e "\e[1;31m检测系统不是centos7,脚本不支持\e[0m"
    exit
fi



echo -e "\e[1;35m==========================源文件检查================================\e[0m"
if [ -e "openssl-${OpensslVersion}.tar.gz" ];then
    echo -e "\e[1;35m文件存在\e[0m"
else
    echo -e "\e[1;33m文件不存在，开始下载\e[0m"
    wget --no-check-certificate https://www.openssl.org/source/openssl-${OpensslVersion}.tar.gz
fi




echo "执行网络检测"
if ping -c 1 www.baidu.com >/dev/null;then
    echo -e "\e[1;32m"网络正常"\e[0m"
else
    echo -e "\e[1;31m"网络不通"\e[0m"
    
fi






echo -e "\e[1;35m==========================安装依赖包================================\e[0m"


#yum install  -y gcc gcc-c++ glibc make
software=(
    "gcc"
    "gcc-c++"
    "glibc"
    "make"
    )
for i in ${software[@]}
do
rpm -q $i &> /dev/null && echo -e "$i\t\e[1;32m已安装\e[0m" || { yum -y install $i &> /dev/null; echo -e "$i\t\e[1;35m安装成功\e[0m" ; }
done

echo -e "\e[1;35m===========================解压,编译===============================\e[0m"


tar zxf /root/openssl-${OpensslVersion}.tar.gz
cd /root/openssl-${OpensslVersion}

./config --prefix=/usr/local/openssl -d shared
make
#执行失败的话执行make clean清除make信息
#[ $? -eq 0 ] || make clean
sleep 1
make install


echo -e "\e[1;35m============================备份旧文件================================\e[0m"
#备份旧的
mv  /usr/bin/openssl /usr/bin/openssl.bak  
echo -e "\e[1;35m=========================对新的创建软连接==============================\e[0m"
#对新的创建软连接
ln -sf /usr/local/openssl/bin/openssl /usr/bin/openssl  
echo -e "\e[1;35m==============================验证====================================\e[0m"
#将 openssl 的 lib 库写进配置中，并使配置生效
#echo "/usr/local/openssl/lib64/" >> /etc/ld.so.conf
echo "/usr/local/openssl/lib" >> /etc/ld.so.conf
#验证：ldconfig -v|grep ssl //确定链接库
ldconfig -v

[ $? -eq 0 ] && echo -e "\e[1;35m             ok \e[0m" || echo -e "\e[1;31m                false \e[0m"


#出现报错libssl.so.1.1。。。缺少依赖库
#ln -s /usr/local/lib/libcrypto.so.1.1 /usr/lib64/libcrypto.so.1.1
#ln -s /usr/local/lib/libssl.so.1.1 /usr/lib64/libssl.so.1.1

#echo "/usr/local/lib64" >> /etc/ld.so.conf
#ldconfig -v | grep ssl


#查看版本 是否安装成功
echo -e "\e[1;35m===============================升级后版本================================\e[0m"

openssl version
}








update_openssh(){

initialize_variables "update_openssh"
echo -e "\e[1;35m========================================================================\e[0m"
echo -e "\e[1;35m已安装版本\e[0m"
ssh -V
echo -e "\n\e[1;35m本次升级的安装版本openssh-${OpensshVersion}，zlib-${ZlibVersion}\e[0m"
echo -e "\e[1;35m离线安装，请提前准备好对应版本的压缩包放在root目录下\e[0m"
echo -e "\e[1;35m=========================================================================\e[0m"
echo -e "\e[1;35m不想安装请在五秒内终止脚本\e[0m\n"

for i in {5..1}
do
    echo -n "${i} "
    echo -ne "\r"
    sleep 1
done


echo -e "\e[1;35m==========================检查系统=====================================\e[0m"

if [ ${SystemVersion} -eq 7 ];then
    echo ""
else
    echo "系统不是centos7系列,不可以执行此脚本"
fi






echo "执行网络检测"
if ping -c 1 www.baidu.com >/dev/null;then
    echo -e "\e[1;32m"网络正常"\e[0m"
else
    echo -e "\e[1;31m"网络不通"\e[0m"
    
fi









echo -e "\e[1;35m=============================安装依赖包===================================\e[0m"

#yum install  -y gcc gcc-c++ glibc make autoconf openssl openssl-devel pcre-devel  pam-devel
#yum install  -y pam* zlib*

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



echo -e "\e[1;35m=============================源文件检查===================================\e[0m"


if [[ -e "zlib-${ZlibVersion}.tar.gz" ]];then
    echo -e "\e[1;35mzlib源文件存在\e[0m"
else
    echo -e "\e[1;33mzlib源文件不存在,尝试下载\e[0m"
    wget --no-check-certificate https://nchc.dl.sourceforge.net/project/libpng/zlib/${ZlibVersion}/zlib-${ZlibVersion}.tar.gz
fi

if [[ -e "openssh-${OpensshVersion}.tar.gz" ]];then
    echo -e "\e[1;35mopenssh源文件存在\e[0m"
else
    echo -e "\e[1;33mopenssh源文件不存在,尝试下载\e[0m"
    wget --no-check-certificate https://mirrors.sonic.net/pub/OpenBSD/OpenSSH/portable/openssh-${OpensshVersion}.tar.gz
fi
echo -e "\e[1;35m=============================解压源文件===================================\e[0m"


tar zxf zlib-${ZlibVersion}.tar.gz
if [ -e /root/zlib-${ZlibVersion} ];then
    echo -e "\n\e[1;35mzlib解压成功\e[0m"
else
    echo -e "\n\e[1;35mzlib解压失败\e[0m"
    exit

fi


tar zxf openssh-${OpensshVersion}.tar.gz
if [ -e /root/openssh-${OpensshVersion} ];then
    echo -e "\e[1;35mopenssh解压成功\e[0m"
else
    echo -e "\e[1;35mopenssh解压失败\e[0m"
    exit
fi


echo -e "\e[1;35m=============================编译zlib===================================\e[0m"
#tar zxf /root/zlib-${ZlibVersion}.tar.gz
if [ -e /usr/local/zlib ];then
    echo -e "\n\e[1;35m已存在\e[0m"
else
echo -e "\n\e[1;35m开始编译\e[0m"
cd /root/zlib-${ZlibVersion}/
./configure --prefix=/usr/local/zlib
make && make install
[ $? -eq 0 ] && echo -e "\e[1;35m             ok \e[0m" || echo -e "\e[1;31m                false \e[0m"
fi


echo -e "\e[1;35m=============================编译openssh===================================\e[0m"
#tar zxf /root/openssh-${OpensshVersion}.tar.gz
if [ -e /usr/local/openssh ];then
    echo -e "\n\e[1;35m已存在\e[0m"
else
echo -e "\n\e[1;35m开始编译\e[0m"
cd /root/openssh-${OpensshVersion}/
./configure --prefix=/usr/local/openssh --with-ssl-dir=/usr/local/openssl --with-zlib=/usr/local/zlib --with-pam --without-openssl-header-check
 make && make install

[ $? -eq 0 ] && echo -e "\e[1;35m             ok \e[0m" || echo -e "\e[1;31m                false \e[0m"
fi

echo -e "\e[1;35m=======================备份旧文件，迁入新文件=============================\e[0m"

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




cp /root/openssh-${OpensshVersion}/contrib/redhat/sshd.init /etc/init.d/sshd
chmod u+x   /etc/init.d/sshd




echo -e "\e[1;35m=========================修改sshd配置文件===============================\e[0m"



cp /etc/init.d/sshd /data/opensshbak/sshdnewbk
sed -i '/SSHD=/c\SSHD=\/usr\/local\/openssh\/sbin\/sshd'  /etc/init.d/sshd
sed -i '/\/usr\/bin\/ssh-keygen/c\         \/usr\/local\/openssh\/bin\/ssh-keygen -A'  /etc/init.d/sshd
sed -i '/ssh_host_rsa_key.pub/i\                \/sbin\/restorecon \/etc\/ssh\/ssh_host_key.pub'  /etc/init.d/sshd  
sed -i '/$SSHD $OPTIONS && success || failure/i\       \ OPTIONS="-f /etc/ssh/sshd_config"' /etc/rc.d/init.d/sshd



echo -e "\e[1;35m======================修改sshd_config配置文件============================\e[0m\n"

echo -e "\n\e[1;35m修改sshd_config配置文件\e[0m"

sed -i '/PasswordAuthentication/c\PasswordAuthentication yes' /etc/ssh/sshd_config
sed -i '/X11Forwarding/c\X11Forwarding yes' /etc/ssh/sshd_config
sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

cp -arp /usr/local/openssh/bin/* /usr/bin/
service sshd restart



echo -e "\n\e[1;35m配置开机项\e[0m"

chkconfig --add sshd
chkconfig --level 2345 sshd on
chkconfig --list


echo -e "\e[1;35m============================更新后版本================================\e[0m"

ssh -V
}




#===================================================================================================================================================================
#适用于从1.*版本升级到openssl1.1.1w,openssh9.7p1

update_sshssl1(){
initialize_variables "update_sshssl1"
#log "Executing update_sshssl1"
echo -e "\e[1;35m========================================================================\e[0m"
echo -e "\e[1;35m现在已安装的版本\e[0m"
openssl version
ssh -V
echo -e "\n\e[1;35m本次安装的版本是openssl-${OpensslVersion}\e[0m"
echo -e "\e[1;35m本次升级的安装版本openssh-${OpensshVersion}，zlib-${ZlibVersion}\e[0m"
echo -e "\e[1;35m离线安装，请提前准备好对应版本的压缩包放在root目录下\e[0m"
echo -e "\e[1;35m========================================================================\e[0m"
echo -e "\e[1;35m不想安装请在五秒内终止脚本\e[0m\n"

for i in {5..1}
do
    echo -n "${i} "
    echo -ne "\r"
    sleep 1
done

echo -e "\e[1;35m==========================检查系统=====================================\e[0m"

if [ ${SystemVersion} -eq 7 ];then
    echo -e "\e[1;32m检测系统为centos7允许执行\e[0m"
else
    echo -e "\e[1;31m系统不是centos7系列,不可以执行此脚本\e[0m"
fi



if [[ ${OpensslVersion1}  < 3 ]];then
    echo -e "\e[1;32m脚本支持升级openssl\e[0m"
else
    echo -e "\e[1;31m检测openssl版本高于3版本,脚本不支持\e[0m"
    exit
fi


echo -e "\e[1;35m==========================源文件检查=====================================\e[0m"
if [ -e "openssl-${OpensslVersion}.tar.gz" ];then
    echo -e "\e[1;35mopenssl文件存在\e[0m"
else
    echo -e "\e[1;33mopenssl文件不存在\e[0m"
    exit
fi

if [[ -a "zlib-${ZlibVersion}.tar.gz" ]];then
    echo -e "\e[1;35mzlib源文件存在\e[0m"
else
    echo -e "\e[1;33mzlib源文件不存在\e[0m"
    exit
fi

if [[ -a "openssh-${OpensshVersion}.tar.gz" ]];then
    echo -e "\e[1;35mopenssh源文件存在\e[0m"
else
    echo -e "\e[1;33mopenssh源文件不存在\e[0m"
    exit
fi




echo "执行网络检测"
if ping -c 1 www.baidu.com >/dev/null;then
    echo -e "\e[1;32m"网络正常"\e[0m"
else
    echo -e "\e[1;31m"网络不通"\e[0m"
    
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

echo -e "\e[1;35m===========================解压源文件====================================\e[0m"
tar zxf /root/zlib-${ZlibVersion}.tar.gz
if [ -e /root/zlib-${ZlibVersion} ];then
    echo -e "\n\e[1;35mzlib解压成功\e[0m"
else
    echo -e "\n\e[1;35mzlib解压失败\e[0m"
    exit
fi


tar zxf /root/openssh-${OpensshVersion}.tar.gz
if [ -e /root/openssh-${OpensshVersion} ];then
    echo -e "\e[1;35mopenssh解压成功\e[0m"
else
    echo -e "\e[1;35mopenssh解压失败\e[0m"
    exit
fi


tar zxf /root/openssl-${OpensslVersion}.tar.gz
if [ -e openssl-${OpensslVersion} ];then
    echo -e "\e[1;35mopenssl解压成功\e[0m\n"
else
    echo -e "\e[1;35mopenssl解压失败\e[0m"
    exit
fi


echo -e "\e[1;35m===========================编译openssl==================================\e[0m"
cd /root/openssl-${OpensslVersion}

./config --prefix=/usr/local/openssl -d shared
#make
#执行失败的话执行make clean清除make信息
#[ $? -eq 0 ] || make clean
#sleep 1
#make install
make -j$(nproc) && make install

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

if [ $? -eq 0 ];then 
    echo -e "\e[1;35m                                                            [  OK  ] \e[0m"
else
    echo -e "\e[1;31m                                                            [ false ] \e[0m"
    exit
fi


#出现报错libssl.so.1.1。。。缺少依赖库
#ln -s /usr/local/lib/libcrypto.so.1.1 /usr/lib64/libcrypto.so.1.1
#ln -s /usr/local/lib/libssl.so.1.1 /usr/lib64/libssl.so.1.1

#echo "/usr/local/lib64" >> /etc/ld.so.conf
#ldconfig -v | grep ssl


#查看版本 是否安装成功
echo -e "\e[1;35m========================升级后openssl版本================================\e[0m"

openssl version



echo -e "\e[1;5;35m=======================================================================\e[0m"
echo -e "\e[1;35m下面开始安装openssh,不想安装请在五秒内终止脚本\e[0m\n"

for i in {5..1}
do
    echo -n "${i} "
    echo -ne "\r"
    sleep 1
done

echo -e "\e[1;35m==========================开始升级openssh==============================\e[0m"


echo -e "\e[1;35m=============================编译zlib===================================\e[0m"
#tar zxf /root/zlib-${ZlibVersion}.tar.gz
if [ -e /usr/local/zlib ];then
    echo -e "\n\e[1;35m已存在\e[0m"
else
echo -e "\n\e[1;35m开始编译\e[0m"
cd /root/zlib-${ZlibVersion}/
./configure --prefix=/usr/local/zlib
make -j$(nproc) && make install
[ $? -eq 0 ] && echo -e "\e[1;35m                                                            [  OK  ] \e[0m" || echo -e "\e[1;31m                false \e[0m"
fi


echo -e "\e[1;35m===========================编译openssh==================================\e[0m"
#tar zxf /root/openssh-${OpensshVersion}.tar.gz
if [ -e /usr/local/openssh ];then
    echo -e "\n\e[1;35m已存在\e[0m"
else
echo -e "\n\e[1;35m开始编译\e[0m"
cd /root/openssh-${OpensshVersion}/
./configure --prefix=/usr/local/openssh --with-ssl-dir=/usr/local/openssl --with-zlib=/usr/local/zlib --with-pam --without-openssl-header-check
make -j$(nproc) && make install

[ $? -eq 0 ] && echo -e "\e[1;35m                                                            [  OK  ] \e[0m" || echo -e "\e[1;31m                false \e[0m"
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


#mv /etc/ssh/sshd_config.rpmsave /etc/ssh/sshd_config

if [ -a /etc/ssh/sshd_config ];then
    mv /etc/ssh/sshd_config /etc/ssh/sshd_config-${date}
else
    echo ''
fi

if [ -a /etc/ssh/sshd_config.rpmsave ];then
    mv /etc/ssh/sshd_config.rpmsave /etc/ssh/sshd_config
  else
    echo ''
fi



cp /root/openssh-${OpensshVersion}/contrib/redhat/sshd.init /etc/init.d/sshd
chmod u+x   /etc/init.d/sshd




echo -e "\e[1;35m==========================修改sshd配置文件================================\e[0m"



cp /etc/init.d/sshd /data/opensshbak/sshdnewbk
sed -i '/SSHD=/c\SSHD=\/usr\/local\/openssh\/sbin\/sshd'  /etc/init.d/sshd
sed -i '/\/usr\/bin\/ssh-keygen/c\         \/usr\/local\/openssh\/bin\/ssh-keygen -A'  /etc/init.d/sshd
sed -i '/ssh_host_rsa_key.pub/i\                \/sbin\/restorecon \/etc\/ssh\/ssh_host_key.pub'  /etc/init.d/sshd  
sed -i '/$SSHD $OPTIONS && success || failure/i\       \ OPTIONS="-f /etc/ssh/sshd_config"' /etc/rc.d/init.d/sshd



echo -e "\e[1;35m=======================修改sshd_config配置文件=============================\e[0m\n"

echo -e "\n\e[1;35m修改sshd_config配置文件\e[0m"

sed -i '/PasswordAuthentication/c\PasswordAuthentication yes' /etc/ssh/sshd_config
sed -i '/X11Forwarding/c\X11Forwarding yes' /etc/ssh/sshd_config
sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

cp -arp /usr/local/openssh/bin/* /usr/bin/
service sshd restart

[ $? -eq 0 ] && echo -e "\e[1;35m                                                           [  OK  ] \e[0m" || echo -e "\e[1;31m                false \e[0m"

echo -e "\n\e[1;35m=================================配置开机项=================================\e[0m"

chkconfig --add sshd
chkconfig --level 2345 sshd on
chkconfig --list


echo -e "\e[1;35m=========================更新后openssh版本=================================\e[0m"

ssh -V
}

















#===================================================================================================================================================================

#适用于从1.*版本升级到openssl3.3.0,openssh9.7p1
update_sshssl2(){

initialize_variables "update_sshssl2"
echo -e "\e[1;35m====================================================================\e[0m"
echo -e "\e[1;35m现在已安装的版本\e[0m"
openssl version
ssh -V
echo -e "\e[1;35m本次安装的版本是openssl-${OpensslVersion}\e[0m"
echo -e "\e[1;35m本次升级的安装版本openssh-${OpensshVersion}，zlib-${ZlibVersion}\e[0m"
echo -e "\e[1;35m离线安装，请提前准备好对应版本的压缩包放在root目录下\e[0m"
echo -e "\e[1;35m====================================================================\e[0m"
echo -e "\e[1;35m不想安装请在五秒内终止脚本\e[0m\n"

for i in {5..1}
do
    echo -n "${i} "
    echo -ne "\r"
    sleep 1
done

echo -e "\e[1;35m==========================检查系统==================================\e[0m"

if [ ${SystemVersion} -eq 7 ];then
    echo -e "\e[1;32m检测系统为centos7允许执行\e[0m"
else
    echo -e "\e[1;31m检测系统不是centos7,脚本不支持\e[0m"
    exit
fi



if [[ ${OpensslVersion1}  < 3 ]];then
    echo -e "\e[1;32m脚本支持升级openssl\e[0m"
else
    echo -e "\e[1;31m检测openssl版本高于3版本,脚本不支持\e[0m"
    exit
fi




echo -e "\e[1;35m=======================开始升级openssl==============================\e[0m"

echo -e "\e[1;35m==========================源文件检查================================\e[0m"
if [ -e "openssl-${OpensslVersion}.tar.gz" ];then
    echo -e "\e[1;35m文件存在\e[0m"
else
    echo -e "\e[1;33m文件不存在，开始下载\e[0m"
    wget --no-check-certificate https://www.openssl.org/source/openssl-${OpensslVersion}.tar.gz
fi



echo "执行网络检测"
if ping -c 1 www.baidu.com >/dev/null;then
    echo -e "\e[1;32m"网络正常"\e[0m"
else
    echo -e "\e[1;31m"网络不通"\e[0m"
    
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

#更换cpam源
sed -i  's#http://www.cpan.org/#https://mirror.tuna.tsinghua.edu.cn/CPAN/#' .cpan/CPAN/




cat > yes_file <<EOF
yes
yes
yes
yes
yes
EOF
#echo -e "\e[1;31m需要手动按回车\e[0m"
cpan IPC::Cmd < yes_file

rm yes_file


tar -zxvf openssl-${OpensslVersion}.tar.gz
cd openssl-${OpensslVersion}
./config --prefix=/usr/local/ssl --openssldir=/usr/local/ssl shared zlib


make && make install

echo "/usr/local/ssl/lib64" > /etc/ld.so.conf.d/openssl.conf
ldconfig
mv /usr/bin/openssl /usr/bin/openssl-${date}
#cp -f /usr/local/ssl/bin/openssl /usr/bin/openssl
cp /usr/local/ssl/bin/openssl /usr/bin/openssl
ldconfig -v
cd
#查看版本 是否安装成功
echo -e "\e[1;35m===============================升级后版本================================\e[0m"

openssl version

echo -e "\e[1;5;35m=======================================================================\e[0m"
echo -e "\e[1;35m下面开始安装openssh,不想安装请在五秒内终止脚本\e[0m\n"

for i in {5..1}
do
    echo -n "${i} "
    echo -ne "\r"
    sleep 1
done

echo -e "\e[1;35m=======================开始升级openssh==============================\e[0m"




echo -e "\e[1;35m==========================源文件检查=====================================\e[0m"

if [[ -a "zlib-${ZlibVersion}.tar.gz" ]];then
    echo -e "\e[1;35mzlib源文件存在\e[0m"
else
    echo -e "\e[1;33mzlib源文件不存在\e[0m"
    exit
fi

if [[ -a "openssh-${OpensshVersion}.tar.gz" ]];then
    echo -e "\e[1;35mopenssh源文件存在\e[0m"
else
    echo -e "\e[1;33mopenssh源文件不存在\e[0m"
    exit
fi




echo "执行网络检测"
if ping -c 1 www.baidu.com >/dev/null;then
    echo -e "\e[1;32m"网络正常"\e[0m"
else
    echo -e "\e[1;31m"网络不通"\e[0m"
    
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

echo -e "\e[1;35m===========================解压源文件====================================\e[0m"
tar zxf /root/zlib-${ZlibVersion}.tar.gz
if [ -e /root/zlib-${ZlibVersion} ];then
    echo -e "\n\e[1;35mzlib解压成功\e[0m"
else
    echo -e "\n\e[1;35mzlib解压失败\e[0m"
    exit
fi


tar zxf /root/openssh-${OpensshVersion}.tar.gz
if [ -e /root/openssh-${OpensshVersion} ];then
    echo -e "\e[1;35mopenssh解压成功\e[0m"
else
    echo -e "\e[1;35mopenssh解压失败\e[0m"
    exit
fi





echo -e "\e[1;35m=============================编译zlib===================================\e[0m"
#tar zxf /root/zlib-${ZlibVersion}.tar.gz
if [ -e /usr/local/zlib ];then
    echo -e "\n\e[1;35m已存在\e[0m"
else
echo -e "\n\e[1;35m开始编译\e[0m"
cd /root/zlib-${ZlibVersion}/
./configure --prefix=/usr/local/zlib
make && make install
[ $? -eq 0 ] && echo -e "\e[1;35m                                                            [  OK  ] \e[0m" || { echo -e "\e[1;31m                false \e[0m";exit; }
fi


echo -e "\e[1;35m===========================编译openssh==================================\e[0m"
#tar zxf /root/openssh-${OpensshVersion}.tar.gz
if [ -e /usr/local/openssh ];then
    echo -e "\n\e[1;35m已存在\e[0m"
else
echo -e "\n\e[1;35m开始编译\e[0m"
cd /root/openssh-${OpensshVersion}/
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

mv /etc/ssh/sshd_config /data/opensshbak/sshd_config-${date} && cp /usr/local/openssh/etc/sshd_config /etc/ssh/sshd_config
[ $? -eq 0 ] && echo "" || { echo "/etc/ssh/sshd_config文件拷贝失败";exit; }


mv /usr/sbin/sshd /data/opensshbak/sshd-${date} && cp /usr/local/openssh/sbin/sshd /usr/sbin/sshd
[ $? -eq 0 ] && echo "" || { echo "/usr/sbin/sshd文件拷贝失败";exit; }


mv /usr/bin/ssh /data/opensshbak/ssh-${date} && cp /usr/local/openssh/bin/ssh /usr/bin/ssh
[ $? -eq 0 ] && echo "" || { echo "/usr/bin/ssh文件拷贝失败";exit; }


mv /usr/bin/ssh-keygen /data/opensshbak/ssh-keygen-${date} && cp /usr/local/openssh/bin/ssh-keygen /usr/bin/ssh-keygen
[ $? -eq 0 ] && echo "" || { echo "/usr/bin/ssh-keygen文件拷贝失败";exit; }


mv /etc/ssh/ssh_host_ecdsa_key.pub /data/opensshbak/ssh_host_ecdsa_key.pub-${date} && cp  -f /usr/local/openssh/etc/ssh_host_ecdsa_key.pub /etc/ssh/ssh_host_ecdsa_key.pub

[ $? -eq 0 ] && echo "" || { echo "/etc/ssh/ssh_host_ecdsa_key.pub文件拷贝失败";exit; }


for  i   in  $(rpm  -qa  |grep  openssh);do  rpm  -e  $i  --nodeps ;done




if [ -a /etc/ssh/sshd_config ];then
    mv /etc/ssh/sshd_config /etc/ssh/sshd_config-${date}
else
    echo ''
fi

if [ -a /etc/ssh/sshd_config.rpmsave ];then
    mv /etc/ssh/sshd_config.rpmsave /etc/ssh/sshd_config
  else
    echo ''
fi


cp /root/openssh-${OpensshVersion}/contrib/redhat/sshd.init /etc/init.d/sshd
[ $? -eq 0 ] && echo "" || { echo "/etc/init.d/sshd文件拷贝失败";exit; }



if [ -a /root/openssh-${OpensshVersion}/contrib/redhat/sshd.init ];then
    echo ""
else
    echo "/root/openssh-${OpensshVersion}/contrib/redhat/sshd.init文件不存在"
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



cp /etc/init.d/sshd /etc/init.d/sshd-${date}
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

[ -a /usr/bin/scp ] && mv /usr/bin/scp /usr/bin/scp-${date} || echo ''
[ -a /usr/bin/sftp ]  && mv /usr/bin/sftp /usr/bin/sftp-${date} || echo ''
[ -a /usr/bin/ssh ]  && mv /usr/bin/ssh /usr/bin/ssh-${date} || echo ''
[ -a /usr/bin/ssh-add ] && mv /usr/bin/ssh-add /usr/bin/ssh-add-${date} || echo ''
[ -a /usr/bin/ssh-agent ] && mv /usr/bin/ssh-agent /usr/bin/ssh-agent-${date} || echo ''
[ -a /usr/bin/ssh-keygen ] && mv /usr/bin/ssh-keygen /usr/bin/ssh-keygen-${date} || echo ''
[ -a /usr/bin/ssh-keyscan ] && mv /usr/bin/ssh-keyscan /usr/bin/ssh-keyscan-${date} || echo ''
cp -arp /usr/local/openssh/bin/* /usr/bin/
service sshd restart

[ $? -eq 0 ] && echo -e "\e[1;35m                                                           [  OK  ] \e[0m" || { echo -e "\e[1;31m                false \e[0m";exit; }

echo -e "\n\e[1;35m=================================配置开机项=================================\e[0m"

chkconfig --add sshd
chkconfig --level 2345 sshd on
chkconfig --list


echo -e "\e[1;35m=========================更新后openssh版本=================================\e[0m"

ssh -V
}











#===================================================================================================================================================================
#适用于从3.*版本升级到openssl3.3.1,openssh9.8p1
update_sshssl3(){
initialize_variables "update_sshssl3"

echo -e "\e[1;35m========================================================================\e[0m"
echo -e "\e[1;35m现在已安装的版本\e[0m"
openssl version
ssh -V
echo -e "\e[1;35m本次安装的版本是openssl-${version}\e[0m"
echo -e "\e[1;35m本次升级的安装版本openssh-${OpensshVersion}，zlib-${ZlibVersion}\e[0m"
echo -e "\e[1;35m\e[0m"
echo -e "\e[1;35m支持在线安装,离线安装请提前准备好对应版本的压缩包放在root目录下\e[0m"
echo -e "\e[1;35m========================================================================\e[0m"
echo -e "\e[1;35m不想安装请在五秒内终止脚本\e[0m\n"

for i in {5..1}
do
    echo -n "${i} "
    echo -ne "\r"
    sleep 1
done

echo -e "\e[1;35m==========================检查系统=======================================\e[0m"

if [ ${SystemVersion} -eq 7 ];then
    echo -e "\e[1;32m检测系统为centos7允许执行\e[0m"
else
    echo -e "\e[1;321m检测系统不是centos7,脚本不支持\e[0m"
    exit
fi

if [[ ${OpensslVersion1}  > 3 ]];then
    echo -e "\e[1;32m脚本支持升级openssl\e[0m"
else
    echo -e "\e[1;31m检测openssl版本低于3版本,脚本不支持\e[0m"
    exit
fi

echo -e "\e[1;35m=======================开始升级openssl===================================\e[0m"

echo -e "\e[1;35m==========================源文件检查======================================\e[0m"
if [ -a "openssl-${OpensslVersion}.tar.gz" ];then
    echo -e "\e[1;35mopenssl-${OpensslVersion}文件存在,开始解压\e[0m"
else
    echo -e "\e[1;33mopenssl-${OpensslVersion}文件不存在，开始下载\e[0m"
    wget --no-check-certificate https://www.openssl.org/source/openssl-${version}.tar.gz
fi

tar -zxf openssl-${version}.tar.gz




echo -e "\e[1;35m==========================编译安装=======================================\e[0m"
cd openssl-${OpensslVersion}
./config --prefix=/usr/local/ssl --openssldir=/usr/local/ssl shared zlib
make && sudo make install



echo "/usr/local/ssl/lib64" > /etc/ld.so.conf.d/openssl.conf
ldconfig
mv /usr/bin/openssl /usr/bin/openssl-${date}
cp -f /usr/local/ssl/bin/openssl /usr/bin/openssl
#ln -sf /usr/local/ssl/bin/openssl /usr/bin/openssl
ldconfig -v
cd
#查看版本 是否安装成功
echo -e "\e[1;35m==========================升级后版本=====================================\e[0m"

openssl version



echo -e "\e[1;5;35m=======================================================================\e[0m"
echo -e "\e[1;35m下面开始安装openssh,不想安装请在五秒内终止脚本\e[0m\n"

for i in {5..1}
do
    echo -n "${i} "
    echo -ne "\r"
    sleep 1
done



echo -e "\e[1;35m=======================开始升级openssh==============================\e[0m"




echo -e "\e[1;35m==========================源文件检查=====================================\e[0m"



if [[ -a "openssh-${OpensshVersion}.tar.gz" ]];then
    echo -e "\e[1;35mopenssh-${OpensshVersion}文件存在\e[0m"
else
    echo -e "\e[1;33mopenssh-${OpensshVersion}文件不存在\e[0m"
    exit
fi



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
./configure --prefix=/usr/local/openssh --with-ssl-dir=/usr/local/ssl --with-zlib=/usr/local/zlib
 make && make install

[ $? -eq 0 ] && echo -e "\e[1;35m                                                           [  OK  ] \e[0m" || { echo -e "\e[1;31m                false \e[0m";exit; }

echo -e "\e[1;35m======================备份旧文件，迁入新文件==============================\e[0m"                  
[ -d /data/opensshbak ] || mkdir -p /data/opensshbak/



[ -a /etc/ssh/sshd_config ] && mv /etc/ssh/sshd_config /data/opensshbak/sshd_config-${date}
cp /usr/local/openssh/etc/sshd_config /etc/ssh/sshd_config
[ $? -eq 0 ] && echo "" || { echo "/etc/ssh/sshd_config文件拷贝失败";exit; }


[ -a /usr/sbin/sshd ] && mv /usr/sbin/sshd /data/opensshbak/sshd-${date}
cp /usr/local/openssh/sbin/sshd /usr/sbin/sshd
[ $? -eq 0 ] && echo "" || { echo "/usr/sbin/sshd文件拷贝失败";exit; }


[ -a /usr/bin/ssh ] && mv /usr/bin/ssh /data/opensshbak/ssh-${date}
cp /usr/local/openssh/bin/ssh /usr/bin/ssh
[ $? -eq 0 ] && echo "" || { echo "/usr/bin/ssh文件拷贝失败";exit; }


[ -a /usr/bin/ssh-keygen ] && mv /usr/bin/ssh-keygen /data/opensshbak/ssh-keygen-${date}
cp /usr/local/openssh/bin/ssh-keygen /usr/bin/ssh-keygen
[ $? -eq 0 ] && echo "" || { echo "/usr/bin/ssh-keygen文件拷贝失败";exit; }


[ -a /etc/ssh/ssh_host_ecdsa_key.pub ] && mv /etc/ssh/ssh_host_ecdsa_key.pub /data/opensshbak/ssh_host_ecdsa_key.pub-${date}
cp /usr/local/openssh/etc/ssh_host_ecdsa_key.pub /etc/ssh/ssh_host_ecdsa_key.pub

[ $? -eq 0 ] && echo "" || { echo "/etc/ssh/ssh_host_ecdsa_key.pub文件拷贝失败";exit; }


#for  i   in  $(rpm  -qa  |grep  openssh);do  rpm  -e  $i  --nodeps ;done

#mv /etc/ssh/sshd_config /etc/ssh/sshd_config-${date} && mv /etc/ssh/ssh_config.rpmsave /etc/ssh/sshd_config


if [ -a /root/openssh-${OpensshVersion}/contrib/redhat/sshd.init ];then
    echo ""
else
    echo "/root/openssh-${OpensshVersion}/contrib/redhat/sshd.init文件不存在"
    exit
fi



if [ -a /etc/init.d/sshd ];then
    echo ""
else
    echo "/etc/init.d/sshd文件不存在"
    exit
fi

mv /etc/init.d/sshd /etc/init.d/sshd-${date}
cp /root/openssh-${OpensshVersion}/contrib/redhat/sshd.init /etc/init.d/sshd
[ $? -eq 0 ] && echo "" || { echo "/etc/init.d/sshd文件拷贝失败";exit; }



chmod u+x   /etc/init.d/sshd




echo -e "\e[1;35m==========================修改sshd配置文件================================\e[0m"



cp /etc/init.d/sshd /data/opensshbak/sshd-${date}
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


[ -a /usr/bin/scp ] && mv /usr/bin/scp /usr/bin/scp-${date} || echo ''
[ -a /usr/bin/sftp ]  && mv /usr/bin/sftp /usr/bin/sftp-${date} || echo ''
[ -a /usr/bin/ssh ]  && mv /usr/bin/ssh /usr/bin/ssh-${date} || echo ''
[ -a /usr/bin/ssh-add ] && mv /usr/bin/ssh-add /usr/bin/ssh-add-${date} || echo ''
[ -a /usr/bin/ssh-agent ] && mv /usr/bin/ssh-agent /usr/bin/ssh-agent-${date} || echo ''
[ -a /usr/bin/ssh-keygen ] && mv /usr/bin/ssh-keygen /usr/bin/ssh-keygen-${date} || echo ''
[ -a /usr/bin/ssh-keyscan ] && mv /usr/bin/ssh-keyscan /usr/bin/ssh-keyscan-${date} || echo ''

cp -arp /usr/local/openssh/bin/* /usr/bin/
service sshd restart

[ $? -eq 0 ] && echo -e "\e[1;35m                                                           [  OK  ] \e[0m" || { echo -e "\e[1;31m                false \e[0m";exit; }

echo -e "\n\e[1;35m==========================配置开机项=====================================\e[0m"

chkconfig --add sshd
chkconfig --level 2345 sshd on
chkconfig --list


echo -e "\e[1;35m=========================更新后openssh版本=================================\e[0m"

ssh -V


}





















#===================================================================================================================================================================

#适用于从1.*版本升级到openssl3.3.1,openssh9.8p1

update_sshssl4(){

initialize_variables "update_sshssl4"
echo -e "\e[1;35m====================================================================\e[0m"
echo -e "\e[1;35m现在已安装的版本\e[0m"
ssh -V
echo -e "\e[1;35m本次安装的版本是openssl-${OpensslVersion}\e[0m"
echo -e "\e[1;35m本次升级的安装版本openssh-${OpensshVersion}，zlib-${ZlibVersion}\e[0m"
echo -e "\e[1;35m离线安装，请提前准备好对应版本的压缩包放在root目录下\e[0m"
echo -e "\e[1;35m====================================================================\e[0m"
echo -e "\e[1;35m不想安装请在五秒内终止脚本\e[0m\n"

for i in {5..1}
do
    echo -n "${i} "
    echo -ne "\r"
    sleep 1
done

echo -e "\e[1;35m==========================检查系统====================================\e[0m"

if [ ${SystemVersion} -eq 7 ];then
    echo -e "\e[1;32m检测系统为centos7允许执行\e[0m"
else
    echo -e "\e[1;31m检测系统不是centos7,脚本不支持\e[0m"
    exit
fi


if [[ ${OpensslVersion1}  < 3 ]];then
    echo -e "\e[1;32m脚本支持升级openssl\e[0m"
else
    echo -e "\e[1;31m检测openssl版本高于3版本,脚本不支持\e[0m"
    exit
fi



echo -e "\e[1;35m==========================执行网络检测==================================\e[0m"
if ping -c 1 www.baidu.com >/dev/null;then
    echo -e "\e[1;32m"网络正常"\e[0m"
else
    echo -e "\e[1;31m"网络不通"\e[0m"
    
fi


echo -e "\e[1;35m==========================源文件检查=====================================\e[0m"





if [ -e "/root/$0" ];then
    echo -e ""
else
    echo -e "\e[1;33m请将脚本文件放在root目录下执行\e[0m"
    exit
fi




if [[ -a "/root/zlib-${ZlibVersion}.tar.gz" ]];then
    echo -e "\e[1;35mzlib-${ZlibVersion}文件存在\e[0m"
else
    echo -e "\e[1;33mzzlib-${ZlibVersion}文件不存在,请将文件放在root目录下\e[0m"
    exit
fi

if [[ -a "/root/openssh-${OpensshVersion}.tar.gz" ]];then
    echo -e "\e[1;35mopenssh-${OpensshVersion}文件存在\e[0m"
else
    echo -e "\e[1;33mopenssh-${OpensshVersion}文件不存在,请将文件放在root目录下\e[0m"
    exit
fi

if [ -e "openssl-${OpensslVersion}.tar.gz" ];then
    echo -e "\e[1;35mopenssl-${OpensslVersion}文件存在\e[0m"
else
    echo -e "\e[1;33mopenssl-${OpensslVersion}文件不存在,请将文件放在root目录下\e[0m"
    exit
fi








echo -e "\e[1;35m=======================开始升级openssl==============================\e[0m"


echo -e "\e[1;35m==========================安装依赖包================================\e[0m"


#yum install  -y gcc gcc-c++ glibc make
software=(
    "gcc"
    "perl"
    "make"
    "zlib-devel"
    "perl-CPAN"
    "perl-IPC-Cmd"
    "pcre-devel"
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


echo -e "\e[1;35m==========================CPAN安装配置================================\e[0m"


# 使用 timeout 命令运行 sudo cpan，忽略退出状态码
timeout 1 sudo cpan || true

# 自动执行 cpan 配置并生成 .cpan/CPAN/MyConfig.pm
#echo -e "\n\n" | sudo cpan > /dev/null 2>&1



# 后台运行 sudo cpan
#sudo cpan &
#CPAN_PID=$!

# 等待 1 秒后终止 cpan 进程
#sleep 1
#kill -INT $CPAN_PID




# 检查是否成功生成 MyConfig.pm
if [ -f /root/.cpan/CPAN/MyConfig.pm ]; then
    echo "MyConfig.pm 文件已成功生成。"
    sed -i  's#http://www.cpan.org/#https://mirror.tuna.tsinghua.edu.cn/CPAN/#' .cpan/CPAN/MyConfig.pm
else
    echo "MyConfig.pm 文件生成失败。"
fi




#更换cpam源
#if [ -f /root/.cpan/CPAN/MyConfig.pm ];then 
#    sed -i  's#http://www.cpan.org/#https://mirror.tuna.tsinghua.edu.cn/CPAN/#' .cpan/CPAN/MyConfig.pm
#else
#    echo ''
#fi


cat > yes_file <<EOF
yes
yes
yes
yes
yes
EOF
#echo -e "\e[1;31m需要手动按回车\e[0m"
cpan IPC::Cmd < yes_file

rm yes_file



#echo -e "\e[1;5;33m警告!!!!!!!!!!\e[0m\n"
#echo -e "\e[1;5;32m如果cpan报错下载失败是出现源的问题请在十秒内终止脚本手动执行修改源命令后再重新执行脚本\e[0m\n"
#echo -e "\e[1;5;32m执行sudo cpan后直接退出,重新执行脚本即可 \e[0m\n"
#echo -e "\e[1;5;32msed -i  \'s#http://www.cpan.org/#https://mirror.tuna.tsinghua.edu.cn/CPAN/#\'\e[0m\n"



#for i in {10..1}
#do
#    echo -n "${i} "
#    echo -ne "\r"
#    sleep 1
#done

for i in {3..1}
do
    echo -n "${i} "
    echo -ne "\r"
    sleep 1
done

echo -e "\e[1;35m==========================openssl编译安装=======================================\e[0m"
tar -zxvf /root/openssl-${OpensslVersion}.tar.gz
cd /root/openssl-${OpensslVersion}
./config --prefix=/usr/local/ssl --openssldir=/usr/local/ssl shared zlib


make -j$(nproc) && make install  || { echo -e "\e[1;31m编译或安装失败,执行make clean 重新编译\e[0m"; exit 1; } 

echo "/usr/local/ssl/lib64" > /etc/ld.so.conf.d/openssl.conf
ldconfig
mv /usr/bin/openssl /usr/bin/openssl-${date}
#cp -f /usr/local/ssl/bin/openssl /usr/bin/openssl
cp /usr/local/ssl/bin/openssl /usr/bin/openssl
ldconfig -v
cd
#查看版本 是否安装成功
echo -e "\e[1;35m==========================升级后版本==========================================\e[0m"

openssl version

echo -e "\e[1;5;35m===========================================================================\e[0m"
echo -e "\e[1;35m下面开始安装openssh,不想安装请在五秒内终止脚本\e[0m\n"

for i in {5..1}
do
    echo -n "${i} "
    echo -ne "\r"
    sleep 1
done





0


for i in {3..1}
do
    echo -n "${i} "
    echo -ne "\r"
    sleep 1
done
echo -e "\e[1;35m========================开始升级openssh=====================================\e[0m"


echo -e "\e[1;35m==========================安装依赖包========================================\e[0m"

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

echo -e "\e[1;35m=========================解压源文件====================================\e[0m"
tar zxf /root/zlib-${ZlibVersion}.tar.gz
if [ -e /root/zlib-${ZlibVersion} ];then
    echo -e "\n\e[1;35mzlib解压成功\e[0m"
else
    echo -e "\n\e[1;35mzlib解压失败\e[0m"
    exit
fi


tar zxf /root/openssh-${OpensshVersion}.tar.gz
if [ -e /root/openssh-${OpensshVersion} ];then
    echo -e "\e[1;35mopenssh解压成功\e[0m"
else
    echo -e "\e[1;35mopenssh解压失败\e[0m"
    exit
fi





echo -e "\e[1;35m=============================编译zlib===================================\e[0m"
#tar zxf /root/zlib-${ZlibVersion}.tar.gz
if [ -e /usr/local/zlib ];then
    echo -e "\n\e[1;35m已存在\e[0m"
else
echo -e "\n\e[1;35m开始编译\e[0m"
cd /root/zlib-${ZlibVersion}/
./configure --prefix=/usr/local/zlib
make -j$(nproc) && make install  || { echo -e "\e[1;31m编译或安装失败,执行make clean 重新编译\e[0m"; exit 1; } 
[ $? -eq 0 ] && echo -e "\e[1;35m                                                            [  OK  ] \e[0m" || { echo -e "\e[1;31m                false \e[0m";exit; }
fi


echo -e "\e[1;35m===========================编译openssh==================================\e[0m"
#tar zxf /root/openssh-${OpensshVersion}.tar.gz
if [ -e /usr/local/openssh ];then
    echo -e "\n\e[1;35m已存在\e[0m"
else
echo -e "\n\e[1;35m开始编译\e[0m"
cd /root/openssh-${OpensshVersion}/
./configure --prefix=/usr/local/openssh --with-ssl-dir=/usr/local/ssl --with-zlib=/usr/local/zlib
 make && make install

[ $? -eq 0 ] && echo -e "\e[1;35m                                                           [  OK  ] \e[0m" || { echo -e "\e[1;31m                false \e[0m";exit; }
fi

echo -e "\e[1;35m======================备份旧文件，迁入新文件==============================\e[0m"                  
echo -e "\e[1;32m备份文件在/data/opensshbak/\e[0m"  
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

[ -a /etc/ssh/sshd_config ] && mv /etc/ssh/sshd_config /data/opensshbak/sshd_config-${date}
cp /usr/local/openssh/etc/sshd_config /etc/ssh/sshd_config
[ $? -eq 0 ] && echo "更新sshd_config" || { echo "/etc/ssh/sshd_config文件拷贝失败";exit; }


[ -a /usr/sbin/sshd ] && mv /usr/sbin/sshd /data/opensshbak/sshd-${date}
cp /usr/local/openssh/sbin/sshd /usr/sbin/sshd
[ $? -eq 0 ] && echo "更新sshd" || { echo "/usr/sbin/sshd文件拷贝失败";exit; }


[ -a /usr/bin/ssh ] && mv /usr/bin/ssh /data/opensshbak/ssh-${date}
cp /usr/local/openssh/bin/ssh /usr/bin/ssh
[ $? -eq 0 ] && echo "更新ssh" || { echo "/usr/bin/ssh文件拷贝失败";exit; }


[ -a /usr/bin/ssh-keygen ] && mv /usr/bin/ssh-keygen /data/opensshbak/ssh-keygen-${date}
cp /usr/local/openssh/bin/ssh-keygen /usr/bin/ssh-keygen
[ $? -eq 0 ] && echo "更新ssh-keygen" || { echo "/usr/bin/ssh-keygen文件拷贝失败";exit; }


[ -a /etc/ssh/ssh_host_ecdsa_key.pub ] && mv /etc/ssh/ssh_host_ecdsa_key.pub /data/opensshbak/ssh_host_ecdsa_key.pub-${date}
cp /usr/local/openssh/etc/ssh_host_ecdsa_key.pub /etc/ssh/ssh_host_ecdsa_key.pub

[ $? -eq 0 ] && echo "更新ssh_host_ecdsa_key.pub" || { echo "/etc/ssh/ssh_host_ecdsa_key.pub文件拷贝失败";exit; }


for  i   in  $(rpm  -qa  |grep  openssh);do  rpm  -e  $i  --nodeps ;done


if [ -a /etc/ssh/sshd_config ];then
    mv /etc/ssh/sshd_config /etc/ssh/sshd_config-${date}
else
    echo ''
fi

if [ -a /etc/ssh/sshd_config.rpmsave ];then
    mv /etc/ssh/sshd_config.rpmsave /etc/ssh/sshd_config
  else
    echo ''
fi




cp /root/openssh-${OpensshVersion}/contrib/redhat/sshd.init /etc/init.d/sshd
[ $? -eq 0 ] && echo "" || { echo "/etc/init.d/sshd文件拷贝失败";exit; }



if [ -a /root/openssh-${OpensshVersion}/contrib/redhat/sshd.init ];then
    echo ""
else
    echo "/root/openssh-${OpensshVersion}/contrib/redhat/sshd.init文件不存在"
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



cp /etc/init.d/sshd /etc/init.d/sshd-${date}
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

[ -a /usr/bin/scp ] && mv /usr/bin/scp /usr/bin/scp-${date} || echo ''
[ -a /usr/bin/sftp ]  && mv /usr/bin/sftp /usr/bin/sftp-${date} || echo ''
[ -a /usr/bin/ssh ]  && mv /usr/bin/ssh /usr/bin/ssh-${date} || echo ''
[ -a /usr/bin/ssh-add ] && mv /usr/bin/ssh-add /usr/bin/ssh-add-${date} || echo ''
[ -a /usr/bin/ssh-agent ] && mv /usr/bin/ssh-agent /usr/bin/ssh-agent-${date} || echo ''
[ -a /usr/bin/ssh-keygen ] && mv /usr/bin/ssh-keygen /usr/bin/ssh-keygen-${date} || echo ''
[ -a /usr/bin/ssh-keyscan ] && mv /usr/bin/ssh-keyscan /usr/bin/ssh-keyscan-${date} || echo ''
cp -arp /usr/local/openssh/bin/* /usr/bin/
service sshd restart

[ $? -eq 0 ] && echo -e "\e[1;35m                                                           [  OK  ] \e[0m" || { echo -e "\e[1;31m                false \e[0m";exit; }

echo -e "\n\e[1;35m=========================配置开机项=================================\e[0m"

chkconfig --add sshd
chkconfig --level 2345 sshd on
chkconfig --list


echo -e "\e[1;35m=========================更新后openssh版本=================================\e[0m"

ssh -V
}












#===================================================================================================================================================================
#适用与centos6系统升级openssh9.8p1和openssl3.3.1

update_sshssl5(){

initialize_variables "update_sshssl5"

echo -e "\e[1;35m====================================================================\e[0m"
echo -e "\e[1;35m现在已安装的版本\e[0m"
openssl version
#ssh -V &>/dev/null
echo -e "\e[1;35m本次安装的版本是openssl-${OpensslVersion}\e[0m"
echo -e "\e[1;35m本次升级的安装版本openssh-${OpensshVersion},perl-${PerlVersion}\e[0m"
echo -e "\e[1;35m离线安装，请提前准备好对应版本的压缩包放在root目录下\e[0m"
echo -e "\e[1;35mcentos6的yum源请提前准备好\e[0m"
echo -e "\e[1;35m====================================================================\e[0m"
echo -e "\e[1;35m不想安装请在五秒内终止脚本\e[0m\n"

for i in {5..1}
do
    echo -n "${i} "
    echo -ne "\r"
    sleep 1
done

echo -e "\e[1;35m==========================检查系统==================================\e[0m"

if [ ${SystemVersion} -lt 7 ];then
    echo -e "\e[1;32m检测系统为centos6允许执行\e[0m"
else
    echo -e "\e[1;31m检测系统不是centos6,脚本不支持\e[0m"
    exit
fi


if [[ ${OpensslVersion1}  < 3 ]];then
    echo -e "\e[1;32m脚本支持升级openssl\e[0m"
else
    echo -e "\e[1;31m检测openssl版本高于3版本,脚本不支持\e[0m"
    exit
fi

echo "执行网络检测"
if ping -c 1 www.baidu.com >/dev/null;then
    echo -e "\e[1;32m"网络正常"\e[0m"
else
    echo -e "\e[1;31m"网络不通"\e[0m"
    
fi



echo -e "\e[1;35m=========================安装依赖包=================================\e[0m"
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
    "rpm-build"
    "zlib"
    "zlib-devel"
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



echo -e "\e[1;35m=========================源文件检查==================================\e[0m"
if [ -a "openssl-${OpensslVersion}.tar.gz" ];then
    echo -e "\e[1;35m openssl-${OpensslVersion}文件存在\e[0m"
else
    echo -e "\e[1;33m openssl-${OpensslVersion}文件不存在，开始下载\e[0m"
    wget --no-check-certificate https://www.openssl.org/source/openssl-${OpensslVersion}.tar.gz
fi


if [ -a "openssh-${OpensshVersion}.tar.gz" ];then
    echo -e "\e[1;35m openssh-${OpensshVersion}文件存在\e[0m"
else
    echo -e "\e[1;33m openssh-${OpensshVersion}文件不存在，开始下载\e[0m"
    wget http://ftp.openbsd.org/pub/OpenBSD/OpenSSH/portable/openssh-${OpensshVersion}.tar.gz
fi

if [ -a "perl-${PerlVersion}.tar.gz" ];then
    echo -e "\e[1;35m perl-${PerlVersion}文件存在\e[0m"
else
    echo -e "\e[1;33m perl-${PerlVersion}文件不存在，开始下载\e[0m"
    wget --no-check-certificate  https://www.cpan.org/src/5.0/perl-${PerlVersion}.tar.gz
fi


echo -e "\e[1;35m=========================安装perl=================================\e[0m"


echo -e "\e[1;35m========================解压源文件================================\e[0m"
tar -zxf /root/perl-${PerlVersion}.tar.gz 
cd /root/perl-${PerlVersion}

echo -e "\e[1;35m=========================编译安装=================================\e[0m"
./Configure -des -Dprefix=/usr/local/perl 
make -j 2 && make install 
mv /usr/bin/perl /usr/bin/perl.bak 
ln -s /usr/local/perl/bin/perl /usr/bin/perl

cd
echo -e "\e[1;35m=======================查看安装版本================================\e[0m"
perl -v 

sleep 3






echo -e "\e[1;35m======================安装openssl=================================\e[0m"

echo -e "\e[1;35m=======================解压源文件==================================\e[0m"



tar -zxvf /root/openssl-${OpensslVersion}.tar.gz
cd /root/openssl-${OpensslVersion}


echo -e "\e[1;35m========================编译安装=================================\e[0m"
./config --prefix=/usr/local/ssl shared zlib
make -j 2 && make install 

mv /usr/bin/openssl /usr/bin/openssl.bak 
ln -s /usr/local/ssl/bin/openssl /usr/bin/openssl 
echo "/usr/local/ssl/lib64">> //etc/ld.so.conf.d/ssl.conf
/sbin/ldconfig 

cd
echo -e "\e[1;35m=======================查看安装版本===============================\e[0m"
openssl version 

sleep 3








echo -e "\e[1;35m======================安装openssh===============================\e[0m"

mv -f /etc/ssh /etc/ssh.bak
for i in `rpm -qa |grep openssh-`; do rpm -e --nodeps $i; done
#wget http://ftp.openbsd.org/pub/OpenBSD/OpenSSH/portable/openssh-8.8p1.tar.gz




echo -e "\e[1;35m========================解压源文件================================\e[0m"
tar -zxf /root/openssh-${OpensshVersion}.tar.gz
cd /root/openssh-${OpensshVersion}




echo -e "\e[1;35m=========================编译安装=================================\e[0m"
#不指定位置
#./configure --prefix=/usr/local/openssh --sysconfdir=/etc/ssh --with-pam --with-zlib --with-md5-passwords
#指定位置
./configure --prefix=/usr/local/openssh --sysconfdir=/etc/ssh --with-pam --with-zlib --with-md5-passwords --with-tcp-wrappers --without-openssl-header-check --with-ssl-dir=/usr/local/ssl
make -j2 && make install


ln -sf /usr/local/openssh/bin/* /usr/bin
ln -sf /usr/local/openssh/sbin/sshd /usr/sbin
echo -e "PermitRootLogin yes\nPasswordAuthentication yes\nPubkeyAuthentication yes\nX11Forwarding yes">>/etc/ssh/sshd_config



[ -a /root/openssh-${OpensshVersion}/contrib/redhat/sshd.init ] && cp /root/openssh-${OpensshVersion}/contrib/redhat/sshd.init /etc/init.d/sshd || echo -e "\e[1;35m更新/etc/init.d/sshd文件出错\e[0m"
[ -a /root/openssh-${OpensshVersion}/contrib/sshd.pam.generic ] && cp /root/openssh-${OpensshVersion}/contrib/sshd.pam.generic  /etc/pam.d/sshd || echo -e "\e[1;35m更新/etc/init.d/sshd文件出错\e[0m"


cat > /etc/pam.d/sshd << 'EOF'
#%PAM-1.0
auth       required     /lib64/security/pam_unix.so shadow nodelay
account    required     /lib64/security/pam_nologin.so
account    required     /lib64/security/pam_unix.so
password   required     /lib64/security/pam_cracklib.so
password   required     /lib64/security/pam_unix.so shadow nullok use_authtok
session    required     /lib64/security/pam_unix.so
session    required     /lib64/security/pam_limits.so
auth       include      /etc/pam.d/password-auth
session    include      /etc/pam.d/password-auth
password   include      /etc/pam.d/password-auth
account    include      /etc/pam.d/password-auth
auth       required     pam_sepermit.so
account    required     pam_nologin.so
session    optional     pam_keyinit.so force revoke
session    required     pam_limits.so
EOF

#两种方法
sudo ln -s /lib64/security/pam_unix.so /lib/security/pam_unix.so
sudo ln -s /lib64/security/pam_nologin.so /lib/security/pam_nologin.so
sudo ln -s /lib64/security/pam_cracklib.so /lib/security/pam_cracklib.so
sudo ln -s /lib64/security/pam_limits.so /lib/security/pam_limits.so

echo -e "\e[1;35m=========================重启sshd服务================================\e[0m"
echo -e "\e[1;35m重启过程中以下命令脚本可能无法继续执行可手动执行\e[0m"
echo -e "\e[1;35mchkconfig --add sshd\e[0m"
echo -e "\e[1;35mchkconfig --level 2345 sshd on\e[0m"
nohup service sshd restart &
chkconfig --add sshd
chkconfig --level 2345 sshd on
cd
echo -e "\e[1;35m======================更新后openssh版本===============================\e[0m"

ssh -V

}









#===================================================================================================================================================================
#适用于openEuler系统升级openssh9.8p1和openssl3.3.1

update_sshssl6(){
initialize_variables "update_sshssl6"
echo -e "\e[1;35m====================================================================\e[0m"
echo -e "\e[1;35m现在已安装的版本\e[0m"
ssh -V
echo -e "\e[1;35m本次安装的版本是openssl-${OpensslVersion}\e[0m"
echo -e "\e[1;35m本次升级的安装版本openssh-${OpensshVersion}\e[0m"
echo -e "\e[1;35m离线安装，请提前准备好对应版本的压缩包放在root目录下\e[0m"
echo -e "\e[1;35m====================================================================\e[0m"
echo -e "\e[1;35m不想安装请在五秒内终止脚本\e[0m\n"







## 关闭严格模式
set +u
source /etc/profile.d/lang.sh

for i in {5..1}
do
    echo -n "${i} "
    echo -ne "\r"
    sleep 1
done




echo -e "\e[1;35m==========================源文件检查================================\e[0m"

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






echo -e "\e[1;35m==========================安装telnet=================================\e[0m"

software=(
    "telnet"
    "telnet-server"
    "xinetd"
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








echo -e "\e[1;35m==========================编译安装=======================================\e[0m"
tar -zxvf openssl-${OpensslVersion}.tar.gz
cd openssl-${OpensslVersion}
./config --prefix=/usr/local/openssl --openssldir=/usr/local/openssl shared zlib


make && make install

sudo mv /usr/bin/openssl /usr/bin/openssl-${Date}
sudo ln -s /usr/local/openssl/bin/openssl /usr/bin/openssl
sudo echo "/usr/local/openssl/lib" >> /etc/ld.so.conf
sudo echo "/usr/local/openssl/lib64" > /etc/ld.so.conf.d/openssl.conf
sudo ldconfig -v

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
 make && make install

systemctl restart sshd

sleep 3
echo -e "\e[1;35m=========================更新后openssh版本=================================\e[0m"
#export LD_LIBRARY_PATH=/usr/local/openssl/lib64:$LD_LIBRARY_PATH
echo 'export LD_LIBRARY_PATH=/usr/local/openssl/lib64:${LD_LIBRARY_PATH:-""}' >> /etc/profile
echo 'export PATH=/usr/local/bin:$PATH' >>/etc/profile
ldconfig
source /etc/profile
ssh -V


}



#===================================================================================================================================================================
#适用于centos7系统升级openssh9.9p1和openssl3.4.0

update_sshssl7(){
initialize_variables "update_sshssl7"
echo -e "\e[1;35m====================================================================================================================\e[0m"
echo -e "\e[1;35m现在已安装的版本\e[0m"
ssh -V
echo -e "\e[1;32m仅支持centos7\e[0m"
echo -e "\e[1;35m本次安装的版本是sudo-${SudoVersion}\e[0m"
echo -e "\e[1;35m本次升级的安装版本zlib-${ZlibVersion}\e[0m"
echo -e "\e[1;35m本次安装的版本是openssl-${OpensslVersion}\e[0m"
echo -e "\e[1;35m本次升级的安装版本openssh-${OpensshVersion}\e[0m"
echo -e "\e[1;35m支持在线下载,如果已经下载好安装包了请将对应版本的压缩包放在root目录下\e[0m"
echo -e "\e[1;35m====================================================================================================================\e[0m"
echo -e "\e[1;35m不想安装请在五秒内终止脚本\e[0m\n"





echo -e "\e[1;35m===================================================升级前系统检查===================================================\e[0m"

## 关闭严格模式
set +u
source /etc/profile.d/lang.sh

for i in {5..1}
do
    echo -n "${i} "
    echo -ne "\r"
    sleep 1
done


if [  $ID = "openEuler" -o  $ID = "kylin" -o $ID = "centos" ]; then
    echo -e "\e[1;32m当前系统是:$NAME，版本号：$VERSION_ID\e[0m"
else
    echo -e "\e[1;31m当前系统脚本不支持。\e[0m"
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

#if ! ping -c 5 114.114.114.114 > /dev/null && ! ping -c 5 8.8.8.8 > /dev/null && ! ping -c 5 www.baidu.com > /dev/null; then
#    echo -e "\e[1;31m网络不通，将跳过相关网络依赖步骤。\e[0m"
#    NETWORK_OK=false
#else
#    echo -e "\e[1;32m网络正常\e[0m"
#    NETWORK_OK=true
#fi

# 检测系统版本
#if [ -f /etc/os-release ]; then
#    . /etc/os-release
#    SYSTEM_NAME=$ID
#    VERSION_ID=${VERSION_ID:-unknown}
#elif [ -f /etc/redhat-release ]; then
#    SYSTEM_NAME="centos"
#    if grep -q "release 6" /etc/redhat-release; then
#        VERSION_ID="6"
#    elif grep -q "release 7" /etc/redhat-release; then
#        VERSION_ID="7"
#    else
#        VERSION_ID="无法判断操作系统版本"
#    fi
#else
#    SYSTEM_NAME="无法判断操作系统名称"
#    VERSION_ID="无法判断操作系统版本"
#fi

#echo -e "\e[1;35m检测到系统为：$SYSTEM_NAME $VERSION_ID\e[0m"
# 备份并更换 YUM 源
#if $NETWORK_OK && [ "$SYSTEM_NAME" = "centos" ] && [ "$VERSION_ID" = "7" ]; then
#    echo -e "\n\e[1;35m======================================================================================================================================\e[0m"
#    echo -e "\e[1;35mYUM源检测\e[0m"

    



#    if [ ! -d /data/bak ];then
#        mkdir -p /data/bak; echo "新建目录/data/bak"
#    else
#        echo "目录 /data/bak 已存在。"
#    fi
#判断文件夹是否有文件
#    if [ "$(ls -A /etc/yum.repos.d/ 2>/dev/null)" ]; then
#        echo -e "\e[1;35m检测到旧的 YUM 源文件，备份到 /data/bak。\e[0m"
#        mv /etc/yum.repos.d/*  /data/bak || { echo "备份失败！"; exit 1; }
#    else
#        echo -e "\e[1;33m未检测到 YUM 源文件。\e[0m"
#    fi
#    echo -e "\e[1;35m写入新的base和epel\e[0m"
#    cat > /etc/yum.repos.d/base.repo <<'EOF'
#[base]
#name=CentOS
#baseurl=https://mirror.tuna.tsinghua.edu.cn/centos/\$releasever/os/\$basearch/
#        https://mirrors.huaweicloud.com/centos/\$releasever/os/\$basearch/
#        https://mirrors.cloud.tencent.com/centos/\$releasever/os/\$basearch/
#        https://mirrors.aliyun.com/centos/\$releasever/os/\$basearch/
#gpgcheck=0

#[extras]
#name=extras
#baseurl=https://mirror.tuna.tsinghua.edu.cn/centos/\$releasever/extras/\$basearch
#        https://mirrors.huaweicloud.com/centos/\$releasever/extras/\$basearch
#        https://mirrors.cloud.tencent.com/centos/\$releasever/extras/\$basearch
#        https://mirrors.aliyun.com/centos/\$releasever/extras/\$basearch
       
#gpgcheck=0
#enabled=1


#[epel]
#name=EPEL
#baseurl=https://mirror.tuna.tsinghua.edu.cn/epel/\$releasever/\$basearch
#        https://mirrors.cloud.tencent.com/epel/\$releasever/\$basearch/
#        https://mirrors.huaweicloud.com/epel/\$releasever/\$basearch 
#        https://mirrors.cloud.tencent.com/epel/\$releasever/\$basearch
#        http://mirrors.aliyun.com/epel/\$releasever/\$basearch
#gpgcheck=0
#enabled=1
#EOF

##可用

#  cat > /etc/yum.repos.d/CentOS-Base.repo<<'EOF'
# CentOS-Base.repo
#
# The mirror system uses the connecting IP address of the client and the
# update status of each mirror to pick mirrors that are updated to and
# geographically close to the client.  You should use this for CentOS updates
# unless you are manually picking other mirrors.
#
# If the mirrorlist= does not work for you, as a fall back you can try the 
# remarked out baseurl= line instead.
#
#

#[base]
#name=CentOS-$releasever - Base
##mirrorlist=http://mirrorlist.centos.org/?release=$releasever&arch=$basearch&repo=os&infra=$infra
#baseurl=https://repo.huaweicloud.com/centos-vault/centos/$releasever/os/$basearch/
#gpgcheck=1
#gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7

#released updates 
#[updates]
#name=CentOS-$releasever - Updates
##mirrorlist=http://mirrorlist.centos.org/?release=$releasever&arch=$basearch&repo=updates&infra=$infra
#baseurl=https://repo.huaweicloud.com/centos-vault/centos/$releasever/updates/$basearch/
#gpgcheck=1
#gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7

#additional packages that may be useful
#[extras]
#name=CentOS-$releasever - Extras
##mirrorlist=http://mirrorlist.centos.org/?release=$releasever&arch=$basearch&repo=extras&infra=$infra
#baseurl=https://repo.huaweicloud.com/centos-vault/centos/$releasever/extras/$basearch/
#gpgcheck=1
#gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7

##additional packages that extend functionality of existing packages
#[centosplus]
#name=CentOS-$releasever - Plus
##mirrorlist=http://mirrorlist.centos.org/?release=$releasever&arch=$basearch&repo=centosplus&infra=$infra
#baseurl=https://repo.huaweicloud.com/centos-vault/centos/$releasever/centosplus/$basearch/
#gpgcheck=1
#enabled=0
#gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7
#EOF



#    cat > /etc/yum.repos.d/epel.repo <<'EOF'
#[epel]
#name=epel
#baseurl=https://mirrors.aliyun.com/epel/\$releasever/x86_64/
#        https://mirrors.tuna.tsinghua.edu.cn/epel/7/x86_64/
#        https://mirrors.ustc.edu.cn/epel/7/x86_64/
#gpgcheck=0
#EOF

#cat > /etc/yum.repos.d/epel.repo <<'EOF'
#[epel]
#name=Extra Packages for Enterprise Linux 7 - $basearch
#baseurl=https://repo.huaweicloud.com/epel/7/$basearch
##metalink=https://mirrors.fedoraproject.org/#metalink?repo=epel-7&arch=$basearch
#failovermethod=priority
#enabled=1
#gpgcheck=1
#gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-7

#[epel-debuginfo]
#name=Extra Packages for Enterprise Linux 7 - $basearch - Debug
#baseurl=https://repo.huaweicloud.com/epel/7/$basearch/debug
##metalink=https://mirrors.fedoraproject.org/#metalink?repo=epel-debug-7&arch=$basearch
#failovermethod=priority
#enabled=0
#gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-7
#gpgcheck=1

#[epel-source]
#name=Extra Packages for Enterprise Linux 7 - $basearch - Source
#baseurl=https://repo.huaweicloud.com/epel/7/SRPMS
##metalink=https://mirrors.fedoraproject.org/#metalink?repo=epel-source-7&arch=$basearch
#failovermethod=priority
#enabled=0
#gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-7
#gpgcheck=1
#EOF

#    echo -e "\e[1;35mYUM 源已成功更换。\e[0m"
#else
#    echo -e "\e[1;33m当前系统不是 CentOS 7 或网络不通，跳过 YUM 源更换。\e[0m"
#fi


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

#software=(
#    "telnet"
#    "telnet-server"
#    "xinetd"
#    )
#    for i in ${software[@]}
#    do
#        if rpm -q  $i &> /dev/null;then
#            echo -e "$i\t\e[1;32m已安装\e[0m" 
#        else 
#            if yum -y install $i &> /dev/null; then 
#                echo -e "$i\t\e[1;35m安装成功\e[0m"
#            else
#                echo -e "$i\t\e[1;31m安装失败\e[0m"
#            fi
#        fi

#    done

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


for i in {5..1}
do
    echo -n "${i} "
    echo -ne "\r"
    sleep 1
done


echo -e "\e[1;35m==============================================升级安装openssl版本======================================================\e[0m"



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















#####


update_sshssl8(){
initialize_variables "update_sshssl8"
echo -e "\e[1;35m====================================================================================================================\e[0m"
echo -e "\e[1;35m现在已安装的版本\e[0m"
ssh -V
echo -e "\e[1;35m本次安装的版本是sudo-${SudoVersion}\e[0m"
echo -e "\e[1;35m本次升级的安装版本zlib-${ZlibVersion}\e[0m"
echo -e "\e[1;35m本次安装的版本是openssl-${OpensslVersion}\e[0m"
echo -e "\e[1;35m本次升级的安装版本openssh-${OpensshVersion}\e[0m"
echo -e "\e[1;35m支持在线下载,如果已经下载好安装包了请将对应版本的压缩包放在root目录下\e[0m"
echo -e "\e[1;35m====================================================================================================================\e[0m"

echo -e "\e[1;31m不可用状态\e[0m\n"
echo -e "\e[1;35m不想安装请在五秒内终止脚本\e[0m\n"

for i in {5..1}
do
    echo -n "${i} "
    echo -ne "\r"
    sleep 1
done

echo -e "\e[1;35m===================================================升级前系统检查===================================================\e[0m"

## 关闭严格模式
set +u
source /etc/profile.d/lang.sh

for i in {5..1}
do
    echo -n "${i} "
    echo -ne "\r"
    sleep 1
done


if [  $ID = "openEuler" -o  $ID = "kylin" -o $ID = "centos" ]; then
    echo -e "\e[1;32m当前系统是:$NAME，版本号：$VERSION_ID\e[0m"
else
    echo -e "\e[1;31m当前系统脚本不支持。\e[0m"
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

#if ! ping -c 5 114.114.114.114 > /dev/null && ! ping -c 5 8.8.8.8 > /dev/null && ! ping -c 5 www.baidu.com > /dev/null; then
#    echo -e "\e[1;31m网络不通，将跳过相关网络依赖步骤。\e[0m"
#    NETWORK_OK=false
#else
#    echo -e "\e[1;32m网络正常\e[0m"
#    NETWORK_OK=true
#fi

# 检测系统版本
#if [ -f /etc/os-release ]; then
#    . /etc/os-release
#    SYSTEM_NAME=$ID
#    VERSION_ID=${VERSION_ID:-unknown}
#elif [ -f /etc/redhat-release ]; then
#    SYSTEM_NAME="centos"
#    if grep -q "release 6" /etc/redhat-release; then
#        VERSION_ID="6"
#    elif grep -q "release 7" /etc/redhat-release; then
#        VERSION_ID="7"
#    else
#        VERSION_ID="无法判断操作系统版本"
#    fi
#else
#    SYSTEM_NAME="无法判断操作系统名称"
#    VERSION_ID="无法判断操作系统版本"
#fi

#echo -e "\e[1;35m检测到系统为：$SYSTEM_NAME $VERSION_ID\e[0m"
# 备份并更换 YUM 源
#if $NETWORK_OK && [ "$SYSTEM_NAME" = "centos" ] && [ "$VERSION_ID" = "7" ]; then
#    echo -e "\n\e[1;35m======================================================================================================================================\e[0m"
#    echo -e "\e[1;35mYUM源检测\e[0m"

    



#    if [ ! -d /data/bak ];then
#        mkdir -p /data/bak; echo "新建目录/data/bak"
#    else
#        echo "目录 /data/bak 已存在。"
#    fi
#判断文件夹是否有文件
#    if [ "$(ls -A /etc/yum.repos.d/ 2>/dev/null)" ]; then
#        echo -e "\e[1;35m检测到旧的 YUM 源文件，备份到 /data/bak。\e[0m"
#        mv /etc/yum.repos.d/*  /data/bak || { echo "备份失败！"; exit 1; }
#    else
#        echo -e "\e[1;33m未检测到 YUM 源文件。\e[0m"
#    fi
#    echo -e "\e[1;35m写入新的base和epel\e[0m"
#    cat > /etc/yum.repos.d/base.repo <<'EOF'
#[base]
#name=CentOS
#baseurl=https://mirror.tuna.tsinghua.edu.cn/centos/\$releasever/os/\$basearch/
#        https://mirrors.huaweicloud.com/centos/\$releasever/os/\$basearch/
#        https://mirrors.cloud.tencent.com/centos/\$releasever/os/\$basearch/
#        https://mirrors.aliyun.com/centos/\$releasever/os/\$basearch/
#gpgcheck=0

#[extras]
#name=extras
#baseurl=https://mirror.tuna.tsinghua.edu.cn/centos/\$releasever/extras/\$basearch
#        https://mirrors.huaweicloud.com/centos/\$releasever/extras/\$basearch
#        https://mirrors.cloud.tencent.com/centos/\$releasever/extras/\$basearch
#        https://mirrors.aliyun.com/centos/\$releasever/extras/\$basearch
       
#gpgcheck=0
#enabled=1


#[epel]
#name=EPEL
#baseurl=https://mirror.tuna.tsinghua.edu.cn/epel/\$releasever/\$basearch
#        https://mirrors.cloud.tencent.com/epel/\$releasever/\$basearch/
#        https://mirrors.huaweicloud.com/epel/\$releasever/\$basearch 
#        https://mirrors.cloud.tencent.com/epel/\$releasever/\$basearch
#        http://mirrors.aliyun.com/epel/\$releasever/\$basearch
#gpgcheck=0
#enabled=1
#EOF

##可用

#  cat > /etc/yum.repos.d/CentOS-Base.repo<<'EOF'
# CentOS-Base.repo
#
# The mirror system uses the connecting IP address of the client and the
# update status of each mirror to pick mirrors that are updated to and
# geographically close to the client.  You should use this for CentOS updates
# unless you are manually picking other mirrors.
#
# If the mirrorlist= does not work for you, as a fall back you can try the 
# remarked out baseurl= line instead.
#
#

#[base]
#name=CentOS-$releasever - Base
##mirrorlist=http://mirrorlist.centos.org/?release=$releasever&arch=$basearch&repo=os&infra=$infra
#baseurl=https://repo.huaweicloud.com/centos-vault/centos/$releasever/os/$basearch/
#gpgcheck=1
#gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7

#released updates 
#[updates]
#name=CentOS-$releasever - Updates
##mirrorlist=http://mirrorlist.centos.org/?release=$releasever&arch=$basearch&repo=updates&infra=$infra
#baseurl=https://repo.huaweicloud.com/centos-vault/centos/$releasever/updates/$basearch/
#gpgcheck=1
#gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7

#additional packages that may be useful
#[extras]
#name=CentOS-$releasever - Extras
##mirrorlist=http://mirrorlist.centos.org/?release=$releasever&arch=$basearch&repo=extras&infra=$infra
#baseurl=https://repo.huaweicloud.com/centos-vault/centos/$releasever/extras/$basearch/
#gpgcheck=1
#gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7

##additional packages that extend functionality of existing packages
#[centosplus]
#name=CentOS-$releasever - Plus
##mirrorlist=http://mirrorlist.centos.org/?release=$releasever&arch=$basearch&repo=centosplus&infra=$infra
#baseurl=https://repo.huaweicloud.com/centos-vault/centos/$releasever/centosplus/$basearch/
#gpgcheck=1
#enabled=0
#gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7
#EOF



#    cat > /etc/yum.repos.d/epel.repo <<'EOF'
#[epel]
#name=epel
#baseurl=https://mirrors.aliyun.com/epel/\$releasever/x86_64/
#        https://mirrors.tuna.tsinghua.edu.cn/epel/7/x86_64/
#        https://mirrors.ustc.edu.cn/epel/7/x86_64/
#gpgcheck=0
#EOF

#cat > /etc/yum.repos.d/epel.repo <<'EOF'
#[epel]
#name=Extra Packages for Enterprise Linux 7 - $basearch
#baseurl=https://repo.huaweicloud.com/epel/7/$basearch
##metalink=https://mirrors.fedoraproject.org/#metalink?repo=epel-7&arch=$basearch
#failovermethod=priority
#enabled=1
#gpgcheck=1
#gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-7

#[epel-debuginfo]
#name=Extra Packages for Enterprise Linux 7 - $basearch - Debug
#baseurl=https://repo.huaweicloud.com/epel/7/$basearch/debug
##metalink=https://mirrors.fedoraproject.org/#metalink?repo=epel-debug-7&arch=$basearch
#failovermethod=priority
#enabled=0
#gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-7
#gpgcheck=1

#[epel-source]
#name=Extra Packages for Enterprise Linux 7 - $basearch - Source
#baseurl=https://repo.huaweicloud.com/epel/7/SRPMS
##metalink=https://mirrors.fedoraproject.org/#metalink?repo=epel-source-7&arch=$basearch
#failovermethod=priority
#enabled=0
#gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-7
#gpgcheck=1
#EOF

#    echo -e "\e[1;35mYUM 源已成功更换。\e[0m"
#else
#    echo -e "\e[1;33m当前系统不是 CentOS 7 或网络不通，跳过 YUM 源更换。\e[0m"
#fi


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

#software=(
#    "telnet"
#    "telnet-server"
#    "xinetd"
#    )
#    for i in ${software[@]}
#    do
#        if rpm -q  $i &> /dev/null;then
#            echo -e "$i\t\e[1;32m已安装\e[0m" 
#        else 
#            if yum -y install $i &> /dev/null; then 
#                echo -e "$i\t\e[1;35m安装成功\e[0m"
#            else
#                echo -e "$i\t\e[1;31m安装失败\e[0m"
#            fi
#        fi

#    done

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

sleep 5



echo -e "\e[1;35m==================================================升级安装sudo========================================================\e[0m"
sleep 3
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
sleep 5





echo -e "\e[1;35m===================================================升级安装openssh======================================================\e[0m"
sleep 3
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





update_sshssl9(){

update_sshssl_openEuler=v7.01.07
echo  "==============================================================================================================="
echo -e "\e[1;$[RANDOM%7+31]m

 ██████╗ ██████╗ ███████╗███╗   ██╗███████╗██╗   ██╗██╗     ███████╗██████╗ 
██╔═══██╗██╔══██╗██╔════╝████╗  ██║██╔════╝██║   ██║██║     ██╔════╝██╔══██╗
██║   ██║██████╔╝█████╗  ██╔██╗ ██║█████╗  ██║   ██║██║     █████╗  ██████╔╝
██║   ██║██╔═══╝ ██╔══╝  ██║╚██╗██║██╔══╝  ██║   ██║██║     ██╔══╝  ██╔══██╗
╚██████╔╝██║     ███████╗██║ ╚████║███████╗╚██████╔╝███████╗███████╗██║  ██║ for 2203-LTS 2403-LTS
    \e[0m"
echo -e "--- update-openssh-openssl-openEuler - openssh-openssl升级脚本"
echo -e "--- version: $update_sshssl_openEuler"
echo -e "--- https://github.com/SMILENCEQ/SMILENCEQ.github.io"
echo "==============================================================================================================="
. /etc/os-release
SudoVersion=1.9.16p2
OpensslVersion=3.4.0
OpensslVersion1=`openssl version | awk  '{print $2}'`
OpensshVersion=9.9p1
ZlibVersion=1.3.1
Current_Date=$(date +%Y%m%d%H%M%S)
TARGET_HOST=`hostname -I`
TARGET_PORT="22"

echo -e "\e[1;35m===============================================================================================================\e[0m"
echo -e "\e[1;35m现在已安装的版本\e[0m"
ssh -V
echo -e "\e[1;35m本次安装的版本是sudo-${SudoVersion}\e[0m"
echo -e "\e[1;35m本次安装的版本是openssl-${OpensslVersion}\e[0m"
echo -e "\e[1;35m本次升级的安装版本openssh-${OpensshVersion}\e[0m"
echo -e "\e[1;35m本次升级的安装版本zlib-${ZlibVersion}\e[0m"
echo -e "\e[1;35m支持在线下载,如果已经下载好安装包了请将对应版本的压缩包放在root目录下\e[0m"
echo -e "\e[1;35m===============================================================================================================\e[0m"
echo -e "\e[1;31m不可用状态\e[0m\n"
echo -e "\e[1;35m不想安装请在五秒内终止脚本\e[0m\n"

for i in {5..1}
do
    echo -n "${i} "
    echo -ne "\r"
    sleep 1
done



check_system(){

if [  $ID = "openEuler" -o  $ID = "kylin" ]; then
    echo -e "\e[1;31m当前系统是:$NAME，版本号：$VERSION_ID\e[0m"
else
    echo -e "\e[1;31m当前系统脚本不支持。\e[0m" 
    exit
fi
}


check_openssl_version(){
if [[ ${OpensslVersion}  = 3.4.0 ]];then
    echo -e "\e[1;35m此脚本只支持升级\e[0m"
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

}





download_files() {
# 定义文件列表及对应的下载链接
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

echo -e "\e[1;35m所有必要文件均已存在。\e[0m"
}







telnet_install(){
echo -e "\e[1;35m===================================================安装telnet===================================================\e[0m"
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




}

check_telnet(){

# 捕获 telnet 输出
result=$(echo -e "\n" | telnet $TARGET_HOST $TARGET_PORT 2>/dev/null | grep "Connected")

if [[ -n "$result" ]]; then
    echo -e "\e[1;35mtelnet 测试成功：可以连接到 $TARGET_HOST:$TARGET_PORT\e[0m"
else
    echo -e "\e[1;31mtelnet 测试失败：无法连接到 $TARGET_HOST:$TARGET_PORT\e[0m"
    exit 1
fi



}

#yum groupinstall "Development Tools" -y
#yum install perl gcc zlib-devel make -y

sleep 5


update_zlib(){
echo -e "\e[1;35m===================================================编译zlib======================================================\e[0m"
#wget https://www.zlib.net/fossils/zlib-1.3.1.tar.gz
tar zxf /root/zlib-${ZlibVersion}.tar.gz 
cd /root/zlib-${ZlibVersion}
./configure --prefix=/usr/local/zlib
make -j$(nproc) && make install
ldconfig -v
/sbin/ldconfig

}



update_openssl(){
echo -e "\e[1;35m===================================================升级openssl===================================================\e[0m"
cd /root/
#wget https://github.com/openssl/openssl/releases/download/openssl-3.4.0/openssl-3.4.0.tar.gz
#yum install  -y gcc gcc-c++ glibc make
software=(
    "tar"
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
#rpm -q $i &> /dev/null && echo -e "$i\t\e[1;32m已安装\e[0m" || { yum -y install $i &> /dev/null; echo -e "$i\t\e[1;35m安装成功\e[0m" ; }
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
echo -e "\e[1;35m===================================================升级后版本===================================================\e[0m"
openssl version
PKG=`pkg-config --modversion openssl`

if [ "$PKG" != "$OpensslVersion" ]; then
    echo -e "\e[1;31m错误: OpenSSL 版本不匹配! 期望版本: $OpensslVersion, 实际版本: $OpensslVersion1\e[0m"
    exit 1  # 停止脚本执行
else
    echo -e "\e[1;32mOpenSSL 版本正确: $PKG\e[0m"
fi

sleep 5
}





update_sudo(){

echo -e "\e[1;35m===================================================升级sudo===================================================\e[0m"

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
echo -e "\e[1;35m===================================================升级后版本===================================================\e[0m"
sudo --version
sleep 5

}




update_openssh(){

echo -e "\e[1;35m===================================================升级openssh===================================================\e[0m"
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

echo -e "\e[1;35m================================================备份旧文件，迁入新文件================================================\e[0m"                  
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




echo -e "\n\e[1;35m==============================================修改sshd_config配置文件===============================================\e[0m"

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
echo -e "\e[1;35m===================================================更新后openssh版本===================================================\e[0m"

ssh -V
exec openssl version &>/dev/null
}



main() {
    check_system
    check_openssl_version
    download_files
    telnet_install
    check_telnet
    update_zlib
    update_openssl
    update_sudo
    update_openssh
}

main "$@"

}






#===================================================================================================================================================================
#适用与centos6系统升级openssh9.9p1和openssl3.4.0

update_sshssl10(){

initialize_variables "update_sshssl10"

echo -e "\e[1;35m====================================================================\e[0m"
echo -e "\e[1;35m现在已安装的版本\e[0m"
openssl version
#ssh -V &>/dev/null
echo -e "\e[1;35m仅支持centos6\e[0m"
echo -e "\e[1;35m本次安装的版本是openssl-${OpensslVersion}\e[0m"
echo -e "\e[1;35m本次升级的安装版本openssh-${OpensshVersion},perl-${PerlVersion}\e[0m"
echo -e "\e[1;35m离线安装，请提前准备好对应版本的压缩包放在root目录下\e[0m"
echo -e "\e[1;35mcentos6的yum源请提前准备好\e[0m"
echo -e "\e[1;35m====================================================================\e[0m"
echo -e "\e[1;35m不想安装请在五秒内终止脚本\e[0m\n"
echo -e "\e[1;31m未测试!!!!!!!!!!\e[0m"
for i in {5..1}
do
    echo -n "${i} "
    echo -ne "\r"
    sleep 1
done

echo -e "\e[1;35m==========================检查系统==================================\e[0m"

if [ ${SystemVersion} -lt 7 ];then
    echo -e "\e[1;32m检测系统为centos6允许执行\e[0m"
else
    echo -e "\e[1;31m检测系统不是centos6,脚本不支持\e[0m"
    exit
fi


if [[ ${OpensslVersion1}  < 3 ]];then
    echo -e "\e[1;32m脚本支持升级openssl\e[0m"
else
    echo -e "\e[1;31m检测openssl版本高于3版本,脚本不支持\e[0m"
    exit
fi

echo "执行网络检测"
if ping -c 1 www.baidu.com >/dev/null;then
    echo -e "\e[1;32m"网络正常"\e[0m"
else
    echo -e "\e[1;31m"网络不通"\e[0m"
    
fi



echo -e "\e[1;35m=========================安装依赖包=================================\e[0m"
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
    "rpm-build"
    "zlib"
    "zlib-devel"
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



echo -e "\e[1;35m=========================源文件检查==================================\e[0m"
if [ -a "openssl-${OpensslVersion}.tar.gz" ];then
    echo -e "\e[1;35m openssl-${OpensslVersion}文件存在\e[0m"
else
    echo -e "\e[1;33m openssl-${OpensslVersion}文件不存在，开始下载\e[0m"
    wget --no-check-certificate https://www.openssl.org/source/openssl-${OpensslVersion}.tar.gz
fi


if [ -a "openssh-${OpensshVersion}.tar.gz" ];then
    echo -e "\e[1;35m openssh-${OpensshVersion}文件存在\e[0m"
else
    echo -e "\e[1;33m openssh-${OpensshVersion}文件不存在，开始下载\e[0m"
    wget http://ftp.openbsd.org/pub/OpenBSD/OpenSSH/portable/openssh-${OpensshVersion}.tar.gz
fi

if [ -a "perl-${PerlVersion}.tar.gz" ];then
    echo -e "\e[1;35m perl-${PerlVersion}文件存在\e[0m"
else
    echo -e "\e[1;33m perl-${PerlVersion}文件不存在，开始下载\e[0m"
    wget --no-check-certificate  https://www.cpan.org/src/5.0/perl-${PerlVersion}.tar.gz
fi


echo -e "\e[1;35m=========================安装perl=================================\e[0m"


echo -e "\e[1;35m========================解压源文件================================\e[0m"
tar -zxf /root/perl-${PerlVersion}.tar.gz 
cd /root/perl-${PerlVersion}

echo -e "\e[1;35m=========================编译安装=================================\e[0m"
./Configure -des -Dprefix=/usr/local/perl 
make -j 2 && make install 
mv /usr/bin/perl /usr/bin/perl.bak 
ln -s /usr/local/perl/bin/perl /usr/bin/perl

cd
echo -e "\e[1;35m=======================查看安装版本================================\e[0m"
perl -v 

sleep 3






echo -e "\e[1;35m======================安装openssl=================================\e[0m"

echo -e "\e[1;35m=======================解压源文件==================================\e[0m"



tar -zxvf /root/openssl-${OpensslVersion}.tar.gz
cd /root/openssl-${OpensslVersion}


echo -e "\e[1;35m========================编译安装=================================\e[0m"
./config --prefix=/usr/local/ssl shared zlib
make -j 2 && make install 

mv /usr/bin/openssl /usr/bin/openssl.bak 
ln -s /usr/local/ssl/bin/openssl /usr/bin/openssl 
echo "/usr/local/ssl/lib64">> //etc/ld.so.conf.d/ssl.conf
/sbin/ldconfig 

cd
echo -e "\e[1;35m=======================查看安装版本===============================\e[0m"
openssl version 

sleep 3








echo -e "\e[1;35m======================安装openssh===============================\e[0m"

mv -f /etc/ssh /etc/ssh.bak
for i in `rpm -qa |grep openssh-`; do rpm -e --nodeps $i; done
#wget http://ftp.openbsd.org/pub/OpenBSD/OpenSSH/portable/openssh-8.8p1.tar.gz




echo -e "\e[1;35m========================解压源文件================================\e[0m"
tar -zxf /root/openssh-${OpensshVersion}.tar.gz
cd /root/openssh-${OpensshVersion}




echo -e "\e[1;35m=========================编译安装=================================\e[0m"
#不指定位置
#./configure --prefix=/usr/local/openssh --sysconfdir=/etc/ssh --with-pam --with-zlib --with-md5-passwords
#指定位置
./configure --prefix=/usr/local/openssh --sysconfdir=/etc/ssh --with-pam --with-zlib --with-md5-passwords --with-tcp-wrappers --without-openssl-header-check --with-ssl-dir=/usr/local/ssl
make -j2 && make install


ln -sf /usr/local/openssh/bin/* /usr/bin
ln -sf /usr/local/openssh/sbin/sshd /usr/sbin
echo -e "PermitRootLogin yes\nPasswordAuthentication yes\nPubkeyAuthentication yes\nX11Forwarding yes">>/etc/ssh/sshd_config



[ -a /root/openssh-${OpensshVersion}/contrib/redhat/sshd.init ] && cp /root/openssh-${OpensshVersion}/contrib/redhat/sshd.init /etc/init.d/sshd || echo -e "\e[1;35m更新/etc/init.d/sshd文件出错\e[0m"
[ -a /root/openssh-${OpensshVersion}/contrib/sshd.pam.generic ] && cp /root/openssh-${OpensshVersion}/contrib/sshd.pam.generic  /etc/pam.d/sshd || echo -e "\e[1;35m更新/etc/init.d/sshd文件出错\e[0m"


cat > /etc/pam.d/sshd << 'EOF'
#%PAM-1.0
auth       required     /lib64/security/pam_unix.so shadow nodelay
account    required     /lib64/security/pam_nologin.so
account    required     /lib64/security/pam_unix.so
password   required     /lib64/security/pam_cracklib.so
password   required     /lib64/security/pam_unix.so shadow nullok use_authtok
session    required     /lib64/security/pam_unix.so
session    required     /lib64/security/pam_limits.so
auth       include      /etc/pam.d/password-auth
session    include      /etc/pam.d/password-auth
password   include      /etc/pam.d/password-auth
account    include      /etc/pam.d/password-auth
auth       required     pam_sepermit.so
account    required     pam_nologin.so
session    optional     pam_keyinit.so force revoke
session    required     pam_limits.so
EOF

#两种方法
sudo ln -s /lib64/security/pam_unix.so /lib/security/pam_unix.so
sudo ln -s /lib64/security/pam_nologin.so /lib/security/pam_nologin.so
sudo ln -s /lib64/security/pam_cracklib.so /lib/security/pam_cracklib.so
sudo ln -s /lib64/security/pam_limits.so /lib/security/pam_limits.so

echo -e "\e[1;35m=========================重启sshd服务================================\e[0m"
echo -e "\e[1;35m重启过程中以下命令脚本可能无法继续执行可手动执行\e[0m"
echo -e "\e[1;35mchkconfig --add sshd\e[0m"
echo -e "\e[1;35mchkconfig --level 2345 sshd on\e[0m"
nohup service sshd restart &
chkconfig --add sshd
chkconfig --level 2345 sshd on
cd
echo -e "\e[1;35m======================更新后openssh版本===============================\e[0m"

ssh -V

}


































#===================================================================================================================================================================
install_openssh1(){

echo -e "\e[1;34m作废\e[0m"
exit
if [ ! -d /home/data ];then
      mkdir /home/data
fi
cd /home/data
yum install wget -y

#wget -O openssh-8.6p1.tar.gz https://ftp.riken.jp/pub/OpenBSD/OpenSSH/portable/openssh-8.6p1.tar.gz
#wget -O zlib-1.2.11.tar.gz https://zlib.net/zlib-1.2.11.tar.gz
#wget -O openssl-1.1.1j.tar.gz https://www.openssl.org/source/openssl-1.1.1j.tar.gz
######保证下载的文件在/home/data里，且文件名相同
tar -zxf openssl-1.1.1q.tar.gz
tar -zxf zlib-1.2.13.tar.gz
tar -zxf openssh-9.1p1.tar.gz
chown -R root:root /home/data
#######################0end----------############################

##1---配置Telnet，以防SSH配置过程中出现问题，可以使用Telnet登录----
setenforce 0                      
#关闭selinux
systemctl stop firewalld         
#关闭
systemctl disable firewalld

#yum install telnet telnet-server xinetd -y
##vi /etc/xinetd.conf                   
##修改disabled = no  ，即可以使用telnet服务
#cp /etc/xinetd.conf   /home/data/xinetd.comfbk
#sed -i '14a      disabled = no ' /etc/xinetd.conf          
##在第14行增加 disabled = no
#echo -e 'pts/0\npts/1\npts/2\npts/3'  >>/etc/securetty

#systemctl start telnet.socket  #开启服务
#systemctl start xinetd        #开启服务
#systemctl enable telnet.socket   #开机自起服务
#systemctl enable xinetd
##1end---------------------------------------------------------------

##2 升级 OpenZlib-----------------------------------------

yum install  -y gcc gcc-c++ glibc make autoconf openssl openssl-devel pcre-devel  pam-devel
yum install  -y pam* zlib*


cd /home/data/zlib-1.2.13/
./configure --prefix=/usr/local/zlib
make && make install
##2end---------------------

##3升级openssl-------------
cd /home/data/openssl-1.1.1q//
./config --prefix=/usr/local/openssl -d shared
make && make install 
echo '/usr/local/openssl/lib' >> /etc/ld.so.conf
ldconfig
mv /usr/bin/openssl /home/data/opensslbk
ln -s /usr/local/openssl/bin/openssl /usr/bin/openssl

##3end--and start update SSH------------------------

##4-----安装OpenSSH 8.6p1-------
cd /home/data/openssh-9.1p1/
./configure --prefix=/usr/local/openssh --with-ssl-dir=/usr/local/openssl --with-zlib=/usr/local/zlib --with-pam --without-openssl-header-check
 make && make install

mv /etc/ssh/sshd_config /home/data/sshd_config.bak
cp /usr/local/openssh/etc/sshd_config /etc/ssh/sshd_config
mv /usr/sbin/sshd /home/data/sshd.bak
cp /usr/local/openssh/sbin/sshd /usr/sbin/sshd
mv /usr/bin/ssh /home/data/ssh.bak
cp /usr/local/openssh/bin/ssh /usr/bin/ssh
mv /usr/bin/ssh-keygen /home/data/ssh-keygen.bak
cp /usr/local/openssh/bin/ssh-keygen /usr/bin/ssh-keygen
mv /etc/ssh/ssh_host_ecdsa_key.pub /home/data/ssh_host_ecdsa_key.pub.bak
cp /usr/local/openssh/etc/ssh_host_ecdsa_key.pub /etc/ssh/ssh_host_ecdsa_key.pub

for  i   in  $(rpm  -qa  |grep  openssh);do  rpm  -e  $i  --nodeps ;done

#mv /etc/ssh/ssh_config.rpmsave /etc/ssh/ssh_config
mv /etc/ssh/sshd_config.rpmsave /etc/ssh/sshd_config


cp /home/data/openssh-9.1p1/contrib/redhat/sshd.init /etc/init.d/sshd
chmod u+x   /etc/init.d/sshd
#-------------修改配置文件------------
cp /etc/init.d/sshd /home/data/sshdnewbk
sed -i '/SSHD=/c\SSHD=\/usr\/local\/openssh\/sbin\/sshd'  /etc/init.d/sshd
sed -i '/\/usr\/bin\/ssh-keygen/c\         \/usr\/local\/openssh\/bin\/ssh-keygen -A'  /etc/init.d/sshd
sed -i '/ssh_host_rsa_key.pub/i\                \/sbin\/restorecon \/etc\/ssh\/ssh_host_key.pub'  /etc/init.d/sshd  
sed -i '/$SSHD $OPTIONS && success || failure/i\       \ OPTIONS="-f /etc/ssh/sshd_config"' /etc/rc.d/init.d/sshd
#---------操作sshd_config-------
sed -i '/PasswordAuthentication/c\PasswordAuthentication yes' /etc/ssh/sshd_config
sed -i '/X11Forwarding/c\X11Forwarding yes' /etc/ssh/sshd_config
sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

cp -arp /usr/local/openssh/bin/* /usr/bin/
service sshd restart

##3end------------------------------------------


#----------配置开机项---------------
chkconfig --add sshd
chkconfig --level 2345 sshd on
chkconfig --list
#----------关闭Telnet服务--------------- 
#systemctl stop telnet.socket  
#systemctl stop xinetd
#systemctl disable xinetd.service
#systemctl disable telnet.socket

#--------清理安装过程文件---------------------
#rm -fr /home/data

}


c7_yum_docker(){
local VERSION=20.10.23-3.el7
echo -e "\n\e[1;35m此方法更换了所有源\e[0m"
echo -e "\n\e[1;35m本次安装版本为20.10.23-3.el7\e[0m"
echo -e "\n\e[1;35m不想安装请在五秒内终止脚本\e[0m\n"
for i in {5..1}
do
    echo -n "${i} "
    echo -ne "\r"
    sleep 1
done


echo -e "\n\e[1;35m使用阿里云的yum源安装docker-ce\e[0m"
local DIR1=$(date +%F)
mkdir -p /data/yumbak-$DIR1

echo -e "\n\e[1;35m备份原有的yum源，备份文件在/data/下\e[0m"
mv /etc/yum.repos.d/* /data/yumbak-$DIR1


echo -e "\n\e[1;35m开启linux内核流量转发\e[0m"
#开启linux内核流量转发
cat > /etc/sysctl.d/docker.conf <<EOF
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
net.ipv4.conf.default.rp_filter = 0
net.ipv4.conf.all.rp_filter = 0
net.ipv4.ip_forward = 1
EOF

modprobe br_netfilter
sysctl -p /etc/sysctl.d/docker.conf


cat > /etc/yum.repos.d/CentOS-Base.repo <<EOF
# CentOS-Base.repo
#
# The mirror system uses the connecting IP address of the client and the
# update status of each mirror to pick mirrors that are updated to and
# geographically close to the client.  You should use this for CentOS updates
# unless you are manually picking other mirrors.
#
# If the mirrorlist= does not work for you, as a fall back you can try the 
# remarked out baseurl= line instead.
#
#
 
[base]
name=CentOS-\$releasever - Base - mirrors.aliyun.com
failovermethod=priority
baseurl=http://mirrors.aliyun.com/centos/\$releasever/os/\$basearch/
        http://mirrors.aliyuncs.com/centos/\$releasever/os/\$basearch/
        http://mirrors.cloud.aliyuncs.com/centos/\$releasever/os/\$basearch/
gpgcheck=1
gpgkey=http://mirrors.aliyun.com/centos/RPM-GPG-KEY-CentOS-7
 
#released updates 
[updates]
name=CentOS-\$releasever - Updates - mirrors.aliyun.com
failovermethod=priority
baseurl=http://mirrors.aliyun.com/centos/\$releasever/updates/\$basearch/
        http://mirrors.aliyuncs.com/centos/\$releasever/updates/\$basearch/
        http://mirrors.cloud.aliyuncs.com/centos/\$releasever/updates/\$basearch/
gpgcheck=1
gpgkey=http://mirrors.aliyun.com/centos/RPM-GPG-KEY-CentOS-7
 
#additional packages that may be useful
[extras]
name=CentOS-\$releasever - Extras - mirrors.aliyun.com
failovermethod=priority
baseurl=http://mirrors.aliyun.com/centos/\$releasever/extras/\$basearch/
        http://mirrors.aliyuncs.com/centos/\$releasever/extras/\$basearch/
        http://mirrors.cloud.aliyuncs.com/centos/\$releasever/extras/\$basearch/
gpgcheck=1
gpgkey=http://mirrors.aliyun.com/centos/RPM-GPG-KEY-CentOS-7
 
#additional packages that extend functionality of existing packages
[centosplus]
name=CentOS-\$releasever - Plus - mirrors.aliyun.com
failovermethod=priority
baseurl=http://mirrors.aliyun.com/centos/\$releasever/centosplus/\$basearch/
        http://mirrors.aliyuncs.com/centos/\$releasever/centosplus/\$basearch/
        http://mirrors.cloud.aliyuncs.com/centos/\$releasever/centosplus/\$basearch/
gpgcheck=1
enabled=0
gpgkey=http://mirrors.aliyun.com/centos/RPM-GPG-KEY-CentOS-7
 
#contrib - packages by Centos Users
[contrib]
name=CentOS-\$releasever - Contrib - mirrors.aliyun.com
failovermethod=priority
baseurl=http://mirrors.aliyun.com/centos/\$releasever/contrib/\$basearch/
        http://mirrors.aliyuncs.com/centos/\$releasever/contrib/\$basearch/
        http://mirrors.cloud.aliyuncs.com/centos/\$releasever/contrib/\$basearch/
gpgcheck=1
enabled=0
gpgkey=http://mirrors.aliyun.com/centos/RPM-GPG-KEY-CentOS-7
EOF

cat > /etc/yum.repos.d/docker-ce.repo <<EOF
[docker-ce-stable]
name=Docker CE Stable - \$basearch
baseurl=https://mirrors.aliyun.com/docker-ce/linux/centos/\$releasever/\$basearch/stable
enabled=1
gpgcheck=1
gpgkey=https://mirrors.aliyun.com/docker-ce/linux/centos/gpg

[docker-ce-stable-debuginfo]
name=Docker CE Stable - Debuginfo \$basearch
baseurl=https://mirrors.aliyun.com/docker-ce/linux/centos/\$releasever/debug-\$basearch/stable
enabled=0
gpgcheck=1
gpgkey=https://mirrors.aliyun.com/docker-ce/linux/centos/gpg

[docker-ce-stable-source]
name=Docker CE Stable - Sources
baseurl=https://mirrors.aliyun.com/docker-ce/linux/centos/\$releasever/source/stable
enabled=0
gpgcheck=1
gpgkey=https://mirrors.aliyun.com/docker-ce/linux/centos/gpg

[docker-ce-test]
name=Docker CE Test - \$basearch
baseurl=https://mirrors.aliyun.com/docker-ce/linux/centos/\$releasever/\$basearch/test
enabled=1
gpgcheck=1
gpgkey=https://mirrors.aliyun.com/docker-ce/linux/centos/gpg

[docker-ce-test-debuginfo]
name=Docker CE Test - Debuginfo \$basearch
baseurl=https://mirrors.aliyun.com/docker-ce/linux/centos/\$releasever/debug-\$basearch/test
enabled=0
gpgcheck=1
gpgkey=https://mirrors.aliyun.com/docker-ce/linux/centos/gpg

[docker-ce-test-source]
name=Docker CE Test - Sources
baseurl=https://mirrors.aliyun.com/docker-ce/linux/centos/\$releasever/source/test
enabled=0
gpgcheck=1
gpgkey=https://mirrors.aliyun.com/docker-ce/linux/centos/gpg

[docker-ce-nightly]
name=Docker CE Nightly - \$basearch
baseurl=https://mirrors.aliyun.com/docker-ce/linux/centos/\$releasever/\$basearch/nightly
enabled=0
gpgcheck=1
gpgkey=https://mirrors.aliyun.com/docker-ce/linux/centos/gpg

[docker-ce-nightly-debuginfo]
name=Docker CE Nightly - Debuginfo \$basearch
baseurl=https://mirrors.aliyun.com/docker-ce/linux/centos/\$releasever/debug-\$basearch/nightly
enabled=0
gpgcheck=1
gpgkey=https://mirrors.aliyun.com/docker-ce/linux/centos/gpg

[docker-ce-nightly-source]
name=Docker CE Nightly - Sources
baseurl=https://mirrors.aliyun.com/docker-ce/linux/centos/\$releasever/source/nightly
enabled=0
gpgcheck=1
gpgkey=https://mirrors.aliyun.com/docker-ce/linux/centos/gpg
EOF

cat >/etc/yum.repos.d/epel.repo <<EOF
[epel]
name=Extra Packages for Enterprise Linux 7 - \$basearch
baseurl=http://mirrors.aliyun.com/epel/7/\$basearch
failovermethod=priority
enabled=1
gpgcheck=0
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-7
 
[epel-debuginfo]
name=Extra Packages for Enterprise Linux 7 - \$basearch - Debug
baseurl=http://mirrors.aliyun.com/epel/7/\$basearch/debug
failovermethod=priority
enabled=0
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-7
gpgcheck=0
 
[epel-source]
name=Extra Packages for Enterprise Linux 7 - \$basearch - Source
baseurl=http://mirrors.aliyun.com/epel/7/SRPMS
failovermethod=priority
enabled=0
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-7
EOF

yum clean all && yum makecache



yum -y install docker-ce-${VERSION}  docker-ce-cli-$VERSION
[ $? -eq 0 ] && echo -e "\e[1;35m安装完成 \e[0m" || echo -e "\e[1;31m安装失败 \e[0m"


sudo rm -rf /usr/bin/docker
#使用阿里做镜像加速
echo -e "\n\e[1;35m阿里镜像加速\e[0m"
[ -d /etc/docker ] || mkdir -p /etc/docker
cat > /etc/docker/daemon.json <<EOF
{
"registry-mirrors": ["https://si7y70hh.mirror.aliyuncs.com"]
}
EOF
systemctl daemon-reload

systemctl enable --now docker
[ $? -eq 0 ] && echo -e "\e[1;35mdocker启动成功\e[0m" || echo -e "\e[1;31mdocker启动失败 \e[0m"


echo -e "\n\e[1;35m安装的docker版本\e[0m"
docker version


}












































c7_yum2_docker(){



DOCKER_VERSION="-20.10.9-3.el7"
echo -e "\n\e[1;35m此方法只添加了docker.repo，不想使用此方法请在五秒内终止脚本\e[0m"
echo -e "\n\e[1;35m安装完没有server端不知道原因\e[0m"
echo -e "\n\e[1;35m不想安装请在五秒内终止脚本\e[0m\n"
for i in {5..1}
do
    echo -n "${i} "
    echo -ne "\r"
    sleep 1
done



cat >/etc/yum.repos.d/docker.repo <<EOF
[docker]
name=docker
baseurl=https://mirrors.aliyun.com/docker-ce/linux/centos/7.9/x86_64/stable/
gpgcheck=0
EOF


yum clean all
yum repolist
#yum list docker-ce* --showduplicates | sort -r


yum -y install docker-ce${DOCKER_VERSION} docker-ce-cli${DOCKER_VERSION}


#使用阿里做镜像加速
echo -e "\n\e[1;35m配置阿里镜像加速\e[0m"
[ -d /etc/docker ] || mkdir -p /etc/docker
cat > /etc/docker/daemon.json <<EOF
{
"registry-mirrors": ["https://252ml0bu.mirror.aliyuncs.com"]
}
EOF
[ $? -eq 0 ] && echo -e "\e[1;32m             ok \e[0m" || echo -e "\e[1;31m                false \e[0m"

systemctl daemon-reload

systemctl enable --now docker
echo -e "\n\e[1;35m查看安装版本信息\e[0m"
docker version

systemctl restart docker

echo -e "\n\e[1;35m验证镜像拉取是否正常\e[0m"
docker run hello-world &>/dev/null
docker images

}



c8_yum_docker(){



local DOCKER_VERSION="-20.10.23-3.el8"
echo -e "\n\e[1;35m本次安装的版本是docker-ce${DOCKER_VERSION}\e[0m"
echo -e "\n\e[1;35m此方法只添加了docker.repo\e[0m"
echo -e "\n\e[1;35m不想安装请在五秒内终止脚本\e[0m\n"
for i in {5..1}
do
    echo -n "${i} "
    echo -ne "\r"
    sleep 1
done


cat >/etc/yum.repos.d/docker.repo <<EOF
[docker]
name=docker
baseurl=https://mirrors.aliyun.com/docker-ce/linux/centos/8/x86_64/stable/
        https://mirrors.tuna.tsinghua.edu.cn/docker-ce/linux/centos/8/x86_64/stable/
gpgcheck=0
EOF


yum clean all
yum repolist
#yum list docker-ce* --showduplicates | sort -r


yum -y install docker-ce${DOCKER_VERSION} docker-ce-cli${DOCKER_VERSION}


#使用阿里做镜像加速
echo -e "\n\e[1;35m配置阿里镜像加速\e[0m"
[ -d /etc/docker ] || mkdir -p /etc/docker
cat > /etc/docker/daemon.json <<EOF
{
"registry-mirrors": ["https://252ml0bu.mirror.aliyuncs.com"]
}
EOF
[ $? -eq 0 ] && echo -e "\e[1;32m             ok \e[0m" || echo -e "\e[1;31m                false \e[0m"

systemctl daemon-reload

systemctl enable --now docker
echo -e "\n\e[1;35m查看安装版本信息\e[0m"
docker version

systemctl restart docker

echo -e "\n\e[1;35m验证镜像拉取是否正常\e[0m"
docker run hello-world &>/dev/null
docker images

}








offline_install_docker(){
local DOCKER_VERSION=20.10.9
local URL=https://mirrors.aliyun.com/docker-ce/linux/static/stable/x86_64/docker-20.10.9.tgz
echo -e "\n\e[1;35m现在安装的版本是docker-${DOCKER_VERSION}，若不想安装此版本请在五秒内终止脚本运行\e[0m"
echo -e "\e[1;35mcentos7，rocky8上测试正常\e[0m\n"

for i in {5..1}
do
    echo -n "${i} "
    echo -ne "\r"
    sleep 1
done


if [ -e docker-${DOCKER_VERSION}.tgz ];then
    echo -e "\n\e[1;32m文件已存在,开始安装\e[0m"
else
    echo -e "\n\e[1;33m文件不存在，开始下载\e[0m"
    wget $URL && echo -e "\e[1;32m下载成功\e[0m" || { echo -e "\e[1;31m下载失败，请检查下载链接是否失效\e[0m" ;exit; }
fi

echo -e "\n\e[1;35m解压源文件，拷贝docker文件到bin下\e[0m"
tar xvf docker-${DOCKER_VERSION}.tgz -C /usr/local/

cp /usr/local/docker/* /usr/bin/
[ $? -eq 0 ] && echo -e "\e[1;32m             ok \e[0m" || echo -e "\e[1;31m                false \e[0m"




echo -e "\n\e[1;35m写入service文件\e[0m"
cat > /lib/systemd/system/docker.service <<EOF
[Unit]
Description=Docker Application Container Engine
Documentation=https://docs.docker.com
After=network-online.target firewalld.service
Wants=network-online.target

[Service]
Type=notify
# the default is not to use systemd for cgroups because the delegate issues still
# exists and systemd currently does not support the cgroup feature set required
# for containers run by docker
ExecStart=/usr/bin/dockerd -H unix://var/run/docker.sock
ExecReload=/bin/kill -s HUP \$MAINPID
# Having non-zero Limit*s causes performance problems due to accounting overhead
# in the kernel. We recommend using cgroups to do container-local accounting.
LimitNOFILE=infinity
LimitNPROC=infinity
LimitCORE=infinity
# Uncomment TasksMax if your systemd version supports it.
# Only systemd 226 and above support this version.
#TasksMax=infinity
TimeoutStartSec=0
# set delegate yes so that systemd does not reset the cgroups of docker containers
Delegate=yes
# kill only the docker process, not all processes in the cgroup
KillMode=process
# restart the docker process if it exits prematurely
Restart=on-failure
StartLimitBurst=3
StartLimitInterval=60s
[Install]
WantedBy=multi-user.target
EOF
[ $? -eq 0 ] && echo -e "\e[1;32m             ok \e[0m" || echo -e "\e[1;31m                false \e[0m"


echo -e "\n\e[1;35m启动\e[0m"
systemctl daemon-reload
systemctl enable --now docker  &>/dev/null
[ $? -eq 0 ] && echo -e "\e[1;32m             ok \e[0m" || echo -e "\e[1;31m                false \e[0m"



#使用阿里做镜像加速
echo -e "\n\e[1;35m配置阿里镜像加速\e[0m"
[ -d /etc/docker ] || mkdir -p /etc/docker
cat > /etc/docker/daemon.json <<EOF
{
"registry-mirrors": ["https://252ml0bu.mirror.aliyuncs.com"]
}
EOF
[ $? -eq 0 ] && echo -e "\e[1;32m             ok \e[0m" || echo -e "\e[1;31m                false \e[0m"

systemctl daemon-reload
systemctl restart docker

echo -e "\n\e[1;35m查看安装版本信息\e[0m"
docker version

echo -e "\n\e[1;35m拉取hello-world，验证镜像拉取是否正常\e[0m"
docker run hello-world &>/dev/null
docker images



}

redhat_install_clickhouse(){
sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://packages.clickhouse.com/rpm/clickhouse.repo
sudo yum install -y clickhouse-server clickhouse-client

sudo /etc/init.d/clickhouse-server start
clickhouse-client 
# or "clickhouse-client --password" if you set up a password.
}



debian_install_clickhouse(){


#安装环境配置和安装软件更新
sudo apt-get install -y apt-transport-https ca-certificates dirmngr
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 8919F6BD2B48D754

echo "deb https://packages.clickhouse.com/deb stable main" | sudo tee \
/etc/apt/sources.list.d/clickhouse.list
sudo apt-get update

#安装clickhouse
sudo apt-get install -y clickhouse-server clickhouse-client

#启动clickhouse服务
sudo service clickhouse-server start 

#启动客户端
clickhouse-client 
# or "clickhouse-client --password" if you've set up a password.

exit


}

tgz_install_clickhouse(){
#获取最后一个版本号
LATEST_VERSION=$(curl -s https://packages.clickhouse.com/tgz/stable/ | \
    grep -Eo '[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+' | sort -V -r | head -n 1)
export LATEST_VERSION

case $(uname -m) in
  x86_64) ARCH=amd64 ;;
  aarch64) ARCH=arm64 ;;
  *) echo "Unknown architecture $(uname -m)"; exit 1 ;;
esac
#下载对应版本号的tgz安装包
for PKG in clickhouse-common-static clickhouse-common-static-dbg clickhouse-server clickhouse-client
do
  curl -fO "https://packages.clickhouse.com/tgz/stable/$PKG-$LATEST_VERSION-${ARCH}.tgz" \
    || curl -fO "https://packages.clickhouse.com/tgz/stable/$PKG-$LATEST_VERSION.tgz"
done
#解压压缩包并执行对应的脚本
tar -xzvf "clickhouse-common-static-$LATEST_VERSION-${ARCH}.tgz" \
  || tar -xzvf "clickhouse-common-static-$LATEST_VERSION.tgz"
#生成ClickHouse编译的二进制文件
sudo "clickhouse-common-static-$LATEST_VERSION/install/doinst.sh"

tar -xzvf "clickhouse-common-static-dbg-$LATEST_VERSION-${ARCH}.tgz" \
  || tar -xzvf "clickhouse-common-static-dbg-$LATEST_VERSION.tgz"
#生成带有调试信息的ClickHouse二进制文件
sudo "clickhouse-common-static-dbg-$LATEST_VERSION/install/doinst.sh"

tar -xzvf "clickhouse-server-$LATEST_VERSION-${ARCH}.tgz" \
  || tar -xzvf "clickhouse-server-$LATEST_VERSION.tgz"
#创建clickhouse-server软连接，并安装默认配置服务
sudo "clickhouse-server-$LATEST_VERSION/install/doinst.sh" configure
#启动服务
sudo /etc/init.d/clickhouse-server start

tar -xzvf "clickhouse-client-$LATEST_VERSION-${ARCH}.tgz" \
  || tar -xzvf "clickhouse-client-$LATEST_VERSION.tgz"
#创建clickhouse-client客户端工具软连接，并安装客户端配置文件
sudo "clickhouse-client-$LATEST_VERSION/install/doinst.sh"
}

compile_install_clickhouse(){
#gcc 10安装
# base centos 7
yum update
yum install -y gcc gcc-c++
yum install -y bzip2
wget -P /home https://mirrors.aliyun.com/gnu/gcc/gcc-10.2.0/gcc-10.2.0.tar.gz
cd /home && tar -xzvf /home/gcc-10.2.0.tar.gz
cd /home/gcc-10.2.0 && ./contrib/download_prerequisites
#这一步看网速，需要挺久的
mkdir /usr/lib/gcc/x86_64-redhat-linux/10.2.0
mkdir /home/gcc-build-10.2.0
cd /home/gcc-build-10.2.0
../gcc-10.2.0/configure --prefix=/usr/lib/gcc/x86_64-redhat-linux/10.2.0/ --enable-checking=release --enable-languages=c,c++ --disable-multilib
make && make install
mv /usr/bin/gcc /usr/bin/gcc-4.8.5
mv /usr/bin/g++ /usr/bin/g++-4.8.5
alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-4.8.5 88 --slave /usr/bin/g++ g++ /usr/bin/g++-4.8.5
alternatives --install /usr/bin/gcc gcc /usr/lib/gcc/x86_64-redhat-linux/10.2.0/bin/x86_64-pc-linux-gnu-gcc 99 --slave /usr/bin/g++ g++ /usr/lib/gcc/x86_64-redhat-linux/10.2.0/bin/x86_64-pc-linux-gnu-g++
alternatives --config gcc
#输入2回车

# 安装re2c
yum -y install git automake libtool
git clone https://github.com.cnpmjs.org/skvadrik/re2c.git re2c
cd re2c
mkdir -p m4
./autogen.sh && ./configure --prefix=/usr && make
make install


# 安装ninja
## 编译安装cmake3.15以上，此教程举例安装3.21
yum install -y openssl-devel
wget https://cmake.org/files/v3.21/cmake-3.21.0-rc1.tar.gz
tar -zxvf cmake-3.21.0-rc1.tar.gz
cd cmake-3.21.0-rc1/
./bootstrap
gmake
gamke install
## 安装ninja
git clone https://github.com/ninja-build/ninja.git ninja
cd ninja
cmake -Bbuild-cmake -H.
cmake --build build-cmake
cp ninja /usr/bin/
ninja --version

#安装python3
yum install -y zlib-devel bzip2-devel openssl-devel ncurses-devel sqlite-devel readline-devel tk-devel
yum -y install python-pip
yum install libffi-devel -y
mv /usr/bin/python /usr/bin/python.bak
wget https://www.python.org/ftp/python/3.7.9/Python-3.7.9.tgz
tar -zxvf Python-3.7.9.tgz
./configure prefix=/usr/local/python3
make && make install
ln -s /usr/local/python3/bin/python3.7 /usr/bin/python

#修改yum配置
vi /usr/bin/yum
把#! /usr/bin/python修改为#! /usr/bin/python2

#
vi /usr/libexec/urlgrabber-ext-down
#把#! /usr/bin/python修改为#! /usr/bin/python2

#安装clickhouse
# 替换github的源（因为墙的原因）
git config --global url."https://hub.fastgit.org".insteadOf https://github.com
git clone https://github.com/ClickHouse/ClickHouse
cd ClickHouse
# 切换到指定版本
git tag -l
git checkout -b v21.7.5.29-stable

git submodule sync
git submodule update --init --recursive #等吧

mkdir build
cd build
cmake -DCMAKE_INSTALL_PREFIX=/usr/local/clickhouse ../
ninja clickhouse #也是需要等很久，最好用screen 


}

compile_install_redis(){
local VERSION=6.2.4
local URL=http://download.redis.io/releases/redis-6.2.4.tar.gz
local INSTALL_DIR=/apps/redis
local PASSWORD=123456

echo -e "\n\e[1;35m 安装的版本是redis-${VERSION}，如果不想安装此版本请在5秒内停止运行脚本 \e[0m"
echo -e "\e[1;35m redis密码是123456 \e[0m"
echo -e "\e[1;35m 安装目录是${INSTALL_DIR} \e[0m"
echo -e "\e[1;35m 官网下载很慢建议提前下载好放在root目录下 \e[0m\n"
for i in {5..1}
do
    echo -n "${i} "
    echo -ne "\r"
    sleep 1
done

echo -e "\n\e[1;35m 消除redis安装启动后的warning \e[0m"
#消除三个warning
#Tcp backlog
#overcommit_memory
cat >> /etc/sysctl.conf <<EOF
net.core.somaxconn = 1024
vm.overcommit_memory = 1
EOF
sysctl -p
#transparent hugepage
if [ $ID = 'centos' -o $ID = 'rocky' ];then
    echo 'echo never > /sys/kernel/mm/transparent_hugepage/enabled' >> /etc/rc.d/rc.local
    chmod +x /etc/rc.d/rc.local
else
#ubuntu
    echo 'echo never > /sys/kernel/mm/transparent_hugepage/enabled' >> /etc/rc.local
    chmod +x /etc/rc.local
fi

echo -e "\n\e[1;35m 安装依赖包 \e[0m"
#安装依赖包 支持systemd
if [ $ID = 'centos' -o $ID = rocky ];then
    #yum -y install gcc jemalloc-devel systemd-devel
    software=("gcc"
    "jemalloc-devel"
    "systemd-devel"
    )
    for i in ${software[@]}
    do
    #rpm -q $i &> /dev/null && echo -e "$i\e[1;32m已安装\e[0m" || { yum -y install $i &> /dev/null; echo -e "$i\e[1;35m安装成功\e[0m" ; }
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
#ubuntu
else
    #apt -y install make gcc libjemalloc-dev libsystemd-dev
    software=("make"
        "gcc"
        "libjemalloc-dev"
        "libsystemd-dev"
        )
    for i in ${software[@]}
    do
    dpkg -l  $i &> /dev/null && echo -e "$i\e[1;32m已安装\e[0m" || { apt -y install $i &> /dev/null ; echo -e "$i\e[1;35m安装成功\e[0m" ; }
done

fi


#下载源码
if [ -e /root/redis-${VERSION}.tar.gz ];then
    echo -e "\n\e[1;35m 文件存在，开始安装\e[0m"
else
    echo -e "\n\e[1;33m 文件不存在，开始下载\e[0m"
    wget ${URL} &&  echo -e "\n\e[1;32m 下载成功\e[0m" || echo -e "\n\e[1;31m 下载失败，请检查下载链接\e[0m"
fi

echo -e "\n\e[1;35m 解压 \e[0m"
tar xvf /root/redis-${VERSION}.tar.gz



#编译安装 支持systemd
echo -e "\n\e[1;35m 编译安装 \e[0m"
cd /root/redis-${VERSION}

#指定redis安装目录
make -j 2 USE_SYSTEMD=yes PREFIX=${INSTALL_DIR} install
[ $? -eq 0 ] && echo -e "\n\e[1;32m                ok \e[0m" || echo -e "\n\e[1;31m                false\e[0m"
ln -s ${INSTALL_DIR}/bin/redis-* /usr/bin/



#配置环境变量
echo -e "\n\e[1;35m 配置环境变量\e[0m"
echo 'PATH=/apps/redis/bin:$PATH' > /etc/profile.d/redis.sh
[ $? -eq 0 ] && echo -e "\n\e[1;32m                ok \e[0m" || echo -e "\n\e[1;31m                false\e[0m"




#准备相关目录和配置文件
#创建配置文件、日志、数据等目录
echo -e "\n\e[1;35m 创建配置文件、日志、数据等目录\e[0m"
mkdir -p ${INSTALL_DIR}/{etc,log,data,run}
[ $? -eq 0 ] && echo -e "\n\e[1;32m                ok \e[0m" || echo -e "\n\e[1;31m                false\e[0m"
cp redis.conf ${INSTALL_DIR}/etc/
sed -i -e 's/bind 127.0.0.1/bind 0.0.0.0/' -e "/# requirepass/a requirepass ${PASSWORD}" -e "/^dir .*/c dir ${INSTALL_DIR}/data/" -e "/logfile .*/c logfile ${INSTALL_DIR}/log/redis-6379.log" -e "/^pidfile .*/c pidfile ${INSTALL_DIR}/run/redis_6379.pid" ${INSTALL_DIR}/etc/redis.conf
#前台启动 redis
#redis-server /apps/redis/etc/redis.conf


echo -e "\n\e[1;35m 创建redis用户\e[0m"
#创建redis用户
if id redis &> /dev/null;then
    echo -e "\n\e[1;35m 用户已存在 \e[0m"
else
    groupadd -g 679 -r redis && useradd -g redis -r -s /sbin/nologin -d /data/redis -u 679 redis
    [ $? -eq 0 ] && echo -e "\n\e[1;32m                ok \e[0m" || echo -e "\n\e[1;31m                false\e[0m"
fi




#设置目录权限
chown -R redis.redis ${INSTALL_DIR}
#创建 Redis 服务 Service 文件




#可以复制CentOS8利用yum安装Redis生成的redis.service文件,进行修改
#cp /lib/systemd/system/redis.service /lib/systemd/system/
echo -e "\n\e[1;35m 配置service文件 \e[0m"
cat >> /lib/systemd/system/redis.service <<EOF
[Unit]
Description=Redis persistent key-value database
After=network.target

[Service]
ExecStart=${INSTALL_DIR}/bin/redis-server ${INSTALL_DIR}/etc/redis.conf --supervised systemd
ExecStop=/bin/kill -s QUIT \$MAINPID
#如果支持systemd可以启用此行
Type=notify
User=redis
Group=redis
RuntimeDirectory=redis
RuntimeDirectoryMode=0755
LimitNOFILE=1000000
#指定此值才支持更大的maxclients值

[Install]
WantedBy=multi-user.target
EOF
[ $? -eq 0 ] && echo -e "\n\e[1;32m                ok \e[0m" || echo -e "\n\e[1;31m                false\e[0m"

echo -e "\n\e[1;35m 启动redis \e[0m"
systemctl daemon-reload
systemctl enable --now redis
[ $? -eq 0 ] && echo -e "\n\e[1;32m                ok \e[0m" || echo -e "\n\e[1;31m                false\e[0m"
systemctl status redis


#验证客户端连接redis
#${INSTALL_DIR}/bin/redis-cli -h IP/HOSTNAME -p PORT -a PASSWORD
echo -e "\n\e[1;35m 连接redis命令 \e[0m"
echo -e "\n\e[1;35m redis-cli -h IP/HOSTNAME -p PORT -a PASSWORD \e[0m"
echo -e "\n\e[1;35m redis-cli -a PASSWORD \e[0m"
}












compile_install_keepalived(){
local VERSION=2.2.7
local URL=https://keepalived.org/software/keepalived-${VERSION}.tar.gz
echo -e "\n\e[1;35m安装的版本是keepalived-${VERSION}，如果不想安装此版本请在5秒内停止运行脚本 \e[0m\n"
for i in {5..1}
do
    echo -n "${i} "
    echo -ne "\r"
    sleep 1
done

if [ $ID = centos -o $ID = rocky ];then
    yum -y install gcc curl openssl-devel libnl3-devel net-snmp-devel
else
    apt update
    apt -y install make gcc ipvsadm build-essential pkg-config automake autoconf libipset-dev libnl-3-dev libnl-genl-3-dev libssl-dev libxtables-dev libip4tc-dev libip6tc-dev libipset-dev libmagic-dev libsnmp-dev libglib2.0-dev libpcre2-dev libnftnl-dev libmnl-dev libsystemd-dev
fi

if [ -e keepalived-${VERSION}.tar.gz ];then
    echo -e "\n\e[1;35m文件存在，开始安装\e[0m"
else
    wget ${URL} && echo -e "\n\e[1;32m下载成功，开始解压安装\e[0m" || echo -e "\n\e[1;31m下载失败，检查下载路径\e[0m"
fi


[ -d /usr/local/src ] || mkdir -p /usr/local/src
echo -e "\n\e[1;35m开始解压\e[0m"
tar xvf keepalived-${VERSION}.tar.gz -C /usr/local/src


echo -e "\n\e[1;35m开始编译\e[0m"
cd /usr/local/src/keepalived-${VERSION}/
./configure --prefix=/usr/local/keepalived --disable-fwmark
make && make install

echo -e "\n\e[1;35m拷贝配置文件\e[0m"
mkdir /etc/keepalived
cp /usr/local/keepalived/etc/keepalived/keepalived.conf.sample /etc/keepalived/keepalived.conf
systemctl enable --now keepalived.service


echo -e "\n\e[1;35m修改配置文件\e[0m"
sed -i 's/vrrp_strict/#vrrp_strict/' /etc/keepalived/keepalived.conf
[ $? -eq 0 ] && echo -e "\e[1;32m                ok \e[0m" || echo -e "\e[1;31m                false\e[0m"


echo -e "\n\e[1;35m重启进程，等待10秒查看服务状态\e[0m"
killall keepalived
for i in {10..1}
do
    echo -n "${i} "
    echo -ne "\r"
    sleep 1
done
systemctl restart keepalived.service


echo -e "\n\e[1;35m查看运行状态\e[0m"
systemctl status keepalived.service | awk "NR==3"
}

install_jumpserver(){
echo -e "\n\e[1;35m官方在线部署\e[0m"
curl -sSL https://github.com/jumpserver/jumpserver/releases/download/v3.9.2/quick_start.sh | bash
}



install_dns(){
DOMAIN=wang.org
HOST=www
HOST_IP=10.0.0.100
LOCALHOST=`hostname -I | awk '{print $1}'`


if [ $ID = 'centos' -o $ID = 'rocky' ];then
        yum install -y  bind bind-utils
elif [ $ID = 'ubuntu' ];then
    apt update
    apt install -y bind9 bind9-utils bind9-host
else
    color "不支持此操作系统，退出!" 1
    exit
fi


if [ $ID = 'centos' -o $ID = 'rocky' ];then
        sed -i -e '/listen-on/s/127.0.0.1/localhost/' -e '/allow-query/s/localhost/any/' -e 's/dnssec-enable yes/dnssec-enable no/' -e 's/dnssec-validation yes/dnssec-validation no/'  /etc/named.conf
        cat >>  /etc/named.rfc1912.zones <<EOF
zone "$DOMAIN" IN {
    type master;
    file  "$DOMAIN.zone";
};
EOF
        cat > /var/named/$DOMAIN.zone <<EOF
\$TTL 1D
@   IN SOA  master admin (
                    1   ; serial
                    1D  ; refresh
                    1H  ; retry
                    1W  ; expire
                    3H )    ; minimum
            NS   master
master      A    ${LOCALHOST}         
$HOST       A    $HOST_IP
EOF
        chmod 640 /var/named/$DOMAIN.zone
        chgrp named /var/named/$DOMAIN.zone
    elif [ $ID = 'ubuntu' ];then
        sed -i 's/dnssec-validation auto/dnssec-validation no/' /etc/bind/named.conf.options
        cat >>  /etc/bind/named.conf.default-zones <<EOF
zone "$DOMAIN" IN {
    type master;
    file  "/etc/bind/$DOMAIN.zone";
};
EOF
        cat > /etc/bind/$DOMAIN.zone <<EOF
\$TTL 1D
@   IN SOA  master admin (
                    1   ; serial
                    1D  ; refresh
                    1H  ; retry
                    1W  ; expire
                    3H )    ; minimum
            NS   master
master      A    ${LOCALHOST}         
$HOST       A    $HOST_IP
EOF
        chgrp bind  /etc/bind/$DOMAIN.zone
    else
        color "不支持此操作系统，退出!" 1
        exit
    fi
    
    
systemctl enable named
systemctl restart named
systemctl is-active named.service
if [ $? -eq 0 ] ;then 
    color "DNS 服务安装成功!" 0  
else 
    color "DNS 服务安装失败!" 1
    exit 1
fi   
}










install_rocky8_zabbix6(){


echo -e "\e[1;35m=============================================================zabbix安装=============================================================\e[0m\n"

echo -e "\n\e[1;35m安装zabbix6版本\e[0m"
echo -e "\n\e[1;35mYUM仓库配置\e[0m"
[[ -e "/etc/yum.repos.d/zabbix.repo" && -e "/etc/yum.repos.d/zabbix-agent2-plugins.repo" ]] && echo -e "\n\e[1;35m检测到已配置\e[0m" || rpm -Uvh https://repo.zabbix.com/zabbix/6.0/rhel/8/x86_64/zabbix-release-6.0-4.el8.noarch.rpm



echo -e "\n\e[1;35mYUM仓库配置修改为清华大学源\e[0m"
sed -i.bak 's#https://repo.zabbix.com#https://mirror.tuna.tsinghua.edu.cn/zabbix#' /etc/yum.repos.d/zabbix.repo

cat /etc/yum.repos.d/zabbix.repo | grep mirror.tuna.tsinghua.edu.cn
[ $? -eq 0 ] && color  "修改成功" 0 || color  "修改失败" 1


dnf clean all
echo -e "\n\e[1;35m安装软件\e[0m"
#dnf install zabbix-server-mysql zabbix-web-mysql zabbix-nginx-conf zabbix-sql-scripts zabbix-selinux-policy zabbix-agent2 -y
software=("zabbix-server-mysql"
    "zabbix-web-mysql" 
    "zabbix-nginx-conf"
    "zabbix-sql-scripts"
    "zabbix-selinux-policy"
    "zabbix-agent2"
    "zabbix-get"
        )
for i in ${software[@]}
do
#rpm -q  $i &> /dev/null && echo -e "$i\t\e[1;32m已安装\e[0m" || { yum -y install $i &> /dev/null ; echo -e "$i\t\e[1;35m安装成功\e[0m" ; }
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




echo -e "\n\e[1;35m安装数据库\e[0m"
#yum -y install mysql mysql-server
software=("mysql"
    "mysql-server" 
        )
for i in ${software[@]}
do
rpm -q  $i &> /dev/null && echo -e "$i\t\e[1;32m已安装\e[0m" || { yum -y install $i &> /dev/null ; echo -e "$i\t\e[1;35m安装成功\e[0m" ; }

done
systemctl enable --now  mysqld

[ $? -eq 0 ] && color  "安装启动成功" 0 || color  "安装启动失败" 1


echo -e "\n\e[1;35m创建zabbix用户\e[0m"
cat << EOF | mysql
create database zabbix character set utf8mb4 collate utf8mb4_bin;
create user zabbix@localhost identified by '123456';
grant all privileges on zabbix.* to zabbix@localhost;
EOF

[ $? -eq 0 ] && color  "创建成功" 0 || color  "创建失败" 1


echo -e "\n\e[1;35m导入初始架构和数据\e[0m"
cat << EOF | mysql
set global log_bin_trust_function_creators = 1;
EOF

zcat /usr/share/zabbix-sql-scripts/mysql/server.sql.gz | mysql --default-character-set=utf8mb4 -uzabbix -p123456 zabbix

cat << EOF | mysql
set global log_bin_trust_function_creators = 0;
EOF

[ $? -eq 0 ] && color  "导入成功" 0 || color  "导入失败" 1
mysql -uzabbix -p123456 zabbix -e 'show tables;'

echo -e "\n\e[1;35m修改配置\e[0m"
sed -i.bak '/# DBPassword/a DBPassword=123456' /etc/zabbix/zabbix_server.conf
#sed -i.bak '/^server/a\        listen 80;\n        server_name     zabbix.wang.org;' /etc/nginx/conf.d/zabbix.conf
sed -i.bak '/^server/a\        listen 8080;' /etc/nginx/conf.d/zabbix.conf
cat >> /etc/php-fpm.d/zabbix.conf <<EOF

php_value[date.timezone] = Asia/Shanghai
EOF


[ $? -eq 0 ] && color  "修改成功" 0 || color  "修改失败" 1

echo -e "\n\e[1;35m修改字体\e[0m"
#wget https://files.cnblogs.com/files/blogs/764021/graphfont.rar
wget https://files.cnblogs.com/files/blogs/764021/SIMHEI.tar.gz
mv /root/SIMHEI.tar.gz /usr/share/zabbix/assets/fonts/
tar zxf /usr/share/zabbix/assets/fonts/SIMHEI.tar.gz -C /usr/share/zabbix/assets/fonts/
mv /usr/share/zabbix/assets/fonts/graphfont.ttf /usr/share/zabbix/assets/fonts/graphfont.ttf.bak
cp /usr/share/zabbix/assets/fonts/SIMHEI.TTF /usr/share/zabbix/assets/fonts/graphfont.ttf

echo -e "\n\e[1;35m重启服务\e[0m"
systemctl restart zabbix-server zabbix-agent2 nginx php-fpm
systemctl enable zabbix-server zabbix-agent2 nginx php-fpm
systemctl is-enabled zabbix-agent2.service  zabbix-server.service nginx php-fpm

echo -e "\e[1;35m===========================================================================================================================================\e[0m"
echo -e "\e[1;32mhttp://`hostname -I`:8080进入配置页面\e[0m"
echo -e "\n\e[1;32m探测被监控端状态zabbix_get -s 被监控端IP -k agent.ping\e[0m"
echo -e "\e[1;35m===========================================================================================================================================\e[0m"
echo -e "\n\e[1;32m中文乱码问题,脚本已经替换了一种字体，如果想替换别的字体按下面步骤操作\e[0m"
echo -e "\e[1;32m将windows上的字体放在此目录/usr/share/zabbix/assets/fonts\e[0m"
#echo -e "\e[1;35m执行命令修改sed -i 's/graphfont/新字体名字/g' /usr/share/zabbix/include/defines.inc.php\e[0m"
echo -e "\e[1;32m新字体改名成graphfont.ttf\e[0m"
echo -e "\e[1;32mcd /usr/share/zabbix/assets/fonts\e[0m"
echo -e "\e[1;32mmv graphfont.ttf graphfont.ttf.bak\e[0m"
echo -e "\e[1;32mcp MSYHBD.TTC graphfont.ttf\e[0m"
echo -e "\e[1;35m===========================================================================================================================================\e[0m"
exit



}









install_rocky8_zabbix6_agent2(){
echo -e "\e[1;35m=============================================================zabbix_agent2安装=============================================================\e[0m"
echo -e "\e[1;35m安装的agent2对应的是zabbix6版本\e[0m\n"
echo -e "\e[1;35mExample: Server=127.0.0.1,192.168.1.0/24,::1,2001:db8::/32,zabbix.example.com\e[0m"
read -p "输入SERVER端IP: " ZABBIX_SERVER

#ZABBIX_SERVER=10.0.0.82

echo -e "\n\e[1;35mYUM仓库配置\e[0m"
[[ -e "/etc/yum.repos.d/zabbix.repo" && -e "/etc/yum.repos.d/zabbix-agent2-plugins.repo" ]] && echo -e "\n\e[1;35m检测到已配置\e[0m" || rpm -Uvh https://repo.zabbix.com/zabbix/6.0/rhel/8/x86_64/zabbix-release-6.0-4.el8.noarch.rpm



echo -e "\n\e[1;35mYUM仓库配置修改为清华大学源\e[0m"
sed -i.bak 's#https://repo.zabbix.com#https://mirror.tuna.tsinghua.edu.cn/zabbix#'  /etc/yum.repos.d/zabbix.repo

cat /etc/yum.repos.d/zabbix.repo | grep mirror.tuna.tsinghua.edu.cn

[ $? -eq 0 ] && color  "修改成功" 0 || color  "修改失败" 1


echo -e "\n\e[1;35m安装agent2\e[0m"
yum -y install zabbix-agent2



#rpm -ivh https://mirrors.aliyun.com/zabbix/zabbix/6.0/rhel/8/x86_64/zabbix-agent2-6.0.5-1.el8.x86_64.rpm



echo -e "\n\e[1;35m修改配置\e[0m"
sed -i -e "/^Server=127.0.0.1/c Server=$ZABBIX_SERVER"  -e "/^Hostname=Zabbix server/c Hostname=`hostname -I`"  /etc/zabbix/zabbix_agent2.conf

[ $? -eq 0 ] && color  "修改成功" 0 || color  "修改失败" 1

echo -e "\n\e[1;35m重启服务\e[0m"
systemctl enable zabbix-agent2.service
systemctl restart zabbix-agent2.service
systemctl is-active zabbix-agent2.service
exit
}









install_rocky8_zabbix5(){

echo -e "\e[1;35m=============================================================zabbix安装=============================================================\e[0m\n"
echo -e "\e[1;35m安装zabbix5版本\e[0m"
echo -e "\n\e[1;35mYUM仓库配置\e[0m"


[ -e /etc/yum.repos.d/zabbix.repo ] && echo -e "\n\e[1;35m检测到已配置\e[0m" || rpm -Uvh https://repo.zabbix.com/zabbix/5.0/rhel/8/x86_64/zabbix-release-5.0-1.el8.noarch.rpm




echo -e "\n\e[1;35mYUM仓库配置修改为清华大学源\e[0m"
sed -i.bak 's#http://repo.zabbix.com#https://mirror.tuna.tsinghua.edu.cn/zabbix#' /etc/yum.repos.d/zabbix.repo
cat /etc/yum.repos.d/zabbix.repo | grep mirror.tuna.tsinghua.edu.cn
[ $? -eq 0 ] && color  "修改成功" 0 || color  "修改失败" 1
dnf clean all


echo -e "\n\e[1;35m安装软件\e[0m"
dnf -y install zabbix-server-mysql zabbix-web-mysql zabbix-nginx-conf zabbix-agent2 zabbix-get

yum -y install langpacks-zh_CN


echo -e "\n\e[1;35m安装，启动数据库\e[0m"
dnf -y install  mysql-server
systemctl enable --now  mysqld

echo -e "\n\e[1;35m创建zabbix用户\e[0m"
cat << EOF | mysql
create database zabbix character set utf8 collate utf8_bin;
create user zabbix@localhost identified by '123456';
grant all privileges on zabbix.* to zabbix@localhost;
set global log_bin_trust_function_creators = 1;
EOF
#set global innodb_large_prefix = 1;

[ $? -eq 0 ] && color  "创建成功" 0 || color  "创建失败" 1


echo -e "\n\e[1;35m导入初始架构和数据\e[0m"
zcat /usr/share/doc/zabbix-server-mysql*/create.sql.gz | mysql -uzabbix -p123456 zabbix
[ $? -eq 0 ] && color  "导入成功" 0 || color  "导入失败" 1


echo 'DBPassword=123456' >> /etc/zabbix/zabbix_server.conf

echo -e "\n\e[1;35m修改端口号和时区\e[0m"
#listen 80;
#server_name example.com;
#/etc/nginx/conf.d/zabbix.conf
#sed -ri 's/^#(\ +listen\ +80;)$/\1/' /etc/nginx/conf.d/zabbix.conf
#sed -ri 's/^# +listen +80(;)$/ +listen +8080\1/' /etc/nginx/conf.d/zabbix.conf
sed -ri '/# +listen +80;/a \        listen          8080;' /etc/nginx/conf.d/zabbix.conf


#php_value[date.timezone] = Asia/Shanghai/ /etc/php-fpm.d/zabbix.conf
#sed -ri 's/^.*Europe\/Riga$/php_value[date.timezone] = Asia\/Shanghai/' /etc/php-fpm.d/zabbix.conf
#sed -ri 's/Europe\/Riga/Asia\/Shanghai/' /etc/php-fpm.d/zabbix.conf



sed -ri '/.*Europe\/Riga/a\php_value[date.timezone] = Asia\/Shanghai' /etc/php-fpm.d/zabbix.conf

[ $? -eq 0 ] && color  "修改成功" 0 || color  "修改失败" 1

echo -e "\n\e[1;35m修改字体\e[0m"
#wget https://files.cnblogs.com/files/blogs/764021/graphfont.rar
wget https://files.cnblogs.com/files/blogs/764021/SIMHEI.tar.gz
mv /root/SIMHEI.tar.gz /usr/share/zabbix/assets/fonts/
tar zxf /usr/share/zabbix/assets/fonts/SIMHEI.tar.gz -C /usr/share/zabbix/assets/fonts/
mv /usr/share/zabbix/assets/fonts/graphfont.ttf /usr/share/zabbix/assets/fonts/graphfont.ttf.bak
cp /usr/share/zabbix/assets/fonts/SIMHEI.TTF /usr/share/zabbix/assets/fonts/graphfont.ttf



echo -e "\n\e[1;35m重启服务\e[0m"
systemctl restart zabbix-server zabbix-agent2 nginx php-fpm
systemctl enable zabbix-server zabbix-agent2 nginx php-fpm



echo -e "\e[1;35m===========================================================================================================================================\e[0m"
echo -e "\e[1;32mhttp://`hostname -I`:8080进入配置页面\e[0m"
echo -e "\n\e[1;32m探测被监控端状态zabbix_get -s 被监控端IP -k agent.ping\e[0m"
echo -e "\e[1;32m===========================================================================================================================================\e[0m"
echo -e "\n\e[1;36m中文乱码问题,脚本已经替换了一种字体，如果想替换别的字体按下面步骤操作\e[0m"
echo -e "\e[1;32m将windows上的字体放在此目录/usr/share/zabbix/assets/fonts\e[0m"
#echo -e "\e[1;35m执行命令修改sed -i 's/graphfont/新字体名字/g' /usr/share/zabbix/include/defines.inc.php\e[0m"
echo -e "\e[1;32m新字体改名成graphfont.ttf\e[0m"
echo -e "\e[1;32mcd /usr/share/zabbix/assets/fonts\e[0m"
echo -e "\e[1;32mmv graphfont.ttf graphfont.ttf.bak\e[0m"
echo -e "\e[1;32mcp MSYHBD.TTC graphfont.ttf\e[0m"
echo -e "\e[1;35m===========================================================================================================================================\e[0m"
exit
}







install_rocky8_zabbix5_agent2(){
echo -e "\e[1;35m=============================================================zabbix_agent2安装=============================================================\e[0m"
echo -e "\e[1;35m安装的agent2对应的是zabbix5版本\e[0m\n"
echo -e "\e[1;35mExample: Server=127.0.0.1,192.168.1.0/24,::1,2001:db8::/32,zabbix.example.com\e[0m"
read -p "输入SERVER端IP: " ZABBIX_SERVER

#ZABBIX_SERVER=10.0.0.82

echo -e "\n\e[1;35mYUM仓库配置\e[0m"
[ -e /etc/yum.repos.d/zabbix.repo ]  && echo -e "\n\e[1;35m检测到已配置\e[0m" || rpm -Uvh https://repo.zabbix.com/zabbix/5.0/rhel/8/x86_64/zabbix-release-5.0-1.el8.noarch.rpm



echo -e "\n\e[1;35mYUM仓库配置修改为清华大学源\e[0m"
sed -i.bak 's#http://repo.zabbix.com#https://mirror.tuna.tsinghua.edu.cn/zabbix#'  /etc/yum.repos.d/zabbix.repo

cat /etc/yum.repos.d/zabbix.repo | grep mirror.tuna.tsinghua.edu.cn
[ $? -eq 0 ] && color  "修改成功" 0 || color  "修改失败" 1





echo -e "\n\e[1;35m安装agent2\e[0m"
yum -y install zabbix-agent2



#rpm -ivh https://mirrors.aliyun.com/zabbix/zabbix/6.0/rhel/8/x86_64/zabbix-agent2-5.0.5-1.el8.x86_64.rpm



echo -e "\n\e[1;35m修改配置\e[0m"
sed -i -e "/^Server=127.0.0.1/c Server=$ZABBIX_SERVER"  -e "/^Hostname=Zabbix server/c Hostname=`hostname -I`"  /etc/zabbix/zabbix_agent2.conf

[ $? -eq 0 ] && color  "修改成功" 0 || color  "修改失败" 1


echo -e "\n\e[1;35m重启服务\e[0m"
systemctl enable zabbix-agent2.service
systemctl restart zabbix-agent2.service

[ $? -eq 0 ] && color  "启动完成" 0 || color  "启动失败" 1
systemctl is-active zabbix-agent2.service


exit
}

install_kubernetes_radhat_master1236(){


if [ $ID = 'centos' -o $ID = 'rocky' ];then
    echo -e "\e[1;32m检测系统为centos/rocky允许执行\e[0m"
else
    echo -e "\e[1;31m系统不是centos/rocky系列,不可以执行此脚本\e[0m"
    exit
fi




hostnamectl set-hostname k8s-master

cat >>/etc/hosts <<EOF
10.0.0.11 k8s-master
10.0.0.12 k8s-node1
10.0.0.13 k8s-node2
EOF

sed -i.bak '/swap/s@^@#@' /etc/fstab
swapoff  -a


cat > /etc/sysctl.d/k8s.conf<<EOF
net.ipv4.ip_forward=1
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF
sysctl -p
yum install -y yum-utils
yum-config-manager --add-repo  https://download.docker.com/linux/centos/docker-ce.repo
yum -y install docker-ce-20.10.7-3.el7 docker-ce-cli-20.10.7-3.el7 containerd.io docker-compose-plugin
systemctl enable --now docker

cat > /etc/docker/daemon.json <<EOF
{
  "exec-opts": ["native.cgroupdriver=systemd"],
  "log-driver": "json-file",
   "log-opts": {
  "max-size": "100m"
 },
 "storage-driver": "overlay2"
}
EOF
systemctl daemon-reload;systemctl restart docker

cat >/etc/yum.repos.d/kubernetes.repo <<EOF
[kubernetes]
name=Kubernetes
baseurl=https://mirrors.aliyun.com/kubernetes/yum/repos/kubernetes-el7-x86_64/
enabled=1
gpgcheck=1
repo_gpgcheck=0
gpgkey=https://mirrors.aliyun.com/kubernetes/yum/doc/yum-key.gpg https://mirrors.aliyun.com/kubernetes/yum/doc/rpm-package-key.gpg
EOF

yum install -y kubeadm-1.23.6-0 kubectl-1.23.6-0 kubelet-1.23.6-0 --disableexcludes=kubernetes

kubeadm init --apiserver-advertise-address=10.0.0.11 --image-repository registry.aliyuncs.com/google_containers --kubernetes-version v1.23.6 --service-cidr=10.96.0.0/12 --pod-network-cidr=10.244.0.0/16
exec bash

}


install_kubernetes_redhat_node1(){


if [ $ID = 'centos' -o $ID = 'rocky' ];then
    echo -e "\e[1;32m检测系统为centos/rocky允许执行\e[0m"
else
    echo -e "\e[1;31m系统不是centos/rocky系列,不可以执行此脚本\e[0m"
    exit
fi


hostnamectl set-hostname k8s-node1

cat >>/etc/hosts <<EOF
10.0.0.11 k8s-master
10.0.0.12 k8s-node1
10.0.0.13 k8s-node2
EOF

sed -i.bak '/swap/s@^@#@' /etc/fstab
swapoff  -a


cat > /etc/sysctl.d/k8s.conf<<EOF
net.ipv4.ip_forward=1
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF
sysctl -p
yum install -y yum-utils
yum-config-manager --add-repo  https://download.docker.com/linux/centos/docker-ce.repo
yum -y install docker-ce-20.10.7-3.el7 docker-ce-cli-20.10.7-3.el7 containerd.io docker-compose-plugin
systemctl enable --now docker

cat > /etc/docker/daemon.json <<EOF
{
  "exec-opts": ["native.cgroupdriver=systemd"],
  "log-driver": "json-file",
   "log-opts": {
  "max-size": "100m"
 },
 "storage-driver": "overlay2"
}
EOF
systemctl daemon-reload;systemctl restart docker

cat >/etc/yum.repos.d/kubernetes.repo <<EOF
[kubernetes]
name=Kubernetes
baseurl=https://mirrors.aliyun.com/kubernetes/yum/repos/kubernetes-el7-x86_64/
enabled=1
gpgcheck=1
repo_gpgcheck=0
gpgkey=https://mirrors.aliyun.com/kubernetes/yum/doc/yum-key.gpg https://mirrors.aliyun.com/kubernetes/yum/doc/rpm-package-key.gpg
EOF

yum install -y kubeadm-1.23.6-0 kubectl-1.23.6-0 kubelet-1.23.6-0 --disableexcludes=kubernetes


exec bash
}


install_kubernetes_redhat_node2(){


if [ $ID = 'centos' -o $ID = 'rocky' ];then
    echo -e "\e[1;32m检测系统为centos/rocky允许执行\e[0m"
else
    echo -e "\e[1;31m系统不是centos/rocky系列,不可以执行此脚本\e[0m"
    exit
fi
hostnamectl set-hostname k8s-node2

cat >>/etc/hosts <<EOF
10.0.0.11 k8s-master
10.0.0.12 k8s-node1
10.0.0.13 k8s-node2
EOF

sed -i.bak '/swap/s@^@#@' /etc/fstab
swapoff  -a


cat > /etc/sysctl.d/k8s.conf<<EOF
net.ipv4.ip_forward=1
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF
sysctl -p
yum install -y yum-utils
yum-config-manager --add-repo  https://download.docker.com/linux/centos/docker-ce.repo
yum -y install docker-ce-20.10.7-3.el7 docker-ce-cli-20.10.7-3.el7 containerd.io docker-compose-plugin
systemctl enable --now docker

cat > /etc/docker/daemon.json <<EOF
{
  "exec-opts": ["native.cgroupdriver=systemd"],
  "log-driver": "json-file",
   "log-opts": {
  "max-size": "100m"
 },
 "storage-driver": "overlay2"
}
EOF
systemctl daemon-reload;systemctl restart docker

cat >/etc/yum.repos.d/kubernetes.repo <<EOF
[kubernetes]
name=Kubernetes
baseurl=https://mirrors.aliyun.com/kubernetes/yum/repos/kubernetes-el7-x86_64/
enabled=1
gpgcheck=1
repo_gpgcheck=0
gpgkey=https://mirrors.aliyun.com/kubernetes/yum/doc/yum-key.gpg https://mirrors.aliyun.com/kubernetes/yum/doc/rpm-package-key.gpg
EOF

yum install -y kubeadm-1.23.6-0 kubectl-1.23.6-0 kubelet-1.23.6-0 --disableexcludes=kubernetes

exec bash
}






install_kubernetes_ubuntu_master(){

echo -e "\e[1;32m安装kubernetes1.24.3版本\e[0m"
if [ $ID = 'ubuntu' ];then
    echo -e "\e[1;32m检测系统为ubuntu允许执行\e[0m"
else
    echo -e "\e[1;31m系统不是ubuntu系列,不可以执行此脚本\e[0m"
    exit
fi


#CIR_DOCKER_VERSION=0.3.0
#CIR_DOCKER_URL="https://github.com/Mirantis/cri-dockerd/releases/download/v${CIR_DOCKER_VERSION}/cri-dockerd_${CIR_DOCKER_VERSION}.3-0.ubuntu-${UBUNTU_CODENAME}_amd64.deb"
#"https://github.com/Mirantis/cri-dockerd/releases/download/v${CIR_DOCKER_VERSION}/cri-dockerd_${CIR_DOCKER_VERSION}.3-0.ubuntu-${UBUNTU_CODENAME}_amd64.deb"

#hostnamectl set-hostname k8s-master01.he.com
echo -e "\e[1;32m更换apt源\e[0m"
cat > /etc/apt/sources.list <<EOF
deb https://mirrors.aliyun.com/ubuntu/ focal main restricted universe multiverse
deb-src https://mirrors.aliyun.com/ubuntu/ focal main restricted universe multiverse

deb https://mirrors.aliyun.com/ubuntu/ focal-security main restricted universe multiverse
deb-src https://mirrors.aliyun.com/ubuntu/ focal-security main restricted universe multiverse

deb https://mirrors.aliyun.com/ubuntu/ focal-updates main restricted universe multiverse
deb-src https://mirrors.aliyun.com/ubuntu/ focal-updates main restricted universe multiverse

# deb https://mirrors.aliyun.com/ubuntu/ focal-proposed main restricted universe multiverse
# deb-src https://mirrors.aliyun.com/ubuntu/ focal-proposed main restricted universe multiverse

deb https://mirrors.aliyun.com/ubuntu/ focal-backports main restricted universe multiverse
deb-src https://mirrors.aliyun.com/ubuntu/ focal-backports main restricted universe multiverse

EOF



cat >> /etc/hosts <<EOF

10.0.0.100   k8s-master01.he.com k8s-master01 kubeapi.he.com k8sapi.he.com kubeapi
10.0.0.101   k8s-node01.he.com k8s-node01
10.0.0.102   k8s-node02.he.com k8s-node02
10.0.0.103   k8s-node03.he.com k8s-node03

EOF

echo -e "\e[1;32m关闭swap\e[0m"
swapoff -a
echo -e "\e[1;32m关闭防火墙\e[0m"
ufw disable
sudo apt-get update


echo -e "\e[1;32m安装必要的一些系统工具\e[0m"
#安装必要的一些系统工具
sudo apt-get -y install apt-transport-https ca-certificates curl software-properties-common

[ $? -eq 0 ] && color "成功 " 0 || color "失败 " 1
echo -e "\e[1;32m安装GPG证书\e[0m"
#安装GPG证书
curl -fsSL https://mirrors.aliyun.com/docker-ce/linux/ubuntu/gpg | sudo apt-key add -


echo -e "\e[1;32m写入软件源信息\e[0m"
#写入软件源信息
sudo add-apt-repository "deb [arch=amd64] https://mirrors.aliyun.com/docker-ce/linux/ubuntu $(lsb_release -cs) stable"
[ $? -eq 0 ] && color "成功 " 0 || color "失败 " 1




echo -e "\e[1;32m更新并安装Docker-CE\e[0m"
#更新并安装Docker-CE
sudo apt-get -y update
sudo apt-get -y install docker-ce
[ $? -eq 0 ] && color "成功 " 0 || color "失败 " 1



echo -e "\e[1;32mdocker镜像加速\e[0m"

cat >  /etc/docker/daemon.json <<EOF
{
"registry-mirrors": [
 "https://docker.mirrors.ustc.edu.cn",
 "https://hub-mirror.c.163.com",
 "https://reg-mirror.qiniu.com",
 "https://registry.docker-cn.com"
],
"exec-opts": ["native.cgroupdriver=systemd"],
"log-driver": "json-file",
"log-opts": {
"max-size": "200m"
},
"storage-driver": "overlay2"
}
EOF
[ $? -eq 0 ] && color "成功 " 0 || color "失败 " 1
systemctl daemon-reload
systemctl enable --now docker.service
systemctl restart docker.service


echo -e "\e[1;32m安装cri-docker\e[0m"
#curl -LO  https://github.com/Mirantis/cri-dockerd/releases/tag/v0.2.5
if [ -e cri-dockerd_0.3.0.3-0.ubuntu-focal_amd64.deb ];then
    dpkg -i cri-dockerd_0.3.0.3-0.ubuntu-focal_amd64.deb
else
    echo -e "\e[1;32mcri-docker,尝试下载\e[0m"
    #curl -LO  https://github.com/Mirantis/cri-dockerd/releases/tag/v0.2.5
    curl -LO https://github.com/Mirantis/cri-dockerd/releases/download/v0.3.0/cri-dockerd_0.3.0.3-0.ubuntu-focal_amd64.deb
    if [ $? -eq 0 ];then
        echo -e "\e[1;32m下载成功\e[0m"
        dpkg -i cri-dockerd_0.2.5.3-0.ubuntu-focal_amd64.deb
    else
        echo -e "\e[1;31m下载失败\e[0m"
        exit
    fi
fi


echo -e "\e[1;32m在各个节点安装工具kubelet、kubeadm和kubectl\e[0m"
#在各个节点安装工具kubelet、kubeadm和kubectl
curl https://mirrors.aliyun.com/kubernetes/apt/doc/apt-key.gpg | apt-key add -

cat  >/etc/apt/sources.list.d/kubernetes.list <<EOF
deb https://mirrors.aliyun.com/kubernetes/apt/ kubernetes-xenial main
EOF

#apt-get update && apt-get install -y kubelet-1.24.3 kubeadm-1.24.3 kubectl-1.24.3
#dpkg -i kubeadm_1.24.3.deb  kubectl_1.24.3.deb kubelet_1.24.3.deb
apt-get update && apt install -y  kubeadm=1.24.3-00 kubelet=1.24.3-00 kubectl=1.24.3-00


#cat > /usr/lib/systemd/system/cri-docker.service <<EOF
#[Service]
#Type=notify
#ExecStart=/usr/bin/cri-dockerd --container-runtime-endpoint fd://  #添加下面一行
#ExecStart=/usr/bin/cri-dockerd --container-runtime-endpoint fd:// --network-plugin=cni --cni-bin-dir=/opt/cni/bin --cni-cache-dir=/var/lib/cni/cache --cni-conf-dir=/etc/cni/net.d
#EOF

sed -i "s/^ExecStart/#&/" /usr/lib/systemd/system/cri-docker.service
sed -i '11iExecStart=/usr/bin/cri-dockerd --container-runtime-endpoint fd:// --network-plugin=cni --cni-bin-dir=/opt/cni/bin --cni-cache-dir=/var/lib/cni/cache --cni-conf-dir=/etc/cni/net.d' /usr/lib/systemd/system/cri-docker.service

systemctl daemon-reload && systemctl restart cri-docker.service

echo -e "\e[1;32m配置kubelet，为其指定cri-dockerd在本地打开的Unix Sock文件的路径\e[0m"
#配置kubelet，为其指定cri-dockerd在本地打开的Unix Sock文件的路径
mkdir /etc/sysconfig 
cat > /etc/sysconfig/kubelet <<EOF
KUBELET_KUBEADM_ARGS="--container-runtime=remote --container-runtime-endpoint=/run/cri-dockerd.sock"
EOF
[ $? -eq 0 ] && color "成功 " 0 || color "失败 " 1




cat  >>/etc/containerd/config.toml << EOF
[plugins."io.containerd.grpc.v1.cri"]
# sandbox_image = "k8s.gcr.io/pause:3.6"
sandbox_image = "registry.aliyuncs.com/google_containers/pause:3.7"
EOF
systemctl start containerd
systemctl enable containerd

#在master节点导入
#docker load -i k8s-master-components.tar 

#在node节点导入
#docker load -i k8s-worker-components.tar

#在master和node都导入
#docker load -i calico-components.tar
echo -e "\e[1;32m初始化\e[0m"

kubeadm init \
--control-plane-endpoint="kubeapi.he.com" \
--kubernetes-version=v1.24.3 \
--pod-network-cidr=192.168.0.0/16 \
--service-cidr=10.96.0.0/12 \
--token-ttl=0 \
--cri-socket unix:///run/cri-dockerd.sock  \
--upload-certs \
--image-repository=registry.aliyuncs.com/google_containers


}


install_kubernetes_ubuntu_master1(){

echo -e "\e[1;32m安装kubernetes1.22.7版本\e[0m"

if [ $ID = 'ubuntu' ];then
    echo -e "\e[1;32m检测系统为ubuntu允许执行\e[0m"
else
    echo -e "\e[1;31m系统不是ubuntu系列,不可以执行此脚本\e[0m"
    exit
fi

echo -e "\e[1;32m更换apt源\e[0m"
cat > /etc/apt/sources.list <<EOF
deb https://mirrors.aliyun.com/ubuntu/ focal main restricted universe multiverse
deb-src https://mirrors.aliyun.com/ubuntu/ focal main restricted universe multiverse

deb https://mirrors.aliyun.com/ubuntu/ focal-security main restricted universe multiverse
deb-src https://mirrors.aliyun.com/ubuntu/ focal-security main restricted universe multiverse

deb https://mirrors.aliyun.com/ubuntu/ focal-updates main restricted universe multiverse
deb-src https://mirrors.aliyun.com/ubuntu/ focal-updates main restricted universe multiverse

# deb https://mirrors.aliyun.com/ubuntu/ focal-proposed main restricted universe multiverse
# deb-src https://mirrors.aliyun.com/ubuntu/ focal-proposed main restricted universe multiverse

deb https://mirrors.aliyun.com/ubuntu/ focal-backports main restricted universe multiverse
deb-src https://mirrors.aliyun.com/ubuntu/ focal-backports main restricted universe multiverse

EOF


echo -e "\e[1;32m关闭swap\e[0m"
swapoff -a
sed -i '/swap/s/^/#/' /etc/fstab
echo -e "\e[1;32m关闭防火墙\e[0m"
ufw disable
sudo apt-get update
echo -e "\e[1;32m时间同步\e[0m"
apt -y install ntpdate
ntpdate time2.aliyun.com




echo -e "\e[1;32m安装必要的一些系统工具\e[0m"

sudo apt-get -y install apt-transport-https ca-certificates curl software-properties-common


echo -e "\e[1;32m更新并安装Docker-io\e[0m"

apt update && apt -y install docker.io
[ $? -eq 0 ] && color "成功 " 0 || color "失败 " 1



echo -e "\e[1;32m配置docker镜像加速\e[0m"

cat >  /etc/docker/daemon.json <<EOF
{
"registry-mirrors": [
 "https://docker.mirrors.ustc.edu.cn",
 "https://hub-mirror.c.163.com",
 "https://reg-mirror.qiniu.com",
 "https://registry.docker-cn.com"
],
"exec-opts": ["native.cgroupdriver=systemd"],
"log-driver": "json-file",
"log-opts": {
"max-size": "200m"
},
"storage-driver": "overlay2"
}
EOF
[ $? -eq 0 ] && color "成功 " 0 || color "失败 " 1

echo -e "\e[1;32m加载docker配置并重启服务\e[0m"
systemctl daemon-reload && systemctl restart docker.service



echo -e "\e[1;32m在各个节点安装工具kubelet、kubeadm和kubectl\e[0m"

curl https://mirrors.aliyun.com/kubernetes/apt/doc/apt-key.gpg | apt-key add -

cat  >/etc/apt/sources.list.d/kubernetes.list <<EOF
deb https://mirrors.aliyun.com/kubernetes/apt/ kubernetes-xenial main
EOF


apt-get update && apt install -y  kubeadm=1.22.7-00 kubelet=1.22.7-00 kubectl=1.22.7-00

[ $? -eq 0 ] && color "成功 " 0 || color "失败 " 1

cat > /etc/default/kubelet <<EOF
KUBELET_EXTRA_ARGS="--fail-swap-on=false"
EOF

systemctl daemon-reload && systemctl restart kubelet





echo -e "\e[1;32m master节点执行\e[0m\n"
echo -e "\e[1;31mkubeadm init --kubernetes-version=v1.22.7 --image-repository=registry.aliyuncs.com/google_containers --pod-network-cidr=10.24.0.0/16 --ignore-preflight-errors=Swap\e[0m"

echo -e "\e[1;32mcurl https://projectcalico.docs.tigera.io/archive/v3.24/manifests/calico.yaml -O\e[0m"
echo -e "\e[1;31mkubectl apply -f calico.yaml\e[0m"


}



install_kubernetes_ubuntu_master2(){
echo -e "\e[1;31mload\e[0m"
}






install_kubernetes_radhat_master1274(){
echo -e "\e[1;35m======================================================================================================================================\e[0m"
echo -e "\e[1;35m安装kubernetes1.27.4版本\e[0m"
echo -e "\e[1;35m本次安装写入内容为一主两从模式\e[0m"
echo -e "\e[1;35m需要提前准备runc.amd64,kube-flannel.yml,cri-dockerd-0.3.1-3.el7.x86_64.rpm文件,自动下载可能无法下载\e[0m"
echo -e "\e[1;35m======================================================================================================================================\e[0m"
if [ $ID = 'centos' -o $ID = 'rocky' ];then
    echo -e "\e[1;32m检测系统为centos/rocky允许执行\e[0m"
else
    echo -e "\e[1;31m系统不是centos/rocky系列,不可以执行此脚本\e[0m"
    exit
fi

if ! ping -c 5 114.114.114.114 > /dev/null && ! ping -c 5 8.8.8.8 > /dev/null && ! ping -c 5 www.baidu.com > /dev/null; then
    echo -e "\e[1;31m网络不通，将跳过相关网络依赖步骤。\e[0m"
    NETWORK_OK=false
else
    echo -e "\e[1;32m网络正常\e[0m"
    NETWORK_OK=true
fi

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
if $NETWORK_OK && [ "$SYSTEM_NAME" = "centos" ] && [ "$VERSION_ID" = "7" ]; then
    echo -e "\n\e[1;35m======================================================================================================================================\e[0m"
    echo -e "\e[1;35mYUM源检测\e[0m"
    echo -e "\e[1;35m========================================================================================================================================\e[0m"
    



    if [ ! -d /data/bak ];then
        mkdir -p /data/bak; echo "新建目录/data/bak"
    else
        echo "目录 /data/bak 已存在。"
    fi
#判断文件夹是否有文件
    if [ "$(ls -A /etc/yum.repos.d/ 2>/dev/null)" ]; then
        echo -e "\e[1;35m检测到旧的 YUM 源文件，备份到 /data/bak。\e[0m"
        mv /etc/yum.repos.d/*  /data/bak || { echo "备份失败！"; exit 1; }
    else
        echo -e "\e[1;33m未检测到 YUM 源文件。\e[0m"
    fi
    echo -e "\e[1;35m写入新的base和epel\e[0m"
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
        "iptables-services"
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



echo -e "\n\e[1;35m=====================================================================================================================================\e[0m"
echo -e "\e[1;35m关闭firewalld\e[0m"

Firewalldstatus=`systemctl status firewalld | grep -o active`
if [[ ${Firewalldstatus} == "acticve" ]];then
    systemctl disable --now firewalld
    [ $? -eq 0 ] && echo -e "\e[1;32mfirewalld关闭成功\e[0m"|| echo -e "\e[1;31m firewalld关闭失败 \e[0m"
else
    echo -e "\e[1;32mfirewalld已经是关闭状态\e[0m"
fi


echo -e "\n\e[1;35m======================================================================================================================================\e[0m"
echo -e "\e[1;35m关闭SELINUX\e[0m"


SELINUXstatus=`getenforce`
if [[ ${SELINUXstatus} == "Enforcing" ]];then
    sed -i 's/SELINUX=enforcing/SELINUX=disabled/'    /etc/selinux/config
    [ $? -eq 0 ] && echo -e "\e[1;35mselinux关闭成功\e[0m" || echo -e "\e[1;35mselinux关闭失败\e[0m"
else
    echo -e "\e[1;32mselinux已经是关闭状态\e[0m"
fi


echo -e "\e[1;35m========================================================================================================================================\e[0m"
echo -e "\e[1;32m关闭swap\e[0m"


swapoff -a
sed -i '/swap/s/^/#/' /etc/fstab
[ $? -eq 0 ] && color "成功 " 0 || color "失败 " 1



#echo -e "\e[1;32m关闭防火墙\e[0m"
#systemctl disable --now firewalld

#echo -e "\e[1;32m时间同步\e[0m"
#yum -y install ntpdate
#ntpdate time2.aliyun.com
# 加入到crontab
#*/5 * * * * /usr/sbin/ntpdate time2.aliyun.com
echo -e "\e[1;35m========================================================================================================================================\e[0m"
echo -e "\e[1;32m修改主机名\e[0m"


IPAD=`hostname -I`
echo -e "\e[1;35m检测到当前地址为: ${IPAD}\e[0m"
#read -p "输入master主机名(例如k8s-master01):" HOSTNAME1
read -p "输入node01主机名位数(例如01):" HOSTNAME2
read -p "输入node02主机名位数(例如02):" HOSTNAME3
#read -p "修改当前主机名,输入位数(例如01,02):" HOSTNAME4
hostnamectl set-hostname k8s-master01

read -p "输入masterip:" IP1
read -p "输入noed01ip:" IP2
read -p "输入node02ip:" IP3

cat <<EOF >> /etc/hosts
${IP1} k8s-master01
${IP2} k8s-node${HOSTNAME2}
${IP3} k8s-node${HOSTNAME3}
EOF


echo -e "\e[1;32m修改Linux内核参数，添加网桥过滤器和地址转发功能\e[0m"
cat >> /etc/sysctl.d/kubernetes.conf <<EOF
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
net.ipv4.ip_forward = 1
EOF


modprobe br_netfilter
sysctl -p /etc/sysctl.d/kubernetes.conf
[ $? -eq 0 ] && color "成功 " 0 || color "失败 " 1

echo -e "\e[1;35m========================================================================================================================================\e[0m"
echo -e "\e[1;32m配置ipvs功能\e[0m"
echo -e "\e[1;35m========================================================================================================================================\e[0m"

yum -y install ipset ipvsadm
cat > /etc/sysconfig/modules/ipvs.modules <<EOF
modprobe -- ip_vs
modprobe -- ip_vs_rr
modprobe -- ip_vs_wrr
modprobe -- ip_vs_sh
modprobe -- nf_conntrack_ipv4  
EOF
chmod +x /etc/sysconfig/modules/ipvs.modules 
/etc/sysconfig/modules/ipvs.modules

[ $? -eq 0 ] && color "成功 " 0 || color "失败 " 1


echo -e "\e[1;35m========================================================================================================================================\e[0m"
echo -e "\e[1;32m安装Docker容器\e[0m"
echo -e "\e[1;35m========================================================================================================================================\e[0m"
curl -o /etc/yum.repos.d/CentOS-Base.repo https://mirrors.aliyun.com/repo/Centos-7.repo
wget -O /etc/yum.repos.d/epel.repo http://mirrors.aliyun.com/repo/epel-7.repo
yum makecache
yum install -y yum-utils


yum-config-manager --add-repo http://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo
yum install docker-ce-20.10.6 docker-ce-cli-20.10.6 -y
mkdir /etc/docker

cat <<EOF > /etc/docker/daemon.json
{
"registry-mirrors": [
"https://docker.m.daocloud.io","https://docker.anyhub.us.kg"
],
"exec-opts": ["native.cgroupdriver=systemd"],
"log-driver": "json-file",
"log-opts": {
"max-size": "200m"
},
"storage-driver": "overlay2"
}
EOF
systemctl enable --now docker 
[ $? -eq 0 ] && color "成功 " 0 || color "失败 " 1


echo -e "\e[1;35m========================================================================================================================================\e[0m"
echo -e "\e[1;32m安装cri-dockerd-0.3.1插件\e[0m"
echo -e "\e[1;35m========================================================================================================================================\e[0m"
if [ -e cri-dockerd-0.3.1-3.el7.x86_64.rpm ];then
    echo -e "\e[1;35m 文件已存在，开始安装\e[0m"
else
    echo -e "\e[1;31m开始下载\e[0m"
    wget https://github.com/Mirantis/cri-dockerd/releases/download/v0.3.1/cri-dockerd-0.3.1-3.el7.x86_64.rpm
    if [ $? -eq 0 ];then
        echo -e "\e[1;32m下载成功\e[0m"
    else
        echo -e "\e[1;32m下载失败，检查下载链接\e[0m"
        exit
    fi
fi
#wget https://github.com/Mirantis/cri-dockerd/releases/download/v0.3.1/cri-dockerd-0.3.1-3.el7.x86_64.rpm
rpm -ivh cri-dockerd-0.3.1-3.el7.x86_64.rpm
sed -i "s/^ExecStart/#&/" /usr/lib/systemd/system/cri-docker.service
sed -i '10iExecStart=/usr/bin/cri-dockerd --network-plugin=cni --pod-infra-container-image=registry.aliyuncs.com/google_containers/pause:3.7' /usr/lib/systemd/system/cri-docker.service
systemctl daemon-reload && systemctl restart docker cri-docker.socket cri-docker
systemctl enable --now docker cri-docker
[ $? -eq 0 ] && color "成功 " 0 || color "失败 " 1



echo -e "\e[1;35m========================================================================================================================================\e[0m"
echo -e "\e[1;32m配置国内yum源，安装 kubeadm、kubelet、kubectl\e[0m"
echo -e "\e[1;35m========================================================================================================================================\e[0m"

cat <<EOF > /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://mirrors.aliyun.com/kubernetes/yum/repos/kubernetes-el7-x86_64/
enabled=1
gpgcheck=0
EOF


yum install -y kubelet-1.27.4 kubeadm-1.27.4 kubectl-1.27.4
systemctl enable kubelet.service --now

[ $? -eq 0 ] && color "成功 " 0 || color "失败 " 1

echo -e "\e[1;35m========================================================================================================================================\e[0m"
echo -e "\e[1;32m安装runc-1.1.10\e[0m"
echo -e "\e[1;35m========================================================================================================================================\e[0m"

if [ -e runc.amd64 ];then
    echo -e "\e[1;35m 文件已存在，开始安装\e[0m"
else
    echo -e "\e[1;31m开始下载\e[0m"
    wget https://github.com/opencontainers/runc/releases/download/v1.1.10/runc.amd64
    if [ $? -eq 0 ];then
        echo -e "\e[1;32m下载成功\e[0m"
    else
        echo -e "\e[1;32m下载失败，检查下载链接\e[0m"
        exit
    fi
fi

sudo install -m 755 runc.amd64  /usr/local/bin/runc
[ $? -eq 0 ] && color "成功 " 0 || color "失败 " 1
runc -v
systemctl enable --now containerd
systemctl enable --now iptables
sudo iptables -I INPUT -p tcp --dport 6443 -j ACCEPT
sudo iptables -I INPUT -p tcp --dport 10250 -j ACCEPT
iptables-save > /etc/sysconfig/iptables
systemctl restart iptables
echo -e "\e[1;35m========================================================================================================================================\e[0m"
echo -e "\e[1;32m初始化kubernetes\e[0m"
echo -e "\e[1;35m========================================================================================================================================\e[0m"
kubeadm init --node-name=k8s-master01 --image-repository=registry.aliyuncs.com/google_containers --cri-socket=unix:///var/run/cri-dockerd.sock --apiserver-advertise-address=${IP1} --pod-network-cidr=10.244.0.0/16 --service-cidr=10.96.0.0/12

mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config





echo -e "\e[1;35m========================================================================================================================================\e[0m"
echo -e "\e[1;32m部署flannel\e[0m"
echo -e "\e[1;35m========================================================================================================================================\e[0m"
if [ -e kube-flannel.yml ];then
    echo -e "\e[1;35m 文件已存在，开始安装\e[0m"
else
    echo -e "\e[1;31m文件不存在，开始下载\e[0m"
    wget https://github.com/flannel-io/flannel/releases/download/v0.22.0/kube-flannel.yml
    if [ $? -eq 0 ];then
        echo -e "\e[1;32m下载成功\e[0m"
    else
        echo -e "\e[1;32m下载失败，检查下载链接\e[0m"
        exit
    fi
fi

kubectl apply -f kube-flannel.yml

exec bash

}

install_kubernetes_radhat_node1274(){
echo -e "\e[1;35m======================================================================================================================================\e[0m"
echo -e "\e[1;35m安装kubernetes1.27.4版本\e[0m"
echo -e "\e[1;35m本次安装写入内容为一主两从模式\e[0m"
echo -e "\e[1;35m需要提前准备runc.amd64,kube-flannel.yml,cri-dockerd-0.3.1-3.el7.x86_64.rpm文件,自动下载可能无法下载\e[0m"
echo -e "\e[1;35m======================================================================================================================================\e[0m"



if [ $ID = 'centos' -o $ID = 'rocky' ];then
    echo -e "\e[1;32m检测系统为centos/rocky允许执行\e[0m"
else
    echo -e "\e[1;31m系统不是centos/rocky系列,不可以执行此脚本\e[0m"
    exit
fi

if ! ping -c 5 114.114.114.114 > /dev/null && ! ping -c 5 8.8.8.8 > /dev/null && ! ping -c 5 www.baidu.com > /dev/null; then
    echo -e "\e[1;31m网络不通，将跳过相关网络依赖步骤。\e[0m"
    NETWORK_OK=false
else
    echo -e "\e[1;32m网络正常\e[0m"
    NETWORK_OK=true
fi

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
if $NETWORK_OK && [ "$SYSTEM_NAME" = "centos" ] && [ "$VERSION_ID" = "7" ]; then
    echo -e "\n\e[1;35m======================================================================================================================================\e[0m"
    echo -e "\e[1;35mYUM源检测\e[0m"
    echo -e "\e[1;35m========================================================================================================================================\e[0m"
    



    if [ ! -d /data/bak ];then
        mkdir -p /data/bak; echo "新建目录/data/bak"
    else
        echo "目录 /data/bak 已存在。"
    fi
#判断文件夹是否有文件
    if [ "$(ls -A /etc/yum.repos.d/ 2>/dev/null)" ]; then
        echo -e "\e[1;35m检测到旧的 YUM 源文件，备份到 /data/bak。\e[0m"
        mv /etc/yum.repos.d/*  /data/bak || { echo "备份失败！"; exit 1; }
    else
        echo -e "\e[1;33m未检测到 YUM 源文件。\e[0m"
    fi
    echo -e "\e[1;35m写入新的base和epel\e[0m"
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
        "iptables-services"
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




echo -e "\e[1;32m关闭swap\e[0m"
swapoff -a
sed -i '/swap/s/^/#/' /etc/fstab
[ $? -eq 0 ] && color "成功 " 0 || color "失败 " 1



#echo -e "\e[1;32m关闭防火墙\e[0m"
#systemctl disable --now firewalld

#echo -e "\e[1;32m时间同步\e[0m"
#yum -y install ntpdate
#ntpdate time2.aliyun.com
# 加入到crontab
#*/5 * * * * /usr/sbin/ntpdate time2.aliyun.com

echo -e "\e[1;35m========================================================================================================================================\e[0m"
echo -e "\e[1;32m修改主机名\e[0m"
echo -e "\e[1;35m========================================================================================================================================\e[0m"
IPAD=`hostname -I`
echo -e "\e[1;35m检测到当前地址为: ${IPAD}\e[0m"
#read -p "输入master主机名(例如k8s-master01):" HOSTNAME1
read -p "输入node01主机名位数(例如01):" HOSTNAME2
read -p "输入node02主机名位数(例如02):" HOSTNAME3
read -p "修改当前主机名,输入位数(例如01,02):" HOSTNAME4
hostnamectl set-hostname k8s-node${HOSTNAME4}

read -p "输入masterip:" IP1
read -p "输入noed01ip:" IP2
read -p "输入node02ip:" IP3

cat <<EOF >> /etc/hosts
${IP1} k8s-master01
${IP2} k8s-node${HOSTNAME2}
${IP3} k8s-node${HOSTNAME3}
EOF

echo -e "\e[1;35m========================================================================================================================================\e[0m"
echo -e "\e[1;32m修改Linux内核参数，添加网桥过滤器和地址转发功能\e[0m"
echo -e "\e[1;35m========================================================================================================================================\e[0m"
cat >> /etc/sysctl.d/kubernetes.conf <<EOF
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
net.ipv4.ip_forward = 1
EOF


modprobe br_netfilter
sysctl -p /etc/sysctl.d/kubernetes.conf
[ $? -eq 0 ] && color "成功 " 0 || color "失败 " 1




echo -e "\e[1;32m配置ipvs功能\e[0m"
yum -y install ipset ipvsadm
cat > /etc/sysconfig/modules/ipvs.modules <<EOF
modprobe -- ip_vs
modprobe -- ip_vs_rr
modprobe -- ip_vs_wrr
modprobe -- ip_vs_sh
modprobe -- nf_conntrack_ipv4  
EOF
chmod +x /etc/sysconfig/modules/ipvs.modules 
/etc/sysconfig/modules/ipvs.modules

[ $? -eq 0 ] && color "成功 " 0 || color "失败 " 1



echo -e "\e[1;32m安装Docker容器\e[0m"
curl -o /etc/yum.repos.d/CentOS-Base.repo https://mirrors.aliyun.com/repo/Centos-7.repo
wget -O /etc/yum.repos.d/epel.repo http://mirrors.aliyun.com/repo/epel-7.repo
yum makecache
yum install -y yum-utils


yum-config-manager --add-repo http://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo
yum install docker-ce-20.10.6 docker-ce-cli-20.10.6 -y
mkdir /etc/docker

cat <<EOF > /etc/docker/daemon.json
{
"registry-mirrors": [
"https://docker.m.daocloud.io","https://docker.anyhub.us.kg"
],
"exec-opts": ["native.cgroupdriver=systemd"],
"log-driver": "json-file",
"log-opts": {
"max-size": "200m"
},
"storage-driver": "overlay2"
}
EOF
systemctl enable --now docker 
[ $? -eq 0 ] && color "成功 " 0 || color "失败 " 1



echo -e "\e[1;32m安装cri-dockerd-0.3.1插件\e[0m"

if [ -e cri-dockerd-0.3.1-3.el7.x86_64.rpm ];then
    echo -e "\e[1;35m 文件已存在，开始安装\e[0m"
else
    echo -e "\e[1;31m开始下载\e[0m"
    wget https://github.com/Mirantis/cri-dockerd/releases/download/v0.3.1/cri-dockerd-0.3.1-3.el7.x86_64.rpm
    if [ $? -eq 0 ];then
        echo -e "\e[1;32m下载成功\e[0m"
    else
        echo -e "\e[1;32m下载失败，检查下载链接\e[0m"
        exit
    fi
fi
#wget https://github.com/Mirantis/cri-dockerd/releases/download/v0.3.1/cri-dockerd-0.3.1-3.el7.x86_64.rpm
rpm -ivh cri-dockerd-0.3.1-3.el7.x86_64.rpm
sed -i "s/^ExecStart/#&/" /usr/lib/systemd/system/cri-docker.service
sed -i '10iExecStart=/usr/bin/cri-dockerd --network-plugin=cni --pod-infra-container-image=registry.aliyuncs.com/google_containers/pause:3.7' /usr/lib/systemd/system/cri-docker.service
systemctl daemon-reload && systemctl restart docker cri-docker.socket cri-docker
systemctl enable --now docker cri-docker
[ $? -eq 0 ] && color "成功 " 0 || color "失败 " 1



echo -e "\e[1;35m========================================================================================================================================\e[0m"
echo -e "\e[1;32m配置国内yum源，安装 kubeadm、kubelet、kubectl\e[0m"
echo -e "\e[1;35m========================================================================================================================================\e[0m"

cat <<EOF > /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://mirrors.aliyun.com/kubernetes/yum/repos/kubernetes-el7-x86_64/
enabled=1
gpgcheck=0
EOF


yum install -y kubelet-1.27.4 kubeadm-1.27.4 kubectl-1.27.4
systemctl enable kubelet.service --now

[ $? -eq 0 ] && color "成功 " 0 || color "失败 " 1


echo -e "\e[1;35m========================================================================================================================================\e[0m"
echo -e "\e[1;32m安装runc-1.1.10\e[0m"
echo -e "\e[1;35m========================================================================================================================================\e[0m"

if [ -e runc.amd64 ];then
    echo -e "\e[1;35m 文件已存在，开始安装\e[0m"
else
    echo -e "\e[1;31m开始下载\e[0m"
    wget https://github.com/opencontainers/runc/releases/download/v1.1.10/runc.amd64
    if [ $? -eq 0 ];then
        echo -e "\e[1;32m下载成功\e[0m"
    else
        echo -e "\e[1;32m下载失败，检查下载链接\e[0m"
        exit
    fi
fi

sudo install -m 755 runc.amd64  /usr/local/bin/runc
[ $? -eq 0 ] && color "成功 " 0 || color "失败 " 1
runc -v
echo -e "\e[1;35m===================================================注意事项==========================================================\e[0m"

echo -e "\e[1;32m加入master节点时需要再 kubeadm join 结尾加上   --cri-socket unix:///var/run/cri-dockerd.sock\e[0m\n"
echo -e "\e[1;35m---------------------------------------------------------------------------------------------------------------------\e[0m"

echo -e "\e[1;32m/etc/kubernetes/admin.conf 需要将master上的admin.conf文件拷贝到node上,再执行以下命令\e[0m"
echo -e "\e[1;32mscp masterIP:/etc/kubernetes/admin.conf /etc/kubernetes/\e[0m"
echo -e "\e[1;32mecho \"export KUBECONFIG=/etc/kubernetes/admin.conf\" >> ~/.bash_profile\e[0m"
echo -e "\e[1;32msource ~/.bash_profile\e[0m"
echo -e "\e[1;35m---------------------------------------------执行下面命令部署flannel----------------------------------------------------\e[0m"
echo -e "\e[1;32mwget https://github.com/flannel-io/flannel/releases/download/v0.22.0/kube-flannel.yml\e[0m"
echo -e "\e[1;32mkubectl apply -f kube-flannel.yml\e[0m"
echo -e "\e[1;35m--------------------------------------遇到node节点一直noready状态可以进行下面操作-----------------------------------------\e[0m"
echo -e "\e[1;32mmkdir -p /etc/cni/net.d/ \e[0m"
#echo -e "\e[1;32m/opt/cni/bin/flannel 检查是否已有该文件,有的话先删除,然后将主节点上的该文件复制到node节点上\e[0m"
echo -e "\e[1;32m/etc/cni/net.d/10-flannel.conflist 检查是否已有该文件,有的话先删除,然后将主节点上的该文件复制到node节点上\e[0m"
echo -e "\e[1;32mscp masterIP:/etc/cni/net.d/10-flannel.conflist /etc/cni/net.d/\e[0m"

echo -e "\e[1;35m======================================================================================================================\e[0m"



exec bash
}




install_kubernetes_radhat_master1322(){
echo -e "\e[1;35m======================================================================================================================================\e[0m"
echo -e "\e[1;35m安装kubernetes1.32.2版本\e[0m"
echo -e "\e[1;35m本次安装写入内容为一主两从模式\e[0m"
echo -e "\e[1;35m需要提前准备runc.amd64,kube-flannel.yml,cri-dockerd-0.3.1-3.el7.x86_64.rpm文件,自动下载可能无法下载\e[0m"
echo -e "\e[1;35m======================================================================================================================================\e[0m"
if [ $ID = 'centos' -o $ID = 'rocky' ];then
    echo -e "\e[1;32m检测系统为centos/rocky允许执行\e[0m"
else
    echo -e "\e[1;31m系统不是centos/rocky系列,不可以执行此脚本\e[0m"
    exit
fi

if ! ping -c 5 114.114.114.114 > /dev/null && ! ping -c 5 8.8.8.8 > /dev/null && ! ping -c 5 www.baidu.com > /dev/null; then
    echo -e "\e[1;31m网络不通，将跳过相关网络依赖步骤。\e[0m"
    NETWORK_OK=false
else
    echo -e "\e[1;32m网络正常\e[0m"
    NETWORK_OK=true
fi

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
if $NETWORK_OK && [ "$SYSTEM_NAME" = "centos" ] && [ "$VERSION_ID" = "7" ]; then
    echo -e "\n\e[1;35m======================================================================================================================================\e[0m"
    echo -e "\e[1;35mYUM源检测\e[0m"
    echo -e "\e[1;35m========================================================================================================================================\e[0m"
    



    if [ ! -d /data/bak ];then
        mkdir -p /data/bak; echo "新建目录/data/bak"
    else
        echo "目录 /data/bak 已存在。"
    fi
#判断文件夹是否有文件
    if [ "$(ls -A /etc/yum.repos.d/ 2>/dev/null)" ]; then
        echo -e "\e[1;35m检测到旧的 YUM 源文件，备份到 /data/bak。\e[0m"
        mv /etc/yum.repos.d/*  /data/bak || { echo "备份失败！"; exit 1; }
    else
        echo -e "\e[1;33m未检测到 YUM 源文件。\e[0m"
    fi
    echo -e "\e[1;35m写入新的base和epel\e[0m"
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
        "iptables-services"
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



echo -e "\n\e[1;35m=====================================================================================================================================\e[0m"
echo -e "\e[1;35m关闭firewalld\e[0m"

Firewalldstatus=`systemctl status firewalld | grep -o active`
if [[ ${Firewalldstatus} == "acticve" ]];then
    systemctl disable --now firewalld
    [ $? -eq 0 ] && echo -e "\e[1;32mfirewalld关闭成功\e[0m"|| echo -e "\e[1;31m firewalld关闭失败 \e[0m"
else
    echo -e "\e[1;32mfirewalld已经是关闭状态\e[0m"
fi


echo -e "\n\e[1;35m======================================================================================================================================\e[0m"
echo -e "\e[1;35m关闭SELINUX\e[0m"


SELINUXstatus=`getenforce`
if [[ ${SELINUXstatus} == "Enforcing" ]];then
    sed -i 's/SELINUX=enforcing/SELINUX=disabled/'    /etc/selinux/config
    [ $? -eq 0 ] && echo -e "\e[1;35mselinux关闭成功\e[0m" || echo -e "\e[1;35mselinux关闭失败\e[0m"
else
    echo -e "\e[1;32mselinux已经是关闭状态\e[0m"
fi


echo -e "\e[1;35m========================================================================================================================================\e[0m"
echo -e "\e[1;32m关闭swap\e[0m"


swapoff -a
sed -i '/swap/s/^/#/' /etc/fstab
[ $? -eq 0 ] && color "成功 " 0 || color "失败 " 1



#echo -e "\e[1;32m关闭防火墙\e[0m"
#systemctl disable --now firewalld

#echo -e "\e[1;32m时间同步\e[0m"
#yum -y install ntpdate
#ntpdate time2.aliyun.com
# 加入到crontab
#*/5 * * * * /usr/sbin/ntpdate time2.aliyun.com
echo -e "\e[1;35m========================================================================================================================================\e[0m"
echo -e "\e[1;32m修改主机名\e[0m"


IPAD=`hostname -I`
echo -e "\e[1;35m检测到当前地址为: ${IPAD}\e[0m"
#read -p "输入master主机名(例如k8s-master01):" HOSTNAME1
read -p "输入node01主机名位数(例如01):" HOSTNAME2
read -p "输入node02主机名位数(例如02):" HOSTNAME3
#read -p "修改当前主机名,输入位数(例如01,02):" HOSTNAME4
hostnamectl set-hostname k8s-master01

read -p "输入masterip:" IP1
read -p "输入noed01ip:" IP2
read -p "输入node02ip:" IP3

cat <<EOF >> /etc/hosts
${IP1} k8s-master01
${IP2} k8s-node${HOSTNAME2}
${IP3} k8s-node${HOSTNAME3}
EOF


echo -e "\e[1;32m修改Linux内核参数，添加网桥过滤器和地址转发功能\e[0m"
cat >> /etc/sysctl.d/kubernetes.conf <<EOF
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
net.ipv4.ip_forward = 1
EOF


modprobe br_netfilter
sysctl -p /etc/sysctl.d/kubernetes.conf
[ $? -eq 0 ] && color "成功 " 0 || color "失败 " 1

echo -e "\e[1;35m========================================================================================================================================\e[0m"
echo -e "\e[1;32m配置ipvs功能\e[0m"
echo -e "\e[1;35m========================================================================================================================================\e[0m"

yum -y install ipset ipvsadm
cat > /etc/sysconfig/modules/ipvs.modules <<EOF
modprobe -- ip_vs
modprobe -- ip_vs_rr
modprobe -- ip_vs_wrr
modprobe -- ip_vs_sh
modprobe -- nf_conntrack_ipv4  
EOF
chmod +x /etc/sysconfig/modules/ipvs.modules 
/etc/sysconfig/modules/ipvs.modules

[ $? -eq 0 ] && color "成功 " 0 || color "失败 " 1


echo -e "\e[1;35m========================================================================================================================================\e[0m"
echo -e "\e[1;32m安装Docker容器\e[0m"
echo -e "\e[1;35m========================================================================================================================================\e[0m"
curl -o /etc/yum.repos.d/CentOS-Base.repo https://mirrors.aliyun.com/repo/Centos-7.repo
wget -O /etc/yum.repos.d/epel.repo http://mirrors.aliyun.com/repo/epel-7.repo
yum makecache
yum install -y yum-utils


yum-config-manager --add-repo http://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo
yum install docker-ce-20.10.6 docker-ce-cli-20.10.6 -y
mkdir /etc/docker

cat <<EOF > /etc/docker/daemon.json
{
"registry-mirrors": [
"https://docker.m.daocloud.io","https://docker.anyhub.us.kg"
],
"exec-opts": ["native.cgroupdriver=systemd"],
"log-driver": "json-file",
"log-opts": {
"max-size": "200m"
},
"storage-driver": "overlay2"
}
EOF
systemctl enable --now docker 
[ $? -eq 0 ] && color "成功 " 0 || color "失败 " 1


echo -e "\e[1;35m========================================================================================================================================\e[0m"
echo -e "\e[1;32m安装cri-dockerd-0.3.1插件\e[0m"
echo -e "\e[1;35m========================================================================================================================================\e[0m"
if [ -e cri-dockerd-0.3.1-3.el7.x86_64.rpm ];then
    echo -e "\e[1;35m 文件已存在，开始安装\e[0m"
else
    echo -e "\e[1;31m开始下载\e[0m"
    wget https://github.com/Mirantis/cri-dockerd/releases/download/v0.3.1/cri-dockerd-0.3.1-3.el7.x86_64.rpm
    if [ $? -eq 0 ];then
        echo -e "\e[1;32m下载成功\e[0m"
    else
        echo -e "\e[1;32m下载失败，检查下载链接\e[0m"
        exit
    fi
fi
#wget https://github.com/Mirantis/cri-dockerd/releases/download/v0.3.1/cri-dockerd-0.3.1-3.el7.x86_64.rpm
rpm -ivh cri-dockerd-0.3.1-3.el7.x86_64.rpm
sed -i "s/^ExecStart/#&/" /usr/lib/systemd/system/cri-docker.service
sed -i '10iExecStart=/usr/bin/cri-dockerd --network-plugin=cni --pod-infra-container-image=registry.aliyuncs.com/google_containers/pause:3.7' /usr/lib/systemd/system/cri-docker.service
systemctl daemon-reload && systemctl restart docker cri-docker.socket cri-docker
systemctl enable --now docker cri-docker
[ $? -eq 0 ] && color "成功 " 0 || color "失败 " 1



echo -e "\e[1;35m========================================================================================================================================\e[0m"
echo -e "\e[1;32m配置国内yum源，安装 kubeadm、kubelet、kubectl\e[0m"
echo -e "\e[1;35m========================================================================================================================================\e[0m"

cat <<EOF > /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://mirrors.aliyun.com/kubernetes-new/core/stable/v1.32/rpm/
enabled=1
gpgcheck=1
gpgkey=https://mirrors.aliyun.com/kubernetes-new/core/stable/v1.32/rpm/repodata/repomd.xml.key
EOF


yum install -y kubelet-1.32.2 kubeadm-1.32.2 kubectl-1.32.2
systemctl enable kubelet.service --now

[ $? -eq 0 ] && color "成功 " 0 || color "失败 " 1

echo -e "\e[1;35m========================================================================================================================================\e[0m"
echo -e "\e[1;32m安装runc-1.1.10\e[0m"
echo -e "\e[1;35m========================================================================================================================================\e[0m"

if [ -e runc.amd64 ];then
    echo -e "\e[1;35m 文件已存在，开始安装\e[0m"
else
    echo -e "\e[1;31m开始下载\e[0m"
    wget https://github.com/opencontainers/runc/releases/download/v1.1.10/runc.amd64
    if [ $? -eq 0 ];then
        echo -e "\e[1;32m下载成功\e[0m"
    else
        echo -e "\e[1;32m下载失败，检查下载链接\e[0m"
        exit
    fi
fi

sudo install -m 755 runc.amd64  /usr/local/bin/runc
[ $? -eq 0 ] && color "成功 " 0 || color "失败 " 1
runc -v
systemctl enable --now containerd
systemctl enable --now iptables
sudo iptables -I INPUT -p tcp --dport 6443 -j ACCEPT 
sudo iptables -I INPUT -p tcp --dport 10250 -j ACCEPT
iptables-save > /etc/sysconfig/iptables
systemctl restart iptables
echo -e "\e[1;35m========================================================================================================================================\e[0m"
echo -e "\e[1;32m初始化kubernetes\e[0m"
echo -e "\e[1;35m========================================================================================================================================\e[0m"
kubeadm init --node-name=k8s-master01 --image-repository=registry.aliyuncs.com/google_containers --cri-socket=unix:///var/run/cri-dockerd.sock --apiserver-advertise-address=${IP1} --pod-network-cidr=10.244.0.0/16 --service-cidr=10.96.0.0/12

mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config





echo -e "\e[1;35m========================================================================================================================================\e[0m"
echo -e "\e[1;32m部署flannel\e[0m"
echo -e "\e[1;35m========================================================================================================================================\e[0m"
if [ -e kube-flannel.yml ];then
    echo -e "\e[1;35m 文件已存在，开始安装\e[0m"
else
    echo -e "\e[1;31m文件不存在，开始下载\e[0m"
    wget https://github.com/flannel-io/flannel/releases/download/v0.22.0/kube-flannel.yml
    if [ $? -eq 0 ];then
        echo -e "\e[1;32m下载成功\e[0m"
    else
        echo -e "\e[1;32m下载失败，检查下载链接\e[0m"
        exit
    fi
fi

kubectl apply -f kube-flannel.yml

exec bash

}



install_kubernetes_radhat_node1322(){
echo 'load'
}






















reset_kubenetes(){
    kubeadm reset -f --cri-socket unix:///run/cri-dockerd.sock
    rm -rf /etc/kubernetes/  /var/lib/kubelet/
}


install_docker_compose(){
    local version=v2.27.0
    echo -e "\e[1;32m离线下载\e[0m"
    echo -e "\e[1;32m安装的版本:${version}\e[0m"
    curl -L https://github.com/docker/compose/releases/download/${version}/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
    chmod +x /usr/local/bin/docker-compose
    docker-compose --version
    #curl -L https://github.com/docker/compose/releases/download/v2.27.0/docker-compose-Linux-x86_64 -o /usr/local/bin/docker-compose
}



















install_telnet(){
echo -e "\e[1;35m==========================安装telnet=====================================\e[0m"
echo "执行网络检测"
if ping -c 1 www.baidu.com >/dev/null;then
    echo -e "\e[1;32m"网络正常"\e[0m"
else
    echo -e "\e[1;31m"网络不通"\e[0m"
    
fi

software=(
    "telnet"
    "telnet-server"
    "xinetd"
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
            fi
        fi
done


systemctl enable --now  xinetd.service
systemctl enable --now  telnet.socket
if [ $? -eq 0 ];then
    echo ""
else
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
pts/11
EOF
fi
echo -e "\e[1;35m手动测试telnet连接是否正常\e[0m"
}



uninstall_docker(){
#ubuntu系统上卸载docker
  sudo systemctl stop docker
  sudo apt-get purge docker-ce docker-ce-cli containerd.io docker-compose-plugin
  sudo rm -rf /var/lib/docker
  sudo rm -rf /var/lib/containerd
  sudo rm -rf /etc/docker
  sudo rm -rf /etc/systemd/system/docker.service
  sudo rm -rf /etc/systemd/system/docker.socket
  sudo rm -rf /usr/bin/docker
  sudo rm -rf /usr/bin/docker-compose
  sudo rm -rf /usr/bin/docker-containerd
  sudo rm -rf /usr/bin/docker-runc
  sudo ip link delete docker0
  sudo apt-get autoremove
  sudo apt-get autoclean
  docker --version


}






install_prometheus1(){
    cd /usr/local/
    tar zxf prometheus-2.35.0.linux-amd64.tar.gz
    mv prometheus-2.35.0.linux-amd64 prometheus
    cat > /usr/lib/systemd/system/prometheus.service <<'EOF'
[Unit]
Description=Prometheus Server
Documentation=https://prometheus.io
After=network.target
 
[Service]
Type=simple
ExecStart=/usr/local/prometheus/prometheus \
--config.file=/usr/local/prometheus/prometheus.yml \
--storage.tsdb.path=/usr/local/prometheus/data/ \
--storage.tsdb.retention=15d \
--web.enable-lifecycle
  
ExecReload=/bin/kill -HUP $MAINPID
Restart=on-failure
 
[Install]
WantedBy=multi-user.target
EOF

systemctl start prometheus
systemctl enable prometheus
#浏览器访问：http://localhost:9090
}







install_lnmp(){
    echo "筹备中"
}
























sshpass_key(){
IPLIST="
10.0.0.8
10.0.0.18
10.0.0.7
10.0.0.6
10.0.0.200"
rpm -q sshpass &> /dev/null || yum -y install sshpass
[ -f /root/.ssh/id_rsa ] || ssh-keygen -f /root/.ssh/id_rsa -P ''
export SSHPASS=123456
for IP in $IPLIST;do
    { sshpass -e ssh-copy-id -o StrictHostKeyChecking=no $IP; } &
done
wait


#########################################
#vim /etc/ssh/ssh_config
#修改下面一行
StrictHostKeyChecking no
cat hosts.list
10.0.0.18
10.0.0.28

vim push_ssh_key.sh
rpm -q sshpass &> /dev/null || yum -y install sshpass
[ -f /root/.ssh/id_rsa ] || ssh-keygen -f /root/.ssh/id_rsa -P ''
export SSHPASS=magedu
while read IP;do
sshpass -e ssh-copy-id -o StrictHostKeyChecking=no $IP
done < hosts.list




#####################
ssh-keygen -f ~/.ssh/id_rsa -P ''
ssh-copy-id root@'10.0.0.31'
#####################
}


ssh_auth(){

target_file="/etc/profile.d/system_info.sh"
cat << 'EOF' > $target_file
#/bin/bash

# Welcome
welcome=$(uname -r)

# Memory
memory_total=$(cat /proc/meminfo | awk '/^MemTotal:/ {printf($2)}')
memory_free=$(cat /proc/meminfo | awk '/^MemFree:/ { printf($2)}')
buffers=$(cat /proc/meminfo | awk '/^Buffers:/ { printf($2)}')
cached=$(cat /proc/meminfo | awk '/^Cached:/ { printf($2)}')
sreclaimable=$(cat /proc/meminfo | awk '/^SReclaimable:/ { printf($2)}')
swap_total=$(cat /proc/meminfo | awk '/^SwapTotal:/ { printf($2)}')
swap_free=$(cat /proc/meminfo | awk '/^SwapFree:/ { printf($2)}')

if [ $memory_total -gt 0 ]
then
    memory_usage=`echo "scale=1; ($memory_total - $memory_free - $buffers - $cached - $sreclaimable) * 100.0 / $memory_total" |bc`
    memory_usage="${memory_usage}%"
else
    memory_usage=0.0%
fi

# Swap memory
if [ $swap_total -gt 0 ]
then
    swap_mem=`echo "scale=1; ($swap_total - $swap_free) * 100.0 / $swap_total" |bc`
    swap_mem="${swap_mem}%"
else
    swap_mem=0.0%
fi

# Usage
usageof=$(df -h / | awk '/\// {print $(NF-1)}')

# System load
load_average=$(awk '{print $1}' /proc/loadavg)

# WHO I AM
whoiam=$(whoami)

# Time
time_cur=$(date)

# Processes
processes=$(ps aux | wc -l)

# Users
user_num=$(users | wc -w)

# Ip address
ip_pre=""
if [ -x "/sbin/ip" ]
then
    ip_pre=$(/sbin/ip a | grep inet | grep -v "127.0.0.1" | grep -v inet6 | awk '{print $2}')
fi

echo -e "\n"
echo -e "Welcome to $welcome\n"
echo -e "System information as of time: \t$time_cur\n"
echo -e "System load: \t\033[0;33;40m$load_average\033[0m"
echo -e "Processes: \t$processes"
echo -e "Memory used: \t$memory_usage"
echo -e "Swap used: \t$swap_mem"
echo -e "Usage On: \t$usageof"
for line in $ip_pre
do
    ip_address=${line%/*}
    echo -e "IP address: \t$ip_address"
done
echo -e "Users online: \t$user_num"
if [ "$whoiam" == "root" ]
then
    echo -e "\n"
else
    echo -e "To run a command as administrator(user \"root\"),use \"sudo <command>\"."
fi
EOF
echo -e "\n\e[1;32m内容已成功写入 $target_file\e[0m"
exec bash
}


ssh_auth1(){


cat > /etc/profile.d/system_info.sh << 'EOF' 
#/bin/bash
#Copyright (c) [2019] Huawei Technologies Co., Ltd.
#generic-release is licensed under the Mulan PSL v2.
#You can use this software according to the terms and conditions of the Mulan PSL v2.
#You may obtain a copy of Mulan PSL v2 at:
#     http://license.coscl.org.cn/MulanPSL2
#THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR
#IMPLIED, INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY OR FIT FOR A PARTICULAR
#PURPOSE.
#See the Mulan PSL v2 for more details.

# Welcome
welcome=$(uname -r)

# Memory
memory_total=$(cat /proc/meminfo | awk '/^MemTotal:/ {printf($2)}')
memory_free=$(cat /proc/meminfo | awk '/^MemFree:/ { printf($2)}')
buffers=$(cat /proc/meminfo | awk '/^Buffers:/ { printf($2)}')
cached=$(cat /proc/meminfo | awk '/^Cached:/ { printf($2)}')
sreclaimable=$(cat /proc/meminfo | awk '/^SReclaimable:/ { printf($2)}')
swap_total=$(cat /proc/meminfo | awk '/^SwapTotal:/ { printf($2)}')
swap_free=$(cat /proc/meminfo | awk '/^SwapFree:/ { printf($2)}')

if [ $memory_total -gt 0 ]
then
    memory_usage=`echo "scale=1; ($memory_total - $memory_free - $buffers - $cached - $sreclaimable) * 100.0 / $memory_total" |bc`
    memory_usage="${memory_usage}%"
else
    memory_usage=0.0%
fi

# Swap memory
if [ $swap_total -gt 0 ]
then
    swap_mem=`echo "scale=1; ($swap_total - $swap_free) * 100.0 / $swap_total" |bc`
    swap_mem="${swap_mem}%"
else
    swap_mem=0.0%
fi

# Usage
usageof=$(df -h / | awk '/\// {print $(NF-1)}')

# System load
load_average=$(awk '{print $1}' /proc/loadavg)

# WHO I AM
whoiam=$(whoami)

# Time
time_cur=$(date)

# Processes
processes=$(ps aux | wc -l)

# Users
user_num=$(users | wc -w)

# Ip address
ip_pre=""
if [ -x "/sbin/ip" ]
then
    ip_pre=$(/sbin/ip a | grep inet | grep -v "127.0.0.1" | grep -v inet6 | awk '{print $2}')
fi

echo -e "\n"
echo -e "Welcome to $welcome\n"
echo -e "System information as of time: \t$time_cur\n"
echo -e "System load: \t\033[0;33;40m$load_average\033[0m"
echo -e "Processes: \t$processes"
echo -e "Memory used: \t$memory_usage"
echo -e "Swap used: \t$swap_mem"
echo -e "Usage On: \t$usageof"
for line in $ip_pre
do
    ip_address=${line%/*}
    echo -e "IP address: \t$ip_address"
done
echo -e "Users online: \t$user_num"
if [ "$whoiam" == "root" ]
then
    echo -e "\n"
else
    echo -e "To run a command as administrator(user \"root\"),use \"sudo <command>\"."
fi
EOF
echo -e "\n\e[1;32m内容已成功写入 $target_file\e[0m"
}



mail_alarm(){

echo -e "\n\e[1;33m脚本适用于centos7系统,不适用于openEuler系统\e[0m"
read -p "属于接收告警信息的邮箱地址:" EMAIL
alarm_file="/root/monitor.sh"
cat << EOF > $alarm_file
#!/bin/bash

rpm -qa mailutils || yum -y install mailutils
# 定义发送邮件的函数
send_email() {
    local subject=\$1
    local body=\$2
    local recipient=$EMAIL

    echo -e "\$body" | mail -s "\$subject" "\$recipient"
}

# 获取系统信息的函数
get_system_info() {
    # 获取磁盘使用情况
    disk_usage=\$(df -h  | awk 'NR==6{print "磁盘已用:"\$3 "\n磁盘剩余可用:"\$4"\n磁盘使用率:"\$5}')
    disk_info="\$disk_usage"

    # 获取内存使用情况
    #memory_info=\$(free -m | awk 'NR==2{printf "内存使用: %s/%sMB (%.2f%%)\n", \$3, \$2, \$3*100/\$2 }')
    memory_info=\$(free -h | awk 'NR==2{print "内存使用:"\$3 "\n剩余可用:"\$4}')

    echo -e "\$disk_info\n\$memory_info"
}

# 主函数
main() {
    while true; do
        system_info=\$(get_system_info)
        send_email "系统资源监控" "\$system_info"
        # 每小时发送一次报告
        sleep 3
    done
}

# 执行主函数
main
EOF
chmod +x monitor.sh
#./monitor.sh
nohup ./monitor.sh &
exit
}

mail_alarm1() {

    echo -e "\n\e[1;33m脚本适用于centos7系统,不适用于openEuler系统\e[0m"
    read -p "属于接收告警信息的邮箱地址:" EMAIL
    alarm_file="/root/monitor.sh"
    
    # 使用 printf 来创建文件，并在其中插入变量
    printf '#!/bin/bash\n\n' \
    'rpm -qa mailutils || yum -y install mailutils\n' \
    'send_email() {\n' \
    '    local subject=$1\n' \
    '    local body=$2\n' \
    '    local recipient=%s\n' \
    '    echo -e "$body" | mail -s "$subject" "$recipient"\n' \
    '}\n\n' \
    'get_system_info() {\n' \
    '    disk_usage=$(df -h | awk '\''NR==6{print "磁盘已用:"$3 "\n磁盘剩余可用:"$4"\n磁盘使用率:"$5}'\'')\n' \
    '    disk_info="$disk_usage"\n\n' \
    '    memory_info=$(free -h | awk '\''NR==2{print "内存使用:"$3 "\n剩余可用:"$4}'\'')\n' \
    '    echo -e "$disk_info\n$memory_info"\n' \
    '}\n\n' \
    'main() {\n' \
    '    while true; do\n' \
    '        system_info=$(get_system_info)\n' \
    '        send_email "系统资源监控" "$system_info"\n' \
    '        sleep 3600\n' \
    '    done\n' \
    '}\n\n' \
    'main\n' \
    > $alarm_file
    
    chmod +x $alarm_file
    # 运行脚本
    # ./monitor.sh
    # nohup ./monitor.sh &
    # exit
}




#cat >/etc/yum.repos.d/local.repo <<'EOF' 
#[local]
#name=local
#baseurl=file:///mnt/cdrom
#enabled=1
#gpgcheck=0
#gpgkey=file:///mnt/cdrom/RPM-GPG-KEY-CentOS-7
#EOF








updateLog(){

echo -e "\e[1;$[RANDOM%7+31]m=================================================================================================== \e[0m"
                 echo "2022-11-26 version:v2.11.26"
                 echo "修改centos7yum源，"
echo -e "\e[1;$[RANDOM%7+31]m=================================================================================================== \e[0m"
                 echo "2022-11-27 version:v2.11.27"
                 echo "添加mariadb，yum安装，二进制安装"
echo -e "\e[1;$[RANDOM%7+31]m=================================================================================================== \e[0m"
                 echo "2022-11-28 version:v2.11.28"
                 echo "完善一些功能"
echo -e "\e[1;$[RANDOM%7+31]m=================================================================================================== \e[0m"
                 echo "2022-12-07 version:v2.12.07"
                 echo "添加编译升级安装openssh，openssl"
echo -e "\e[1;$[RANDOM%7+31]m=================================================================================================== \e[0m"
                 echo "2022-12-27 version:v2.12.27"
                 echo "改进网卡配置流程"
echo -e "\e[1;$[RANDOM%7+31]m=================================================================================================== \e[0m"
                 echo "2023-1-27 version:v3.1.27"
                 echo "升级nginx，升级openssl"
echo -e "\e[1;$[RANDOM%7+31]m=================================================================================================== \e[0m"
                 echo "2023-2-2 version:v3.2.2"
                 echo "新增docker"
echo -e "\e[1;$[RANDOM%7+31]m=================================================================================================== \e[0m"
                 echo "2023-2-3 version:v3.2.3"
                 echo "新增clickhouse"
echo -e "\e[1;$[RANDOM%7+31]m=================================================================================================== \e[0m"
                 echo "2023-2-15 version:v3.2.15"
                 echo "新增redis"
echo -e "\e[1;$[RANDOM%7+31]m=================================================================================================== \e[0m"
                 echo "2023-2-17 version:v3.2.17"
                 echo "新增keepalived"
echo -e "\e[1;$[RANDOM%7+31]m=================================================================================================== \e[0m"
                 echo "2023-5-26 version:v3.5.26"
                 echo "新增zabbix,dns"
echo -e "\e[1;$[RANDOM%7+31]m=================================================================================================== \e[0m"
                 echo "2024-4-25 version:v4.4.25"
                 echo "升级openssl openssh两个版本"
echo -e "\e[1;$[RANDOM%7+31]m=================================================================================================== \e[0m"
                 echo "2024-7-09 version:v4.7.09"
                 echo "添加邮箱告警功能,ssh登录显示功能"
echo -e "\e[1;$[RANDOM%7+31]m=================================================================================================== \e[0m"
                 echo "2024-7-23 version:v4.7.23"
                 echo "增加升级openssl openssl更多版本"
echo -e "\e[1;$[RANDOM%7+31]m=================================================================================================== \e[0m"
                 echo "2025-02-25 version:v4.8.5"
                 echo "调整优化centos7.9一键部署kubernetes1.27.4版本"
echo -e "\e[1;$[RANDOM%7+31]m=================================================================================================== \e[0m"
                 echo "2025-3-12 version:v4.8.6"
                 echo "修复centos7从openssl 1.0版本升级到3.3.1版本的一个问题"
}

re(){
init 6
}

shut(){
init 0
#shutdown -r now
}




setReset(){

echo -e "\e[1;35m====================================================================================================================================\e[0m"
echo -e "\e[1;35m一键初始化\e[0m"
echo -e "\e[1;35m支持openEuler2203，centos7.9，rocky8.5，kylinV10\e[0m"
echo -e "\e[1;35m初始化内容:更新yum源，安装软件，关闭防火墙，关闭selinux，优化limits，添加别名\e[0m"
echo -e "\e[1;35m====================================================================================================================================\e[0m"

echo "执行网络检测"
if ping -c 1 www.baidu.com >/dev/null;then
    echo -e "\e[1;32m"网络正常"\e[0m"
else
    echo -e "\e[1;31m"网络不通"\e[0m"
    
fi

echo -e "\n\e[1;35m============================================================1.更新yum源============================================================\e[0m"
yum clean all 
yum makecache

echo -e "\n\e[1;35m============================================================2.安装软件=============================================================\e[0m"
if [ $ID = 'rocky' -o $ID = 'centos' -o $ID ='openEuler' ];then
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
        "libtalloc"
        "net-tools"
        "httpd-tools"
        "bash-completion"
        )
for i in ${software[@]}
do
rpm -q  $i &> /dev/null && echo -e "$i\t\e[1;32m已安装\e[0m" || { yum -y install $i &> /dev/null ; echo -e "$i\t\e[1;35m安装成功\e[0m" ; }

done
else
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
fi



#yum -y install vim lrzsz tar.x86_64 net-tools.x86_64 telnet ftp bridge-utils.x86_64 libtalloc libtalloc-devel psmisc libpcap libpcap-devel tcpdump

sleep 2

echo -e "\n\e[1;35m=============================================================3.关闭防火墙=============================================================\e[0m"

systemctl disable --now firewalld

[ $? -eq 0 ] && echo -e "\e[1;32m                                                                       ok \e[0m" || echo -e "\e[1;31m                false \e[0m"
sleep 2



echo -e "\n\e[1;35m=============================================================4.添加别名===============================================================\e[0m"
echo -e "\n\e[1;35m添加的别名有：cdnet='cd /etc/sysconfig/network-scripts/'，vi='vim'\e[0m"


cat >>~/.bashrc <<EOF
alias cdnet='cd /etc/sysconfig/network-scripts/'
alias vi='vim'
EOF

[ $? -eq 0 ] && echo -e "\e[1;32m                                                                       ok \e[0m" || echo -e "\e[1;31m                false \e[0m"

sleep 2

echo -e "\n\e[1;35m=============================================================5.关闭selinux=============================================================\e[0m"


sed -i 's/SELINUX=enforcing/SELINUX=disabled/'    /etc/selinux/config

[ $? -eq 0 ] && echo -e "\e[1;32m                                                                       ok \e[0m" || echo -e "\e[1;31m                false \e[0m"

sleep 2

echo -e "\n\e[1;35m=============================================================6.优化limits==============================================================\e[0m"

cat >> /etc/security/limits.conf << EOF
* soft nofile 65535
* hard nofile 65535
* soft noproc 65535
* hard noproc 65535
EOF
echo "fs.file-max = 1000000" >> /etc/sysctl.conf
sysctl -p

[ $? -eq 0 ] && echo -e "\e[1;32m                                                                       ok \e[0m" || echo -e "\e[1;31m                false \e[0m"
sleep 2
echo -e "\n\e[1;35m=============================================================7.主机名颜色=============================================================\e[0m"
#echo  "PS1='\[\e[1;34m\][\[\e[$[RANDOM%7+31]m\]\u\[\e[$[RANDOM%7+31]m\]@\[\e[$[RANDOM%7+31]m\]\h\[\e[$[RANDOM%7+31]m\]\W\[\e[34m\]]\\$\[\e[0m\]'" >> /etc/bashrc
#[ $? -eq 0 ] && echo -e "\e[1;32m                                                                       ok \e[0m" || echo -e "\e[1;31m                false \e[0m"

if [ $ID = 'centos' -o $ID = 'rocky' ];then
    echo  "PS1='\[\e[1;34m\][\[\e[$[RANDOM%7+31]m\]\u\[\e[$[RANDOM%7+31]m\]@\[\e[$[RANDOM%7+31]m\]\h\[\e[$[RANDOM%7+31]m\] \W\[\e[34m\]]\\$\[\e[0m\]'" >> /etc/bashrc
    #echo  "PS1='\[\e[1;36m\][\[\e[34m\]\u\[\e[35m\]@\[\e[32m\]\h\[\e[31m\]\W\[\e[36m\]]\\$\[\e[0m\]'" >> /etc/bashrc
    #color "修改成功 " 0
[ $? -eq 0 ] && echo -e "\e[1;32m                                                                       ok \e[0m" || echo -e "\e[1;31m                false \e[0m"

else
    echo  "PS1='\[\e[1;34m\][\[\e[$[RANDOM%7+31]m\]\u\[\e[$[RANDOM%7+31]m\]@\[\e[$[RANDOM%7+31]m\]\h\[\e[$[RANDOM%7+31]m\] \W\[\e[34m\]]\\$\[\e[0m\]'" >> ~/.bashrc
    #echo "PS1='\[\e[1;35m\][\[\e[35m\]\u\[\e[35m\]@\[\e[35m\]\h \[\e[36m\]\W\[\e[35m\]]\\$\[\e[0m\]'" >> ~/.bashrc
    #color "修改成功 " 0
[ $? -eq 0 ] && echo -e "\e[1;32m                                                                       ok \e[0m" || echo -e "\e[1;31m                false \e[0m"

fi

#这两种都可以修改
#sed -i "/HISTSIZE=/c\HISTSIZE=10000" /etc/profile
sed -i 's/^HISTSIZE=.*/HISTSIZE=10000/' /etc/profile

echo  "export HISTTIMEFORMAT=\"%Y-%m-%d %H:%M:%S \"" >> /etc/bashrc
#echo export HISTTIMEFORMAT=\"%Y-%m-%d %H:%M:%S \" >> /etc/profile
#echo HISTTIMEFORMAT=\"%Y-%m-%d %H:%M:%S \" >> /etc/profile

#echo  "shopt -s histappend" >> /etc/bashrc
#source /etc/profile


cat >> ~/.bashrc <<'EOF'
# 立即将每条命令追加到历史文件
PROMPT_COMMAND='history -a'
# 合并来自其他会话的历史记录
shopt -s histappend
history -r
#export HISTTIMEFORMAT="%F %T "
EOF




#CPU=`grep -c processor /proc/cpuinfo`
echo -e "\n\e[1;35m=============================================================8.硬件配置信息=============================================================\e[0m"
local INFO=`cat /proc/cpuinfo  | grep name | cut -d: -f2 |uniq -c | tr -s ' '` 
local MEM=`free -h | head -n2 |tail -n1 | awk '{print $2}'`
local DISK=`lsblk /dev/sda | grep "^sda" | tr -s " " | cut -d " " -f4`
local SYSTEM=`uname -m`
local CPUCORES=`cat /proc/cpuinfo |grep 'cpu cores' | uniq`
local CPUNUMS=`grep 'physical id' /proc/cpuinfo | sort -u | wc -l`
echo -e "\n\e[1;35m逻辑cpu个数 cpu型号 系统架构:$INFO $SYSTEM\e[0m"
echo -e "\n\e[1;35mCPU核数:$CPUCORES\e[0m"
echo -e "\n\e[1;35m物理CPU个数:$CPUNUMS\e[0m"
echo -e "\n\e[1;35m内存总大小:$MEM\e[0m"
echo -e "\n\e[1;35m硬盘总大小:$DISK\e[0m"
sleep 2
echo -e "\n\e[1;35m===============================================================9.重启系统==============================================================\e[0m"
echo -e "\n\e[1;35m五秒后重启系统\e[0m"
for i in {5..1}
do
    echo -n "${i} "
    echo -ne "\r"
   sleep 1
done
init 6








}



install_jenkins(){
   echo -e "\e[1;32m未完成\e[0m"
#    sudo yum install -y java-11-openjdk-devel
#    wget https://mirrors.tuna.tsinghua.edu.cn/jenkins/redhat-stable/jenkins-2.452.2-1.1.noarch.rpm
#    rpm -ivh jenkins-2.452.2-1.1.noarch.rpm
#    systemctl enable --now  jenkins
#    sudo firewall-cmd --permanent --zone=public --add-port=8080/tcp
#    sudo firewall-cmd --reload
#    sudo cat /var/lib/jenkins/secrets/initialAdminPassword
#    sed -i.bak 's#updates.jenkins.io/download#mirrors.tuna.tsinghua.edu.cn/jenkins#g' ./data/updates/default.json  
#    sed -i.bak 's#www.google.com#www.baidu.com#g' ./data/updates/default.json 
#修改镜像源
#vim /var/lib/jenkins/hudson.model.UpdateCenter.xml 
#<?xml version='1.1' encoding='UTF-8'?>
#<sites>
#  <site>
#    <id>default</id>
#    <url>http://mirror.esuni.jp/jenkins/updates/update-center.json</url>
#    https://jenkins-zh.gitee.io/update-center-mirror/tsinghua/update-
#center.json
#https://mirrors.tuna.tsinghua.edu.cn/jenkins/updates/update-center.json
#  </site>
#</sites>

}


ubuntu_docker(){
echo -e "\e[1;32m未完成\e[0m"
}

install_podman(){
echo -e "\e[1;32m未完成\e[0m"
}





install_lvs(){
echo -e "\e[1;32m未完成\e[0m"
}

install_tomcat(){
echo -e "\e[1;32m未完成\e[0m"
}

install_haproxy(){
echo -e "\e[1;32m未完成\e[0m"
} 








install_halo(){
echo -e "\e[1;32m未完成\e[0m"
}

install_lua(){
echo -e "\e[1;32m未完成\e[0m"
}

install_gitlab(){
echo -e "\e[1;32m未完成\e[0m"
}

install_git(){
echo -e "\e[1;32m未完成\e[0m"
}

install_wordpress(){
echo -e "\e[1;32m未完成\e[0m"
}

install_apache(){
echo -e "\e[1;32m未完成\e[0m"
}

install_jdk(){
echo -e "\e[1;32m未完成\e[0m"
}

install_php(){
echo -e "\e[1;32m未完成\e[0m"
}

install_phpadmin(){
echo -e "\e[1;32m未完成\e[0m"
}

install_memcached(){
echo -e "\e[1;32m未完成\e[0m"
}




oneStep(){
    while :;do
echo -e "\n\e[1;$[RANDOM%7+31]m ^_^~~~^_^centos7一键初始化 ^_^~~~^_^\e[0m"
echo -e "\n\e[1;31m暂时弃用\e[0m"
echo -e "\n\e[1;32m1.返回上一目录\e[0m"
echo -e "\n\e[1;35m2.关闭防火墙\e[0m"
echo -e "\n\e[1;35m3.selinux\e[0m"
echo -e "\n\e[1;35m4.优化limit\e[0m"
echo -e "\n\e[1;35m5.修改centos7-yum源\e[0m"
echo -e "\n\e[1;35m6.软件安装\e[0m"
echo -e "\n\e[1;35m7.添加vim开头显示\e[0m"
echo -e "\n\e[1;35m8.修改登录显示\e[0m"
echo -e "\n\e[1;35m9.修改网卡名\e[0m"
echo -e "\n\e[1;35m10.添加别名\e[0m"
echo -e "\n\e[1;35m11.修改主机名颜色\e[0m"
echo -e "\n\e[1;35m12.网卡配置\e[0m"
echo -e "\n\e[1;31m0.退出\e[0m\n"
read -p "$(echo -e '\e[1;35m输入序号: \e[0m')" OOOO

case $OOOO in

1)    break
      ;;
2)    disable_firewalld
      ;;
3)    disableSelinux
      ;;
4)    set_ulimit
      ;;
5)    set_yum2_centos7
      ;;
6)    c7_software
      ;;
7)    set_vim
      ;;
8)    set_motd
      ;;
9)    set_redhat_netname
      ;;
10)    set_alias
      ;;
11)   set_PS1
      ;;
12)   configure_redhat_IP_address
      ;;
0)    set_et
      ;;

*)      echo -e "\n\e[1;31m输入无效!请输入正确的选项!!!\e[0m" 
        ;;
esac
done
}


help1(){
echo -e "\n\e[1;35m==============================================================================\e[0m"
    echo -e "\n\e[1;35m帮助/快捷使用\e[0m"
    echo "1. chmod +x csh.sh, ./csh.sh 函数名 即可直接执行对应脚本,无需再进入菜单进行选择"
    echo "2. bash csh.sh 函数名 即可直接执行对应脚本,无需再进入菜单进行选择"
    echo "3. 例如:./csh.sh ceshi1或者bash csh.sh ceshi1即可执行对应的功能"
    echo "4. 以下是所有函数名和功能对应关系"
echo -e "\n\e[1;35m==============================================================================\e[0m\n"


echo -e "\n\e[1;35m======================系统初始化相关==========================================\e[0m"
echo -e "\E[37;1m"
cat << EOF
disable_firewalld------关闭centos7以上版本防火墙 
stop_centos6_firewalld------关闭centos6版本防火墙
disableSelinux---关闭SELINUX
c6_software---安装初始化软件
c7_software---安装初始化软件
Ubuntu_software---安装初始化软件
auto_install_software----所有系统通用,自动识别系统版本
set_rm---垃圾桶
disk
set_mail
set_ulimit---优化ulimit
stop_swap---关闭swap
start_swap---开启swap
set_ssh
systemInfo---显示硬件信息
ubuntu_root_login---ubuntu  ssh登录显示
sshpass_key---设置ssh互通,地址需要自己修改,代码在7806行
ssh_auth---设置ssh登录显示
ssh_auth1
mail_alarm---设置邮箱告警
mail_alarm1---设置邮箱告警
updateLog---更新日志
re---重启
shut---关机
setReset---一键初始化
set_vim---vim配置
set_motd---设置ssh登录显示
set_motd1---设置ssh登录显示
set_timezone---修改时区为上海
EOF
echo -e "\E[0m"




echo -e "\n\e[1;35m=======================配置源相关=============================================\e[0m"
echo -e "\E[37;1m"
cat << EOF
set_yum_rocky8---配置Rocky8(有挂载磁盘)
set_yum2_rocky8---配置Rocky8(无挂载磁盘)
set_epel_rocky8---配置EPEL源
set_yum_centos7
set_yum1_centos7
set_yum2_centos7---配置所有源(有挂载磁盘)
set_yum3_centos7---配置所有源(无挂载磁盘)
set_yum4_centos7
set_epel_centos7
set_epel---配置centos7EPEL源
set_ali---配置阿里源
set_qinghua---配置清华源
set_wangyi---配置网易源
set_huawei---配置华为源
set_nanjing---配置南京大学源
****************************
centos6的源目前测试已经失效
****************************
set_yum_centos610---配置centos6.10
set_yum_centos65---配置centos6.5
set_yum_centos66---配置centos6.6
set_epel_centos6---配置centos6EPEL源
****************************
ubuntu_aliyun_source---阿里云源 
ubuntu_tuna_source---清华大学源
ubuntu_ustc_source---中科大源 
ubuntu1604_aliyun_source---ubuntu1604阿里源
ubuntu1804_aliyun_source---ubuntu1804阿里源
ubuntu2004_aliyun_source---ubuntu2004阿里源
ubuntu2204_aliyun_source
EOF
echo -e "\E[0m"




echo -e "\n\e[1;35m========================网卡配置相关===========================================\e[0m"
echo -e "\E[37;1m"
cat << EOF
configure_redhat_IP_address---配置Redhat7以上系列网卡文件 
configure_redhat6_IP_address---配置Redhat6版本网卡文件
configure_ubuntu_IP_address---配置Ubuntu网卡文件
set_alias
set_PS1---修改Redhat7以上或Ubuntu主机名颜色
set_c6_PS1---修改Redhat6主机名颜色
set_redhat_netname---Redhat系列修改网卡名为eth0
set_ubuntu_netname---Ubuntu修改网卡名为eth0

EOF
echo -e "\E[0m"




echo -e "\n\e[1;35m========================数据库安装相关==========================================\e[0m"
echo -e "\E[37;1m"
cat << EOF
binInstallMysql5736---二进制安装Mysql
rpm_install_mysql57---yum源安装Mysql
rpm_install_mysql8---yum源安装Mysql
binInstallMariadbVersion10103---二进制安装Mariadb
yumInstallMariadbVersion1151---yum源安装Mariadb
EOF
echo -e "\E[0m"

echo -e "\n\e[1;35m======================clickhouse相关============================================\e[0m"
echo -e "\E[37;1m"
cat << EOF
redhat_install_clickhouse---RedHat系列
debian_install_clickhouse---Debian系列
tgz_install_clickhouse---包安装
compile_install_clickhouse---源码编译
EOF
echo -e "\E[0m"





echo -e "\n\e[1;35m========================redis相关===============================================\e[0m"
echo -e "\E[37;1m"
cat << EOF
compile_install_redis---编译安装
EOF
echo -e "\E[0m"




echo -e "\n\e[1;35m=========================nginx相关==============================================\e[0m"
echo -e "\E[37;1m"
cat << EOF
install_nginx1---编译安装Nginx
update_nginx---升级Nginx
update_srunnginx
update_srunnginx2
EOF
echo -e "\E[0m"





echo -e "\n\e[1;35m====================openssh,openssl相关=========================================\e[0m"
echo -e "\E[37;1m"
cat << EOF
install_telnet---安装telnet,适用于redhat系列
update_openssl---升级openssl到1.1.1w版本
update_openssh---升级openssh到9.7p1版本
update_sshssl1---适用于从openssl1.*版本升级到openssl1.1.1w,openssh9.7p1
update_sshssl2---适用于从1.*版本升级到openssl3.3.0,openssh9.7p1
update_sshssl3---适用于从3.*版本升级到openssl3.3.1,openssh9.8p1
update_sshssl4---适用于从1.*版本升级到openssl3.3.1,openssh9.8p1
update_sshssl5---适用于centos6系统升级openssh9.8p1和openssl3.3.1
update_sshssl6---适用于openeuler系统升级openssh9.8p1和openssl3.3.1
update_sshssl7---适用于openeuler系统升级openssh9.9p1和openssl3.4.0
EOF
echo -e "\E[0m"





echo -e "\n\e[1;35m=======================docker相关================================================\e[0m"
echo -e "\E[37;1m"
cat << EOF
c7_yum_docker---CentOS7yum源安装
c7_yum2_docker---CentOS7yum源安装
c8_yum_docker---CentOS8yum源版本
install_docker_compose---在线下载安装
uninstall_docker---卸载docker,适用于ubuntu
ubuntu_docker---安装ubuntu版本docker
install_podman---安装podman
EOF
echo -e "\E[0m"










echo -e "\n\e[1;35m=========================keepalived相关==========================================\e[0m"
echo -e "\E[37;1m"
cat << EOF
compile_install_keepalived---编译安装
EOF
echo -e "\E[0m"




echo -e "\n\e[1;35m=========================dns相关=================================================\e[0m"
echo -e "\E[37;1m"
cat << EOF
install_dns
EOF
echo -e "\E[0m"




echo -e "\n\e[1;35m=========================zabbix相关==============================================\e[0m"
echo -e "\E[37;1m"
cat << EOF
install_rocky8_zabbix6
install_rocky8_zabbix6_agent2
install_rocky8_zabbix5
install_rocky8_zabbix5_agent2
EOF
echo -e "\E[0m"




echo -e "\n\e[1;35m========================kubernetes相关===========================================\e[0m"
echo -e "\E[37;1m"
cat << EOF
install_kubernetes_redhat_node1
install_kubernetes_ubuntu_master
install_kubernetes_ubuntu_master1
install_kubernetes_ubuntu_master2
install_kubernetes_radhat_master
install_kubernetes_radhat_node
reset_kubenetes---重置kubernetes

EOF
echo -e "\E[0m"




echo -e "\n\e[1;35m========================其他服务安装=============================================\e[0m"
echo -e "\E[37;1m"
cat << EOF
install_jenkins---安装jenkins
install_lvs---安装lvs
install_tomcat---安装tomcat
install_haproxy---安装haproxy
install_halo---安装halo
install_lua---安装lua
install_gitlab---安装gitlab
install_git---安装git
install_wordpress---安装wordpress
install_apache---安装apache
install_jdk---安装jdk
install_php---安装php
install_phpadmin---安装phpadmin
install_memcached---安装memcached
EOF
echo -e "\E[0m"



echo -e "\n\e[1;35m================================================================================\e[0m"
}




# 根据第一个参数执行对应函数
# 检查第一个参数是否存在并非空值
# 如果没有参数则进入菜单
if [[ -n "${1-}" ]];then
    case "$1" in
        disable_firewalld |\
        stop_centos6_firewalld |\
        disableSelinux |\
        c6_software |\
        c7_software |\
        Ubuntu_software |\
        set_rm |\
        disk |\
        set_mail |\
        set_ulimit |\
        stop_swap |\
        start_swap |\
        set_ssh |\
        systemInfo |\
        ubuntu_root_login |\
        set_yum_rocky8 |\
        set_yum2_rocky8 |\
        set_epel_rocky8 |\
        set_yum_centos7 |\
        set_yum1_centos7 |\
        set_yum2_centos7 |\
        set_yum3_centos7 |\
        set_yum4_centos7 |\
        set_epel_centos7 |\
        set_yum_centos610 |\
        set_yum_centos65 |\
        set_yum_centos66 |\
        set_epel_centos6 |\
        set_epel |\
        set_ali |\
        set_qinghua |\
        set_wangyi |\
        set_huawei |\
        set_nanjing |\
        ubuntu_aliyun_source |\
        ubuntu_tuna_source |\
        ubuntu_ustc_source |\
        ubuntu1604_aliyun_source |\
        ubuntu1804_aliyun_source |\
        ubuntu2004_aliyun_source |\
        ubuntu2204_aliyun_source |\
        configure_redhat_IP_address |\
        configure_redhat6_IP_address |\
        configure_ubuntu_IP_address |\
        set_alias |\
        set_PS1 |\
        set_c6_PS1 |\
        set_redhat_netname |\
        set_ubuntu_netname |\
        set_vim |\
        set_motd |\
        set_motd1 |\
        set_timezone |\
        binInstallMysql5736 |\
        rpm_install_mysql57 |\
        rpm_install_mysql8 |\
        binInstallMariadbVersion10103 |\
        yumInstallMariadbVersion1151 |\
        install_nginx1 |\
        update_nginx |\
        update_srunnginx |\
        update_srunnginx2 |\
        update_openssl |\
        update_openssh |\
        update_sshssl1 |\
        update_sshssl2 |\
        update_sshssl3 |\
        update_sshssl4 |\
        update_sshssl5 |\
        update_sshssl6 |\
        update_sshssl7 |\
        update_sshssl8 |\
        c7_yum_docker |\
        c7_yum2_docker |\
        c8_yum_docker |\
        redhat_install_clickhouse |\
        debian_install_clickhouse |\
        tgz_install_clickhouse |\
        compile_install_clickhouse |\
        compile_install_redis |\
        compile_install_keepalived |\
        install_dns |\
        install_rocky8_zabbix6 |\
        install_rocky8_zabbix6_agent2 |\
        install_rocky8_zabbix5 |\
        install_rocky8_zabbix5_agent2 |\
        install_kubernetes_redhat_node1 |\
        install_kubernetes_ubuntu_master |\
        install_kubernetes_ubuntu_master1 |\
        install_kubernetes_ubuntu_master2 |\
        install_kubernetes_radhat_master |\
        install_kubernetes_radhat_node |\
        reset_kubenetes |\
        install_docker_compose |\
        install_telnet |\
        uninstall_docker |\
        sshpass_key |\
        ssh_auth |\
        ssh_auth1 |\
        mail_alarm |\
        mail_alarm1 |\
        updateLog |\
        re |\
        shut |\
        setReset |\
        install_jenkins |\
        ubuntu_docker |\
        install_podman |\
        install_lvs |\
        install_tomcat |\
        install_haproxy |\
        install_halo |\
        install_lua |\
        install_gitlab |\
        install_git |\
        install_wordpress |\
        install_apache |\
        install_jdk |\
        install_php |\
        install_phpadmin |\
        install_memcached |\
        auto_install_software |\
        help1)
            "$1" #调用与参数同名的函数
            exit 0
            ;;
        *)
            echo "Usage: $0 {ceshi1|ceshi2|ceshi3}" 
            exit 1
            ;;
    esac
fi


#####################################################################################################################################




install_kubernetes_ubuntu(){
    while :;do
    echo -e "\E[$[RANDOM%7+31];1m"
    cat << EOF

************************************************************
************************************************************
************************************************************
**********                                        **********
**********              安装kubernetes            **********
**********              for  ubuntu               **********
**********                                        **********
**********             1.返回上一目录             **********
**********                                        **********
**********             2.1.24.3                   **********
**********             3.1.22.7                   **********
**********                                        **********
**********             0.退出                     **********
**********                                        **********
************************************************************
************************************************************
************************************************************


EOF

    echo -e "\E[0m"
read -p "$(echo -e '\e[1;36m请输入序号: \e[0m')" Menu

case $Menu in

1)     break
       ;;

2)     install_kubernetes_ubuntu_master
       ;;

3)     install_kubernetes_ubuntu_master1
       ;;



0)     set_et
       ;;

*)      echo -e "\n\e[1;31m输入无效!请输入正确的选项!!!\e[0m" 
        ;;
esac
done

}





#####################################################################################################################################

install_kubernetes_radhat1322(){
    while :;do
    echo -e "\E[$[RANDOM%7+31];1m"
    cat << EOF

************************************************************
************************************************************
************************************************************
**********                                        **********
**********                 1.32.2                 **********
**********                                        **********
**********             1.返回上一目录             **********
**********                                        **********
**********             2.安装master01             **********
**********             3.安装node                 **********
**********                                        **********
**********             0.退出                     **********
**********                                        **********
************************************************************
************************************************************
************************************************************


EOF

    echo -e "\E[0m"
read -p "$(echo -e '\e[1;36m请输入序号: \e[0m')" Menu

case $Menu in

1)     break
       ;;

2)     install_kubernetes_radhat_master1322
       ;;

3)     install_kubernetes_radhat_node1322
       ;;

0)     set_et
       ;;

*)      echo -e "\n\e[1;31m输入无效!请输入正确的选项!!!\e[0m" 
        ;;
esac
done

}




#####################################################################################################################################

install_kubernetes_radhat1274(){
    while :;do
    echo -e "\E[$[RANDOM%7+31];1m"
    cat << EOF

************************************************************
************************************************************
************************************************************
**********                                        **********
**********                 1.27.4                 **********
**********                                        **********
**********             1.返回上一目录             **********
**********                                        **********
**********             2.安装master01             **********
**********             3.安装node                 **********
**********                                        **********
**********             0.退出                     **********
**********                                        **********
************************************************************
************************************************************
************************************************************


EOF

    echo -e "\E[0m"
read -p "$(echo -e '\e[1;36m请输入序号: \e[0m')" Menu

case $Menu in

1)     break
       ;;

2)     install_kubernetes_radhat_master1274
       ;;

3)     install_kubernetes_radhat_node1274
       ;;

0)     set_et
       ;;

*)      echo -e "\n\e[1;31m输入无效!请输入正确的选项!!!\e[0m" 
        ;;
esac
done

}






#####################################################################################################################################







install_kubernetes_radhat(){
    while :;do
    echo -e "\E[$[RANDOM%7+31];1m"
    cat << EOF

************************************************************
************************************************************
************************************************************
**********                                        **********
**********         安装kubernetes for  radhat     **********
**********                                        **********
**********             1.返回上一目录             **********
**********                                        **********
**********             2.1.27.4                   **********
**********             3.1.32.2                   **********
**********                                        **********
**********             0.退出                     **********
**********                                        **********
************************************************************
************************************************************
************************************************************


EOF

    echo -e "\E[0m"
read -p "$(echo -e '\e[1;36m请输入序号: \e[0m')" Menu

case $Menu in

1)     break
       ;;

2)     install_kubernetes_radhat1274
       ;;

3)     install_kubernetes_radhat1322
       ;;


0)     set_et
       ;;

*)      echo -e "\n\e[1;31m输入无效!请输入正确的选项!!!\e[0m" 
        ;;
esac
done

}




#####################################################################################################################################





install_kubernetes_openEuler132(){
    while :;do
    echo -e "\E[$[RANDOM%7+31];1m"
    cat << EOF

************************************************************
************************************************************
************************************************************
**********                                        **********
**********                 1.32                   **********
**********                                        **********
**********             1.返回上一目录             **********
**********                                        **********
**********             2.安装master01             **********
**********             3.安装node                 **********
**********                                        **********
**********             0.退出                     **********
**********                                        **********
************************************************************
************************************************************
************************************************************


EOF

    echo -e "\E[0m"
read -p "$(echo -e '\e[1;36m请输入序号: \e[0m')" Menu

case $Menu in

1)     break
       ;;

2)     install_kubernetes_openEuler_master132
       ;;

3)     install_kubernetes_openEuler_node132
       ;;

0)     set_et
       ;;

*)      echo -e "\n\e[1;31m输入无效!请输入正确的选项!!!\e[0m" 
        ;;
esac
done

}







#####################################################################################################################################







install_kubernetes_openEuler(){
    while :;do
    echo -e "\E[$[RANDOM%7+31];1m"
    cat << EOF

************************************************************
************************************************************
************************************************************
**********                                        **********
**********         安装kubernetes for  openEuler  **********
**********                                        **********
**********             1.返回上一目录             **********
**********                                        **********
**********             2.1.32                     **********
**********                                        **********
**********             0.退出                     **********
**********                                        **********
************************************************************
************************************************************
************************************************************


EOF

    echo -e "\E[0m"
read -p "$(echo -e '\e[1;36m请输入序号: \e[0m')" Menu

case $Menu in

1)     break
       ;;

2)     install_kubernetes_openEuler132
       ;;


0)     set_et
       ;;

*)      echo -e "\n\e[1;31m输入无效!请输入正确的选项!!!\e[0m" 
        ;;
esac
done

}







#####################################################################################################################################









install_kubernetes(){
    while :;do
    echo -e "\E[$[RANDOM%7+31];1m"
    cat << EOF

************************************************************
************************************************************
************************************************************
**********                                        **********
**********              安装kubernetes            **********
**********                                        **********
**********             1.返回上一目录             **********
**********                                        **********
**********             2.redhat                   **********
**********             3.ubuntu                   **********
**********             4.openEuler                **********
**********             5.重置                     **********
**********                                        **********
**********             0.退出                     **********
**********                                        **********
************************************************************
************************************************************
************************************************************


EOF

    echo -e "\E[0m"
read -p "$(echo -e '\e[1;36m请输入序号: \e[0m')" Menu

case $Menu in

1)     break
       ;;

2)     install_kubernetes_radhat
       ;;

3)     install_kubernetes_ubuntu
       ;;

4)     install_kubernetes_openEuler
       ;;

5)     reset_kubenetes
       ;;
  

0)     set_et
       ;;

*)      echo -e "\n\e[1;31m输入无效!请输入正确的选项!!!\e[0m" 
        ;;
esac
done

}







#####################################################################################################################################












install_zabbix(){
while :;do
    echo -e "\E[$[RANDOM%7+31];1m"
    cat << EOF

************************************************************
************************************************************
************************************************************
**********                                        **********
**********              安装zabbix                **********
**********                                        **********
********** 1.返回上一目录                         **********
**********          ==================            **********
********** zabbix6安装         zabbix6-agent2安装 **********
**********                                        **********
********** 2.rocky8安装        8.rocky8安装       **********
********** 3.ubuntu2204安装    9.ubuntu2204安装   **********
********** 4.centos7安装       10.centos7安装     **********
**********          ==================            **********
********** zabbix5安装         zabbix5-agent2安装 **********
**********                                        **********
********** 5.rocky8安装        11.rocky8安装      **********
********** 6.ubuntu2204安装    12.ubuntu2204安装  **********
********** 7.centos7安装       13.centos7安装     **********
**********          ==================            **********
********** 0.退出                                 **********
**********                                        **********
************************************************************
************************************************************
************************************************************


EOF

    echo -e "\E[0m"
read -p "$(echo -e '\e[1;36m请输入序号: \e[0m')" Menu

case $Menu in

1)     break
       ;;

2)     install_rocky8_zabbix6
       ;;

3)     install_ubuntu2204_zabbix6
       ;;

4)     install_centos7_zabbix6
       ;;


5)     install_rocky8_zabbix5
       ;;

6)     install_ubuntu2204_zabbix5
       ;;

7)     install_centos7_zabbix5
       ;;


8)     install_rocky8_zabbix6_agent2
       ;;

9)     install_ubuntu2204_zabbix6_agent2
       ;;

10)    install_centos7_zabbix6_agent2
       ;;


11)    install_rocky8_zabbix5_agent2
       ;;

12)    install_ubuntu2204_zabbix5_agent2
       ;;

13)    install_centos7_zabbix5_agent2
       ;;



0)     set_et
       ;;

*)      echo -e "\n\e[1;31m输入无效!请输入正确的选项!!!\e[0m" 
        ;;
esac
done

}






















install_keepalived(){
while :;do
    echo -e "\E[$[RANDOM%7+31];1m"
    cat << EOF

************************************************************
************************************************************
************************************************************
**********                                        **********
**********              安装keepalived            **********
**********                                        **********
**********             1.返回上一目录             **********
**********                                        **********
**********             2.编译安装                 **********
**********                                        **********
**********             0.退出                     **********
**********                                        **********
************************************************************
************************************************************
************************************************************


EOF

    echo -e "\E[0m"
read -p "$(echo -e '\e[1;36m请输入序号: \e[0m')" Menu

case $Menu in

1)     break
       ;;

2)     compile_install_keepalived
       ;;

0)     set_et
       ;;


*)      echo -e "\n\e[1;31m输入无效!请输入正确的选项!!!\e[0m" 
        ;;
esac
done

}























install_redis(){
while :;do
    echo -e "\E[$[RANDOM%7+31];1m"
    cat << EOF

************************************************************
************************************************************
************************************************************
**********                                        **********
**********              安装Redis                 **********
**********                                        **********
**********             1.返回上一目录             **********
**********                                        **********
**********             2.编译安装                 **********
**********                                        **********
**********             0.退出                     **********
**********                                        **********
************************************************************
************************************************************
************************************************************


EOF

    echo -e "\E[0m"
read -p "$(echo -e '\e[1;36m请输入序号: \e[0m')" Menu

case $Menu in

1)     break
       ;;

2)     compile_install_redis
       ;;

0)     set_et
       ;;

*)      echo -e "\n\e[1;31m输入无效!请输入正确的选项!!!\e[0m" 
        ;;
esac
done

}


























install_clickhouse(){
while :;do
    echo -e "\E[$[RANDOM%7+31];1m"
    cat << EOF

========================================================
RedHat系列是直接yum下载安装
Debian系列是直接apt下载安装
包安装是自动下载官网tgz包再安装
========================================================

************************************************************
************************************************************
************************************************************
**********                                        **********
**********              安装clickhouse            **********
**********                                        **********
**********             1.返回上一目录             **********
**********                                        **********
**********             2.RedHat系列               **********
**********             3.Debian系列               **********
**********             4.包安装                   **********
**********             5.源码编译                 **********
**********                                        **********
**********             0.退出                     **********
**********                                        **********
************************************************************
************************************************************
************************************************************


EOF

    echo -e "\E[0m"
read -p "$(echo -e '\e[1;36m请输入序号: \e[0m')" Menu

case $Menu in

1)     break
       ;;

2)     redhat_install_clickhouse
       ;;

3)     debian_install_clickhouse
       ;;

4)     tgz_install_clickhouse
       ;;

5)     compile_install_clickhouse
       ;;     

0)     set_et
       ;;

*)      echo -e "\n\e[1;31m输入无效!请输入正确的选项!!!\e[0m" 
        ;;
esac
done

}

















install_docker(){
while :;do
    echo -e "\E[$[RANDOM%7+31];1m"
    cat << EOF

========================================================
选项3弃用
选项5还没写
选项7还没写
二进制安装可在线可离线
========================================================

************************************************************
************************************************************
************************************************************
**********                                        ********** 
**********           安装docker                   **********    
**********                                        **********
**********        1.返回上一目录                  **********
**********                                        **********
**********        2.CentOS7yum源安装              **********
**********        3.CentOS7yum源安装              **********
**********        4.CentOS8yum源版本              **********
**********        5.Ubuntu安装                    **********
**********        6.二进制安装                    **********
**********        7.安装podman                    **********
**********        8.安装docker-compose            **********
**********        9.卸载docker                    **********
**********                                        **********
**********        0.退出                          ********** 
**********                                        **********
************************************************************
************************************************************
************************************************************


EOF

    echo -e "\E[0m"
read -p "$(echo -e '\e[1;36m请输入序号: \e[0m')" Menu

case $Menu in

1)     break
       ;;

2)     c7_yum_docker
       ;;

3)     c7_yum2_docker
       ;;

4)     c8_yum_docker
       ;;

5)     ubuntu_docker
       ;;

6)     offline_install_docker
       ;;

7)     install_podman
       ;;

8)     install_docker_compose
       ;;

9)     uninstall_docker
       ;;

0)     set_et
       ;;

*)      echo -e "\n\e[1;31m输入无效!请输入正确的选项!!!\e[0m" 
        ;;
esac
done

}






















reset_PS1(){
while :;do
    echo -e  "\E[$[RANDOM%7+31];1m"
    cat << EOF


************************************************************
************************************************************
************************************************************
**********                                        **********
**********           修改主机名颜色               ********** 
**********                                        **********
**********     1.返回上一目录                     **********
**********                                        **********
**********     2.Redhat7以上或Ubuntu              **********
**********     3.Redhat6                          **********
**********                                        **********
**********     0.退出                             **********
**********                                        **********
************************************************************
************************************************************
************************************************************


EOF
        echo -e "\E[0m"

read -p "$(echo -e '\e[1;36m请输入序号: \e[0m')" Menu
case $Menu in
1)      break
        ;;

2)      set_PS1
        ;;

3)      set_c6_PS1
        ;;


0)      set_et
        ;;

*)      echo -e "\n\e[1;31m输入无效!请输入正确的选项!!!\e[0m" 
        ;;
esac
done

}






















set_net(){
while :;do
    echo -e  "\E[$[RANDOM%7+31];1m"
    cat << EOF


************************************************************
************************************************************
************************************************************
**********                                        **********
**********            网卡配置                    ********** 
**********                                        **********
**********     1.返回上一目录                     **********
**********                                        **********
**********     2.配置Redhat7以上系列网卡文件      **********
**********     3.配置Redhat6版本网卡文件          **********
**********     4.配置Ubuntu网卡文件               **********
**********     ============================       ********** 
**********     5.Redhat系列修改网卡名为eth0       **********
**********     6.Ubuntu修改网卡名为eth0           **********
**********                                        **********
**********     0.退出                             **********
**********                                        **********
************************************************************
************************************************************
************************************************************


EOF
        echo -e "\E[0m"

read -p "$(echo -e '\e[1;36m请输入序号: \e[0m')" Menu
case $Menu in
2)      configure_redhat_IP_address
        ;;

3)      configure_redhat6_IP_address
        ;;

4)      configure_ubuntu_IP_address
        ;;

5)      set_redhat_netname
        ;;

6)      set_ubuntu_netname
        ;;

1)      break
        ;;

0)      set_et
        ;;

*)      echo -e "\n\e[1;31m输入无效!请输入正确的选项!!!\e[0m" 
        ;;
esac
done

}























ubuntu_source(){
while :;do
    echo -e  "\E[$[RANDOM%7+31];1m"
    cat << EOF


************************************************************
************************************************************
************************************************************
**********                                        **********
**********        ubuntu源配置                    ********** 
**********                                        **********
**********     1.返回上一目录                     **********
**********                                        **********
**********     2.阿里云源                         **********
**********     3.清华大学源                       **********
**********     4.中科大源                         **********
**********     5.ubuntu2004阿里源                 **********
**********     6.ubuntu1804阿里源                 **********
**********     7.ubuntu1604阿里源                 **********
**********                                        **********
**********     0.退出                             **********
**********                                        **********
************************************************************
************************************************************
************************************************************


EOF
        echo -e "\E[0m"

read -p "$(echo -e '\e[1;36m请输入序号: \e[0m')" Menu
case $Menu in
2)      ubuntu_aliyun_source
        ;;

3)      ubuntu_tuna_source
        ;;

4)      ubuntu_ustc_source
        ;;

5)      ubuntu2004_aliyun_source
        ;;

6)      ubuntu1804_aliyun_source
        ;;

7)      ubuntu1604_aliyun_source
        ;;

1)      break
        ;;

0)      set_et
        ;;

*)      echo -e "\n\e[1;31m输入无效!请输入正确的选项!!!\e[0m" 
        ;;
esac
done

}





set_centos7_yum(){
    while :;do
    echo -e  "\E[$[RANDOM%7+31];1m"
    cat << EOF

============================================================
适用于centos7.9.2009和redhat7.9
============================================================

************************************************************
************************************************************
************************************************************
**********                                        **********
**********           centos7                      **********
**********                                        **********
**********         1.返回上一目录                 **********
**********                                        **********
**********         2.挂载本地镜像源               ********** 
**********         3.配置EPEL源                   **********
**********         4.配置阿里源                   **********
**********         5.配置清华源                   **********
**********         6.配置网易源                   **********
**********         7.配置华为源                   **********
**********         8.配置南京大学源               **********
**********         9.配置所有源(无挂载磁盘)       **********
**********         10.配置所有源(有挂载磁盘)      **********
**********                                        **********
**********         0.退出                         **********
**********                                        **********
************************************************************
************************************************************
************************************************************


EOF
        echo -e "\E[0m"

read -p "$(echo -e '\e[1;36m请输入序号: \e[0m')" Menu
case $Menu in
2)      set_local_yum
        ;;

3)      set_epel
        ;;

4)      set_ali
        ;;

5)      set_qinghua
        ;;

6)      set_wangyi
        ;;

7)      set_huawei
        ;;

8)      set_nanjing
        ;;

9)      set_yum3_centos7
        ;;

10)      set_yum2_centos7
        ;;


1)      break
        ;;

0)      set_et
        ;;

*)      echo -e "\n\e[1;31m输入无效!请输入正确的选项!!!\e[0m" 
        ;;
esac
done

}



set_centos6_yum(){
    while :;do
    echo -e  "\E[$[RANDOM%7+31];1m"
    cat << EOF

============================================================
选项3可适用于大版本是centos6的系统
============================================================

************************************************************
************************************************************
************************************************************
**********                                        **********
**********           centos6                      **********
**********                                        **********
**********         1.返回上一目录                 **********
**********                                        ********** 
**********         2.配置EPEL源                   **********
**********         3.配置centos6.10               **********
**********         4.配置centos6.5                **********
**********         5.配置centos6.6                **********
**********                                        **********
**********         0.退出                         **********
**********                                        **********
************************************************************
************************************************************
************************************************************


EOF
        echo -e "\E[0m"

read -p "$(echo -e '\e[1;36m请输入序号: \e[0m')" Menu
case $Menu in
2)      set_epel_centos6
        ;;

3)      set_yum_centos610
        ;;

4)      set_yum_centos65
        ;;

5)      set_yum_centos66
        ;;



1)      break
        ;;

0)      set_et
        ;;

*)      echo -e "\n\e[1;31m输入无效!请输入正确的选项!!!\e[0m" 
        ;;
esac
done

}



set_Rocky8_yum(){
    while :;do
    echo -e  "\E[$[RANDOM%7+31];1m"
    cat << EOF


************************************************************
************************************************************
************************************************************
**********                                        **********
**********           Rocky8                       **********
**********                                        **********
**********         1.返回上一目录                 **********
**********                                        ********** 
**********         2.配置EPEL源                   **********
**********         3.配置Rocky8(无挂载磁盘)       **********
**********         4.配置Rocky8(有挂载磁盘)       **********
**********                                        **********
**********         0.退出                         **********
**********                                        **********
************************************************************
************************************************************
************************************************************


EOF
        echo -e "\E[0m"

read -p "$(echo -e '\e[1;36m请输入序号: \e[0m')" Menu
case $Menu in
2)      set_epel_rocky8
        ;;

3)      set_yum2_rocky8
        ;;

4)      set_yum_rocky8
        ;;


1)      break
        ;;

0)      set_et
        ;;

*)      echo -e "\n\e[1;31m输入无效!请输入正确的选项!!!\e[0m" 
        ;;
esac
done

}






set_yum(){
while :;do
    echo -e  "\E[$[RANDOM%7+31];1m"
    cat << EOF


************************************************************
************************************************************
************************************************************
**********                                        **********
**********             配置yum源                  **********
**********                                        **********
**********         1.返回上一目录                 **********
**********                                        ********** 
**********         2.配置Rocky8 源                **********
**********         =======================        **********
**********         3.配置centos7 源               **********
**********         =======================        **********
**********         4.配置centos6 源               **********
**********         =======================        **********
**********         5.配置ubuntu apt源             **********
**********                                        **********
**********         0.退出                         **********
**********                                        **********
************************************************************
************************************************************
************************************************************


EOF
        echo -e "\E[0m"

read -p "$(echo -e '\e[1;36m请输入序号: \e[0m')" Menu
case $Menu in
2)      set_Rocky8_yum
        ;;

3)      set_centos7_yum
        ;;

4)      set_centos6_yum
        ;;

5)     ubuntu_source
        ;;


1)      break
        ;;

0)      set_et
        ;;

*)      echo -e "\n\e[1;31m输入无效!请输入正确的选项!!!\e[0m" 
        ;;
esac
done

}














setFirewalld(){
while :;do
    echo -e "\E[$[RANDOM%7+31];1m"
    cat << EOF


************************************************************
************************************************************
************************************************************
**********                                        ********** 
**********             关闭防火墙                 **********    
**********                                        **********
**********           1.返回上一目录               **********
**********                                        **********
**********           2.Redhat7以上版本            **********
**********           3.Redhat6版本                **********
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

1)     break
       ;;

2)     disable_firewalld
       ;;

3)     stop_centos6_firewalld
       ;;

0)     set_et
       ;;

*)      echo -e "\n\e[1;31m输入无效!请输入正确的选项!!!\e[0m" 
        ;;
esac
done

}



















software(){
while :;do
    echo -e "\E[$[RANDOM%7+31];1m"
    cat << EOF
========================================
Ubuntu和redhat安装的软件多少不一样
选项5 是可以自动识别系统版本进行安装
========================================

************************************************************
************************************************************
************************************************************
**********                                        ********** 
**********           安装初始化软件               **********    
**********                                        **********
**********           1.返回上一目录               **********
**********                                        **********
**********           2.Redhat7,8系列              **********
**********           3.Redhat6系列                **********
**********           4.Ubuntu系列                 **********
**********           5.所有系统通用               **********
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

1)     break
       ;;

2)     c7_software
       ;;

3)     c6_software
       ;;

4)     Ubuntu_software
       ;;

5)     auto_install_software
       ;;

0)     set_et
       ;;

*)      echo -e "\n\e[1;31m输入无效!请输入正确的选项!!!\e[0m" 
        ;;
esac
done




}

time1(){
clock -s
}

time2(){
clock -w
}









binInstallMariadbVersion(){
while :;do
    echo -e "\E[$[RANDOM%7+31];1m"
    cat << EOF



************************************************************
************************************************************
************************************************************
**********                                        ********** 
**********           二进制安装Mariadb            **********    
**********                                        **********
**********           1.返回上一目录               **********
**********                                        **********
**********           2.10.10.3                    **********
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

1)     break
       ;;

2)    binInstallMariadbVersion10103
      ;;


0)     set_et
       ;;

*)      echo -e "\n\e[1;31m输入无效!请输入正确的选项!!!\e[0m" 
        ;;
esac
done
}






yumInstallMariadbVersion(){
while :;do
    echo -e "\E[$[RANDOM%7+31];1m"
    cat << EOF



************************************************************
************************************************************
************************************************************
**********                                        ********** 
**********           yum源安装Mariadb             **********    
**********                                        **********
**********           1.返回上一目录               **********
**********                                        **********
**********           2.11.5.1                     **********
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

1)     break
       ;;

2)    yumInstallMariadbVersion1151
      ;;


0)     set_et
       ;;

*)      echo -e "\n\e[1;31m输入无效!请输入正确的选项!!!\e[0m" 
        ;;
esac
done
}
















installMariadb(){
while :;do
    echo -e "\E[$[RANDOM%7+31];1m"
    cat << EOF



************************************************************
************************************************************
************************************************************
**********                                        ********** 
**********             Mariadb                    **********    
**********                                        **********
**********           1.返回上一目录               **********
**********                                        **********
**********           2.二进制安装                 **********
**********           3.yum安装                    **********
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

1)     break
       ;;

2)    binInstallMariadbVersion
      ;;

3)    yumInstallMariadbVersion
      ;;

0)     set_et
       ;;

*)      echo -e "\n\e[1;31m输入无效!请输入正确的选项!!!\e[0m" 
        ;;
esac
done
}

























rpmInstallMysqlVersion(){
while :;do
    echo -e "\E[$[RANDOM%7+31];1m"
    cat << EOF



************************************************************
************************************************************
************************************************************
**********                                        ********** 
**********            yum源安装Mysql              **********    
**********                                        **********
**********           1.返回上一目录               **********
**********                                        **********
**********           2.5.6                        **********
**********           3.8.0                        **********
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

1)     break
       ;;

2)     rpm_install_mysql57
       ;;

3)     rpm_install_mysql8
       ;;

0)     set_et
       ;;

*)      echo -e "\n\e[1;31m输入无效!请输入正确的选项!!!\e[0m" 
        ;;
esac
done
}







binInstallMysqlVersion(){
while :;do
    echo -e "\E[$[RANDOM%7+31];1m"
    cat << EOF



************************************************************
************************************************************
************************************************************
**********                                        ********** 
**********           二进制安装Mysql              **********    
**********                                        **********
**********           1.返回上一目录               **********
**********                                        **********
**********           2.5.7.36                     **********
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

1)     break
       ;;

2)     binInstallMysql5736
       ;;

0)     set_et
       ;;

*)      echo -e "\n\e[1;31m输入无效!请输入正确的选项!!!\e[0m" 
        ;;
esac
done
}






installMysql(){
while :;do
    echo -e "\E[$[RANDOM%7+31];1m"
    cat << EOF



************************************************************
************************************************************
************************************************************
**********                                        ********** 
**********             Mysql                      **********    
**********                                        **********
**********           1.返回上一目录               **********
**********                                        **********
**********           2.二进制安装                 **********
**********           3.yum安装                    **********
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

1)     break
       ;;

2)     binInstallMysqlVersion
       ;;
3)     rpmInstallMysqlVersion
       ;;

0)     set_et
       ;;

*)      echo -e "\n\e[1;31m输入无效!请输入正确的选项!!!\e[0m" 
        ;;
esac
done
}










install_Database(){
while :;do
    echo -e "\E[$[RANDOM%7+31];1m"
    cat << EOF



************************************************************
************************************************************
************************************************************
**********                                        ********** 
**********             安装数据库                 **********    
**********                                        **********
**********           1.返回上一目录               **********
**********                                        **********
**********           2.MySQL                      **********
**********           3.MariaDB                    **********
**********           4.redis                      **********
**********           5.clickhouse                 **********
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

1)     break
       ;;

2)     installMysql
       ;;

3)     installMariadb
       ;;

4)     install_redis
       ;;

5)     install_clickhouse
       ;;

0)     set_et
       ;;

*)      echo -e "\n\e[1;31m输入无效!请输入正确的选项!!!\e[0m" 
        ;;
esac
done
}































install_NGINX(){
while :;do
    echo -e "\E[$[RANDOM%7+31];1m"
    cat << EOF



************************************************************
************************************************************
************************************************************
**********                                        ********** 
**********             安装NGINX                  **********    
**********                                        **********
**********           1.返回上一目录               **********
**********                                        **********
**********           2.编译安装Nginx              **********
**********           3.升级Nginx                  **********
**********           4.升级srun-Nginx             **********
**********           5.升级旧版本srun-Nginx       **********
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

1)     break
       ;;


2)      install_nginx1
        ;;

3)      update_nginx
        ;;

4)      update_srunnginx
        ;;

5)      update_srunnginx2
        ;;

0)     set_et
       ;;

*)      echo -e "\n\e[1;31m输入无效!请输入正确的选项!!!\e[0m" 
        ;;
esac
done
}

















install_SSHSSL(){
while :;do
    echo -e "\E[$[RANDOM%7+31];1m"
    cat << EOF

============================================================

**********以下支持在centos7系列使用*************
3.升级openssl到1.1.1w版本
4.升级openssh到9.7p1版本
5 适用于从openssl1.*版本升级到openssl1.1.1w,openssh9.7p1
6 适用于从openssl1.*版本升级到openssl3.3.0,openssh9.7p1
7.适用于从openssl3.*版本升级到openssl3.3.1,openssh9.8p1
8.适用于从openssl1.*版本升级到openssl3.3.1,openssh9.8p1
11.适用于从openssl1.*版本升级到openssl3.4.0,openssh9.9p1

**********以下支持在centos6系列使用*************
9.适用于从openssl1.*版本升级到openssl3.3.1,openssh9.8p1
14.适用于从openssl1.*版本升级到openssl3.4.0,openssh9.9p1

**********以下支持在openEuler系列使用*************
10.适用于从openssl1.*版本升级到openssl3.3.1,openssh9.8p1
12.适用于从openssl1.*版本升级到openssl3.4.0,openssh9.9p1

============================================================

************************************************************
************************************************************
************************************************************
**********                                        ********** 
**********          升级安装openssl,openssh       **********    
**********                                        **********
**********           1.返回上一目录               **********
**********                                        **********
**********           2.安装telnet                 **********
**********           3.升级安装openssl            **********
**********           4.升级安装openssh            **********
**********           5.升级openssl,openssh        **********
**********           6.升级openssl,openssh        **********
**********           7.升级openssl,openssh        **********
**********           8.升级openssl,openssh        **********
**********           9.升级openssl,openssh        **********
**********           10.升级openssl,openssh       **********
**********           11.升级openssl,openssh       **********
**********           12.升级openssl,openssh       **********
**********           13.升级openssl,openssh       **********
**********           14.升级openssl,openssh       **********
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

1)     break
       ;;

2)      install_telnet
        ;;

3)      update_openssl
        ;;

4)     update_openssh
        ;;

5)     update_sshssl1
        ;;

6)     update_sshssl2
        ;;

7)     update_sshssl3
        ;;

8)     update_sshssl4
        ;;

9)     update_sshssl5
        ;;

10)    update_sshssl6
        ;;

11)    update_sshssl7
        ;;

12)    update_sshssl8
        ;;

13)    update_sshssl9
        ;;

14)    update_sshssl10
        ;;

0)     set_et
       ;;

*)      echo -e "\n\e[1;31m输入无效!请输入正确的选项!!!\e[0m" 
        ;;
esac
done
}




install_prometheus(){
while :;do
    echo -e "\E[$[RANDOM%7+31];1m"
    cat << EOF




************************************************************
************************************************************
************************************************************
**********                                        ********** 
**********            安装prometheus              **********    
**********                                        **********
**********           1.返回上一目录               **********
**********                                        **********
**********           2.二进制安装                  **********
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

1)     break
       ;;

2)     install_prometheus1
        ;;

0)     set_et
       ;;

*)      echo -e "\n\e[1;31m输入无效!请输入正确的选项!!!\e[0m" 
        ;;
esac
done
}








installService(){
	while :;do
	echo -e "\E[$[RANDOM%7+31];1m"
	cat << EOF


************************************************************
************************************************************
************************************************************
************************************************************
**********                                        **********
**********              安装服务                  **********
**********                                        **********
**********           1.返回上一目录               **********
**********                                        **********
**********           2.安装数据库                 **********
**********           3.安装Nginx                  **********
**********           4.升级安装openssl,openssh    **********
**********           5.安装docker                 **********
**********           6.安装clickhouse             **********
**********           7.安装Redis                  **********
**********           8.安装keepalived             **********
**********           9.安装jumpserver             **********
**********           10.安装zabbix                **********
**********           11.安装DNS                   **********
**********           12.安装kubernetes            **********
**********           13.安装prometheus            **********
**********           14.安装telnet                **********
**********           15.安装LNMP                  **********
**********                                        **********
**********           0.退出                       **********
**********                                        **********
************************************************************
************************************************************
************************************************************


EOF
	echo -e "\E[0m"



read -p "$(echo -e '\e[1;36m请输入序号:  \e[0m')" Menu

case $Menu in

2)      install_Database
	    ;;

3)      install_NGINX
        ;;

4)      install_SSHSSL
        ;;

5)      install_docker
        ;;

6)      install_clickhouse
        ;;

7)      install_redis
        ;;

8)      install_keepalived
        ;;

9)      install_jumpserver
        ;;

10)     install_zabbix
        ;;

11)     install_dns
        ;;

12)     install_kubernetes
        ;;

13)     install_prometheus
        ;;

14)     install_telnet
        ;;

15)     install_lnmp
        ;;

39)     install_haproxy
        ;;

40)     install_jenkins
        ;;

41)     install_halo
        ;;

42)     install_lua
        ;;

43)     install_gitlab
        ;;

44)     install_git
        ;;

45)     install_wordpress
        ;;

46)     install_apache
        ;;

47)     install_jdk
        ;;

48)     install_php
        ;;

49)     install_phpadmin
        ;;

50)     install_memcached
        ;;

1)      break
        ;;

0)	set_et
	;;

*)      echo -e "\n\e[1;31m输入无效!请输入正确的选项!!!\e[0m" 
        ;;
esac
done

}
















setAll(){
while :;do
    echo -e  "\E[$[RANDOM%7+31];1m"
    cat << EOF


************************************************************
************************************************************
************************************************************
**********                                        ********** 
**********              系统设置                  ********** 
**********                                        **********
**********  1.返回上一目录                        **********
**********                                        **********
**********  2.关闭防火墙         3.关闭SELINUX    **********
**********  4.安装初始化软件     5.配置yum,apt源  **********
**********         ====================           **********
**********  6.网卡配置           7.修改别名       **********
**********  8.修改主机名颜色     9.修改主机名     **********
**********         ====================           **********
**********  10.设置vim           11.设置时区      **********
**********  12.设置登录显示      13.矫正软件时间  **********
**********         ====================           **********
**********  14.矫正硬件时间      15.垃圾桶        **********
**********  16.设置邮箱          17.优化ulimit    **********
**********         ====================           **********
**********  18.禁用swap          19.启用swap      **********
**********  20.修改ssh端口号     21.ubuntu远程登录**********
*********         ====================            **********
**********  22.sshpass验证       23.ssh登录显示   **********
**********  24.邮箱告警                           **********
**********                                        **********
**********  0.退出                                **********
************************************************************       
************************************************************
************************************************************
EOF
    echo -e "\E[0m"

read -p "$(echo -e '\e[1;36m请输入序号: \e[0m')" Menu 
case $Menu in


2)      setFirewalld
        ;;

3)      disableSelinux
        ;;

4)      software
        ;;

5)      set_yum
        ;;

6)      set_net
        ;;

7)      set_alias
        ;;

8)      reset_PS1
        ;;

9)      set_hostname
        ;;

10)     set_vim
        ;;

11)     set_timezone
        ;;

12)     set_motd1
        ;;

13)     time1
        ;;

14)     time2
        ;;

15)     set_rm
        ;;

16)     set_mail
        ;;

17)     set_ulimit
        ;;

18)     stop_swap
        ;;

19)     start_swap
        ;;

20)     set_ssh
        ;;

21)     ubuntu_root_login
        ;;

22)     sshpass_key
        ;;

23)     ssh_auth
        ;;

24)     mail_alarm
        ;;

1)      break
        ;;

0)      set_et
        ;;

*)      echo -e "\n\e[1;31m请输入无效!请输入正确的选项!!!!!!\e[0m" 
        ;;
esac
done

}






while :;do
	echo -e "\E[$[RANDOM%7+31];1m"
	cat << EOF
************************************************************
************************************************************
************************************************************
**********                                        **********
**********            Linux运维脚本               **********
**********                                        **********
**********            1.帮助/快捷使用             **********
**********                                        **********
**********                                        **********
**********            2.系统设置                  **********
**********            3.安装服务                  **********
**********            4.一键初始化                **********
**********            5.centos7配置初始化         **********
**********            6.更新日志                  **********
**********            7.系统信息                  **********
**********            8.重启                      **********
**********            9.关机                      **********
**********                                        **********
**********                                        **********
**********                                        **********
**********            0.退出                      **********
**********                                        **********
************************************************************
************************************************************
************************************************************

EOF
	echo -e "\E[0m"

read -p "$(echo -e '\e[1;34m输入选项:  \e[0m')" option
case $option in

2)
	setAll
	;;

3)	installService
	;;

4)      setReset
        ;;

5)      oneStep
        ;;

6)      updateLog
        ;;

7)      systemInfo
        ;;

8)      re
        ;;

9)      shut
        ;;

1)      help1
        ;;

0) 	set_et
	;;

*)      echo -e "\n\e[1;31m输入无效!请输入正确的选项!!!\e[0m"
        ;;
esac
done