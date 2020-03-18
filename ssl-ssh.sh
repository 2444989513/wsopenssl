cd ~
#安装依赖关系
yum install -y pam-devel rpm-build
yum install -y perl-core libtemplate-perl zlib-devel gcc wget
#下载openssl
wget https://www.openssl.org/source/openssl-1.1.1e.tar.gz
#老版本的openssl放到另外一个目录
mkdir /root/openssl.bak
mv /usr/bin/openssl /root/openssl.bak
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

rm -rf /etc/ssh/*
rm -rf /usr/lib/systemd/system/sshd.service
# 安装 openssh
wget https://openbsd.hk/pub/OpenBSD/OpenSSH/portable/openssh-8.2p1.tar.gz
tar -xvf openssh-8.2p1.tar.gz
chown -R root.root openssh-8.2p1
cd openssh-8.2p1
./configure --prefix=/usr/ --sysconfdir=/etc/ssh  --with-openssl-includes=/usr/local/ssl/include --with-ssl-dir=/usr/local/ssl   --with-zlib   --with-md5-passwords   --with-pam  
 
make && make install
 
grep "^PermitRootLogin"  /etc/ssh/sshd_config
grep  "UseDNS"  /etc/ssh/sshd_config

cp -a contrib/redhat/sshd.init /etc/init.d/sshd
cp -a contrib/redhat/sshd.pam /etc/pam.d/sshd.pam

chmod +x /etc/init.d/sshd
chkconfig --add sshd
systemctl enable sshd
chkconfig sshd on

#终端运行脚本可以重启ssh服务生效，如果是通过ssh连接进行操作的，需要重启服务器，脚本最后一条命令替换为：reboot
service sshd restart
#reboot

cd ~
rm -rf openssh-8.2p1.tar.gz
rm -rf openssh-8.2p1
rm -rf openssl-1.1.1e.tar.gz
rm -rf openssl-1.1.1e

#检查版本
openssl version

ssh -V

