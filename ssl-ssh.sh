cd ~
#安装依赖关系
yum install -y pam-devel rpm-build
yum install -y perl-core libtemplate-perl zlib-devel gcc wget
#下载openssl
wget https://www.openssl.org/source/openssl-1.1.1e.tar.gz
#老版本的openssl
rm -rf /usr/bin/openssl/*
#解压	
tar zxvf openssl-1.1.1e.tar.gz
#进入文件夹
cd openssl-1.1.1e
./config --prefix=/usr/local/ssl
make&&make install
#处理库文件
echo "/usr/local/ssl/lib">>/etc/ld.so.conf
ldconfig -v
#处理命令文件
ln -s /usr/local/ssl/bin/openssl /usr/bin/openssl
ln -s /usr/local/ssl/include/openssl /usr/include/openssl
#检查版本
openssl version


cd ~

# 关闭Selinux
setenforce 0
sed -i "s/SELINUX=enforcing/SELINUX=disabled/g" /etc/selinux/config
# 卸载 openssh
rpm -qa |grep  openssh
for i in $(rpm -qa |grep openssh);do rpm -e $i --nodeps;done
# 安装 openssh
wget https://openbsd.hk/pub/OpenBSD/OpenSSH/portable/openssh-8.2p1.tar.gz
tar -xvf openssh-8.2p1.tar.gz
chown -R root.root openssh-8.2p1
cd openssh-8.2p1
./configure --prefix=/usr --sysconfdir=/etc/ssh --with-md5-passwords --with-pam --with-ssl-dir=/usr/local/ssl --without-hardening --with-zlib --with-tcp-wrappers
mv /etc/ssh /etc/ssh.old
cp contrib/redhat/sshd.pam /etc/pam.d/sshd
make && make install
#复制启动脚本到/etc/init.d
cp contrib/redhat/sshd.init /etc/init.d/sshd
chkconfig --add sshd
chkconfig sshd on
chkconfig --list|grep sshd
#sed -i "32a PermitRootLogin yes" /etc/ssh/sshd_config
echo "PermitRootLogin yes" >> /etc/ssh/sshd_config
echo "PasswordAuthentication yes"  >> /etc/ssh/sshd_config

cd ~
rm -rf openssh-8.2p1.tar.gz
rm -rf openssh-8.2p1
rm -rf openssl-1.1.1e.tar.gz
rm -rf openssl-1.1.1e

#检查版本
openssl version

ssh -V

#终端运行脚本可以重启ssh服务生效，如果是通过ssh连接进行操作的，需要重启服务器，脚本最后一条命令替换为：reboot
service sshd restart
#reboot


