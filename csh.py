print('''
Linux 运维脚本,基于csh.sh脚本进行Python重构
重构时间:2025-02-26
''')

def set_all():
    print('构建中')

def service_install():
    print('构建中')

print("""
Linux 运维脚本
1.设置Linux系统配置
2.服务安装
""")

csh_all = int(input('请输入功能菜单序号: '))
if csh_all == 1:
    set_all()
elif csh_all == 2:
    service_install()
else:
    print('输入错误!')