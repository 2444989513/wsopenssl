
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


## 升级openssh版本到8.1p1

```
bash <(curl -L -s https://raw.githubusercontent.com/2444989513/wsopenssl/master/openssh.sh) | tee openssh_ins.log
```
验证更新结果

执行命令：
```
ssh -V
```
输出版本号为“OpenSSH_8.1p1, OpenSSL 1.1.1d  10 Sep 2019”，说明更新成功






