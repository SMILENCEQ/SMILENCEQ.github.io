package main

import (
	"bufio"
	"fmt"
	"os"
	"os/exec"
	"regexp"
	"strconv"
	"strings"
	"time"
)


func main() {
	for {
		fmt.Println("\033[1;35m") // 随机颜色可能在 Go 中不太适用，这里用红色
		fmt.Println(`
============================================================

  ███████╔ ████████═ ██╗   ██╗ 
 ██══════╝ ██ ╔══════██║   ██║ 
██         ████████═ ████████║ 
╚██        ╚════ ██  ██║   ██║ 
  ███████╔ ████████  ██║   ██║ 
  ╚══════╝ ╚════════╝╚═╝   ╚═╝                  
                                    Linux

--- csh - Linux初始化脚本和服务程序安装脚本
--- version: v0.0.2
--- https://github.com/SMILENCEQ/SMILENCEQ.github.io
Updated by HE-handsome
路漫漫其修远兮，吾将上下而求索
脚本编写纯属个人爱好，生产环境需要自己斟酌使用\e[0m
============================================================

************************************************************
************************************************************
************************************************************
**********                                        **********
**********           Linux运维脚本                **********
**********                                        **********
**********            1.系统设置                  **********
**********            2.安装服务                  **********
**********            3.一键初始化                **********
**********            4.centos7配置初始化         **********
**********            5.更新日志                  **********
**********            6.系统信息                  **********
**********            7.重启                      **********
**********            8.关机                      **********
**********                                        **********
**********            0.退出                      **********
**********                                        **********
************************************************************
************************************************************
************************************************************
`)
		fmt.Println("\033[0m")

		var option int
		reader := bufio.NewReader(os.Stdin)
		fmt.Print("\033[1;36m请输入序号: \033[0m")
		input, err := reader.ReadString('\n')
		if err != nil {
			fmt.Println("\n\033[1;31m读取错误:\033[0m", err)
			continue
		}

		input = strings.TrimSpace(input) // 去除输入中的换行符和多余空白
		if input == "" {
			fmt.Println("\n\033[1;31m输入不能为空\033[0m")
			continue
		}

		option, err = strconv.Atoi(input)
		if err != nil {
			fmt.Println("\n\033[1;31m输入错误:请输入一个有效的选项\033[0m")
			continue
		}
		switch option {
		case 1:
			setAll()
		case 2:
			installService()
		case 0:
			fmt.Println("\n\033[1;35mGoodbye!\033[0m")
			os.Exit(0)
		default:
			fmt.Println("\n\033[1;31m无效的选项\033[0m")
		}
	}
}

func installService() {
	for {
		fmt.Println("\033[1;31m") // 随机颜色处理
		fmt.Println(`
************************************************************
************************************************************
************************************************************
************************************************************
**********                                        **********
**********              安装服务                  **********
**********                                        **********
**********           1.返回上一目录               **********
**********                                        **********
**********           2.安装Database               **********
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
**********                                        **********
**********           0.退出                       **********
**********                                        **********
************************************************************
************************************************************
************************************************************
`)
		fmt.Println("\033[0m")

		var choice int
		reader := bufio.NewReader(os.Stdin)
		fmt.Print("\033[1;36m请输入序号: \033[0m")
		input, err := reader.ReadString('\n')
		if err != nil {
			fmt.Println("\n\033[1;31m读取错误:\033[0m", err)
			continue
		}

		input = strings.TrimSpace(input) // 去除输入中的换行符和多余空白
		if input == "" {
			fmt.Println("\n\033[1;31m输入不能为空\033[0m")
			continue
		}

		choice, err = strconv.Atoi(input)
		if err != nil {
			fmt.Println("\n\033[1;31m输入错误:请输入一个有效的选项\033[0m")
			continue
		}

		switch choice {
		case 1:
			// 返回上一目录的逻辑
			return
		case 2:
			installDatabase()
		case 3:
			installNginx()
		case 4:
			installSshssl()
		case 0:
			fmt.Println("\n\033[1;35mGoodbye!\033[0m")
			os.Exit(0)
		default:
			fmt.Println("\n\033[1;31m无效的选项\033[0m")
		}
	}
}

func installNginx() {
	fmt.Println("loading...")
}

func installSshssl() {
	for {
		fmt.Println("\033[1;31m") // 随机颜色处理
		fmt.Println(`
============================================================
**********以下支持在centos7系列使用*************
3.升级openssl到1.1.1w版本
4.升级openssh到9.7p1版本
5 适用于从openssl1.*版本升级到openssl1.1.1w,openssh9.7p1
6 适用于从openssl1.*版本升级到openssl3.3.0,openssh9.7p1
7.适用于从openssl3.*版本升级到openssl3.3.1,openssh9.8p1
8.适用于从openssl1.*版本升级到openssl3.3.1,openssh9.8p1
**********以下支持在centos6系列使用*************
9.适用于从openssl1.*版本升级到openssl3.3.1,openssh9.8p1
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
**********                                        **********
**********           0.退出                       ********** 
**********                                        **********
************************************************************
************************************************************
************************************************************
`)
		fmt.Println("\033[0m")

		var choice int
		reader := bufio.NewReader(os.Stdin)
		fmt.Print("\033[1;36m请输入序号: \033[0m")
		input, err := reader.ReadString('\n')
		if err != nil {
			fmt.Println("\n\033[1;31m读取错误:\033[0m", err)
			continue
		}

		input = strings.TrimSpace(input) // 去除输入中的换行符和多余空白
		if input == "" {
			fmt.Println("\n\033[1;31m输入不能为空\033[0m")
			continue
		}

		choice, err = strconv.Atoi(input)
		if err != nil {
			fmt.Println("\n\033[1;31m输入错误:请输入一个有效的选项\033[0m")
			continue
		}

		switch choice {
		case 1:
			// 返回上一目录的逻辑
			return
		case 2:
			installTelnet()
		case 3:
			updateOpenssl()
		case 4:
			updateOpenssh()
		case 0:
			fmt.Println("\n\033[1;35mGoodbye!\033[0m")
			os.Exit(0)
		default:
			fmt.Println("\n\033[1;31m无效的选项\033[0m")
		}
	}
}

func setAll() {
	for {
		fmt.Println("\033[1;31m") // 随机颜色处理
		fmt.Println(`
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
`)
		fmt.Println("\033[0m")

		var choice int
		reader := bufio.NewReader(os.Stdin)
		fmt.Print("\033[1;36m请输入序号: \033[0m")
		input, err := reader.ReadString('\n')
		if err != nil {
			fmt.Println("\n\033[1;31m读取错误:\033[0m", err)
			continue
		}

		input = strings.TrimSpace(input) // 去除输入中的换行符和多余空白
		if input == "" {
			fmt.Println("\n\033[1;31m输入不能为空\033[0m")
			continue
		}

		choice, err = strconv.Atoi(input)
		if err != nil {
			fmt.Println("\n\033[1;31m输入错误:请输入一个有效的选项\033[0m")
			continue
		}

		switch choice {
		case 1:
			// 返回上一目录的逻辑
			return
		case 2:
			setFirewalld()
		case 3:
			disableSelinux()
		case 4:
			software()
		case 5:
			setYum()
		case 6:
			setNet()
		case 7:
			setAlias()
		case 8:
			resetPs1()
		case 9:
			setHostname()
		case 10:
			setVim()
		case 11:
			setTimezone()
		case 12:
			setMotd1()
		case 13:
			time1()
		case 14:
			time2()
		case 15:
			setRm()
		case 16:
			setMail()
		case 17:
			setUlimit()
		case 18:
			stopSwap()
		case 19:
			startSwap()
		case 20:
			setSsh()
		case 21:
			ubuntuRootlogin()
		case 22:
			sshpassKey()
		case 23:
			sshAuth()
		case 24:
			mailAlarm()
		case 0:
			fmt.Println("\n\033[1;35mGoodbye!\033[0m")
			os.Exit(0)
		default:
			fmt.Println("\n\033[1;31m无效的选项\033[0m")
		}
	}
}

func installDatabase() {
	// 安装数据库的逻辑
	for {
		fmt.Println("\033[1;31m") // 随机颜色处理
		fmt.Println(`
************************************************************
************************************************************
************************************************************
************************************************************
**********                                        **********
**********             安装数据库                 **********
**********                                        **********
**********           1.返回上一目录               **********
**********                                        **********
**********           2.二进制安装MySQL            **********
**********                                        **********
**********           0.退出                       **********
**********                                        **********
************************************************************
************************************************************
************************************************************
`)
		fmt.Println("\033[0m")

		var choice int
		reader := bufio.NewReader(os.Stdin)
		fmt.Print("\033[1;36m请输入序号: \033[0m")
		input, err := reader.ReadString('\n')
		if err != nil {
			fmt.Println("\n\033[1;31m读取错误:\033[0m", err)
			continue
		}

		input = strings.TrimSpace(input) // 去除输入中的换行符和多余空白
		if input == "" {
			fmt.Println("\n\033[1;31m输入不能为空\033[0m")
			continue
		}

		choice, err = strconv.Atoi(input)
		if err != nil {
			fmt.Println("\n\033[1;31m输入错误:请输入一个有效的选项\033[0m")
			continue
		}

		switch choice {
		case 1:
			// 返回上一目录的逻辑
			return
		case 2:
			installMysql()
		case 0:
			fmt.Println("\n\033[1;35mGoodbye!\033[0m\n")
			os.Exit(0)
		default:
			fmt.Println("\n\033[1;31m无效的选项\033[0m")
		}
	}

}
func installMysql() {
	//
	fmt.Println("Setting installMysql...")
}
func setFirewalld() {
	for {
		fmt.Println("\033[1;31m") // 随机颜色处理
		fmt.Println(`
************************************************************
************************************************************
************************************************************
************************************************************
**********                                        **********
**********              关闭防火墙                **********
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
`)
		fmt.Println("\033[0m")

		var choice int
		reader := bufio.NewReader(os.Stdin)
		fmt.Print("\033[1;36m请输入序号: \033[0m")
		input, err := reader.ReadString('\n')
		if err != nil {
			fmt.Println("\n\033[1;31m读取错误:\033[0m", err)
			continue
		}

		input = strings.TrimSpace(input) // 去除输入中的换行符和多余空白
		if input == "" {
			fmt.Println("\n\033[1;31m输入不能为空\033[0m")
			continue
		}

		choice, err = strconv.Atoi(input)
		if err != nil {
			fmt.Println("\n\033[1;31m输入错误:请输入一个有效的选项\033[0m")
			continue
		}

		switch choice {
		case 1:
			// 返回上一目录的逻辑
			return
		case 2:
			disableFirewalld()
		case 3:
			stopCentos6Firewalld()
		case 0:
			fmt.Println("\n\033[1;35mGoodbye!\033[0m")
			os.Exit(0)
		default:
			fmt.Println("\n\033[1;31m无效的选项\033[0m")
		}
	}

}

func software() {
	for {
		fmt.Println("\033[1;31m") // 随机颜色处理
		fmt.Println(`
************************************************************
************************************************************
************************************************************
************************************************************
**********                                        **********
**********            安装初始化软件              **********
**********                                        **********
**********           1.返回上一目录               **********
**********                                        **********
**********           2.Redhat7,8系列              **********
**********           3.Redhat6系列                **********
**********           4.Ubuntu系列                 **********
**********                                        **********
**********           0.退出                       **********
**********                                        **********
************************************************************
************************************************************
************************************************************
`)
		fmt.Println("\033[0m")

		var choice int
		reader := bufio.NewReader(os.Stdin)
		fmt.Print("\033[1;36m请输入序号: \033[0m")
		input, err := reader.ReadString('\n')
		if err != nil {
			fmt.Println("\n\033[1;31m读取错误:\033[0m", err)
			continue
		}

		input = strings.TrimSpace(input) // 去除输入中的换行符和多余空白
		if input == "" {
			fmt.Println("\n\033[1;31m输入不能为空\033[0m")
			continue
		}

		choice, err = strconv.Atoi(input)
		if err != nil {
			fmt.Println("\n\033[1;31m输入错误:请输入一个有效的选项\033[0m")
			continue
		}

		switch choice {
		case 1:
			// 返回上一目录的逻辑
			return
		case 2:
			c7Software()
		case 3:
			c6Software()
		case 4:
			ubuntuSoftware()
		case 0:
			fmt.Println("\n\033[1;35mGoodbye!\033[0m")
			os.Exit(0)
		default:
			fmt.Println("\n\033[1;31m无效的选项\033[0m")
		}
	}

}

func setYum() {
	for {
		fmt.Println("\033[1;31m") // 随机颜色处理
		fmt.Println(`
************************************************************
************************************************************
************************************************************
************************************************************
**********                                        **********
**********             配置yum源                  **********
**********                                        **********
**********         1.返回上一目录                 **********
**********                                        ********** 
**********         2.配置Rocky8 yum源             **********
**********         3.配置Rocky8 yum源             **********
**********         4.配置Rocky8 EPEL源            **********
**********         =======================        **********
**********         5.配置centos7 源               **********
**********         =======================        **********
**********         6.配置centos6.10 yum源         **********
**********         7.配置centos6 EPEL源           **********
**********         8.配置centos6.5 yum源          **********
**********         9.配置centos6.6 yum源          **********
**********         =======================        **********
**********         10.配置ubuntu apt源            **********
**********                                        **********
**********           0.退出                       **********
**********                                        **********
************************************************************
************************************************************
************************************************************
`)
		fmt.Println("\033[0m")

		var choice int
		reader := bufio.NewReader(os.Stdin)
		fmt.Print("\033[1;36m请输入序号: \033[0m")
		input, err := reader.ReadString('\n')
		if err != nil {
			fmt.Println("\n\033[1;31m读取错误:\033[0m", err)
			continue
		}

		input = strings.TrimSpace(input) // 去除输入中的换行符和多余空白
		if input == "" {
			fmt.Println("\n\033[1;31m输入不能为空\033[0m")
			continue
		}

		choice, err = strconv.Atoi(input)
		if err != nil {
			fmt.Println("\n\033[1;31m输入错误:请输入一个有效的选项\033[0m")
			continue
		}

		switch choice {
		case 1:
			// 返回上一目录的逻辑
			return
		case 2:
			setYum2Rocky8()
		case 3:
			setYUmRocky8()
		case 4:
			setEpelRocky8()
		case 5:
			setCentos7Yum()
		case 6:
			setYumCentos610()
		case 7:
			setEpelCentos6()
		case 8:
			setYumCentos65()
		case 9:
			setYumCentos66()
		case 10:
			ubuntuSource()
		case 0:
			fmt.Println("\n\033[1;35mGoodbye!\033[0m")
			os.Exit(0)
		default:
			fmt.Println("\n\033[1;31m无效的选项\033[0m")
		}
	}

}

func setYum2Rocky8() {
	fmt.Println("loading...")
}
func setYUmRocky8() {
	fmt.Println("loading...")
}
func setEpelRocky8() {
	fmt.Println("loading...")
}

func setCentos7Yum() {
	for {
		fmt.Println("\033[1;31m") // 随机颜色处理
		fmt.Println(`
************************************************************
************************************************************
************************************************************
************************************************************
**********                                        **********
**********            centos7                     **********
**********                                        **********
**********         1.返回上一目录                 **********
**********                                        ********** 
**********         2.配置EPEL源                   **********
**********         3.配置阿里源                   **********
**********         4.配置清华源                   **********
**********         5.配置网易源                   **********
**********         6.配置华为源                   **********
**********         7.配置南京大学源               **********
**********         8.配置所有源(无挂载磁盘)       **********
**********         9.配置所有源(有挂载磁盘)       **********
**********                                        **********
**********           0.退出                       **********
**********                                        **********
************************************************************
************************************************************
************************************************************
`)
		fmt.Println("\033[0m")
		var choice int
		reader := bufio.NewReader(os.Stdin)
		fmt.Print("\033[1;36m请输入序号: \033[0m")
		input, err := reader.ReadString('\n')
		if err != nil {
			fmt.Println("\n\033[1;31m读取错误:\033[0m", err)
			continue
		}

		input = strings.TrimSpace(input) // 去除输入中的换行符和多余空白
		if input == "" {
			fmt.Println("\n\033[1;31m输入不能为空\033[0m")
			continue
		}

		choice, err = strconv.Atoi(input)
		if err != nil {
			fmt.Println("\n\033[1;31m输入错误:请输入一个有效的选项\033[0m")
			continue
		}

		switch choice {
		case 1:
			// 返回上一目录的逻辑
			return
		case 2:
			setEpel()
		case 3:
			setAli()
		case 4:
			setQinghua()
		case 5:
			setWangyi()
		case 6:
			setHuawei()
		case 7:
			setNanjing()
		case 8:
			setYum3Centos7()
		case 9:
			setYum2Centos7()
		case 0:
			fmt.Println("\n\033[1;35mGoodbye!\033[0m")
			os.Exit(0)
		default:
			fmt.Println("\n\033[1;31m无效的选项\033[0m")
		}
	}

}

// 变量存储
type Variables struct {
	Version        string
	URL            string
	DataDir        string
	Dir            string
	SystemVersion  string
	ZlibVersion    string
	OpensslVersion string
	OpensshVersion string
	Date           string
	PerlVersion    string
}

func initializeVariables(action string) (Variables, error) {
	var vars Variables

	switch action {
	//case "install_mysql":
	//	vars.Version = "5.7.36"
	//	vars.URL = "https://downloads.mysql.com/archives/get/p/23/file/mysql-5.7.36-linux-glibc2.12-x86_64.tar.gz"
	//	vars.DataDir = "/data/mysql/"
	//	vars.Dir = "/usr/local/"
	//case "install_nginx1":
	//	vars.Version = "1.20.2"
	//	vars.URL = "http://nginx.org/download/nginx-1.20.2.tar.gz"
	//case "update_nginx":
	//	vars.Version = "1.22.1"
	//	vars.URL = "http://nginx.org/download/nginx-1.22.1.tar.gz"
	//case "update_srunnginx":
	//	vars.Version = "1.22.1"
	//	vars.URL = "http://nginx.org/download/nginx-1.22.1.tar.gz"
	//case "update_srunnginx2":
	//	vars.Version = "1.22.1"
	//	vars.URL = "http://nginx.org/download/nginx-1.22.1.tar.gz"
	case "update_openssl":
		OpensslVersion = "1.1.1w"
		URL = "https://www.openssl.org/source/old/1.1.1/openssl-1.1.1w.tar.gz"
		SystemVersion = getSystemVersion()
		Date = getCurrentDate()
	//case "update_openssh":
	//	vars.ZlibVersion = "1.3.1"
	//	vars.OpensshVersion = "9.7p1"
	//	vars.SystemVersion = getSystemVersion()
	//case "update_sshssl1":
	//	vars.ZlibVersion = "1.3.1"
	//	vars.OpensshVersion = "9.7p1"
	//	vars.OpensslVersion = "1.1.1w"
	//	vars.OpensslVersion1 = getOpensslVersion()
	//	vars.SystemVersion = getSystemVersion()
	//case "update_sshssl2":
	//	vars.OpensslVersion = "3.3.0"
	//	vars.OpensslVersion1 = getOpensslVersion()
	//	vars.SystemVersion = getSystemVersion()
	//	vars.ZlibVersion = "1.3.1"
	//	vars.OpensshVersion = "9.7p1"
	//	vars.Date = getCurrentDate()
	//case "update_sshssl3":
	//	vars.OpensslVersion = "3.3.1"
	//	vars.OpensslVersion1 = getOpensslVersion()
	//	vars.SystemVersion = getSystemVersion()
	//	vars.ZlibVersion = "1.3.1"
	//	vars.OpensshVersion = "9.8p1"
	//	vars.URL = "https://www.openssl.org/source/openssl-3.3.1.tar.gz"
	//	vars.Date = getCurrentDate()
	//case "update_sshssl4":
	//	vars.OpensslVersion = "3.3.1"
	//	vars.OpensslVersion1 = getOpensslVersion()
	//	vars.SystemVersion = getSystemVersion()
	//	vars.ZlibVersion = "1.3.1"
	//	vars.OpensshVersion = "9.8p1"
	//	vars.Date = getCurrentDate()
	//case "update_sshssl5":
	//	vars.Date = getCurrentDate()
	//	vars.OpensslVersion = "3.3.1"
	//	vars.OpensshVersion = "9.8p1"
	//	vars.PerlVersion = "5.36.0"
	//	vars.OpensslVersion1 = getOpensslVersion()
	//	vars.SystemVersion = getSystemVersion()
	default:
		return vars, fmt.Errorf("unknown function: %s", action)
	}

	return vars, nil
}

func getSystemVersion() string {
	out, err := exec.Command("sh", "-c", "cat /etc/redhat-release | sed -r 's/.* ([0-9]+)\\..*/\\1/'").Output()
	if err != nil {
		fmt.Printf("failed to get system version: %v\n", err)
		return ""
	}
	return strings.TrimSpace(string(out))
}

func OpensslVersion() string {
	out, err := exec.Command("openssl", "version").Output()
	if err != nil {
		fmt.Printf("failed to get openssl version: %v\n", err)
		return ""
	}
	return strings.Fields(string(out))[1]
}

func getCurrentDate() string {
	out, err := exec.Command("date", "+%Y%m%d%H%M%S").Output()
	if err != nil {
		fmt.Printf("failed to get current date: %v\n", err)
		return ""
	}
	return strings.TrimSpace(string(out))
}

//func main() {
//	vars, err := initializeVariables("update_openssl")
//	if err != nil {
//		fmt.Println(err)
//		return
//	}
//	fmt.Printf("Initialized variables: %+v\n", vars)
//
//	// You can now use the variables in `vars` for your installation/update logic.
//}

func installTelnet() {
	fmt.Println("loading...")
}

func updateOpenssl() {
	vars, err := initializeVariables("update_openssl")
	if err != nil {
		fmt.Println(err)
		return
	}
	fmt.Printf("Initialized variables: %+v\n", vars)
	fmt.Println("====================================================================")
	fmt.Println("现在已安装的版本")
	cmd := exec.Command("openssl", "version")
	cmd.Stdout = os.Stdout
	cmd.Stderr = os.Stderr
	if err := cmd.Run(); err != nil {
		fmt.Printf("failed to get openssl version: %v\n", err)
		return
	}

	fmt.Printf("本次安装的版本是openssl-%s\n", OpensslVersion)
	fmt.Println("====================================================================")
	fmt.Println("不想安装请在五秒内终止脚本")

	for i := 5; i > 0; i-- {
		fmt.Printf("%d ", i)
		time.Sleep(1 * time.Second)
	}
	fmt.Println()

	fmt.Println("==========================检查系统=====================================")
	if SystemVersion == "7" {
		fmt.Println("检测系统为centos7允许执行")
	} else {
		fmt.Println("检测系统不是centos7,脚本不支持")
		return
	}

	fmt.Println("==========================源文件检查================================")
	if _, err := os.Stat(fmt.Sprintf("openssl-%s.tar.gz", OpensslVersion)); err == nil {
		fmt.Println("文件存在")
	} else {
		fmt.Println("文件不存在，开始下载")
		cmd := exec.Command("wget", "--no-check-certificate", URL)
		cmd.Stdout = os.Stdout
		cmd.Stderr = os.Stderr
		if err := cmd.Run(); err != nil {
			fmt.Printf("failed to download openssl: %v\n", err)
			return
		}
	}

	fmt.Println("==========================安装依赖包================================")
	software := []string{
		"gcc",
		"gcc-c++",
		"glibc",
		"make",
	}

	for _, pkg := range software {
		cmd := exec.Command("rpm", "-q", pkg)
		if err := cmd.Run(); err != nil {
			fmt.Printf("%s\t安装中...\n", pkg)
			cmd := exec.Command("yum", "-y", "install", pkg)
			cmd.Stdout = os.Stdout
			cmd.Stderr = os.Stderr
			if err := cmd.Run(); err != nil {
				fmt.Printf("failed to install %s: %v\n", pkg, err)
				return
			}
			fmt.Printf("%s\t安装成功\n", pkg)
		} else {
			fmt.Printf("%s\t已安装\n", pkg)
		}
	}

	fmt.Println("===========================解压,编译===============================")
	cmd = exec.Command("tar", "zxf", fmt.Sprintf("openssl-%s.tar.gz", OpensslVersion), "-C", "/root")
	cmd.Stdout = os.Stdout
	cmd.Stderr = os.Stderr
	if err := cmd.Run(); err != nil {
		fmt.Printf("failed to extract openssl: %v\n", err)
		return
	}

	cmd = exec.Command("sh", "-c", fmt.Sprintf("cd /root/openssl-%s && ./config --prefix=/usr/local/openssl -d shared && make && make install", OpensslVersion))
	cmd.Stdout = os.Stdout
	cmd.Stderr = os.Stderr
	if err := cmd.Run(); err != nil {
		fmt.Printf("failed to compile and install openssl: %v\n", err)
		return
	}

	fmt.Println("============================备份旧文件================================")
	cmd = exec.Command("mv", "/usr/bin/openssl", "/usr/bin/openssl.bak")
	cmd.Stdout = os.Stdout
	cmd.Stderr = os.Stderr
	if err := cmd.Run(); err != nil {
		fmt.Printf("failed to backup old openssl: %v\n", err)
		return
	}

	fmt.Println("=========================对新的创建软连接==============================")
	cmd = exec.Command("ln", "-sf", "/usr/local/openssl/bin/openssl", "/usr/bin/openssl")
	cmd.Stdout = os.Stdout
	cmd.Stderr = os.Stderr
	if err := cmd.Run(); err != nil {
		fmt.Printf("failed to create symbolic link: %v\n", err)
		return
	}

	fmt.Println("==============================验证====================================")
	cmd = exec.Command("sh", "-c", "echo '/usr/local/openssl/lib' >> /etc/ld.so.conf && ldconfig -v")
	cmd.Stdout = os.Stdout
	cmd.Stderr = os.Stderr
	if err := cmd.Run(); err != nil {
		fmt.Printf("failed to update ldconfig: %v\n", err)
		return
	}

	fmt.Println("===============================升级后版本================================")
	cmd = exec.Command("openssl", "version")
	cmd.Stdout = os.Stdout
	cmd.Stderr = os.Stderr
	if err := cmd.Run(); err != nil {
		fmt.Printf("failed to get new openssl version: %v\n", err)
	}

}

func updateOpenssh() {
	fmt.Println("loading...")
}

func setEpel() {
	fmt.Println("loading...")
}

func setAli() {
	fmt.Println("loading...")
}

func setQinghua() {
	fmt.Println("loading...")
}

func setWangyi() {
	fmt.Println("loading...")
}

func setHuawei() {
	fmt.Println("loading...")
}

func setNanjing() {
	fmt.Println("loading...")
}

func setYum3Centos7() {
	// 创建备份目录
	backupDir := "/data/bak"
	if err := os.MkdirAll(backupDir, 0755); err != nil {
		fmt.Printf("创建备份目录失败: %v\n", err)
		return
	}

	// 备份旧的 yum 源文件
	files, err := os.ReadDir("/etc/yum.repos.d")
	if err != nil {
		fmt.Printf("读取 yum 源目录失败: %v\n", err)
		return
	}

	for _, file := range files {
		oldPath := "/etc/yum.repos.d/" + file.Name()
		newPath := backupDir + "/" + file.Name()
		if err := os.Rename(oldPath, newPath); err != nil {
			fmt.Printf("移动文件失败: %v\n", err)
			return
		}
	}
	fmt.Println("\033[1;35m备份旧的 yum 源文件\033[0m")
	// 写入新的 yum 源文件
	repoContent := `
[base]
name=CentOS
baseurl=https://mirror.tuna.tsinghua.edu.cn/centos/$releasever/os/$basearch/
        https://mirrors.huaweicloud.com/centos/$releasever/os/$basearch/
        https://mirrors.cloud.tencent.com/centos/$releasever/os/$basearch/
        https://mirrors.aliyun.com/centos/$releasever/os/$basearch/
gpgcheck=0

[extras]
name=extras
baseurl=https://mirror.tuna.tsinghua.edu.cn/centos/$releasever/extras/$basearch
        https://mirrors.huaweicloud.com/centos/$releasever/extras/$basearch
        https://mirrors.cloud.tencent.com/centos/$releasever/extras/$basearch
        https://mirrors.aliyun.com/centos/$releasever/extras/$basearch
       
gpgcheck=0
enabled=1


[epel]
name=EPEL
baseurl=https://mirror.tuna.tsinghua.edu.cn/epel/$releasever/$basearch
        https://mirrors.cloud.tencent.com/epel/$releasever/$basearch/
        https://mirrors.huaweicloud.com/epel/$releasever/$basearch 
        https://mirrors.cloud.tencent.com/epel/$releasever/$basearch
        http://mirrors.aliyun.com/epel/\$releasever/$basearch
gpgcheck=0
enabled=1
`
	repoFilePath := "/etc/yum.repos.d/base.repo"
	if err := os.WriteFile(repoFilePath, []byte(repoContent), 0644); err != nil {
		fmt.Printf("写入新的 yum 源文件失败: %v\n", err)
		return
	}
	fmt.Println("\033[1;35m写入新的 yum 源文件\033[0m")

	///// 执行 yum 命令
	//commands := []string{"yum", "clean", "all"}
	//if err := exec.Command(commands[0], commands[1:]...).Run(); err != nil {
	//	fmt.Printf("执行 'yum clean all' 失败: %v\n", err)
	//	return
	//}
	//
	//commands = []string{"yum", "makecache"}
	//if err := exec.Command(commands[0], commands[1:]...).Run(); err != nil {
	//	fmt.Printf("执行 'yum makecache' 失败: %v\n", err)
	//	return
	//}
	//
	//commands = []string{"yum", "repolist"}
	//if out, err := exec.Command(commands[0], commands[1:]...).Output(); err != nil {
	//	fmt.Printf("执行 'yum repolist' 失败: %v\n", err)
	//	fmt.Printf("输出: %s\n", string(out))
	//	return
	//} else {
	//	fmt.Printf("yum repolist 输出:\n%s\n", string(out))
	//}
	//
	//fmt.Println("\033[1;35myum 源配置完毕!\033[0m")
	// 执行 yum 命令
	runCommand := func(name string, args ...string) error {
		cmd := exec.Command(name, args...)
		output, err := cmd.CombinedOutput()
		if err != nil {
			fmt.Printf("执行命令 '%s' 失败: %v\n", name, err)
			fmt.Printf("输出: %s\n", output)
			return err
		}
		fmt.Printf("命令 '%s' 输出:\n%s\n", name, output)
		return nil
	}

	if err := runCommand("yum", "clean", "all"); err != nil {
		return
	}

	if err := runCommand("yum", "makecache"); err != nil {
		return
	}

	if err := runCommand("yum", "repolist"); err != nil {
		return
	}

}

func setYum2Centos7() {
	fmt.Println("loading...")
}

func setYumCentos610() {
	// 创建备份目录
	backupDir := "/data/bak"
	if err := os.MkdirAll(backupDir, 0755); err != nil {
		fmt.Printf("创建备份目录失败: %v\n", err)
		return
	}

	// 备份旧的 yum 源文件
	files, err := os.ReadDir("/etc/yum.repos.d")
	if err != nil {
		fmt.Printf("读取 yum 源目录失败: %v\n", err)
		return
	}

	for _, file := range files {
		oldPath := "/etc/yum.repos.d/" + file.Name()
		newPath := backupDir + "/" + file.Name()
		if err := os.Rename(oldPath, newPath); err != nil {
			fmt.Printf("移动文件失败: %v\n", err)
			return
		}
	}

	fmt.Println("备份旧的 yum 源文件")

	// 写入新的 yum 源文件
	repoContent := `
[base]
name=CentOS-vault-6.10 - Base - mirrors.aliyun.com
failovermethod=priority
baseurl=http://mirrors.aliyun.com/centos-vault/6.10/os/$basearch/
        http://mirrors.aliyuncs.com/centos-vault/6.10/os/$basearch/
        http://mirrors.cloud.aliyuncs.com/centos-vault/6.10/os/$basearch/
gpgcheck=1
gpgkey=http://mirrors.aliyun.com/centos-vault/RPM-GPG-KEY-CentOS-6

#released updates 
[updates]
name=CentOS-vault-6.10 - Updates - mirrors.aliyun.com
failovermethod=priority
baseurl=http://mirrors.aliyun.com/centos-vault/6.10/updates/$basearch/
        http://mirrors.aliyuncs.com/centos-vault/6.10/updates/$basearch/
        http://mirrors.cloud.aliyuncs.com/centos-vault/6.10/updates/$basearch/
gpgcheck=1
gpgkey=http://mirrors.aliyun.com/centos-vault/RPM-GPG-KEY-CentOS-6

#additional packages that may be useful
[extras]
name=CentOS-vault-6.10 - Extras - mirrors.aliyun.com
failovermethod=priority
baseurl=http://mirrors.aliyun.com/centos-vault/6.10/extras/$basearch/
        http://mirrors.aliyuncs.com/centos-vault/6.10/extras/$basearch/
        http://mirrors.cloud.aliyuncs.com/centos-vault/6.10/extras/$basearch/
gpgcheck=1
gpgkey=http://mirrors.aliyun.com/centos-vault/RPM-GPG-KEY-CentOS-6

#additional packages that extend functionality of existing packages
[centosplus]
name=CentOS-vault-6.10 - Plus - mirrors.aliyun.com
failovermethod=priority
baseurl=http://mirrors.aliyun.com/centos-vault/6.10/centosplus/$basearch/
        http://mirrors.aliyuncs.com/centos-vault/6.10/centosplus/$basearch/
        http://mirrors.cloud.aliyuncs.com/centos-vault/6.10/centosplus/$basearch/
gpgcheck=1
enabled=0
gpgkey=http://mirrors.aliyun.com/centos-vault/RPM-GPG-KEY-CentOS-6

#contrib - packages by Centos Users
[contrib]
name=CentOS-vault-6.10 - Contrib - mirrors.aliyun.com
failovermethod=priority
baseurl=http://mirrors.aliyun.com/centos-vault/6.10/contrib/$basearch/
        http://mirrors.aliyuncs.com/centos-vault/6.10/contrib/$basearch/
        http://mirrors.cloud.aliyuncs.com/centos-vault/6.10/contrib/$basearch/
gpgcheck=1
enabled=0
gpgkey=http://mirrors.aliyun.com/centos-vault/RPM-GPG-KEY-CentOS-6
`

	repoFilePath := "/etc/yum.repos.d/CentOS-Base.repo"
	if err := os.WriteFile(repoFilePath, []byte(repoContent), 0644); err != nil {
		fmt.Printf("写入新的 yum 源文件失败: %v\n", err)
		return
	}

	fmt.Println("写入新的 yum 源文件")

	// 执行 yum 命令
	commands := []string{"yum", "clean", "all"}
	if err := exec.Command(commands[0], commands[1:]...).Run(); err != nil {
		fmt.Printf("执行 'yum clean all' 失败: %v\n", err)
		return
	}

	commands = []string{"yum", "makecache"}
	if err := exec.Command(commands[0], commands[1:]...).Run(); err != nil {
		fmt.Printf("执行 'yum makecache' 失败: %v\n", err)
		return
	}

	commands = []string{"yum", "repolist"}
	if out, err := exec.Command(commands[0], commands[1:]...).Output(); err != nil {
		fmt.Printf("执行 'yum repolist' 失败: %v\n", err)
		fmt.Printf("输出: %s\n", string(out))
		return
	} else {
		fmt.Printf("yum repolist 输出:\n%s\n", string(out))
	}

	fmt.Println("\033[1;35myum 源配置完毕!\033[0m")
}

func setEpelCentos6() {
	fmt.Println("loading...")
}

func setYumCentos65() {
	fmt.Println("loading...")
}

func setYumCentos66() {
	fmt.Println("loading...")
}

func ubuntuSource() {
	fmt.Println("loading...")
}

func c7Software() {
	// 打开 /etc/os-release 文件
	file, err := os.Open("/etc/os-release")
	if err != nil {
		fmt.Printf("打开 /etc/os-release 文件失败: %v\n", err)
		return
	}
	defer file.Close()

	var systemID string
	// 读取文件内容并查找 ID 行
	scanner := bufio.NewScanner(file)
	for scanner.Scan() {
		line := scanner.Text()
		if strings.HasPrefix(line, "ID=") {
			systemID = strings.TrimPrefix(line, "ID=")
			systemID = strings.Trim(systemID, `"`)
			break
		}
	}
	if err := scanner.Err(); err != nil {
		fmt.Printf("读取 /etc/os-release 文件失败: %v\n", err)
		return
	}
	fmt.Printf("系统ID: %s\n", systemID)

	if systemID == "centos" || systemID == "rocky" {
		software := []string{
			"lrzsz",
			"vim",
			"bash-completion",
			"wget",
			"tcpdump",
			"redhat-lsb-core",
			"psmisc",
			"rsync",
			"net-tools",
			"mlocate",
			"bzip2",
			"zip",
			"unzip",
			"lsof",
			"httpd-tools",
		}

		for _, s := range software {
			// 检查软件是否已安装
			checkCmd := exec.Command("rpm", "-q", s)
			if err := checkCmd.Run(); err == nil {
				fmt.Printf("%s\033[1;32m已安装\033[0m\n", s)
			} else {
				// 如果未安装，则安装软件
				installCmd := exec.Command("yum", "-y", "install", s)
				if err := installCmd.Run(); err == nil {
					fmt.Printf("%s\t\033[1;35m安装成功\033[0m\n", s)
				} else {
					fmt.Printf("%s\t\033[1;31m安装失败\033[0m\n", s)
				}
			}
		}
	} else {
		fmt.Println("\033[1;31m不是centos系统\033[0m")
	}
}

func c6Software() {
	// 打开 /etc/os-release 文件
	file, err := os.Open("/etc/redhat-release")
	if err != nil {
		fmt.Printf("打开 /etc/redhat-release 文件失败: %v\n", err)
		return
	}
	defer file.Close()

	var systemID string
	// 读取文件内容并查找 ID 行
	scanner := bufio.NewScanner(file)
	for scanner.Scan() {
		line := scanner.Text()
		if strings.HasPrefix(line, "ID=") {
			systemID = strings.TrimPrefix(line, "ID=")
			systemID = strings.Trim(systemID, `"`)
			break
		}
	}
	if err := scanner.Err(); err != nil {
		fmt.Printf("读取 /etc/redhat-release 文件失败: %v\n", err)
		return
	}
	fmt.Printf("系统ID: %s\n", systemID)

	if systemID == "centos" {
		software := []string{
			"lrzsz",
			"vim",
			"bash-completion",
			"wget",
			"tcpdump",
			"redhat-lsb-core",
			"psmisc",
			"rsync",
			"net-tools",
			"mlocate",
			"bzip2",
			"zip",
			"unzip",
			"lsof",
			"httpd-tools",
		}

		for _, s := range software {
			// 检查软件是否已安装
			checkCmd := exec.Command("rpm", "-q", s)
			if err := checkCmd.Run(); err == nil {
				fmt.Printf("%s\033[1;32m已安装\033[0m\n", s)
			} else {
				// 如果未安装，则安装软件
				installCmd := exec.Command("yum", "-y", "install", s)
				if err := installCmd.Run(); err == nil {
					fmt.Printf("%s\t\033[1;35m安装成功\033[0m\n", s)
				} else {
					fmt.Printf("%s\t\033[1;31m安装失败\033[0m\n", s)
				}
			}
		}
	} else {
		fmt.Println("\033[1;31m不是centos系统\033[0m")
	}

}

func ubuntuSoftware() {
	// 打开 /etc/os-release 文件
	file, err := os.Open("/etc/os-release")
	if err != nil {
		fmt.Printf("打开 /etc/os-release 文件失败: %v\n", err)
		return
	}
	defer file.Close()

	var systemID string
	// 读取文件内容并查找 ID 行
	scanner := bufio.NewScanner(file)
	for scanner.Scan() {
		line := scanner.Text()
		if strings.HasPrefix(line, "ID=") {
			systemID = strings.TrimPrefix(line, "ID=")
			systemID = strings.Trim(systemID, `"`)
			break
		}
	}
	if err := scanner.Err(); err != nil {
		fmt.Printf("读取 /etc/os-release 文件失败: %v\n", err)
		return
	}
	fmt.Printf("系统ID: %s\n", systemID)

	if systemID == "ubuntu" {
		software := []string{
			"lrzsz",
			"vim",
			"bash-completion",
			"wget",
			"tcpdump",
			"redhat-lsb-core",
			"psmisc",
			"rsync",
			"net-tools",
			"mlocate",
			"bzip2",
			"zip",
			"unzip",
			"lsof",
			"httpd-tools",
		}

		for _, s := range software {
			// 检查软件是否已安装
			checkCmd := exec.Command("dpdk", "-l", s)
			if err := checkCmd.Run(); err == nil {
				fmt.Printf("%s\033[1;32m已安装\033[0m\n", s)
			} else {
				// 如果未安装，则安装软件
				installCmd := exec.Command("apt", "-y", "install", s)
				if err := installCmd.Run(); err == nil {
					fmt.Printf("%s\t\033[1;35m安装成功\033[0m\n", s)
				} else {
					fmt.Printf("%s\t\033[1;31m安装失败\033[0m\n", s)
				}
			}
		}
	} else {
		fmt.Println("\033[1;31m不是ubuntu系统\033[0m")
	}

}

func disableFirewalld() {
	// 运行 systemctl disable --now firewalld 命令
	cmd := exec.Command("systemctl", "disable", "--now", "firewalld")
	err := cmd.Run()

	// 检查命令执行结果并打印相应的消息
	if err != nil {
		fmt.Println("防火墙关闭失败")
	} else {
		fmt.Println("防火墙关闭成功")
	}

}

func stopCentos6Firewalld() {
	// 运行 service iptables stop 命令
	cmd := exec.Command("service", "iptables", "stop")
	err := cmd.Run()

	// 检查命令执行结果并打印相应的消息
	if err != nil {
		fmt.Println("防火墙关闭失败")
	} else {
		fmt.Println("防火墙关闭成功")
	}
}

func disableSelinux() {
	// 关闭 SELINUX 的逻辑
	// 读取 /etc/selinux/config 文件内容
	configPath := "/etc/selinux/config"
	content, err := os.ReadFile(configPath)
	if err != nil {
		fmt.Printf("读取配置文件失败: %v\n", err)
		return
	}
	// 使用正则表达式替换 SELINUX=enforcing 为 SELINUX=disabled
	re := regexp.MustCompile(`SELINUX=enforcing`)
	modifiedContent := re.ReplaceAllString(string(content), "SELINUX=disabled")
	// 将修改后的内容写回文件
	err = os.WriteFile(configPath, []byte(modifiedContent), 0644)
	if err != nil {
		fmt.Printf("写入配置文件失败: %v\n", err)
		return
	}
	fmt.Println("SELINUX关闭完成")

	// 执行 setenforce 0 命令
	cmd := exec.Command("setenforce", "0")
	err = cmd.Run()
	if err != nil {
		fmt.Printf("临时禁用SELINUX失败: %v\n", err)
		return
	}

	fmt.Println("请务必重启！")
	fmt.Println("现在已经临时禁用，重启生效!")
}

func setNet() {
	//
	fmt.Println("loading...")
}

func setAlias() {
	//
	fmt.Println("loading...")
}

func resetPs1() {
	//
	fmt.Println("loading...")
}

func setHostname() {
	//
	fmt.Println("loading...")
}

func setVim() {
	//
	fmt.Println("loading...")
}

func setTimezone() {
	//
	fmt.Println("loading...")
}

func setMotd1() {
	//
	fmt.Println("loading...")
}

func time1() {
	//
	fmt.Println("loading...")
}

func time2() {
	//
	fmt.Println("loading...")
}

func setRm() {
	//
	fmt.Println("loading...")
}

func setMail() {
	//
	fmt.Println("loading...")
}

func setUlimit() {
	//
	fmt.Println("loading...")
}

func stopSwap() {
	//
	fmt.Println("loading...")
}

func startSwap() {
	//
	fmt.Println("loading...")
}

func setSsh() {
	//
	fmt.Println("loading...")
}

func ubuntuRootlogin() {
	//
	fmt.Println("loading...")
}

func sshpassKey() {
	//
	fmt.Println("loading...")
}

func sshAuth() {
	//
	fmt.Println("loading...")
}

func mailAlarm() {
	//
	fmt.Println("loading...")
}
