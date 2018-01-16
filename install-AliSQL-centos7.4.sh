#安装必要的依赖
 yum remove mysql
 yum install gcc gcc-c++ ncurses-devel perl perl-Data-Dumper cmake bison zip -y
 groupadd mysql
 useradd -r -g mysql mysql
 mkdir -p /usr/local/mysql
 mkdir -p /data/mysqldb
 #解压在opt目录下的源码,前提是AliSQL-master.zip已经存在,因为git下载太慢,所以直接scp上传的
 cd /opt
 unzip AliSQL-master.zip
 cd AliSQL-master
 #编译
 cmake -DCMAKE_INSTALL_PREFIX=/usr/local/mysql -DMYSQL_UNIX_ADDR=/usr/local/mysql/mysql.sock -DDEFAULT_CHARSET=utf8 -DDEFAULT_COLLATION=utf8_general_ci -DWITH_INNOBASE_STORAGE_ENGINE=1 -DWITH_ARCHIVE_STORAGE_ENGINE=1 -DWITH_BLACKHOLE_STORAGE_ENGINE=1 -DMYSQL_DATADIR=/data/mysqldb -DMYSQL_TCP_PORT=3306 -DENABLE_DOWNLOADS=1
 make
 make install
 #编译结束,开始配置
 cd /usr/local/mysql
 chown -R mysql:mysql
 chown -R mysql:mysql .
 cd /data/mysqldb
 chown -R mysql:mysql .
 cd /usr/local/mysql
 scripts/mysql_install_db --user=mysql --datadir=/data/mysqldb
 cp /usr/local/mysql/support-files/my-default.cnf /etc/my.cnf
 cp support-files/mysql.server /etc/init.d/mysqld
 #添加mysql的路径到全局PATH中
 echo "PATH=/usr/local/mysql/bin:/usr/local/mysql/lib:$PATH">>/etc/profile
 source /etc/profile
 #启动服务
 service mysqld start
 chkconfig --level 35 mysqld on
 mysql -u root -p
 ./bin/mysqladmin -u root password 'root'
 mysql -u root -p
 echo "username:root \n password:root" > defautAccount.txt
 #防火墙开放3306端口
 firewall-cmd --zone=public --add-port=3306/tcp --permanent
 firewall-cmd --reload
