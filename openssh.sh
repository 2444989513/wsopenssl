# 关闭Selinux
setenforce 0
sed -i "s/SELINUX=enforcing/SELINUX=disabled/g" /etc/selinux/config
# 卸载 openssh
rpm -qa |grep  openssh
for i in $(rpm -qa |grep openssh);do rpm -e $i --nodeps;done
#安装依赖关系
yum install -y gcc pam-devel rpm-build wget 
# 安装 openssh
wget https://openbsd.hk/pub/OpenBSD/OpenSSH/portable/openssh-8.1p1.tar.gz
tar -xvf openssh-8.1p1.tar.gz
cd openssh-8.1p1
./configure --prefix=/usr --sysconfdir=/etc/ssh --with-md5-passwords --with-pam --with-ssl-dir=/usr/local/ssl --without-hardening --with-zlib --with-tcp-wrappers
mv /etc/ssh /etc/ssh.old
cp contrib/redhat/sshd.pam /etc/pam.d/sshd
make && make install
#复制启动脚本到/etc/init.d
cp contrib/redhat/sshd.init /etc/init.d/sshd
chkconfig --add sshd
chkconfig sshd on
chkconfig --list|grep sshd
sed -i "32a PermitRootLogin yes" /etc/ssh/sshd_config
#终端运行脚本可以重启ssh服务生效，如果是通过ssh连接进行操作的，需要重启服务器，脚本最后一条命令替换为：reboot
#service sshd restart
reboot
