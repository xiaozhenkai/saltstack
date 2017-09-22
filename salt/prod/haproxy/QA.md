## 搭建过程中遇到的问题
### 一、HAPROXY 的问题

1. 现象
通过虚 IP 无法访问到 HAProxy，通过主机 IP 可以访问大 HAProxy。

2. 解决办法
配置 HAProxy 时，bind 的配置，写成了固定 IP:PORT 的格式，此时 HAProxy 无法绑定虚拟 IP 。将改行配置改成 bind *：port，问题解决。

### 二、KEEPALIVED 的问题

1. 现象：
停止 MASTER 主机上的 HAProxy 服务，虚 IP 不漂移到 BACKUP 主机上。

2. 问题处理过程:

> 1）健康检查脚本

首先怀疑健康检查脚本的问题。

进行手动执行：

HAProxy 未启动时：

![HAProxy 未启动时](http://img.debugrun.com/pic/2017/3/3/f04ecff8f4be85cc4128fed52814aa41.png)

HAProxy 启动时：

![HAProxy 启动时](http://img.debugrun.com/pic/2017/3/3/f8d86f69b82619c70d1f0abcb6f9fa53.png)

说明脚本没有问题，排除该脚本问题。

> 2）Keepalived 主备切换

怀疑 Keepalived 本身就不能切换。

停止 MASTER 的 Keepalived 服务，发现虚 IP 漂移到了 BACKUP 主机上。

说明 Keepalived 可以进行主备切换

> 3）版本

怀疑 Keepalived 版本的问题。

安装其他的版本，问题依然未解决。

排除版本问题

> 4）其他

主备配置字段、执行检测脚本的配置字段等，均已排除。

3. 解决办法
1）查看 Keepalived 的日志，发现一直打印 pid 退出的的日志，怀疑与此有关。



2）观察 Keepalived 启动过程的日志，日志中提示健康检查脚本中的 killall 使用完整的路径，即 /usr/bin/killall，修改完成后，重启，主备切换正常。

