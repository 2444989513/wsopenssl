
### centos6.8下升级到openssl1.1.1d和openssh8.1p1



## 我只个搬运工

## 原做者http://www.lyxyy521.cc/?p=941#comment-57




1、虽然yum安装依赖和下载安装包放到脚本里了，但我还是推荐独立运行，以免网络原因造成无法下载，导致脚本出错。

2、最好在服务器终端中运行脚本，尽量不要通过ssh操作。

3、使用root用户登录系统，进行操作。

4、更新过程多是覆盖或卸载原软件，无法进行降级、恢复。升级前请备份项目相关文件和数据，如出现意外情况可能需重新安装系统、搭建环境、还原数据方可恢复业务。




## 升级openssl版本到1.1.1d

```
bash <(curl -L -s https://raw.githubusercontent.com/2444989513/wsopenssl/master/openssl.sh) | tee openssl_ins.log
```
验证更新结果

执行命令：
```
openssl version
```
输出版本号为“OpenSSL 1.1.1d  10 Sep 2019”，说明更新成功


## 升级openssh版本到OpenSSH_8.2p1

```
bash <(curl -L -s https://raw.githubusercontent.com/2444989513/wsopenssl/master/openssh.sh) | tee openssh_ins.log
```
验证更新结果

执行命令：
```
ssh -V
```
输出版本号为“OpenSSH_8.1p1, OpenSSL 1.1.1d  10 Sep 2019”，说明更新成功






