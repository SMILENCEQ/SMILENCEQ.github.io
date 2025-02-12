#!/bin/bash
tar -C /usr/local -xzf go1.22.1.linux-amd64.tar.gz
cat >> ~/.bashrc <<'EOF'
export PATH=$PATH:/usr/local/go/bin
EOF

ln -s /root/command/cmd /usr/bin/cmd

echo -e "\n\e[1;32mcmd脚本运行方法: ./cmd 后跟上linux命令\e[0m"

source ~/.bashrc
exec bash