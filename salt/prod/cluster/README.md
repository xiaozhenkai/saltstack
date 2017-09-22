**haproxy和keepalived的安装不在这里进行，这里负责配置下发，haproxy和keepalived的安装请点击下面的超链接跳转到对应目录**

------
### [haproxy安装](../haproxy)
### [keepalived安装](../keepalived)

------

### Keepalived配置文件以及说明
```
global_defs{
   notification_email {
        root@localhost         //收邮件人，可以定义多个
   }
   notification_email_from kaadmin@localhost       //发邮件人可以伪装
   smtp_server 127.0.0.1  //发送邮件的服务器地址
   smtp_connect_timeout 30 //连接超时时间
   router_id LVS_DEVEL       
}
vrrp_instanceVI_1 {    //每一个vrrp_instance就是定义一个虚拟路由器的
    state MASTER       //由初始状态状态转换为master状态
    interface eth0    
    virtual_router_id 51    //虚拟路由的id号，一般不能大于255的
    priority 100    //初始化优先级
    advert_int 1    //初始化通告
    authentication {   //认证机制
        auth_type PASS
        auth_pass 1111   //密码
    }
    virtual_ipaddress {     //虚拟地址vip
       172.16.2.8
    }
}
```

> **注意：** 确保两台的防火墙都要放开，不然会出现两台keepalived检测不到对方的健康状态然后两台都开启VIP

------
```
    {% if grains['fqdn'] == 'saltstack-node1.example.com' %}
    - ROUTEID: haproxy_ha
    - STATEID: MASTER
    - PRIORITYID: 150

    {% elif grains['fqdn'] == 'saltstack-node2.example.com' %}
    - ROUTEID: haproxy_ha
    - STATEID: BACKUP
    - PRIORITYID: 100
    {% endif %}
```
> 把需要做keepalived的两台机器的hostname改成saltstack-node1.example.com和saltstack-node2.example.com

然后用salt命令`salt '*' grains.item fqdn`查看fqdn
> **扩展：** 全域名（FQDN，Fully Qualified Domain Name）是指主机名加上全路径，全路径中列出了序列中所有域成员。全域名可以从逻辑上准确地表示出主机在什么地方，也可以说全域名是主机名的一种完全表示形式。

```
salt '*' grains.item fqdn
saltstack-node2.example.com:
    ----------
    fqdn:
        saltstack-node2.example.com
web:
    ----------
    fqdn:
        saltstack-node1.example.com

```
