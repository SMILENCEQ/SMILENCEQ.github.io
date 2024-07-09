#!/bin/bash
rpm -qa mailutils || yum -y install mailutils
# 定义发送邮件的函数
send_email() {
    local subject=$1
    local body=$2
    local recipient="hping977@163.com"

    echo -e "$body" | mail -s "$subject" "$recipient"
}

# 获取系统信息的函数
get_system_info() {
    # 获取磁盘使用情况
    disk_usage=$(df -h  | awk 'NR==6{print "磁盘已用:"$3 "\n磁盘剩余可用:"$4"\n磁盘使用率:"$5}')
    disk_info="磁盘使用: $disk_usage"

    # 获取内存使用情况
    memory_info=$(free -h | awk 'NR==2{print "内存使用:"$3 "\n剩余可用:"$4}')

    echo -e "$disk_info\n$memory_info"
}

# 主函数
main() {
    while true; do
        system_info=$(get_system_info)
        send_email "系统资源监控" "$system_info"
        # 每小时发送一次报告
        sleep 3
    done
}

# 执行主函数
main

#chmod +x monitor.sh
#./monitor.sh
#nohup ./monitor.sh &
