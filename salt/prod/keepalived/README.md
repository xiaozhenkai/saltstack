### 写在前面
> **注意：** 为了保持安装的独立性，我们在install.sls里并没有编写keepalived配置文件和服务的管理，haproxy和keepalived的配置文件和服务的管理在cluster业务模块里,结构如下:
```
/srv/salt/prod/cluster
├── files
│   ├── haproxy-outside.cfg
│   └── haproxy-outside-keepalived.conf
├── haproxy-outside-keepalived.sls
├── haproxy-outside.sls
└── README.md
```
------

## 开始
### 软件版本
| Item      |    Value | 备注  |
| :-------- | --------:| :--: |
| 方式   | 编译安装 |  0    |
| 版本      | 1.2.17 |  0      |
| 目录      |   /usr/local/keepalived|  0    |


**下载源文件**
```
cd /usr/local/src
wget http://www.keepalived.org/software/keepalived-1.2.17.tar.gz
tar xf keepalived-1.2.17.tar.gz
cd keepalived-1.2.17
```
**把需要的init脚本和sysconfig复制到files目录下**
```
cp keepalived/etc/init.d/keepalived.init /srv/salt/prod/keepalived/files/
cp keepalived/etc/init.d/keepalived.sysconfig /srv/salt/prod/keepalived/files/
```
**由于这次默认安装keepalived到/usr/local/keepalived目录下，所以需要修改源码包里面的init脚本**
```
<  将  daemon keepalived ${KEEPALIVED_OPTIONS}
---
> 改成 daemon /usr/local/keepalived/sbin/keepalived ${KEEPALIVED_OPTIONS}

```
