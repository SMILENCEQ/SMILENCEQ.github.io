#!/bin/bash

# 配置数据库连接信息
DB_USER="root"
DB_PASSWORD="123456"
DB_NAME="database"
DB_TABLE="tmp_users"

# CSV文件路径
CSV_FILE="/root/202404.csv"
[ -e $CSV_FILE ] && echo -e "\e[1;35m $CSV_FILE文件不存在 \e[0m" || echo -e "\e[1;31m $CSV_FILE文件不存在 \e[0m"


# 创建一个临时SQL文件
TEMP_SQL_FILE="temp_load_data.sql"


# 创建临时SQL文件内容
echo "LOAD DATA LOCAL INFILE '$CSV_FILE' INTO TABLE $DB_TABLE" > $TEMP_SQL_FILE
echo "FIELDS TERMINATED BY ','" >> $TEMP_SQL_FILE
echo "ENCLOSED BY '\"'" >> $TEMP_SQL_FILE
echo "LINES TERMINATED BY '\n'" >> $TEMP_SQL_FILE
echo "IGNORE 1 ROWS" >> $TEMP_SQL_FILE
echo "(user_name, phone);" >> $TEMP_SQL_FILE



#创建临时表
mysql  -u$DB_USER -p$DB_PASSWORD $DB_NAME << EOF
DROP  TABLE IF EXISTS $DB_TABLE;
CREATE TABLE tmp_users (user_name VARCHAR(255) PRIMARY KEY, phone CHAR(11));
EOF

# 执行SQL文件
mysql --local-infile=1 -u$DB_USER -p$DB_PASSWORD $DB_NAME < $TEMP_SQL_FILE

#更新users表数据
mysql  -u$DB_USER -p$DB_PASSWORD $DB_NAME << EOF
UPDATE users u JOIN tmp_users tu ON u.user_name = tu.user_name SET u.phone = tu.phone;
EOF
# 删除临时SQL文件
rm $TEMP_SQL_FILE

echo "CSV数据已成功导入到表 $DB_TABLE 中"


