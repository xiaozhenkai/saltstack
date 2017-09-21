### 写在前面
> **注意：** 为了保持安装的独立性，我们在install.sls里并没有编写eepalived配置文件和服务的管理，haproxy和keepalived的配置文件和服务的管理在cluster业务模块里,结构如下:
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

`wget http://www.keepalived.org/software/keepalived-1.2.17.tar.gz`
