#!/usr/bin/env python3
print('''
Linux 运维脚本,基于csh.sh脚本进行Python重构
重构时间:2025-02-26
''')

def set_all():
    print('Linux系统设置构建中')

def service_install():
    print('服务安装构建中')


def main():
    while True:
        print("""
        Linux 运维脚本
        1.设置Linux系统配置
        2.服务安装
        0.退出
        """)
        try:
            csh_all = int(input('请输入功能菜单序号: '))
        except ValueError:
            print('输入错误! 请输入数字。')
            continue  # 继续循环，不退出

        if csh_all == 1:
            set_all()
        elif csh_all == 2:
            service_install()
        elif csh_all == 0:
            print("退出")
            break
        else:
            print('输入错误!')
if __name__ == "__main__":
    main()