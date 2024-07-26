package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
	"strings"
)

func main() {
	for {
		fmt.Println("\033[1;35m") // 随机颜色可能在 Go 中不太适用，这里用红色
		fmt.Println(`
************************************************************
************************************************************
************************************************************
**********                                        **********
**********           Linux运维脚本                **********
**********                                        **********
**********            1.系统设置                  **********
**********            2.安装服务                  **********
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
	// 关闭防火墙的逻辑
	fmt.Println("Setting firewalld...")
}

func disableSelinux() {
	// 关闭 SELINUX 的逻辑
	fmt.Println("Disabling SELINUX...")
}
