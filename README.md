# saltstack

## 安装saltstack

SaltStack Package Repo

Download and install the latest release of SaltStack.


`yum install https://repo.saltstack.com/yum/redhat/salt-repo-latest-2.el6.noarch.rpm`

```
sudo yum install salt-master
sudo yum install salt-minion
sudo yum install salt-ssh
sudo yum install salt-syndic
sudo yum install salt-cloud
sudo yum install salt-api
```

### salt-master:
`vim /etc/salt/master`
```
file_roots:
  base:
    - /srv/salt/base/
  prod:
    - /srv/salt/prod/
```


### salt-minion:
`vim /etc/salt/minion`
```
master: 192.168.0.8

id: nginx
```
------

## 参考
### [Saltstack自动化（一）安装与概述](http://www.361way.com/saltstack-install/3123.html)
### [Saltstack自动化（二）分组](http://www.361way.com/saltstack-nodegroup/3126.html)
### [Saltstack自动化（三）Grains组件](http://www.361way.com/saltstack-grains/5104.html)
### [Saltstack自动化（四）pillar组件](http://www.361way.com/saltstack-pillar/5107.html)
### [Saltstack自动化（五）sls文件使用](http://www.361way.com/salt-states/5350.html)
### [Saltstack自动化（六）Highstate数据结构](http://www.361way.com/saltstack-highstate/5353.html)
### [Saltstack自动化（七）自定义模块](http://www.361way.com/salt-custom-module/5515.html)
