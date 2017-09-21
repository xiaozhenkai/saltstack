### 写在前面
> **注意：** 为了保持安装的独立性，我们在install.sls里并没有编写haproxy配置文件和服务的管理，haproxy和keepalived的配置文件和服务的管理在cluster业务模块里,结构如下:
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
| 版本      | 1.5.19 |  0      |
| 目录      |   /usr/local/haproxy|  0    |


**下载源文件**
```
cd /usr/local/src
wget http://www.haproxy.org/download/1.5/src/haproxy-1.5.19.tar.gz
tar xf haproxy-1.5.19.tar.gz
cd haproxy-1.5.19
```

修改**启动脚本**,文件在haproxy/examples/haproxy.init

`sed -i 's/\/usr\/sbin\/'\$BASENAME'/\/usr\/local\/haproxy\/sbin\/'\$BASENAME'/g' haproxy.init`

---------
## 参考
### [HAProxy从零开始到掌握](http://www.jianshu.com/p/c9f6d55288c0)
