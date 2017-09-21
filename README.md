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
