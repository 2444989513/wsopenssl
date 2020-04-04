cd ~
#安装依赖,同时上传软件包到服务器
yum -y install perl-core libtemplate-perl zlib-devel gcc wget

sudo yum install centos-release-scl -y
sudo yum install devtoolset-9 -y
sudo scl enable devtoolset-9 bash
#下载openssl
wget https://www.openssl.org/source/openssl-1.1.1f.tar.gz
#备份原openssl
mv /usr/bin/openssl /usr/bin/openssl.bak
#解压	
tar zxvf openssl-1.1.1f.tar.gz
#进入文件夹
cd openssl-1.1.1f
./config --prefix=/usr/local/ssl
make&&make install
#处理库文件
echo "/usr/local/ssl/lib">>/etc/ld.so.conf
ldconfig -v
#处理命令文件
ln -s /usr/local/ssl/bin/openssl /usr/bin/openssl
ln -s /usr/local/ssl/include/openssl /usr/include/openssl

cd ~
rm -rf openssl-1.1.1f.tar.gz
rm -rf openssl-1.1.1f

#检查版本
openssl version

