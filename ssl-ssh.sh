cd ~
#安装依赖关系
yum update -y
yum upgrade -y
yum install -y pam-devel rpm-build
yum install -y perl-core libtemplate-perl zlib-devel gcc wget
#下载openssl
wget https://www.openssl.org/source/openssl-1.1.1d.tar.gz
#老版本的openssl放到另外一个目录
mkdir /root/openssl.bak
mv /usr/bin/openssl /root/openssl.bak
#解压	
tar zxvf openssl-1.1.1d.tar.gz
#进入文件夹
cd openssl-1.1.1d
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
#老版本的ssh放到另外一个目录
mkdir /root/ssh.bak
mv  /etc/ssh/* /root/ssh.bak/
# 安装 openssh
rm -rf /usr/lib/systemd/system/sshd.service
wget https://openbsd.hk/pub/OpenBSD/OpenSSH/portable/openssh-8.2p1.tar.gz
tar -xvf openssh-8.2p1.tar.gz
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
sed -i "32a PermitRootLogin yes" /etc/ssh/sshd_config
#终端运行脚本可以重启ssh服务生效，如果是通过ssh连接进行操作的，需要重启服务器，脚本最后一条命令替换为：reboot
service sshd restart
#reboot

cd ~
rm -rf openssh-8.2p1.tar.gz
rm -rf openssh-8.2p1
rm -rf openssl-1.1.1d.tar.gz
rm -rf openssl-1.1.1d

#检查版本
openssl version

ssh -V

